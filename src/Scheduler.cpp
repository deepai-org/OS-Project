//
// Created by os on 7/10/26.
//
#include "../h/Scheduler.hpp"
Scheduler::Elem* Scheduler::head = nullptr;
Scheduler::Elem* Scheduler::tail = nullptr;
TCB* Scheduler::get() {
    if (!head) return nullptr;
    Elem* oldHead = head;
    TCB* thread = oldHead->data;
    head = head->next;
    if (head == nullptr) {
        tail = nullptr;
    }

    delete oldHead;
    return thread;
}

void Scheduler::put(TCB *tcb) {
    if (!tcb) return;

    Elem* newElem = new Elem;
    if (!newElem) return;

    newElem->data = tcb;
    newElem->next = nullptr;

    if (!tail) {
        head = newElem;
        tail = newElem;
    } else {
        tail->next = newElem;
        tail = newElem;
    }
}

bool Scheduler::isEmpty() {
    return head == nullptr;
}