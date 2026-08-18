//
// Created by os on 7/10/26.
//

#ifndef PROJECT_BASE_V1_1_RISCV_HPP
#define PROJECT_BASE_V1_1_RISCV_HPP
#include "../lib/hw.h"
#include "../lib/console.h"

class Riscv {
public:
    static void handleSupervisorTrap(uint64* registers);

    static uint64 r_scause() {
        uint64 value;
        __asm__ volatile("csrr %0, scause" : "=r"(value));
        return value;
    }

    static uint64 r_sepc() {
        uint64 value;
        __asm__ volatile("csrr %0, sepc" : "=r"(value));
        return value;
    }

    static void w_sepc(uint64 value) {
        __asm__ volatile("csrw sepc, %0" : : "r"(value));
    }

    static void w_stvec(uint64 value) {
        __asm__ volatile("csrw stvec, %0" : : "r"(value));
    }

    static void w_sscratch(uint64 value) {
        __asm__ volatile("csrw sscratch, %0" : : "r"(value));
    }

    static uint64 r_sstatus() {
        uint64 value;
        __asm__ volatile("csrr %0, sstatus" : "=r"(value));
        return value;
    }

    static void w_sstatus(uint64 value) {
        __asm__ volatile("csrw sstatus, %0" : : "r"(value));
    }
    static void popOff();

    static bool interruptsEnabled();

    static void pushOff();
    static constexpr uint64 SSTATUS_SIE = (1UL << 1);
    static constexpr uint64 SIE_SEIE    = 1UL << 9;
    static uint64 r_stval() {
        uint64 value;
        __asm__ volatile("csrr %0, stval" : "=r"(value));
        return value;
    }
    static uint64 r_stvec() {
        uint64 x;
        asm volatile("csrr %0, stvec" : "=r"(x));
        return x;
    }

    static uint64 r_sie() {
        uint64 x;
        __asm__ volatile("csrr %0, sie" : "=r"(x));
        return x;
    }

    static void w_sie(uint64 x) {
        __asm__ volatile("csrw sie, %0" : : "r"(x));
    }

    static uint64 r_sip() {
        uint64 x;
        __asm__ volatile("csrr %0, sip" : "=r"(x));
        return x;
    }

    static void w_sip(uint64 x) {
        __asm__ volatile("csrw sip, %0" : : "r"(x));
    }

    static void ms_sstatus(uint64 mask)
    {
        __asm__ volatile("csrs sstatus, %0" : : "r"(mask));
    }

    static void mc_sstatus(uint64 mask)
    {
        __asm__ volatile("csrc sstatus, %0" : : "r"(mask));
    }

    static void mc_sip(uint64 mask)
    {
        __asm__ volatile("csrc sip, %0" : : "r"(mask));
    }

    static void popSppSpie();
    static constexpr uint64 SSTATUS_SPIE = 1UL << 5;
    static constexpr uint64 SSTATUS_SPP  = 1UL << 8;
    static constexpr uint64 SIP_SSIP = 1UL << 1;
private:
    static int interruptLockDepth;
    static bool interruptsWereEnabled;
};

extern "C" void supervisorTrap();
#endif //PROJECT_BASE_V1_1_RISCV_HPP
