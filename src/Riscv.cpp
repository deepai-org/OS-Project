//
// Created by os on 7/10/26.
//

#include "../h/Riscv.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/SleepingThreads.hpp"
#include "../h/TCB.hpp"
#include "../h/syscall_c.hpp"
#include "../lib/console.h"
#include "../h/_Semaphore.hpp"
#include "../h/_Console.hpp"
extern void printHex(uint64 registers);
extern "C" {
int plic_claim();
void plic_complete(int irq);
}
volatile uint64 testInterruptSeen = 0;
volatile uint64 testInterruptId = 0;
volatile uint64 testConsoleStatus = 0;
volatile uint64 externalInterruptCount = 0;
volatile uint64 debugExternalInterruptEntered = 0;
volatile int lastInterruptId = -1;
volatile uint64 consoleInterruptCount = 0;
volatile uint8 lastIir = 0;

void Riscv::handleSupervisorTrap(uint64* registers) {
    uint64 scause = r_scause();

    if ((scause & (1UL << 63)) == 0 &&
    scause != 8 &&
    scause != 9) {

        __putc('?');
        __putc('\n');

        __putc('C');
        __putc(':');
        printHex(scause);

        __putc('E');
        __putc(':');
        printHex(r_sepc());

        __putc('V');
        __putc(':');
        printHex(r_stval());
    }

    if (scause == 8 || scause == 9) {
        registers[32] += 4;
        uint64 syscallCode = registers[10];

        if (syscallCode == 0x01) {
            size_t numOfBlocks = registers[11];

            void* result = MemoryAllocator::mem_alloc(
                numOfBlocks * MEM_BLOCK_SIZE
            );

            registers[10] = (uint64)result;
        } else if (syscallCode == 0x02) {
            void* ptr = (void*)(registers[11]);

            int result = MemoryAllocator::mem_free(ptr);

            registers[10] = (uint64) (result);
        } else if (syscallCode == 0x11) {
            thread_t* handle = (thread_t*)(registers[11]);
            TCB::Body body = (TCB::Body)(registers[12]);
            void* arg = (void*)(registers[13]);
            uint64* stack = (uint64*)(registers[14]);
            uint64* systemStack = (uint64*)(registers[15]);

            int result = TCB::create(
                (TCB**)handle,
                body,
                arg,
                stack,
                systemStack
            );
            registers[10] = (uint64)result;
        } else if (syscallCode == 0x12) {
            int result = TCB::exit();
            registers[10] = (uint64) result;
        } else if (syscallCode == 0x13) {
            TCB::dispatch();
            registers[10] = 0;
        } else if (syscallCode == 0x21) {
            sem_t* handle = (sem_t*)registers[11];
            unsigned init = (unsigned)registers[12];

            if (!handle) {
                registers[10] = (uint64)-1;
            } else {
                _Semaphore* sem = new _Semaphore(init);

                if (!sem) {
                    *handle = nullptr;
                    registers[10] = (uint64)-1;
                } else {
                    *handle = sem;
                    registers[10] = 0;
                }
            }

        } else if (syscallCode == 0x22) {
            _Semaphore* sem = (_Semaphore*)registers[11];

            if (!sem) {
                registers[10] = (uint64)-1;
            } else {
                int result = sem->close();

                if (result == 0) {
                    delete sem;
                }

                registers[10] = (uint64)result;
            }
        } else if (syscallCode == 0x23) {
            _Semaphore* sem = (_Semaphore*)registers[11];
            registers[10] = sem ? (uint64) sem->wait() : (uint64)-1;

        } else if (syscallCode == 0x24) {
            _Semaphore* sem = (_Semaphore*)registers[11];
            registers[10] = sem ? (uint64) sem->signal() : (uint64)-1;

        } else if (syscallCode == 0x25) {
            _Semaphore* sem = (_Semaphore*)registers[11];
            unsigned n = (unsigned)registers[12];

            registers[10] = sem
                ? (uint64)sem->wait_n(n)
                : (uint64)-1;

        } else if (syscallCode == 0x26) {
            _Semaphore* sem = (_Semaphore*)registers[11];
            unsigned n = (unsigned)registers[12];

            registers[10] = sem
                ? (uint64)sem->signal_n(n)
                : (uint64)-1;
        } else if (syscallCode == 0x41) {
            char c = _Console::getc();
            registers[10] = (uint64)c;
        } else if (syscallCode == 0x42) {
            char c = (char)registers[11];
            _Console::putc(c);
            registers[10] = 0;
        } else if (syscallCode == 0x31) {
            time_t time = (time_t) registers[11];
            registers[10] = TCB::sleep(time);
        } else {
            while (true) {
                // Zaustavi kernel da ne ispisuje beskonacno.
            }
        }

        // w_sepc(sepc);
        return;
    } else if (scause == 0x8000000000000009UL) {

        int interruptId = plic_claim();

        if (interruptId == CONSOLE_IRQ) {
            _Console::handleInterrupt();
        }

        if (interruptId != 0) {
            plic_complete(interruptId);
        }

        return;
    } else if (scause == 0x8000000000000001UL) {
        mc_sip(SIP_SSIP);

        SleepingThreads::tick();

        TCB::incrementTimeSliceCounter();

        if (TCB::getTimeSliceCounter() >= DEFAULT_TIME_SLICE) {
            uint64 sepc = r_sepc();
            uint64 sstatus = r_sstatus();

            TCB::resetTimeSliceCounter();
            TCB::dispatch();

            w_sstatus(sstatus);
            w_sepc(sepc);
        }

        return;
    } else {
        __putc('?');
        __putc('\n');

        __putc('C');
        __putc(':');
        printHex(scause);

        __putc('E');
        __putc(':');
        printHex(Riscv::r_sepc());

        __putc('V');
        __putc(':');
        printHex(Riscv::r_stval());
    }
}

int Riscv::interruptLockDepth = 0;
bool Riscv::interruptsWereEnabled = false;

bool Riscv::interruptsEnabled() {
    return r_sstatus() & SSTATUS_SIE;
}

void Riscv::pushOff() {
    bool enabled = interruptsEnabled();

    uint64 sstatus = r_sstatus();
    w_sstatus(sstatus & ~SSTATUS_SIE);

    if (interruptLockDepth == 0) interruptsWereEnabled = enabled;
    interruptLockDepth++;
}

void Riscv::popOff() {
    if (interruptsEnabled()) {
        // Greska prekidi ne bi smeli da budu ukljuceni
        return;
    }
    if (interruptLockDepth <= 0) {
        //Greska unlock bez odgovarajuceg locka
        return;
    }

    interruptLockDepth--;
    if (interruptLockDepth == 0 && interruptsWereEnabled) {
        uint64 sstatus = r_sstatus();
        w_sstatus(sstatus | SSTATUS_SIE);
    }
}

extern "C" void handleSupervisorTrapC(uint64* registers)
{
    Riscv::handleSupervisorTrap(registers);
}