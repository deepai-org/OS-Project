//
// Created by os on 7/19/26.
//
#include "../h/KernelBuffer.hpp"

KernelBuffer::KernelBuffer():
    head(0),
    tail(0),
    count(0),
    mutex(1),
    itemAvailable(0),
    spaceAvailable(BUFFER_SIZE)
     {}

void KernelBuffer::put(char c) {
    spaceAvailable.wait();
    mutex.wait();

    buffer[tail] = c;
    tail = (tail + 1) % BUFFER_SIZE;
    count++;
    mutex.signal();
    itemAvailable.signal();
}

char KernelBuffer::get() {
    itemAvailable.wait();
    mutex.wait();
    char c = buffer[head];
    head = (head + 1) % BUFFER_SIZE;
    count--;
    mutex.signal();
    spaceAvailable.signal();
    return c;
}

bool KernelBuffer::tryPut(char c) {
    if (spaceAvailable.tryWait() != 0) {
        return false;
    }

    if (mutex.tryWait() != 0) {
        spaceAvailable.signal();
        return false;
    }

    buffer[tail] = c;
    tail = (tail + 1) % BUFFER_SIZE;
    count++;

    mutex.signal();
    itemAvailable.signal();

    return true;
}

// Try su za prekidnu rutinu
bool KernelBuffer::tryGet(char& c) {
    if (itemAvailable.tryWait() != 0) {
        return false;
    }

    if (mutex.tryWait() != 0) {
        itemAvailable.signal();
        return false;
    }

    c = buffer[head];
    head = (head + 1) % BUFFER_SIZE;
    count--;

    mutex.signal();
    spaceAvailable.signal();

    return true;
}