//
// Created by os on 7/10/26.
//

#ifndef PROJECT_BASE_V1_1_SYSCALL_C_HPP
#define PROJECT_BASE_V1_1_SYSCALL_C_HPP
#include "../lib/hw.h"
class TCB;
typedef TCB* thread_t;
class _Semaphore;
typedef _Semaphore* sem_t;
const int EOF = -1;
void *mem_alloc(size_t size);
int mem_free(void* ptr);
int thread_create(
        thread_t* handle,
        void (*start_routine)(void*),
        void* arg
        );
int thread_exit();
void thread_dispatch();
int sem_open(sem_t* handle, unsigned init);
int sem_close(sem_t handle);
int sem_wait(sem_t id);
int sem_signal(sem_t id);
int sem_wait_n(sem_t id, unsigned n);
int sem_signal_n(sem_t id, unsigned n);
char getc();
void putc(char c);
int time_sleep(time_t time);

#endif
