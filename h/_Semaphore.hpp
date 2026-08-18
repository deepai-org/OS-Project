//
// Created by os on 7/10/26.
//

#ifndef PROJECT_BASE_V1_1_SEMAPHORE_HPP
#define PROJECT_BASE_V1_1_SEMAPHORE_HPP
#include "TCB.hpp"

class _Semaphore {
public:

    explicit _Semaphore(unsigned value);
    int wait ();
    int signal ();
    int wait_n (unsigned n);
    int signal_n (unsigned n);
    int close();
    int tryWait();

private:
    int value;
    struct BlockedThread {
        TCB* data;
        unsigned requested;
        BlockedThread* next;
    };

    void lock();
    void unlock();
    BlockedThread* head;
    BlockedThread* tail;
};

#endif //PROJECT_BASE_V1_1_SEMAPHORE_HPP
