//
// Created by os on 7/10/26.
//
#include "../h/syscall_c.hpp"
#include "../lib/console.h"
void* mem_alloc(size_t size) {
    size_t numOfBlocks =
        (size + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE;

    register uint64 a0 asm("a0") = 0x01;
    register uint64 a1 asm("a1") = (uint64)numOfBlocks;

    __asm__ volatile(
        "ecall"
        : "+r"(a0)
        : "r"(a1)
        : "memory"
    );

    return (void*)a0;
}

int mem_free(void* ptr) {
    register uint64 a0 asm("a0") = 0x02;
    register uint64 a1 asm("a1") = (uint64)ptr;

    __asm__ volatile(
        "ecall"
        : "+r"(a0)
        : "r"(a1)
        : "memory"
    );

    return (int)a0;
}

int thread_create(thread_t* handle,
                  void (*start_routine)(void*),
                  void* arg)
{

    if (handle == nullptr) {
        return -1;
    }

    uint64* stack = nullptr;

    uint64* systemStack = (uint64*)mem_alloc(
        DEFAULT_STACK_SIZE * sizeof(uint64)
    );

    if (systemStack == nullptr) {
        return -1;
    }

    if (start_routine != nullptr) {
        stack = (uint64*)mem_alloc(
            DEFAULT_STACK_SIZE * sizeof(uint64)
        );

        if (stack == nullptr) {
            mem_free(systemStack);
            return -1;
        }
    }

    register uint64 a0 asm("a0") = 0x11;
    register uint64 a1 asm("a1") = (uint64)handle;
    register uint64 a2 asm("a2") = (uint64)start_routine;
    register uint64 a3 asm("a3") = (uint64)arg;
    register uint64 a4 asm("a4") = (uint64)stack;
    register uint64 a5 asm("a5") = (uint64)systemStack;

    __asm__ volatile(
        "ecall"
        : "+r"(a0)
        : "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5)
        : "memory"
    );

    int result = (int)a0;

    return result;
}

int thread_exit()
{
    register uint64 a0 asm("a0") = 0x12;

    __asm__ volatile(
    "ecall"
    : "+r"(a0)
    :
    : "memory"
    );

    return (int)a0;
}

void thread_dispatch()
{
    register uint64 a0 asm("a0") = 0x13;

    __asm__ volatile(
    "ecall"
    : "+r"(a0)
    :
    : "memory"
    );
}

int sem_open(sem_t* handle, unsigned init) {
    register uint64 a0 asm("a0") = 0x21;
    register uint64 a1 asm("a1") = (uint64)handle;
    register uint64 a2 asm("a2") = (uint64)init;

    asm volatile("ecall"
        : "+r"(a0)
        : "r"(a1), "r"(a2)
        : "memory"
    );

    return (int)a0;
}

int sem_close(sem_t handle) {
    register uint64 a0 asm("a0") = 0x22;
    register uint64 a1 asm("a1") = (uint64)handle;

    asm volatile("ecall"
        : "+r"(a0)
        : "r"(a1)
        : "memory"
    );

    return (int)a0;
}

int sem_wait(sem_t id) {
    register uint64 a0 asm("a0") = 0x23;
    register uint64 a1 asm("a1") = (uint64)id;

    asm volatile("ecall"
        : "+r"(a0)
        : "r"(a1)
        : "memory"
    );

    return (int)a0;
}

int sem_signal(sem_t id) {
    register uint64 a0 asm("a0") = 0x24;
    register uint64 a1 asm("a1") = (uint64)id;

    asm volatile("ecall"
        : "+r"(a0)
        : "r"(a1)
        : "memory"
    );

    return (int)a0;
}

int sem_wait_n(sem_t id, unsigned n) {
    register uint64 a0 asm("a0") = 0x25;
    register uint64 a1 asm("a1") = (uint64)id;
    register uint64 a2 asm("a2") = (uint64)n;

    asm volatile("ecall"
        : "+r"(a0)
        : "r"(a1), "r"(a2)
        : "memory"
    );

    return (int)a0;
}

int sem_signal_n(sem_t id, unsigned n) {
    register uint64 a0 asm("a0") = 0x26;
    register uint64 a1 asm("a1") = (uint64)id;
    register uint64 a2 asm("a2") = (uint64)n;

    asm volatile("ecall"
        : "+r"(a0)
        : "r"(a1), "r"(a2)
        : "memory"
    );

    return (int)a0;
}

char getc() {
    register uint64 a0 asm("a0") = 0x41;

    __asm__ volatile(
        "ecall"
        : "+r"(a0)
        :
        : "memory"
    );

    return (char)a0;
}

void putc(char c) {

    register uint64 a0 __asm__("a0") = 0x42;
    register uint64 a1 __asm__("a1") = (uint64)c;

    __asm__ volatile(
        "ecall"
        : "+r"(a0)
        : "r"(a1)
        : "memory"
    );
}

int time_sleep(time_t time) {
    register uint64 a0 asm("a0") = 0x31;
    register uint64 a1 asm("a1") = (uint64)time;

    __asm__ volatile(
        "ecall"
        : "+r"(a0)
        : "r"(a1)
        : "memory"
    );

    return (int)a0;
}
