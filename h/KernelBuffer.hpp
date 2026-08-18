//
// Created by os on 7/19/26.
//
#include "../lib/hw.h"
#include "_Semaphore.hpp"
#ifndef PROJECT_BASE_V1_1_BUFFER_H
#define PROJECT_BASE_V1_1_BUFFER_H
class KernelBuffer {
public:
    KernelBuffer();

    void put(char c);
    char get();
    bool tryPut(char c);
    bool tryGet(char& c);

private:
    static const size_t BUFFER_SIZE = 256;

    char buffer[BUFFER_SIZE];
    size_t head;
    size_t tail;
    size_t count;

    _Semaphore mutex;
    _Semaphore itemAvailable;
    _Semaphore spaceAvailable;
};
#endif //PROJECT_BASE_V1_1_BUFFER_H
