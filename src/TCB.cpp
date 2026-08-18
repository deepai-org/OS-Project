//
// Created by os on 7/10/26.
//
#include "../h/TCB.hpp"
#include "../h/Scheduler.hpp"
#include "../lib/console.h"
#include "../h/Riscv.hpp"
#include "../h/_Console.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/SleepingThreads.hpp"

void printHex(uint64 value)
{
    __putc('0');
    __putc('x');

    for (int i = 15; i >= 0; i--) {
        uint8 digit = (value >> (i * 4)) & 0xF;

        if (digit < 10)
            __putc('0' + digit);
        else
            __putc('A' + digit - 10);
    }

    __putc('\n');
}
TCB* TCB::running = nullptr;
TCB* TCB::idle = nullptr;
uint64 TCB::timeSliceCounter = 0;
// za alociranje mora da bude DEFAULT_STACK_SIZE * sizeof(uint64) jer mem_alloc prima velicinu u bajtovima
TCB::TCB(Body body,
         void* arg,
         uint64* stack,
         uint64* systemStack,
         bool systemThread)
{

    this->body = body;
    this->arg = arg;
    this->stack = stack;
    this->systemStack = systemStack;
    this->finished = false;
    this->blocked = false;
    this->semaphoreWaitResult = 0;
    this->systemThread = systemThread;

    context = {};

    if (body != nullptr) {
        context.ra = (uint64)&threadStart;
        context.systemSp = getSystemStackTop();
    }
}
//uint64* stack = (uint64*)mem_alloc(
//    DEFAULT_STACK_SIZE * sizeof(uint64)
//);
//
//TCB::create(handle, start_routine, arg, stack);
// !!!MORA DA SE MENJA NAKON SCHEDULERA

int TCB::create(TCB** handle,
                Body body,
                void* arg,
                uint64* stack,
                uint64* systemStack,
                bool systemThread)
{
    if (handle == nullptr) return -1;

    TCB* newThread = new TCB(
        body,
        arg,
        stack,
        systemStack,
        systemThread
    );

    if (newThread == nullptr) {
        *handle = nullptr;
        return -1;
    }

    *handle = newThread;

    if (body == nullptr) {
        running = newThread;
    } else {
        Scheduler::put(newThread);
    }

    return 0;
}

int TCB::create(TCB** handle,
                Body body,
                void* arg,
                uint64* stack,
                uint64* systemStack)
{
    return create(
        handle,
        body,
        arg,
        stack,
        systemStack,
        false
    );
}

void TCB::dispatch()
{
    TCB* old = running;

    if (old == nullptr) {
        __putc('O');
        while (true) {}
    }

    if (old != idle &&
        !old->isFinished() &&
        !old->isBlocked()) {

        Scheduler::put(old);
        }

    TCB* next = Scheduler::get();

    if (next == nullptr) {
        next = idle;
    }

    if (next == nullptr) {
        __putc('Z');
        while (true) {}
    }

    running = next;
    resetTimeSliceCounter();

    contextSwitch(
        &old->context,
        &running->context
    );
}

void TCB::threadWrapper()
{
    running->body(running->arg);

    if (running->isSystemThread()) {
        TCB::exit();
    } else {
        thread_exit();
    }

    while (true) {}
}

void TCB::runThreadWrapper()
{
    threadWrapper();
}

int TCB::exit()
{
    if (running == nullptr) {
        return -1;
    }

    running->finished = true;
    dispatch();
    while (true) {
    }
}

int TCB::createMain(TCB **handle) {
    if (!handle) return -1;

    uint64* systemStack = (uint64*)MemoryAllocator::mem_alloc(
            (DEFAULT_STACK_SIZE * sizeof(uint64)));

    if (!systemStack) {
        *handle = nullptr;
        return -1;
    }

    TCB* mainThread = new TCB(
            nullptr,
            nullptr,
            nullptr,
            systemStack,
            true
            );

    if (!mainThread) {
        MemoryAllocator::mem_free(systemStack);
        *handle = nullptr;
        return -1;
    }

    running = mainThread;
    *handle = mainThread;

    // uint64 systemStackTop = (uint64)&systemStack[DEFAULT_STACK_SIZE];
    // systemStackTop &= ~((uint64)0xF);

    Riscv::w_sscratch(0);
    return 0;
}

int TCB::sleep(time_t sleepTime) {

    if (sleepTime == 0) {
        return 0;
    }

    running->setBlocked(true);

    int result = SleepingThreads::put(running, sleepTime);

    if (result < 0) {
        running->setBlocked(false);
        return -1;
    }
    dispatch();

    return 0;
}

void TCB::idleBody(void*) {
    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);
    while (true) {
    }
}

int TCB::initializeIdle() {
    uint64* systemStack =
        (uint64*)MemoryAllocator::mem_alloc(
            DEFAULT_STACK_SIZE * sizeof(uint64)
        );

    if (systemStack == nullptr) {
        return -1;
    }

    TCB::idle = new TCB(
        &idleBody,
        nullptr,
        nullptr,
        systemStack,
        true
    );

    if (TCB::idle == nullptr) {
        MemoryAllocator::mem_free(systemStack);
        return -1;
    }

    return 0;
}

uint64 TCB::getRunningUserStackTop() {
    if (running == nullptr) {
        return 0;
    }

    return running->getUserStackTop();
}

uint64 TCB::getRunningSystemStackTop() {
    if (running == nullptr) {
        return 0;
    }

    return running->getSystemStackTop();
}

extern "C" void threadWrapperC()
{
    TCB::runThreadWrapper();
}

extern "C" uint64 getRunningUserStackTopC() {
    return TCB::getRunningUserStackTop();
}

extern "C" uint64 getRunningSystemStackTopC() {
    return TCB::getRunningSystemStackTop();
}

extern "C" uint64 isRunningSystemThreadC()
{
    if (TCB::running == nullptr) {
        return 1;
    }

    return TCB::running->isSystemThread() ? 1 : 0;
}

// extern "C" void threadWrapperC() {
//     Riscv::w_sstatus(
//         Riscv::r_sstatus() | Riscv::SSTATUS_SIE
//     );
//     TCB::runThreadWrapper();
// }