//
// Created by os on 7/20/26.
//

#ifndef PROJECT_BASE_V1_1_SLEEPINGTHREAD_H
#define PROJECT_BASE_V1_1_SLEEPINGTHREAD_H
#include "TCB.hpp"
#include "../lib/hw.h"

class SleepingThreads {
public:
    static int put(TCB* thread, time_t sleepTime);
    static void tick();

private:
    struct Elem {
        TCB* thread;
        time_t time;
        Elem* next;
    };

    static Elem* head;
};
#endif //PROJECT_BASE_V1_1_SLEEPINGTHREAD_H
