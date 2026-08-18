.section .text

.global _ZN5Riscv11popSppSpieEv
.type _ZN5Riscv11popSppSpieEv, @function

_ZN5Riscv11popSppSpieEv:
    # ra je adresa instrukcije posle:
    # call Riscv::popSppSpie()
    csrw sepc, ra

    # SPP = 0
    # sret će preci u user mode
    li t0, 0x100
    csrc sstatus, t0

    # SPIE = 1
    # nakon sret-a prekidi će biti ukljuceni
    li t0, 0x20
    csrs sstatus, t0

    sret