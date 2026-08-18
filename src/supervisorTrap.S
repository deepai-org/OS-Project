.section .text

.extern handleSupervisorTrapC

.align 4
.global supervisorTrap
.type supervisorTrap, @function

/*
 * Trap frame:
 *
 *   0(sp)    x0
 *   8(sp)    x1
 *  16(sp)    x2 rezervisano
 *  24(sp)    x3
 *  ...
 * 248(sp)    x31
 * 256(sp)    sepc
 * 264(sp)    sstatus
 * 272(sp)    user sp
 * 280(sp)    rezervisano
 *
 * Ukupno: 288 bajtova
 */

supervisorTrap:
    addi sp, sp, -16
    sd t0, 0(sp)

    csrr t0, sstatus
    andi t0, t0, 0x100

    bnez t0, trap_from_supervisor


trap_from_user:
    ld t0, 0(sp)
    addi sp, sp, 16

    /*
     * sp postaje sistemski stek,
     * sscratch postaje korisnički sp.
     */
    csrrw sp, sscratch, sp

    j create_trap_frame


trap_from_supervisor:
    ld t0, 0(sp)
    addi sp, sp, 16


create_trap_frame:
    addi sp, sp, -288

    sd x1,    8(sp)

    sd x3,   24(sp)
    sd x4,   32(sp)
    sd x5,   40(sp)
    sd x6,   48(sp)
    sd x7,   56(sp)
    sd x8,   64(sp)
    sd x9,   72(sp)
    sd x10,  80(sp)
    sd x11,  88(sp)
    sd x12,  96(sp)
    sd x13, 104(sp)
    sd x14, 112(sp)
    sd x15, 120(sp)
    sd x16, 128(sp)
    sd x17, 136(sp)
    sd x18, 144(sp)
    sd x19, 152(sp)
    sd x20, 160(sp)
    sd x21, 168(sp)
    sd x22, 176(sp)
    sd x23, 184(sp)
    sd x24, 192(sp)
    sd x25, 200(sp)
    sd x26, 208(sp)
    sd x27, 216(sp)
    sd x28, 224(sp)
    sd x29, 232(sp)
    sd x30, 240(sp)
    sd x31, 248(sp)

    csrr t0, sepc
    sd t0, 256(sp)

    csrr t0, sstatus
    sd t0, 264(sp)

    andi t0, t0, 0x100
    bnez t0, save_supervisor_sp


save_user_sp:
    csrr t0, sscratch
    sd t0, 272(sp)

    j call_handler


save_supervisor_sp:
    sd zero, 272(sp)


call_handler:
    mv a0, sp
    call handleSupervisorTrapC


restore_context:
    /*
     * Handler moze da promeni registers[32],
     * zato se sepc vraća iz trap frame-a.
     */
    ld t0, 256(sp)
    csrw sepc, t0

    ld t0, 264(sp)
    csrw sstatus, t0

    ld x1,    8(sp)

    ld x3,   24(sp)
    ld x4,   32(sp)

    ld x6,   48(sp)
    ld x7,   56(sp)
    ld x8,   64(sp)
    ld x9,   72(sp)
    ld x10,  80(sp)
    ld x11,  88(sp)
    ld x12,  96(sp)
    ld x13, 104(sp)
    ld x14, 112(sp)
    ld x15, 120(sp)
    ld x16, 128(sp)
    ld x17, 136(sp)
    ld x18, 144(sp)
    ld x19, 152(sp)
    ld x20, 160(sp)
    ld x21, 168(sp)
    ld x22, 176(sp)
    ld x23, 184(sp)
    ld x24, 192(sp)
    ld x25, 200(sp)
    ld x26, 208(sp)
    ld x27, 216(sp)
    ld x28, 224(sp)
    ld x29, 232(sp)
    ld x30, 240(sp)
    ld x31, 248(sp)

    ld t0, 264(sp)
    andi t0, t0, 0x100

    bnez t0, return_to_supervisor


return_to_user:
    ld t0, 272(sp)
    csrw sscratch, t0

    ld x5, 40(sp)

    addi sp, sp, 288

    /*
     * sp postaje user sp,
     * sscratch postaje sistemski sp.
     */
    csrrw sp, sscratch, sp

    sret


return_to_supervisor:
    csrw sscratch, zero

    ld x5, 40(sp)

    addi sp, sp, 288

    sret


.size supervisorTrap, .-supervisorTrap