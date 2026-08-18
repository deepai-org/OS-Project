# RISC-V Operating System Kernel

A lightweight educational operating system kernel implemented in **C/C++ and RISC-V assembly**.

The project implements core operating system concepts including memory management, threads, scheduling, synchronization, system calls, privilege-level transitions, interrupts, and console I/O. It runs on the **RISC-V 64-bit architecture** using **QEMU**.

## Features

### Memory Management

* Custom dynamic memory allocator
* First-fit allocation strategy
* Memory block splitting
* Automatic merging of adjacent free blocks
* Custom `new` and `delete` operators

### Threads

* User and system threads
* Thread creation and termination
* Context switching written in RISC-V assembly
* FIFO scheduler
* Idle thread
* Timer-based preemption
* Per-thread time slices

### Synchronization

Semaphore implementation supporting:

* `wait`
* `signal`
* `wait_n`
* `signal_n`

Threads waiting on semaphores are blocked and returned to the scheduler when the required resources become available.

### System Calls

User programs communicate with the kernel through the RISC-V `ecall` instruction.

Implemented system calls include operations for:

* memory allocation
* memory deallocation
* thread management
* thread synchronization
* semaphores
* sleeping
* console input/output

### User / Supervisor Mode

The kernel supports transitions between **RISC-V User Mode** and **Supervisor Mode**.

System calls and interrupts enter the kernel through a supervisor trap handler, while `sret` is used to return execution to user mode.

Relevant RISC-V CSRs include:

* `scause`
* `sepc`
* `sstatus`
* `stvec`
* `sscratch`
* `sie`
* `sip`

### Interrupt Handling

The kernel handles:

* timer interrupts
* UART external interrupts
* supervisor software interrupts
* synchronous exceptions and system calls

The **PLIC (Platform-Level Interrupt Controller)** is used for external interrupt handling.

### Console

Asynchronous console I/O is implemented using:

* UART interrupts
* input and output buffers
* a dedicated kernel output thread

This allows user threads to perform console operations without directly accessing hardware.

## Kernel Architecture

The project is organized around several core components:

```text
MemoryAllocator
      |
      v
     TCB <---- Scheduler
      |
      +---- SleepingThreads
      |
      +---- Semaphores
      |
      v
System Call Interface
      |
      v
Supervisor Trap Handler
      |
      +---- Timer Interrupts
      +---- UART Interrupts
      +---- Exceptions
```

Context switching and privilege transitions are implemented partly in **RISC-V assembly**, while most kernel functionality is implemented in **C++**.

## Thread Scheduling

Runnable threads are stored in a FIFO scheduler.

When a thread:

* blocks,
* finishes,
* explicitly dispatches, or
* exhausts its time slice,

the kernel selects another runnable thread and performs a context switch.

If no runnable thread exists, the **idle thread** is executed.

## Building and Running

The project requires a RISC-V cross-compiler and QEMU.

Example toolchain:

```bash
riscv64-linux-gnu-g++
riscv64-linux-gnu-gcc
riscv64-linux-gnu-ld
qemu-system-riscv64
```

Build the kernel:

```bash
make
```

Run it using QEMU:

```bash
make qemu
```

The kernel runs on the QEMU `virt` machine using a single RISC-V CPU core.

## Debugging

The project can be debugged using **GDB** together with QEMU.


## Technologies

* C++
* C
* RISC-V Assembly
* QEMU
* GDB
* GNU Make
* Git

## Purpose

This project was developed as part of an **Operating Systems course** to explore the implementation of fundamental operating system mechanisms at kernel level.

The main goal is to provide practical experience with low-level concepts such as context switching, privilege levels, interrupts, system calls, scheduling, memory management, and thread synchronization.
