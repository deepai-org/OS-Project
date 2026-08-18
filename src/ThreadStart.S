.section .text

.extern isRunningSystemThreadC
.extern getRunningUserStackTopC
.extern threadWrapperC

.align 4

.global threadStart
.type threadStart, @function

threadStart:
    /*
     * contextSwitch nas je doveo na sistemski stek niti.
     */
    call isRunningSystemThreadC

    /*
     * a0 != 0 znaci sistemska nit.
     */
    bnez a0, system_thread


user_thread:
    /*
     * Trenutni sp je sistemski stek.
     * Cuvamo ga u sscratch za kasnije trapove iz user rezima.
     */
    csrw sscratch, sp

    /*
     * Prelazimo na korisnički stek.
     */
    call getRunningUserStackTopC
    mv sp, a0

    /*
     * SPP = 0 i sret u user mode.
     */
    call _ZN5Riscv11popSppSpieEv

    /*
     * Ovde se izvrsavanje nastavlja u user rezimu.
     */
    call threadWrapperC

1:
    j 1b


system_thread:
    csrw sscratch, zero
    li t0, 2
    csrs sstatus, t0
    call threadWrapperC

2:
    j 2b

.size threadStart, .-threadStart