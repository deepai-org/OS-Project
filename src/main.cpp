#include "../h/_syscall_cpp.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/Riscv.hpp"
#include "../h/_Console.hpp"
#include "../h/TCB.hpp"
#include "../lib/hw.h"
#include "../h/syscall_c.hpp"

extern void userMain();

// extern "C" {
//     void supervisorTrap();
//     void plicinit();
//     void plicinithart(int hart);
// }

static void userMainWrapper(void*)
{
    userMain();
}

int main()
{
    MemoryAllocator::initialize();

    Riscv::w_stvec((uint64)&supervisorTrap);

    // plicinit();
    // plicinithart(0);

    thread_t mainThread = nullptr;

    if (TCB::createMain(&mainThread) != 0) {
        while (true) {}
    }

    if (TCB::initializeIdle() != 0) {
        while (true) {}
    }

    _Console::initialize();
    uint64* userStack =
        (uint64*)MemoryAllocator::mem_alloc(
            DEFAULT_STACK_SIZE * sizeof(uint64)
        );

    uint64* systemStack =
        (uint64*)MemoryAllocator::mem_alloc(
            DEFAULT_STACK_SIZE * sizeof(uint64)
        );

    if (userStack == nullptr || systemStack == nullptr) {
        while (true) {}
    }

    thread_t userMainThread = nullptr;

    if (TCB::create(
            &userMainThread,
            &userMainWrapper,
            nullptr,
            userStack,
            systemStack,
            false
        ) != 0) {
        while (true) {}
        }
    Riscv::w_sie(
    Riscv::r_sie() | Riscv::SIE_SEIE
    );

    Riscv::w_sstatus(
        Riscv::r_sstatus() | Riscv::SSTATUS_SIE
    );

    mainThread->setBlocked(true);

    thread_dispatch();

    while (true) {
    }
}

// os@ubuntu:~$ sudo mkdir -p /mnt/hgfs
// os@ubuntu:~$ sudo vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other
// cp -r /home/os/Desktop/project-base-v1.1 /mnt/hgfs/Desktop/
// cp -r /mnt/hgfs/Desktop/ImeFajlaIliFoldera ~/Desktop/