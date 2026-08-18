//
// Created by os on 7/10/26.
//
#include "../h/TCB.hpp"
#ifndef PROJECT_BASE_V1_1_SCHEDULER_HPP
#define PROJECT_BASE_V1_1_SCHEDULER_HPP
class Scheduler {
public:
    static TCB* get();
    static void put(TCB* tcb);

    static bool isEmpty();

private:
    struct Elem {
        TCB* data;
        Elem* next;
    };

    static Elem* head;
    static Elem* tail;
};
#endif //PROJECT_BASE_V1_1_SCHEDULER_HPP
