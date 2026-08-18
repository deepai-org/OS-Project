//
// Created by os on 7/20/26.
//

#include "../h/_syscall_cpp.hpp"
#include "../lib/console.h"

Thread::Thread(void (*body)(void*), void* arg)
    : myHandle(nullptr),
      body(body),
      arg(arg)
{
}

Thread::Thread()
    : myHandle(nullptr),
      body(nullptr),
      arg(nullptr) {}

Thread::~Thread() {}

int Thread::start() {

    if (body != nullptr) {
        return thread_create(&myHandle, body, arg);
    }

    return thread_create(
        &myHandle,
        [](void* argument) {
            Thread* thread = static_cast<Thread*>(argument);

            if (thread != nullptr) {
                thread->run();
            }
        },
        this
    );
}

void Thread::dispatch() {
    thread_dispatch();
}

int Thread::sleep(time_t time) {
    return time_sleep(time);
}

Semaphore::Semaphore(unsigned init)
    : myHandle(nullptr) {
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore() {
    if (myHandle != nullptr) {
        sem_close(myHandle);
        myHandle = nullptr;
    }
}

int Semaphore::wait() {
    return sem_wait(myHandle);
}

int Semaphore::signal() {
    return sem_signal(myHandle);
}

PeriodicThread::PeriodicThread(time_t period) : Thread(),
    period(period),
    terminated(false) {}

void PeriodicThread::terminate() {
    terminated = true;
}

void PeriodicThread::run()
{
    while (!terminated) {
        periodicActivation();

        if (terminated) {
            break;
        }

        if (period == 0) {
            Thread::dispatch();
        } else {
            time_sleep(period);
        }
    }
}

char Console::getc()
{
    return ::getc();
}

void Console::putc(char c)
{
    ::putc(c);
}