//
// Created by os on 7/20/26.
//
#include "../h/SleepingThreads.hpp"
#include "../h/Scheduler.hpp"
#include "../lib/console.h"

SleepingThreads::Elem* SleepingThreads::head = nullptr;

int SleepingThreads::put(TCB* thread, time_t sleepTime)
{
    if (thread == nullptr || sleepTime == 0) {
        return -1;
    }

    Elem* newElem = new Elem;

    if (newElem == nullptr) {
        return -1;
    }

    newElem->thread = thread;
    newElem->time = sleepTime;
    newElem->next = head;

    head = newElem;

    return 0;
}

void SleepingThreads::tick() {

    if (head == nullptr) {
        return;
    }

    Elem* current = head;
    Elem* previous = nullptr;

    while (current != nullptr) {
        if (current->time > 0) {
            current->time--;
        }

        if (current->time == 0) {
            Elem* finished = current;

            if (previous == nullptr) {
                head = current->next;
                current = head;
            } else {
                previous->next = current->next;
                current = current->next;
            }

            finished->thread->setBlocked(false);
            Scheduler::put(finished->thread);

            delete finished;
        } else {
            previous = current;
            current = current->next;
        }
    }
}