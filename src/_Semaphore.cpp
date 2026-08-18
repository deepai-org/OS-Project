//
// Created by os on 7/10/26.
//
#include "../h/_Semaphore.hpp"

#include "../h/Riscv.hpp"
#include "../h/TCB.hpp"
#include "../h/Scheduler.hpp"

_Semaphore::_Semaphore (unsigned value) {
    this->value = value;
    this->head = nullptr;
    this->tail = nullptr;
}

int _Semaphore::wait() {
    return wait_n(1);
}

int _Semaphore::signal() {
    return signal_n(1);
}

int _Semaphore::wait_n(unsigned n) {
    if (n == 0) return 0;

    lock();

    if (value >= static_cast<int>(n)) {
        value -= n;
        unlock();
        return 0;
    }

    TCB* thread = TCB::running;
    BlockedThread* newThread = new BlockedThread;

    if (!newThread) {
        unlock();
        return -1;
    }

    newThread->data = thread;
    newThread->requested = n;
    newThread->next = nullptr;

    thread->setSemaphoreWaitResult(0);
    thread->setBlocked(true);

    if (!tail) {
        head = tail = newThread;
    } else {
        tail->next = newThread;
        tail = newThread;
    }

    unlock();
    TCB::dispatch();

    return thread->getSemaphoreWaitResult();
}

int _Semaphore::signal_n(unsigned n) {
    if (n == 0) return 0;

    lock();

    value += n;

    while (head &&
           value >= static_cast<int>(head->requested)) {

        BlockedThread* oldHead = head;
        TCB* thread = oldHead->data;

        value -= oldHead->requested;

        head = head->next;
        if (!head) {
            tail = nullptr;
        }

        thread->setSemaphoreWaitResult(0);
        thread->setBlocked(false);

        Scheduler::put(thread);

        delete oldHead;
           }

    unlock();

    return 0;
}

void _Semaphore::lock() {
    Riscv::pushOff();
}

void _Semaphore::unlock() {
    Riscv::popOff();
}

int _Semaphore::close() {
    lock();

    while (head) {
        BlockedThread* oldHead = head;
        TCB* thread = oldHead->data;

        head = head->next;

        thread->setSemaphoreWaitResult(-1);
        thread->setBlocked(false);
        Scheduler::put(thread);

        delete oldHead;
    }

    tail = nullptr;

    unlock();

    return 0;
}

int _Semaphore::tryWait() {
    lock();
    if (value <= 0) {
        unlock();
        return -1;
    }
    value--;
    unlock();
    return 0;
}
