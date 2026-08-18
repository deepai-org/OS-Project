//
// Created by os on 7/10/26.
//

//
// Created by os on 7/19/26.
//

#include "../h/_Console.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../lib/console.h"

KernelBuffer* _Console::inputBuffer = nullptr;
KernelBuffer* _Console::outputBuffer = nullptr;
thread_t _Console::outputThread = nullptr;
extern void printHex(uint64);

volatile uint64 _Console::rxCount = 0;
volatile uint64 _Console::successfulPutCount = 0;
volatile uint64 _Console::interruptCount = 0;
volatile uint64 _Console::rxReadyCount = 0;
volatile uint64 _Console::txReadyCount = 0;
extern "C" {
void uartinit();
int uartgetc();
}
static uint8 readConsoleStatus() {
    return *(volatile uint8*)CONSOLE_STATUS;
}

void _Console::initialize()
{
    inputBuffer = new KernelBuffer();
    outputBuffer = new KernelBuffer();

    uint64* systemStack =
        (uint64*)MemoryAllocator::mem_alloc(
            DEFAULT_STACK_SIZE * sizeof(uint64)
        );

    if (systemStack == nullptr) {
        return;
    }

    if (TCB::create(
            &outputThread,
            &_Console::outputWorker,
            nullptr,
            nullptr,
            systemStack,
            true
        ) != 0) {

        MemoryAllocator::mem_free(systemStack);
        return;
        }

    volatile uint8* uart =
        (volatile uint8*)CONSOLE_RX_DATA;

    /*
     * Iskljuci sve UART prekide.
     * Najpre obavezno ugasi DLAB.
     */
    uart[3] = 0x03;  // LCR: 8 bita, bez pariteta, 1 stop bit
    uart[1] = 0x00;  // IER: svi prekidi ugaseni

    /*
     * Ukljuci FIFO i očisti prijemni i predajni FIFO.
     */
    uart[2] = 0x07;

    /*
     * Modem control:
     * DTR, RTS i OUT2.
     * OUT2 je bitan za prosledjivanje UART prekida.
     */
    uart[4] = 0x0B;

    /*
     * Ukljuci samo RX interrupt.
     */
    uart[1] = 0x01;
}

char _Console::getc() {
    return inputBuffer->get();
}

void _Console::putc(char c)
{
    outputBuffer->put(c);
}


static volatile uint64 receivedCharacterCount = 0;
static volatile int lastReceivedCharacter = -2;

void _Console::handleInterrupt()
{
    while (readConsoleStatus() & CONSOLE_RX_STATUS_BIT) {
        char c = *(volatile uint8*)CONSOLE_RX_DATA;
        inputBuffer->tryPut(c);
    }
}

void _Console::outputWorker(void*)
{
    while (true) {
        char c = outputBuffer->get();
        while (!(readConsoleStatus() & CONSOLE_TX_STATUS_BIT)) {
            TCB::dispatch();
        }

        *(volatile uint8*)CONSOLE_TX_DATA = c;
    }
}