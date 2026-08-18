//
// Created by os on 7/10/26.
//

#ifndef PROJECT_BASE_V1_1_TCB_HPP
#define PROJECT_BASE_V1_1_TCB_HPP
#include "../lib/hw.h"

class TCB {
public:
    using Body = void (*)(void*);

    struct Context {
        uint64 ra;
        uint64 systemSp;

        uint64 s0;
        uint64 s1;
        uint64 s2;
        uint64 s3;
        uint64 s4;
        uint64 s5;
        uint64 s6;
        uint64 s7;
        uint64 s8;
        uint64 s9;
        uint64 s10;
        uint64 s11;
    };

    static TCB* running;
    static TCB* idle;

    // proveri rucku, napravi novi TCB, 0 za uspeh, negativna vrednost za -1
    static int create(
            TCB** handle, // pokazivac na kernel objekat TCB
            Body body,
            void* arg,
            uint64 * stack,
            uint64* systemStack,
            bool systemThread
            );

    static int create(
        TCB** handle,
        Body body,
        void* arg,
        uint64* stack,
        uint64* systemStack
    );

    static void dispatch();

    bool isFinished() const {
        return finished;
    }

    bool isBlocked() const { return blocked;}

    void setBlocked(bool b) {blocked = b;}

    static int exit();

    uint64* getSystemStack() const {
        return systemStack;
    }

    static int createMain(TCB** handle);
    static uint64 getRunningUserStackTop();
    static uint64 getRunningSystemStackTop();
    static void runThreadWrapper();
    void setSemaphoreWaitResult(int result) {
        semaphoreWaitResult = result;
    }

    int getSemaphoreWaitResult() const {
        return semaphoreWaitResult;
    }

    static int sleep(time_t time);

    static void idleBody(void*);

    static int initializeIdle();

    static void incrementTimeSliceCounter() {
        timeSliceCounter++;
    }

    static void resetTimeSliceCounter() {
        timeSliceCounter = 0;
    }

    static uint64 getTimeSliceCounter() {
        return timeSliceCounter;
    }

    bool isSystemThread() const
    {
        return systemThread;
    }

private:
    TCB(Body body, void* arg, uint64* stack, uint64* systemStack, bool systemThread);

    Body body;
    void* arg;
    uint64* stack;
    Context context{};
    bool finished;
    bool blocked;
    uint64* systemStack;
    bool systemThread;

    static void threadWrapper();

    uint64 getUserStackTop() const {
        if (stack == nullptr) return 0;

        uint64 top = (uint64)&stack[DEFAULT_STACK_SIZE];
        return top & ~((uint64)0xF);
    }

    uint64 getSystemStackTop() const {
        if (systemStack == nullptr) return 0;

        uint64 top = (uint64)&systemStack[DEFAULT_STACK_SIZE];

        return top & ~((uint64)0xF);
    }

    int semaphoreWaitResult;
    static uint64 timeSliceCounter;

};

extern "C" void contextSwitch(
    TCB::Context* oldContext,
    TCB::Context* newContext
);

extern "C" void threadStart();

extern "C" uint64 getRunningUserStackTopC();
extern "C" uint64 getRunningSystemStackTopC();
extern "C" void threadWrapperC();
extern "C" uint64 isRunningSystemThreadC();
extern "C" void systemThreadStart();
extern "C" void userThreadStart();
#endif //PROJECT_BASE_V1_1_TCB_HPP
