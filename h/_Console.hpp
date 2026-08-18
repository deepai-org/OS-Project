//
// Created by os on 7/10/26.
//

#include "_Semaphore.hpp"
#include "../lib/hw.h"
#ifndef PROJECT_BASE_V1_1_CONSOLE_HPP
#define PROJECT_BASE_V1_1_CONSOLE_HPP

#include "KernelBuffer.hpp"
#include "syscall_c.hpp"

class _Console {
public:
    static volatile uint64 interruptCount;

    static volatile uint64 rxReadyCount;

    static volatile uint64 txReadyCount;

    static void initialize();
    static char getc();
    static void putc(char c);
    static void handleInterrupt();

    static void outputWorker(void*);
    static thread_t outputThread;

    static volatile char testChar;
    static volatile bool testCharReady;

private:
    static volatile uint64 rxCount;
    static volatile uint64 successfulPutCount;
    static void transmitOutput();
    static KernelBuffer* inputBuffer;
    static KernelBuffer* outputBuffer;
};

#endif//PROJECT_BASE_V1_1_CONSOLE_HPP
