
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000c117          	auipc	sp,0xc
    80000004:	ad813103          	ld	sp,-1320(sp) # 8000bad8 <_GLOBAL_OFFSET_TABLE_+0x38>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	40d060ef          	jal	ra,80006c28 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <supervisorTrap>:
 *
 * Ukupno: 288 bajtova
 */

supervisorTrap:
    addi sp, sp, -16
    80001000:	ff010113          	addi	sp,sp,-16
    sd t0, 0(sp)
    80001004:	00513023          	sd	t0,0(sp)

    csrr t0, sstatus
    80001008:	100022f3          	csrr	t0,sstatus
    andi t0, t0, 0x100
    8000100c:	1002f293          	andi	t0,t0,256

    bnez t0, trap_from_supervisor
    80001010:	00029a63          	bnez	t0,80001024 <trap_from_supervisor>

0000000080001014 <trap_from_user>:


trap_from_user:
    ld t0, 0(sp)
    80001014:	00013283          	ld	t0,0(sp)
    addi sp, sp, 16
    80001018:	01010113          	addi	sp,sp,16

    /*
     * sp postaje sistemski stek,
     * sscratch postaje korisnički sp.
     */
    csrrw sp, sscratch, sp
    8000101c:	14011173          	csrrw	sp,sscratch,sp

    j create_trap_frame
    80001020:	00c0006f          	j	8000102c <create_trap_frame>

0000000080001024 <trap_from_supervisor>:


trap_from_supervisor:
    ld t0, 0(sp)
    80001024:	00013283          	ld	t0,0(sp)
    addi sp, sp, 16
    80001028:	01010113          	addi	sp,sp,16

000000008000102c <create_trap_frame>:


create_trap_frame:
    addi sp, sp, -288
    8000102c:	ee010113          	addi	sp,sp,-288

    sd x1,    8(sp)
    80001030:	00113423          	sd	ra,8(sp)

    sd x3,   24(sp)
    80001034:	00313c23          	sd	gp,24(sp)
    sd x4,   32(sp)
    80001038:	02413023          	sd	tp,32(sp)
    sd x5,   40(sp)
    8000103c:	02513423          	sd	t0,40(sp)
    sd x6,   48(sp)
    80001040:	02613823          	sd	t1,48(sp)
    sd x7,   56(sp)
    80001044:	02713c23          	sd	t2,56(sp)
    sd x8,   64(sp)
    80001048:	04813023          	sd	s0,64(sp)
    sd x9,   72(sp)
    8000104c:	04913423          	sd	s1,72(sp)
    sd x10,  80(sp)
    80001050:	04a13823          	sd	a0,80(sp)
    sd x11,  88(sp)
    80001054:	04b13c23          	sd	a1,88(sp)
    sd x12,  96(sp)
    80001058:	06c13023          	sd	a2,96(sp)
    sd x13, 104(sp)
    8000105c:	06d13423          	sd	a3,104(sp)
    sd x14, 112(sp)
    80001060:	06e13823          	sd	a4,112(sp)
    sd x15, 120(sp)
    80001064:	06f13c23          	sd	a5,120(sp)
    sd x16, 128(sp)
    80001068:	09013023          	sd	a6,128(sp)
    sd x17, 136(sp)
    8000106c:	09113423          	sd	a7,136(sp)
    sd x18, 144(sp)
    80001070:	09213823          	sd	s2,144(sp)
    sd x19, 152(sp)
    80001074:	09313c23          	sd	s3,152(sp)
    sd x20, 160(sp)
    80001078:	0b413023          	sd	s4,160(sp)
    sd x21, 168(sp)
    8000107c:	0b513423          	sd	s5,168(sp)
    sd x22, 176(sp)
    80001080:	0b613823          	sd	s6,176(sp)
    sd x23, 184(sp)
    80001084:	0b713c23          	sd	s7,184(sp)
    sd x24, 192(sp)
    80001088:	0d813023          	sd	s8,192(sp)
    sd x25, 200(sp)
    8000108c:	0d913423          	sd	s9,200(sp)
    sd x26, 208(sp)
    80001090:	0da13823          	sd	s10,208(sp)
    sd x27, 216(sp)
    80001094:	0db13c23          	sd	s11,216(sp)
    sd x28, 224(sp)
    80001098:	0fc13023          	sd	t3,224(sp)
    sd x29, 232(sp)
    8000109c:	0fd13423          	sd	t4,232(sp)
    sd x30, 240(sp)
    800010a0:	0fe13823          	sd	t5,240(sp)
    sd x31, 248(sp)
    800010a4:	0ff13c23          	sd	t6,248(sp)

    csrr t0, sepc
    800010a8:	141022f3          	csrr	t0,sepc
    sd t0, 256(sp)
    800010ac:	10513023          	sd	t0,256(sp)

    csrr t0, sstatus
    800010b0:	100022f3          	csrr	t0,sstatus
    sd t0, 264(sp)
    800010b4:	10513423          	sd	t0,264(sp)

    andi t0, t0, 0x100
    800010b8:	1002f293          	andi	t0,t0,256
    bnez t0, save_supervisor_sp
    800010bc:	00029863          	bnez	t0,800010cc <save_supervisor_sp>

00000000800010c0 <save_user_sp>:


save_user_sp:
    csrr t0, sscratch
    800010c0:	140022f3          	csrr	t0,sscratch
    sd t0, 272(sp)
    800010c4:	10513823          	sd	t0,272(sp)

    j call_handler
    800010c8:	0080006f          	j	800010d0 <call_handler>

00000000800010cc <save_supervisor_sp>:


save_supervisor_sp:
    sd zero, 272(sp)
    800010cc:	10013823          	sd	zero,272(sp)

00000000800010d0 <call_handler>:


call_handler:
    mv a0, sp
    800010d0:	00010513          	mv	a0,sp
    call handleSupervisorTrapC
    800010d4:	274020ef          	jal	ra,80003348 <handleSupervisorTrapC>

00000000800010d8 <restore_context>:
restore_context:
    /*
     * Handler može da promeni registers[32],
     * zato se sepc vraća iz trap frame-a.
     */
    ld t0, 256(sp)
    800010d8:	10013283          	ld	t0,256(sp)
    csrw sepc, t0
    800010dc:	14129073          	csrw	sepc,t0

    ld t0, 264(sp)
    800010e0:	10813283          	ld	t0,264(sp)
    csrw sstatus, t0
    800010e4:	10029073          	csrw	sstatus,t0

    ld x1,    8(sp)
    800010e8:	00813083          	ld	ra,8(sp)

    ld x3,   24(sp)
    800010ec:	01813183          	ld	gp,24(sp)
    ld x4,   32(sp)
    800010f0:	02013203          	ld	tp,32(sp)

    ld x6,   48(sp)
    800010f4:	03013303          	ld	t1,48(sp)
    ld x7,   56(sp)
    800010f8:	03813383          	ld	t2,56(sp)
    ld x8,   64(sp)
    800010fc:	04013403          	ld	s0,64(sp)
    ld x9,   72(sp)
    80001100:	04813483          	ld	s1,72(sp)
    ld x10,  80(sp)
    80001104:	05013503          	ld	a0,80(sp)
    ld x11,  88(sp)
    80001108:	05813583          	ld	a1,88(sp)
    ld x12,  96(sp)
    8000110c:	06013603          	ld	a2,96(sp)
    ld x13, 104(sp)
    80001110:	06813683          	ld	a3,104(sp)
    ld x14, 112(sp)
    80001114:	07013703          	ld	a4,112(sp)
    ld x15, 120(sp)
    80001118:	07813783          	ld	a5,120(sp)
    ld x16, 128(sp)
    8000111c:	08013803          	ld	a6,128(sp)
    ld x17, 136(sp)
    80001120:	08813883          	ld	a7,136(sp)
    ld x18, 144(sp)
    80001124:	09013903          	ld	s2,144(sp)
    ld x19, 152(sp)
    80001128:	09813983          	ld	s3,152(sp)
    ld x20, 160(sp)
    8000112c:	0a013a03          	ld	s4,160(sp)
    ld x21, 168(sp)
    80001130:	0a813a83          	ld	s5,168(sp)
    ld x22, 176(sp)
    80001134:	0b013b03          	ld	s6,176(sp)
    ld x23, 184(sp)
    80001138:	0b813b83          	ld	s7,184(sp)
    ld x24, 192(sp)
    8000113c:	0c013c03          	ld	s8,192(sp)
    ld x25, 200(sp)
    80001140:	0c813c83          	ld	s9,200(sp)
    ld x26, 208(sp)
    80001144:	0d013d03          	ld	s10,208(sp)
    ld x27, 216(sp)
    80001148:	0d813d83          	ld	s11,216(sp)
    ld x28, 224(sp)
    8000114c:	0e013e03          	ld	t3,224(sp)
    ld x29, 232(sp)
    80001150:	0e813e83          	ld	t4,232(sp)
    ld x30, 240(sp)
    80001154:	0f013f03          	ld	t5,240(sp)
    ld x31, 248(sp)
    80001158:	0f813f83          	ld	t6,248(sp)

    ld t0, 264(sp)
    8000115c:	10813283          	ld	t0,264(sp)
    andi t0, t0, 0x100
    80001160:	1002f293          	andi	t0,t0,256

    bnez t0, return_to_supervisor
    80001164:	00029e63          	bnez	t0,80001180 <return_to_supervisor>

0000000080001168 <return_to_user>:


return_to_user:
    ld t0, 272(sp)
    80001168:	11013283          	ld	t0,272(sp)
    csrw sscratch, t0
    8000116c:	14029073          	csrw	sscratch,t0

    ld x5, 40(sp)
    80001170:	02813283          	ld	t0,40(sp)

    addi sp, sp, 288
    80001174:	12010113          	addi	sp,sp,288

    /*
     * sp postaje user sp,
     * sscratch postaje sistemski sp.
     */
    csrrw sp, sscratch, sp
    80001178:	14011173          	csrrw	sp,sscratch,sp

    sret
    8000117c:	10200073          	sret

0000000080001180 <return_to_supervisor>:


return_to_supervisor:
    csrw sscratch, zero
    80001180:	14001073          	csrw	sscratch,zero

    ld x5, 40(sp)
    80001184:	02813283          	ld	t0,40(sp)

    addi sp, sp, 288
    80001188:	12010113          	addi	sp,sp,288

    sret
    8000118c:	10200073          	sret

0000000080001190 <contextSwitch>:

.global contextSwitch
.type contextSwitch, @function

contextSwitch:
    sd ra,   0(a0)
    80001190:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp,   8(a0)
    80001194:	00253423          	sd	sp,8(a0)
    sd s0,  16(a0)
    80001198:	00853823          	sd	s0,16(a0)
    sd s1,  24(a0)
    8000119c:	00953c23          	sd	s1,24(a0)
    sd s2,  32(a0)
    800011a0:	03253023          	sd	s2,32(a0)
    sd s3,  40(a0)
    800011a4:	03353423          	sd	s3,40(a0)
    sd s4,  48(a0)
    800011a8:	03453823          	sd	s4,48(a0)
    sd s5,  56(a0)
    800011ac:	03553c23          	sd	s5,56(a0)
    sd s6,  64(a0)
    800011b0:	05653023          	sd	s6,64(a0)
    sd s7,  72(a0)
    800011b4:	05753423          	sd	s7,72(a0)
    sd s8,  80(a0)
    800011b8:	05853823          	sd	s8,80(a0)
    sd s9,  88(a0)
    800011bc:	05953c23          	sd	s9,88(a0)
    sd s10, 96(a0)
    800011c0:	07a53023          	sd	s10,96(a0)
    sd s11, 104(a0)
    800011c4:	07b53423          	sd	s11,104(a0)

    ld ra,   0(a1)
    800011c8:	0005b083          	ld	ra,0(a1)
    ld sp,   8(a1)
    800011cc:	0085b103          	ld	sp,8(a1)
    ld s0,  16(a1)
    800011d0:	0105b403          	ld	s0,16(a1)
    ld s1,  24(a1)
    800011d4:	0185b483          	ld	s1,24(a1)
    ld s2,  32(a1)
    800011d8:	0205b903          	ld	s2,32(a1)
    ld s3,  40(a1)
    800011dc:	0285b983          	ld	s3,40(a1)
    ld s4,  48(a1)
    800011e0:	0305ba03          	ld	s4,48(a1)
    ld s5,  56(a1)
    800011e4:	0385ba83          	ld	s5,56(a1)
    ld s6,  64(a1)
    800011e8:	0405bb03          	ld	s6,64(a1)
    ld s7,  72(a1)
    800011ec:	0485bb83          	ld	s7,72(a1)
    ld s8,  80(a1)
    800011f0:	0505bc03          	ld	s8,80(a1)
    ld s9,  88(a1)
    800011f4:	0585bc83          	ld	s9,88(a1)
    ld s10, 96(a1)
    800011f8:	0605bd03          	ld	s10,96(a1)
    ld s11, 104(a1)
    800011fc:	0685bd83          	ld	s11,104(a1)

    80001200:	00008067          	ret
	...

0000000080001210 <threadStart>:

threadStart:
    /*
     * contextSwitch nas je doveo na sistemski stek niti.
     */
    call isRunningSystemThreadC
    80001210:	129010ef          	jal	ra,80002b38 <isRunningSystemThreadC>

    /*
     * a0 != 0 znači sistemska nit.
     */
    bnez a0, system_thread
    80001214:	00051e63          	bnez	a0,80001230 <system_thread>

0000000080001218 <user_thread>:
user_thread:
    /*
     * Trenutni sp je sistemski stek.
     * Čuvamo ga u sscratch za kasnije trapove iz user režima.
     */
    csrw sscratch, sp
    80001218:	14011073          	csrw	sscratch,sp

    /*
     * Prelazimo na korisnički stek.
     */
    call getRunningUserStackTopC
    8000121c:	0cd010ef          	jal	ra,80002ae8 <getRunningUserStackTopC>
    mv sp, a0
    80001220:	00050113          	mv	sp,a0

    /*
     * SPP = 0 i sret u user mode.
     */
    call _ZN5Riscv11popSppSpieEv
    80001224:	02c000ef          	jal	ra,80001250 <_ZN5Riscv11popSppSpieEv>

    /*
     * Ovde se izvršavanje nastavlja u user režimu.
     */
    call threadWrapperC
    80001228:	0a9010ef          	jal	ra,80002ad0 <threadWrapperC>

1:
    j 1b
    8000122c:	0000006f          	j	8000122c <user_thread+0x14>

0000000080001230 <system_thread>:


system_thread:
    csrw sscratch, zero
    80001230:	14001073          	csrw	sscratch,zero
    li t0, 2
    80001234:	00200293          	li	t0,2
    csrs sstatus, t0
    80001238:	1002a073          	csrs	sstatus,t0
    call threadWrapperC
    8000123c:	095010ef          	jal	ra,80002ad0 <threadWrapperC>

2:
    j 2b
    80001240:	0000006f          	j	80001240 <system_thread+0x10>
	...

0000000080001250 <_ZN5Riscv11popSppSpieEv>:
.type _ZN5Riscv11popSppSpieEv, @function

_ZN5Riscv11popSppSpieEv:
    # ra je adresa instrukcije posle:
    # call Riscv::popSppSpie()
    csrw sepc, ra
    80001250:	14109073          	csrw	sepc,ra

    # SPP = 0
    # sret će preći u user mode
    li t0, 0x100
    80001254:	10000293          	li	t0,256
    csrc sstatus, t0
    80001258:	1002b073          	csrc	sstatus,t0

    # SPIE = 1
    # nakon sret-a prekidi će biti uključeni
    li t0, 0x20
    8000125c:	02000293          	li	t0,32
    csrs sstatus, t0
    80001260:	1002a073          	csrs	sstatus,t0

    80001264:	10200073          	sret

0000000080001268 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001268:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    8000126c:	00b29a63          	bne	t0,a1,80001280 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001270:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    80001274:	fe029ae3          	bnez	t0,80001268 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001278:	00000513          	li	a0,0
    jr ra                  # Return.
    8000127c:	00008067          	ret

0000000080001280 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001280:	00100513          	li	a0,1
    80001284:	00008067          	ret

0000000080001288 <_Z9mem_allocm>:
//
// Created by os on 7/10/26.
//
#include "../h/syscall_c.hpp"
#include "../lib/console.h"
void* mem_alloc(size_t size) {
    80001288:	ff010113          	addi	sp,sp,-16
    8000128c:	00813423          	sd	s0,8(sp)
    80001290:	01010413          	addi	s0,sp,16
    size_t numOfBlocks =
        (size + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE;
    80001294:	03f50593          	addi	a1,a0,63

    register uint64 a0 asm("a0") = 0x01;
    80001298:	00100513          	li	a0,1
    register uint64 a1 asm("a1") = (uint64)numOfBlocks;
    8000129c:	0065d593          	srli	a1,a1,0x6
    __asm__ volatile(
        "ecall"
        : "+r"(a0)
        : "r"(a1)
        : "memory"
    );
    800012a0:	00000073          	ecall

    return (void*)a0;
}
    800012a4:	00813403          	ld	s0,8(sp)
    800012a8:	01010113          	addi	sp,sp,16
    800012ac:	00008067          	ret

00000000800012b0 <_Z8mem_freePv>:

int mem_free(void* ptr) {
    800012b0:	ff010113          	addi	sp,sp,-16
    800012b4:	00813423          	sd	s0,8(sp)
    800012b8:	01010413          	addi	s0,sp,16
    800012bc:	00050593          	mv	a1,a0
    register uint64 a0 asm("a0") = 0x02;
    800012c0:	00200513          	li	a0,2
    __asm__ volatile(
        "ecall"
        : "+r"(a0)
        : "r"(a1)
        : "memory"
    );
    800012c4:	00000073          	ecall

    return (int)a0;
}
    800012c8:	0005051b          	sext.w	a0,a0
    800012cc:	00813403          	ld	s0,8(sp)
    800012d0:	01010113          	addi	sp,sp,16
    800012d4:	00008067          	ret

00000000800012d8 <_Z13thread_createPP3TCBPFvPvES2_>:
int thread_create(thread_t* handle,
                  void (*start_routine)(void*),
                  void* arg)
{

    if (handle == nullptr) {
    800012d8:	0a050a63          	beqz	a0,8000138c <_Z13thread_createPP3TCBPFvPvES2_+0xb4>
{
    800012dc:	fd010113          	addi	sp,sp,-48
    800012e0:	02113423          	sd	ra,40(sp)
    800012e4:	02813023          	sd	s0,32(sp)
    800012e8:	00913c23          	sd	s1,24(sp)
    800012ec:	01213823          	sd	s2,16(sp)
    800012f0:	01313423          	sd	s3,8(sp)
    800012f4:	01413023          	sd	s4,0(sp)
    800012f8:	03010413          	addi	s0,sp,48
    800012fc:	00050493          	mv	s1,a0
    80001300:	00058913          	mv	s2,a1
    80001304:	00060a13          	mv	s4,a2
        return -1;
    }

    uint64* stack = nullptr;

    uint64* systemStack = (uint64*)mem_alloc(
    80001308:	00008537          	lui	a0,0x8
    8000130c:	00000097          	auipc	ra,0x0
    80001310:	f7c080e7          	jalr	-132(ra) # 80001288 <_Z9mem_allocm>
    80001314:	00050993          	mv	s3,a0
        DEFAULT_STACK_SIZE * sizeof(uint64)
    );

    if (systemStack == nullptr) {
    80001318:	06050e63          	beqz	a0,80001394 <_Z13thread_createPP3TCBPFvPvES2_+0xbc>
        return -1;
    }

    if (start_routine != nullptr) {
    8000131c:	06090463          	beqz	s2,80001384 <_Z13thread_createPP3TCBPFvPvES2_+0xac>
        stack = (uint64*)mem_alloc(
    80001320:	00008537          	lui	a0,0x8
    80001324:	00000097          	auipc	ra,0x0
    80001328:	f64080e7          	jalr	-156(ra) # 80001288 <_Z9mem_allocm>
    8000132c:	00050713          	mv	a4,a0
            DEFAULT_STACK_SIZE * sizeof(uint64)
        );

        if (stack == nullptr) {
    80001330:	04050063          	beqz	a0,80001370 <_Z13thread_createPP3TCBPFvPvES2_+0x98>
            mem_free(systemStack);
            return -1;
        }
    }

    register uint64 a0 asm("a0") = 0x11;
    80001334:	01100513          	li	a0,17
    register uint64 a1 asm("a1") = (uint64)handle;
    80001338:	00048593          	mv	a1,s1
    register uint64 a2 asm("a2") = (uint64)start_routine;
    8000133c:	00090613          	mv	a2,s2
    register uint64 a3 asm("a3") = (uint64)arg;
    80001340:	000a0693          	mv	a3,s4
    register uint64 a4 asm("a4") = (uint64)stack;
    register uint64 a5 asm("a5") = (uint64)systemStack;
    80001344:	00098793          	mv	a5,s3
    __asm__ volatile(
        "ecall"
        : "+r"(a0)
        : "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5)
        : "memory"
    );
    80001348:	00000073          	ecall

    int result = (int)a0;
    8000134c:	0005051b          	sext.w	a0,a0

    return result;
}
    80001350:	02813083          	ld	ra,40(sp)
    80001354:	02013403          	ld	s0,32(sp)
    80001358:	01813483          	ld	s1,24(sp)
    8000135c:	01013903          	ld	s2,16(sp)
    80001360:	00813983          	ld	s3,8(sp)
    80001364:	00013a03          	ld	s4,0(sp)
    80001368:	03010113          	addi	sp,sp,48
    8000136c:	00008067          	ret
            mem_free(systemStack);
    80001370:	00098513          	mv	a0,s3
    80001374:	00000097          	auipc	ra,0x0
    80001378:	f3c080e7          	jalr	-196(ra) # 800012b0 <_Z8mem_freePv>
            return -1;
    8000137c:	fff00513          	li	a0,-1
    80001380:	fd1ff06f          	j	80001350 <_Z13thread_createPP3TCBPFvPvES2_+0x78>
    uint64* stack = nullptr;
    80001384:	00000713          	li	a4,0
    80001388:	fadff06f          	j	80001334 <_Z13thread_createPP3TCBPFvPvES2_+0x5c>
        return -1;
    8000138c:	fff00513          	li	a0,-1
}
    80001390:	00008067          	ret
        return -1;
    80001394:	fff00513          	li	a0,-1
    80001398:	fb9ff06f          	j	80001350 <_Z13thread_createPP3TCBPFvPvES2_+0x78>

000000008000139c <_Z11thread_exitv>:

int thread_exit()
{
    8000139c:	ff010113          	addi	sp,sp,-16
    800013a0:	00813423          	sd	s0,8(sp)
    800013a4:	01010413          	addi	s0,sp,16
    register uint64 a0 asm("a0") = 0x12;
    800013a8:	01200513          	li	a0,18
    __asm__ volatile(
    "ecall"
    : "+r"(a0)
    :
    : "memory"
    );
    800013ac:	00000073          	ecall

    return (int)a0;
}
    800013b0:	0005051b          	sext.w	a0,a0
    800013b4:	00813403          	ld	s0,8(sp)
    800013b8:	01010113          	addi	sp,sp,16
    800013bc:	00008067          	ret

00000000800013c0 <_Z15thread_dispatchv>:

void thread_dispatch()
{
    800013c0:	ff010113          	addi	sp,sp,-16
    800013c4:	00813423          	sd	s0,8(sp)
    800013c8:	01010413          	addi	s0,sp,16
    register uint64 a0 asm("a0") = 0x13;
    800013cc:	01300513          	li	a0,19
    __asm__ volatile(
    "ecall"
    : "+r"(a0)
    :
    : "memory"
    );
    800013d0:	00000073          	ecall
}
    800013d4:	00813403          	ld	s0,8(sp)
    800013d8:	01010113          	addi	sp,sp,16
    800013dc:	00008067          	ret

00000000800013e0 <_Z8sem_openPP10_Semaphorej>:

int sem_open(sem_t* handle, unsigned init) {
    800013e0:	ff010113          	addi	sp,sp,-16
    800013e4:	00813423          	sd	s0,8(sp)
    800013e8:	01010413          	addi	s0,sp,16
    800013ec:	00050793          	mv	a5,a0
    800013f0:	00058613          	mv	a2,a1
    register uint64 a0 asm("a0") = 0x21;
    800013f4:	02100513          	li	a0,33
    register uint64 a1 asm("a1") = (uint64)handle;
    800013f8:	00078593          	mv	a1,a5
    register uint64 a2 asm("a2") = (uint64)init;
    800013fc:	02061613          	slli	a2,a2,0x20
    80001400:	02065613          	srli	a2,a2,0x20

    asm volatile("ecall"
        : "+r"(a0)
        : "r"(a1), "r"(a2)
        : "memory"
    );
    80001404:	00000073          	ecall

    return (int)a0;
}
    80001408:	0005051b          	sext.w	a0,a0
    8000140c:	00813403          	ld	s0,8(sp)
    80001410:	01010113          	addi	sp,sp,16
    80001414:	00008067          	ret

0000000080001418 <_Z9sem_closeP10_Semaphore>:

int sem_close(sem_t handle) {
    80001418:	ff010113          	addi	sp,sp,-16
    8000141c:	00813423          	sd	s0,8(sp)
    80001420:	01010413          	addi	s0,sp,16
    80001424:	00050593          	mv	a1,a0
    register uint64 a0 asm("a0") = 0x22;
    80001428:	02200513          	li	a0,34

    asm volatile("ecall"
        : "+r"(a0)
        : "r"(a1)
        : "memory"
    );
    8000142c:	00000073          	ecall

    return (int)a0;
}
    80001430:	0005051b          	sext.w	a0,a0
    80001434:	00813403          	ld	s0,8(sp)
    80001438:	01010113          	addi	sp,sp,16
    8000143c:	00008067          	ret

0000000080001440 <_Z8sem_waitP10_Semaphore>:

int sem_wait(sem_t id) {
    80001440:	ff010113          	addi	sp,sp,-16
    80001444:	00813423          	sd	s0,8(sp)
    80001448:	01010413          	addi	s0,sp,16
    8000144c:	00050593          	mv	a1,a0
    register uint64 a0 asm("a0") = 0x23;
    80001450:	02300513          	li	a0,35

    asm volatile("ecall"
        : "+r"(a0)
        : "r"(a1)
        : "memory"
    );
    80001454:	00000073          	ecall

    return (int)a0;
}
    80001458:	0005051b          	sext.w	a0,a0
    8000145c:	00813403          	ld	s0,8(sp)
    80001460:	01010113          	addi	sp,sp,16
    80001464:	00008067          	ret

0000000080001468 <_Z10sem_signalP10_Semaphore>:

int sem_signal(sem_t id) {
    80001468:	ff010113          	addi	sp,sp,-16
    8000146c:	00813423          	sd	s0,8(sp)
    80001470:	01010413          	addi	s0,sp,16
    80001474:	00050593          	mv	a1,a0
    register uint64 a0 asm("a0") = 0x24;
    80001478:	02400513          	li	a0,36

    asm volatile("ecall"
        : "+r"(a0)
        : "r"(a1)
        : "memory"
    );
    8000147c:	00000073          	ecall

    return (int)a0;
}
    80001480:	0005051b          	sext.w	a0,a0
    80001484:	00813403          	ld	s0,8(sp)
    80001488:	01010113          	addi	sp,sp,16
    8000148c:	00008067          	ret

0000000080001490 <_Z10sem_wait_nP10_Semaphorej>:

int sem_wait_n(sem_t id, unsigned n) {
    80001490:	ff010113          	addi	sp,sp,-16
    80001494:	00813423          	sd	s0,8(sp)
    80001498:	01010413          	addi	s0,sp,16
    8000149c:	00050793          	mv	a5,a0
    800014a0:	00058613          	mv	a2,a1
    register uint64 a0 asm("a0") = 0x25;
    800014a4:	02500513          	li	a0,37
    register uint64 a1 asm("a1") = (uint64)id;
    800014a8:	00078593          	mv	a1,a5
    register uint64 a2 asm("a2") = (uint64)n;
    800014ac:	02061613          	slli	a2,a2,0x20
    800014b0:	02065613          	srli	a2,a2,0x20

    asm volatile("ecall"
        : "+r"(a0)
        : "r"(a1), "r"(a2)
        : "memory"
    );
    800014b4:	00000073          	ecall

    return (int)a0;
}
    800014b8:	0005051b          	sext.w	a0,a0
    800014bc:	00813403          	ld	s0,8(sp)
    800014c0:	01010113          	addi	sp,sp,16
    800014c4:	00008067          	ret

00000000800014c8 <_Z12sem_signal_nP10_Semaphorej>:

int sem_signal_n(sem_t id, unsigned n) {
    800014c8:	ff010113          	addi	sp,sp,-16
    800014cc:	00813423          	sd	s0,8(sp)
    800014d0:	01010413          	addi	s0,sp,16
    800014d4:	00050793          	mv	a5,a0
    800014d8:	00058613          	mv	a2,a1
    register uint64 a0 asm("a0") = 0x26;
    800014dc:	02600513          	li	a0,38
    register uint64 a1 asm("a1") = (uint64)id;
    800014e0:	00078593          	mv	a1,a5
    register uint64 a2 asm("a2") = (uint64)n;
    800014e4:	02061613          	slli	a2,a2,0x20
    800014e8:	02065613          	srli	a2,a2,0x20

    asm volatile("ecall"
        : "+r"(a0)
        : "r"(a1), "r"(a2)
        : "memory"
    );
    800014ec:	00000073          	ecall

    return (int)a0;
}
    800014f0:	0005051b          	sext.w	a0,a0
    800014f4:	00813403          	ld	s0,8(sp)
    800014f8:	01010113          	addi	sp,sp,16
    800014fc:	00008067          	ret

0000000080001500 <_Z4getcv>:

char getc() {
    80001500:	ff010113          	addi	sp,sp,-16
    80001504:	00813423          	sd	s0,8(sp)
    80001508:	01010413          	addi	s0,sp,16
    register uint64 a0 asm("a0") = 0x41;
    8000150c:	04100513          	li	a0,65
    __asm__ volatile(
        "ecall"
        : "+r"(a0)
        :
        : "memory"
    );
    80001510:	00000073          	ecall

    return (char)a0;
}
    80001514:	0ff57513          	andi	a0,a0,255
    80001518:	00813403          	ld	s0,8(sp)
    8000151c:	01010113          	addi	sp,sp,16
    80001520:	00008067          	ret

0000000080001524 <_Z4putcc>:

void putc(char c) {
    80001524:	ff010113          	addi	sp,sp,-16
    80001528:	00813423          	sd	s0,8(sp)
    8000152c:	01010413          	addi	s0,sp,16
    80001530:	00050593          	mv	a1,a0

    register uint64 a0 __asm__("a0") = 0x42;
    80001534:	04200513          	li	a0,66
    __asm__ volatile(
        "ecall"
        : "+r"(a0)
        : "r"(a1)
        : "memory"
    );
    80001538:	00000073          	ecall
}
    8000153c:	00813403          	ld	s0,8(sp)
    80001540:	01010113          	addi	sp,sp,16
    80001544:	00008067          	ret

0000000080001548 <_Z10time_sleepm>:

int time_sleep(time_t time) {
    80001548:	ff010113          	addi	sp,sp,-16
    8000154c:	00813423          	sd	s0,8(sp)
    80001550:	01010413          	addi	s0,sp,16
    80001554:	00050593          	mv	a1,a0
    register uint64 a0 asm("a0") = 0x31;
    80001558:	03100513          	li	a0,49
    __asm__ volatile(
        "ecall"
        : "+r"(a0)
        : "r"(a1)
        : "memory"
    );
    8000155c:	00000073          	ecall

    return (int)a0;
}
    80001560:	0005051b          	sext.w	a0,a0
    80001564:	00813403          	ld	s0,8(sp)
    80001568:	01010113          	addi	sp,sp,16
    8000156c:	00008067          	ret

0000000080001570 <_Znwm>:
//

#include "../h/MemoryAllocator.hpp"
#include "../lib/hw.h"

void* operator new(size_t size) {
    80001570:	ff010113          	addi	sp,sp,-16
    80001574:	00113423          	sd	ra,8(sp)
    80001578:	00813023          	sd	s0,0(sp)
    8000157c:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    80001580:	00002097          	auipc	ra,0x2
    80001584:	e44080e7          	jalr	-444(ra) # 800033c4 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001588:	00813083          	ld	ra,8(sp)
    8000158c:	00013403          	ld	s0,0(sp)
    80001590:	01010113          	addi	sp,sp,16
    80001594:	00008067          	ret

0000000080001598 <_Znam>:

void* operator new[](size_t size) {
    80001598:	ff010113          	addi	sp,sp,-16
    8000159c:	00113423          	sd	ra,8(sp)
    800015a0:	00813023          	sd	s0,0(sp)
    800015a4:	01010413          	addi	s0,sp,16
    return MemoryAllocator::mem_alloc(size);
    800015a8:	00002097          	auipc	ra,0x2
    800015ac:	e1c080e7          	jalr	-484(ra) # 800033c4 <_ZN15MemoryAllocator9mem_allocEm>
}
    800015b0:	00813083          	ld	ra,8(sp)
    800015b4:	00013403          	ld	s0,0(sp)
    800015b8:	01010113          	addi	sp,sp,16
    800015bc:	00008067          	ret

00000000800015c0 <_ZdlPv>:

void operator delete(void* ptr) noexcept {
    800015c0:	ff010113          	addi	sp,sp,-16
    800015c4:	00113423          	sd	ra,8(sp)
    800015c8:	00813023          	sd	s0,0(sp)
    800015cc:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(ptr);
    800015d0:	00002097          	auipc	ra,0x2
    800015d4:	eac080e7          	jalr	-340(ra) # 8000347c <_ZN15MemoryAllocator8mem_freeEPv>
}
    800015d8:	00813083          	ld	ra,8(sp)
    800015dc:	00013403          	ld	s0,0(sp)
    800015e0:	01010113          	addi	sp,sp,16
    800015e4:	00008067          	ret

00000000800015e8 <_ZdaPv>:

void operator delete[](void* ptr) noexcept {
    800015e8:	ff010113          	addi	sp,sp,-16
    800015ec:	00113423          	sd	ra,8(sp)
    800015f0:	00813023          	sd	s0,0(sp)
    800015f4:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(ptr);
    800015f8:	00002097          	auipc	ra,0x2
    800015fc:	e84080e7          	jalr	-380(ra) # 8000347c <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001600:	00813083          	ld	ra,8(sp)
    80001604:	00013403          	ld	s0,0(sp)
    80001608:	01010113          	addi	sp,sp,16
    8000160c:	00008067          	ret

0000000080001610 <_ZdlPvm>:

void operator delete(void* ptr, size_t) noexcept {
    80001610:	ff010113          	addi	sp,sp,-16
    80001614:	00113423          	sd	ra,8(sp)
    80001618:	00813023          	sd	s0,0(sp)
    8000161c:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(ptr);
    80001620:	00002097          	auipc	ra,0x2
    80001624:	e5c080e7          	jalr	-420(ra) # 8000347c <_ZN15MemoryAllocator8mem_freeEPv>
}
    80001628:	00813083          	ld	ra,8(sp)
    8000162c:	00013403          	ld	s0,0(sp)
    80001630:	01010113          	addi	sp,sp,16
    80001634:	00008067          	ret

0000000080001638 <_ZdaPvm>:

void operator delete[](void* ptr, size_t) noexcept {
    80001638:	ff010113          	addi	sp,sp,-16
    8000163c:	00113423          	sd	ra,8(sp)
    80001640:	00813023          	sd	s0,0(sp)
    80001644:	01010413          	addi	s0,sp,16
    MemoryAllocator::mem_free(ptr);
    80001648:	00002097          	auipc	ra,0x2
    8000164c:	e34080e7          	jalr	-460(ra) # 8000347c <_ZN15MemoryAllocator8mem_freeEPv>
    80001650:	00813083          	ld	ra,8(sp)
    80001654:	00013403          	ld	s0,0(sp)
    80001658:	01010113          	addi	sp,sp,16
    8000165c:	00008067          	ret

0000000080001660 <_ZN12KernelBufferC1Ev>:
//
// Created by os on 7/19/26.
//
#include "../h/KernelBuffer.hpp"

KernelBuffer::KernelBuffer():
    80001660:	fe010113          	addi	sp,sp,-32
    80001664:	00113c23          	sd	ra,24(sp)
    80001668:	00813823          	sd	s0,16(sp)
    8000166c:	00913423          	sd	s1,8(sp)
    80001670:	02010413          	addi	s0,sp,32
    80001674:	00050493          	mv	s1,a0
    head(0),
    tail(0),
    count(0),
    mutex(1),
    itemAvailable(0),
    spaceAvailable(BUFFER_SIZE)
    80001678:	10053023          	sd	zero,256(a0) # 8100 <_entry-0x7fff7f00>
    8000167c:	10053423          	sd	zero,264(a0)
    80001680:	10053823          	sd	zero,272(a0)
    80001684:	00100593          	li	a1,1
    80001688:	11850513          	addi	a0,a0,280
    8000168c:	00001097          	auipc	ra,0x1
    80001690:	aa8080e7          	jalr	-1368(ra) # 80002134 <_ZN10_SemaphoreC1Ej>
    80001694:	00000593          	li	a1,0
    80001698:	13048513          	addi	a0,s1,304
    8000169c:	00001097          	auipc	ra,0x1
    800016a0:	a98080e7          	jalr	-1384(ra) # 80002134 <_ZN10_SemaphoreC1Ej>
    800016a4:	10000593          	li	a1,256
    800016a8:	14848513          	addi	a0,s1,328
    800016ac:	00001097          	auipc	ra,0x1
    800016b0:	a88080e7          	jalr	-1400(ra) # 80002134 <_ZN10_SemaphoreC1Ej>
     {}
    800016b4:	01813083          	ld	ra,24(sp)
    800016b8:	01013403          	ld	s0,16(sp)
    800016bc:	00813483          	ld	s1,8(sp)
    800016c0:	02010113          	addi	sp,sp,32
    800016c4:	00008067          	ret

00000000800016c8 <_ZN12KernelBuffer3putEc>:

void KernelBuffer::put(char c) {
    800016c8:	fd010113          	addi	sp,sp,-48
    800016cc:	02113423          	sd	ra,40(sp)
    800016d0:	02813023          	sd	s0,32(sp)
    800016d4:	00913c23          	sd	s1,24(sp)
    800016d8:	01213823          	sd	s2,16(sp)
    800016dc:	01313423          	sd	s3,8(sp)
    800016e0:	03010413          	addi	s0,sp,48
    800016e4:	00050493          	mv	s1,a0
    800016e8:	00058913          	mv	s2,a1
    spaceAvailable.wait();
    800016ec:	14850513          	addi	a0,a0,328
    800016f0:	00001097          	auipc	ra,0x1
    800016f4:	bb0080e7          	jalr	-1104(ra) # 800022a0 <_ZN10_Semaphore4waitEv>
    mutex.wait();
    800016f8:	11848993          	addi	s3,s1,280
    800016fc:	00098513          	mv	a0,s3
    80001700:	00001097          	auipc	ra,0x1
    80001704:	ba0080e7          	jalr	-1120(ra) # 800022a0 <_ZN10_Semaphore4waitEv>

    buffer[tail] = c;
    80001708:	1084b783          	ld	a5,264(s1)
    8000170c:	00f48733          	add	a4,s1,a5
    80001710:	01270023          	sb	s2,0(a4)
    tail = (tail + 1) % BUFFER_SIZE;
    80001714:	00178793          	addi	a5,a5,1
    80001718:	0ff7f793          	andi	a5,a5,255
    8000171c:	10f4b423          	sd	a5,264(s1)
    count++;
    80001720:	1104b783          	ld	a5,272(s1)
    80001724:	00178793          	addi	a5,a5,1
    80001728:	10f4b823          	sd	a5,272(s1)
    mutex.signal();
    8000172c:	00098513          	mv	a0,s3
    80001730:	00001097          	auipc	ra,0x1
    80001734:	c64080e7          	jalr	-924(ra) # 80002394 <_ZN10_Semaphore6signalEv>
    itemAvailable.signal();
    80001738:	13048513          	addi	a0,s1,304
    8000173c:	00001097          	auipc	ra,0x1
    80001740:	c58080e7          	jalr	-936(ra) # 80002394 <_ZN10_Semaphore6signalEv>
}
    80001744:	02813083          	ld	ra,40(sp)
    80001748:	02013403          	ld	s0,32(sp)
    8000174c:	01813483          	ld	s1,24(sp)
    80001750:	01013903          	ld	s2,16(sp)
    80001754:	00813983          	ld	s3,8(sp)
    80001758:	03010113          	addi	sp,sp,48
    8000175c:	00008067          	ret

0000000080001760 <_ZN12KernelBuffer3getEv>:

char KernelBuffer::get() {
    80001760:	fd010113          	addi	sp,sp,-48
    80001764:	02113423          	sd	ra,40(sp)
    80001768:	02813023          	sd	s0,32(sp)
    8000176c:	00913c23          	sd	s1,24(sp)
    80001770:	01213823          	sd	s2,16(sp)
    80001774:	01313423          	sd	s3,8(sp)
    80001778:	03010413          	addi	s0,sp,48
    8000177c:	00050493          	mv	s1,a0
    itemAvailable.wait();
    80001780:	13050513          	addi	a0,a0,304
    80001784:	00001097          	auipc	ra,0x1
    80001788:	b1c080e7          	jalr	-1252(ra) # 800022a0 <_ZN10_Semaphore4waitEv>
    mutex.wait();
    8000178c:	11848913          	addi	s2,s1,280
    80001790:	00090513          	mv	a0,s2
    80001794:	00001097          	auipc	ra,0x1
    80001798:	b0c080e7          	jalr	-1268(ra) # 800022a0 <_ZN10_Semaphore4waitEv>
    char c = buffer[head];
    8000179c:	1004b783          	ld	a5,256(s1)
    800017a0:	00f48733          	add	a4,s1,a5
    800017a4:	00074983          	lbu	s3,0(a4)
    head = (head + 1) % BUFFER_SIZE;
    800017a8:	00178793          	addi	a5,a5,1
    800017ac:	0ff7f793          	andi	a5,a5,255
    800017b0:	10f4b023          	sd	a5,256(s1)
    count--;
    800017b4:	1104b783          	ld	a5,272(s1)
    800017b8:	fff78793          	addi	a5,a5,-1
    800017bc:	10f4b823          	sd	a5,272(s1)
    mutex.signal();
    800017c0:	00090513          	mv	a0,s2
    800017c4:	00001097          	auipc	ra,0x1
    800017c8:	bd0080e7          	jalr	-1072(ra) # 80002394 <_ZN10_Semaphore6signalEv>
    spaceAvailable.signal();
    800017cc:	14848513          	addi	a0,s1,328
    800017d0:	00001097          	auipc	ra,0x1
    800017d4:	bc4080e7          	jalr	-1084(ra) # 80002394 <_ZN10_Semaphore6signalEv>
    return c;
}
    800017d8:	00098513          	mv	a0,s3
    800017dc:	02813083          	ld	ra,40(sp)
    800017e0:	02013403          	ld	s0,32(sp)
    800017e4:	01813483          	ld	s1,24(sp)
    800017e8:	01013903          	ld	s2,16(sp)
    800017ec:	00813983          	ld	s3,8(sp)
    800017f0:	03010113          	addi	sp,sp,48
    800017f4:	00008067          	ret

00000000800017f8 <_ZN12KernelBuffer6tryPutEc>:

bool KernelBuffer::tryPut(char c) {
    800017f8:	fd010113          	addi	sp,sp,-48
    800017fc:	02113423          	sd	ra,40(sp)
    80001800:	02813023          	sd	s0,32(sp)
    80001804:	00913c23          	sd	s1,24(sp)
    80001808:	01213823          	sd	s2,16(sp)
    8000180c:	01313423          	sd	s3,8(sp)
    80001810:	01413023          	sd	s4,0(sp)
    80001814:	03010413          	addi	s0,sp,48
    80001818:	00050493          	mv	s1,a0
    8000181c:	00058913          	mv	s2,a1
    if (spaceAvailable.tryWait() != 0) {
    80001820:	14850993          	addi	s3,a0,328
    80001824:	00098513          	mv	a0,s3
    80001828:	00001097          	auipc	ra,0x1
    8000182c:	c24080e7          	jalr	-988(ra) # 8000244c <_ZN10_Semaphore7tryWaitEv>
    80001830:	02050463          	beqz	a0,80001858 <_ZN12KernelBuffer6tryPutEc+0x60>
        return false;
    80001834:	00000513          	li	a0,0

    mutex.signal();
    itemAvailable.signal();

    return true;
}
    80001838:	02813083          	ld	ra,40(sp)
    8000183c:	02013403          	ld	s0,32(sp)
    80001840:	01813483          	ld	s1,24(sp)
    80001844:	01013903          	ld	s2,16(sp)
    80001848:	00813983          	ld	s3,8(sp)
    8000184c:	00013a03          	ld	s4,0(sp)
    80001850:	03010113          	addi	sp,sp,48
    80001854:	00008067          	ret
    if (mutex.tryWait() != 0) {
    80001858:	11848a13          	addi	s4,s1,280
    8000185c:	000a0513          	mv	a0,s4
    80001860:	00001097          	auipc	ra,0x1
    80001864:	bec080e7          	jalr	-1044(ra) # 8000244c <_ZN10_Semaphore7tryWaitEv>
    80001868:	04051463          	bnez	a0,800018b0 <_ZN12KernelBuffer6tryPutEc+0xb8>
    buffer[tail] = c;
    8000186c:	1084b783          	ld	a5,264(s1)
    80001870:	00f48733          	add	a4,s1,a5
    80001874:	01270023          	sb	s2,0(a4)
    tail = (tail + 1) % BUFFER_SIZE;
    80001878:	00178793          	addi	a5,a5,1
    8000187c:	0ff7f793          	andi	a5,a5,255
    80001880:	10f4b423          	sd	a5,264(s1)
    count++;
    80001884:	1104b783          	ld	a5,272(s1)
    80001888:	00178793          	addi	a5,a5,1
    8000188c:	10f4b823          	sd	a5,272(s1)
    mutex.signal();
    80001890:	000a0513          	mv	a0,s4
    80001894:	00001097          	auipc	ra,0x1
    80001898:	b00080e7          	jalr	-1280(ra) # 80002394 <_ZN10_Semaphore6signalEv>
    itemAvailable.signal();
    8000189c:	13048513          	addi	a0,s1,304
    800018a0:	00001097          	auipc	ra,0x1
    800018a4:	af4080e7          	jalr	-1292(ra) # 80002394 <_ZN10_Semaphore6signalEv>
    return true;
    800018a8:	00100513          	li	a0,1
    800018ac:	f8dff06f          	j	80001838 <_ZN12KernelBuffer6tryPutEc+0x40>
        spaceAvailable.signal();
    800018b0:	00098513          	mv	a0,s3
    800018b4:	00001097          	auipc	ra,0x1
    800018b8:	ae0080e7          	jalr	-1312(ra) # 80002394 <_ZN10_Semaphore6signalEv>
        return false;
    800018bc:	00000513          	li	a0,0
    800018c0:	f79ff06f          	j	80001838 <_ZN12KernelBuffer6tryPutEc+0x40>

00000000800018c4 <_ZN12KernelBuffer6tryGetERc>:

// Try su za prekidnu rutinu
bool KernelBuffer::tryGet(char& c) {
    800018c4:	fd010113          	addi	sp,sp,-48
    800018c8:	02113423          	sd	ra,40(sp)
    800018cc:	02813023          	sd	s0,32(sp)
    800018d0:	00913c23          	sd	s1,24(sp)
    800018d4:	01213823          	sd	s2,16(sp)
    800018d8:	01313423          	sd	s3,8(sp)
    800018dc:	01413023          	sd	s4,0(sp)
    800018e0:	03010413          	addi	s0,sp,48
    800018e4:	00050493          	mv	s1,a0
    800018e8:	00058913          	mv	s2,a1
    if (itemAvailable.tryWait() != 0) {
    800018ec:	13050993          	addi	s3,a0,304
    800018f0:	00098513          	mv	a0,s3
    800018f4:	00001097          	auipc	ra,0x1
    800018f8:	b58080e7          	jalr	-1192(ra) # 8000244c <_ZN10_Semaphore7tryWaitEv>
    800018fc:	02050463          	beqz	a0,80001924 <_ZN12KernelBuffer6tryGetERc+0x60>
        return false;
    80001900:	00000513          	li	a0,0

    mutex.signal();
    spaceAvailable.signal();

    return true;
    80001904:	02813083          	ld	ra,40(sp)
    80001908:	02013403          	ld	s0,32(sp)
    8000190c:	01813483          	ld	s1,24(sp)
    80001910:	01013903          	ld	s2,16(sp)
    80001914:	00813983          	ld	s3,8(sp)
    80001918:	00013a03          	ld	s4,0(sp)
    8000191c:	03010113          	addi	sp,sp,48
    80001920:	00008067          	ret
    if (mutex.tryWait() != 0) {
    80001924:	11848a13          	addi	s4,s1,280
    80001928:	000a0513          	mv	a0,s4
    8000192c:	00001097          	auipc	ra,0x1
    80001930:	b20080e7          	jalr	-1248(ra) # 8000244c <_ZN10_Semaphore7tryWaitEv>
    80001934:	04051863          	bnez	a0,80001984 <_ZN12KernelBuffer6tryGetERc+0xc0>
    c = buffer[head];
    80001938:	1004b783          	ld	a5,256(s1)
    8000193c:	00f487b3          	add	a5,s1,a5
    80001940:	0007c783          	lbu	a5,0(a5)
    80001944:	00f90023          	sb	a5,0(s2)
    head = (head + 1) % BUFFER_SIZE;
    80001948:	1004b783          	ld	a5,256(s1)
    8000194c:	00178793          	addi	a5,a5,1
    80001950:	0ff7f793          	andi	a5,a5,255
    80001954:	10f4b023          	sd	a5,256(s1)
    count--;
    80001958:	1104b783          	ld	a5,272(s1)
    8000195c:	fff78793          	addi	a5,a5,-1
    80001960:	10f4b823          	sd	a5,272(s1)
    mutex.signal();
    80001964:	000a0513          	mv	a0,s4
    80001968:	00001097          	auipc	ra,0x1
    8000196c:	a2c080e7          	jalr	-1492(ra) # 80002394 <_ZN10_Semaphore6signalEv>
    spaceAvailable.signal();
    80001970:	14848513          	addi	a0,s1,328
    80001974:	00001097          	auipc	ra,0x1
    80001978:	a20080e7          	jalr	-1504(ra) # 80002394 <_ZN10_Semaphore6signalEv>
    return true;
    8000197c:	00100513          	li	a0,1
    80001980:	f85ff06f          	j	80001904 <_ZN12KernelBuffer6tryGetERc+0x40>
        itemAvailable.signal();
    80001984:	00098513          	mv	a0,s3
    80001988:	00001097          	auipc	ra,0x1
    8000198c:	a0c080e7          	jalr	-1524(ra) # 80002394 <_ZN10_Semaphore6signalEv>
        return false;
    80001990:	00000513          	li	a0,0
    80001994:	f71ff06f          	j	80001904 <_ZN12KernelBuffer6tryGetERc+0x40>

0000000080001998 <_ZN9Scheduler3getEv>:
// Created by os on 7/10/26.
//
#include "../h/Scheduler.hpp"
Scheduler::Elem* Scheduler::head = nullptr;
Scheduler::Elem* Scheduler::tail = nullptr;
TCB* Scheduler::get() {
    80001998:	fe010113          	addi	sp,sp,-32
    8000199c:	00113c23          	sd	ra,24(sp)
    800019a0:	00813823          	sd	s0,16(sp)
    800019a4:	00913423          	sd	s1,8(sp)
    800019a8:	02010413          	addi	s0,sp,32
    if (!head) return nullptr;
    800019ac:	0000a517          	auipc	a0,0xa
    800019b0:	19453503          	ld	a0,404(a0) # 8000bb40 <_ZN9Scheduler4headE>
    800019b4:	04050263          	beqz	a0,800019f8 <_ZN9Scheduler3getEv+0x60>
    Elem* oldHead = head;
    TCB* thread = oldHead->data;
    800019b8:	00053483          	ld	s1,0(a0)
    head = head->next;
    800019bc:	00853783          	ld	a5,8(a0)
    800019c0:	0000a717          	auipc	a4,0xa
    800019c4:	18f73023          	sd	a5,384(a4) # 8000bb40 <_ZN9Scheduler4headE>
    if (head == nullptr) {
    800019c8:	02078263          	beqz	a5,800019ec <_ZN9Scheduler3getEv+0x54>
        tail = nullptr;
    }

    delete oldHead;
    800019cc:	00000097          	auipc	ra,0x0
    800019d0:	bf4080e7          	jalr	-1036(ra) # 800015c0 <_ZdlPv>
    return thread;
}
    800019d4:	00048513          	mv	a0,s1
    800019d8:	01813083          	ld	ra,24(sp)
    800019dc:	01013403          	ld	s0,16(sp)
    800019e0:	00813483          	ld	s1,8(sp)
    800019e4:	02010113          	addi	sp,sp,32
    800019e8:	00008067          	ret
        tail = nullptr;
    800019ec:	0000a797          	auipc	a5,0xa
    800019f0:	1407be23          	sd	zero,348(a5) # 8000bb48 <_ZN9Scheduler4tailE>
    800019f4:	fd9ff06f          	j	800019cc <_ZN9Scheduler3getEv+0x34>
    if (!head) return nullptr;
    800019f8:	00050493          	mv	s1,a0
    800019fc:	fd9ff06f          	j	800019d4 <_ZN9Scheduler3getEv+0x3c>

0000000080001a00 <_ZN9Scheduler3putEP3TCB>:

void Scheduler::put(TCB *tcb) {
    if (!tcb) return;
    80001a00:	06050a63          	beqz	a0,80001a74 <_ZN9Scheduler3putEP3TCB+0x74>
void Scheduler::put(TCB *tcb) {
    80001a04:	fe010113          	addi	sp,sp,-32
    80001a08:	00113c23          	sd	ra,24(sp)
    80001a0c:	00813823          	sd	s0,16(sp)
    80001a10:	00913423          	sd	s1,8(sp)
    80001a14:	02010413          	addi	s0,sp,32
    80001a18:	00050493          	mv	s1,a0

    Elem* newElem = new Elem;
    80001a1c:	01000513          	li	a0,16
    80001a20:	00000097          	auipc	ra,0x0
    80001a24:	b50080e7          	jalr	-1200(ra) # 80001570 <_Znwm>
    if (!newElem) return;
    80001a28:	02050263          	beqz	a0,80001a4c <_ZN9Scheduler3putEP3TCB+0x4c>

    newElem->data = tcb;
    80001a2c:	00953023          	sd	s1,0(a0)
    newElem->next = nullptr;
    80001a30:	00053423          	sd	zero,8(a0)

    if (!tail) {
    80001a34:	0000a797          	auipc	a5,0xa
    80001a38:	1147b783          	ld	a5,276(a5) # 8000bb48 <_ZN9Scheduler4tailE>
    80001a3c:	02078263          	beqz	a5,80001a60 <_ZN9Scheduler3putEP3TCB+0x60>
        head = newElem;
        tail = newElem;
    } else {
        tail->next = newElem;
    80001a40:	00a7b423          	sd	a0,8(a5)
        tail = newElem;
    80001a44:	0000a797          	auipc	a5,0xa
    80001a48:	10a7b223          	sd	a0,260(a5) # 8000bb48 <_ZN9Scheduler4tailE>
    }
}
    80001a4c:	01813083          	ld	ra,24(sp)
    80001a50:	01013403          	ld	s0,16(sp)
    80001a54:	00813483          	ld	s1,8(sp)
    80001a58:	02010113          	addi	sp,sp,32
    80001a5c:	00008067          	ret
        head = newElem;
    80001a60:	0000a797          	auipc	a5,0xa
    80001a64:	0e078793          	addi	a5,a5,224 # 8000bb40 <_ZN9Scheduler4headE>
    80001a68:	00a7b023          	sd	a0,0(a5)
        tail = newElem;
    80001a6c:	00a7b423          	sd	a0,8(a5)
    80001a70:	fddff06f          	j	80001a4c <_ZN9Scheduler3putEP3TCB+0x4c>
    80001a74:	00008067          	ret

0000000080001a78 <_ZN9Scheduler7isEmptyEv>:

bool Scheduler::isEmpty() {
    80001a78:	ff010113          	addi	sp,sp,-16
    80001a7c:	00813423          	sd	s0,8(sp)
    80001a80:	01010413          	addi	s0,sp,16
    return head == nullptr;
    80001a84:	0000a517          	auipc	a0,0xa
    80001a88:	0bc53503          	ld	a0,188(a0) # 8000bb40 <_ZN9Scheduler4headE>
    80001a8c:	00153513          	seqz	a0,a0
    80001a90:	00813403          	ld	s0,8(sp)
    80001a94:	01010113          	addi	sp,sp,16
    80001a98:	00008067          	ret

0000000080001a9c <_ZL15userMainWrapperPv>:
//     void plicinit();
//     void plicinithart(int hart);
// }

static void userMainWrapper(void*)
{
    80001a9c:	ff010113          	addi	sp,sp,-16
    80001aa0:	00113423          	sd	ra,8(sp)
    80001aa4:	00813023          	sd	s0,0(sp)
    80001aa8:	01010413          	addi	s0,sp,16
    userMain();
    80001aac:	00004097          	auipc	ra,0x4
    80001ab0:	5dc080e7          	jalr	1500(ra) # 80006088 <_Z8userMainv>
}
    80001ab4:	00813083          	ld	ra,8(sp)
    80001ab8:	00013403          	ld	s0,0(sp)
    80001abc:	01010113          	addi	sp,sp,16
    80001ac0:	00008067          	ret

0000000080001ac4 <main>:

int main()
{
    80001ac4:	fd010113          	addi	sp,sp,-48
    80001ac8:	02113423          	sd	ra,40(sp)
    80001acc:	02813023          	sd	s0,32(sp)
    80001ad0:	00913c23          	sd	s1,24(sp)
    80001ad4:	03010413          	addi	s0,sp,48
    MemoryAllocator::initialize();
    80001ad8:	00002097          	auipc	ra,0x2
    80001adc:	898080e7          	jalr	-1896(ra) # 80003370 <_ZN15MemoryAllocator10initializeEv>

    Riscv::w_stvec((uint64)&supervisorTrap);
    80001ae0:	0000a797          	auipc	a5,0xa
    80001ae4:	fe87b783          	ld	a5,-24(a5) # 8000bac8 <_GLOBAL_OFFSET_TABLE_+0x28>
    static void w_sepc(uint64 value) {
        __asm__ volatile("csrw sepc, %0" : : "r"(value));
    }

    static void w_stvec(uint64 value) {
        __asm__ volatile("csrw stvec, %0" : : "r"(value));
    80001ae8:	10579073          	csrw	stvec,a5

    // plicinit();
    // plicinithart(0);

    thread_t mainThread = nullptr;
    80001aec:	fc043c23          	sd	zero,-40(s0)

    if (TCB::createMain(&mainThread) != 0) {
    80001af0:	fd840513          	addi	a0,s0,-40
    80001af4:	00001097          	auipc	ra,0x1
    80001af8:	d78080e7          	jalr	-648(ra) # 8000286c <_ZN3TCB10createMainEPPS_>
    80001afc:	00050463          	beqz	a0,80001b04 <main+0x40>
        while (true) {}
    80001b00:	0000006f          	j	80001b00 <main+0x3c>
    }

    if (TCB::initializeIdle() != 0) {
    80001b04:	00001097          	auipc	ra,0x1
    80001b08:	e9c080e7          	jalr	-356(ra) # 800029a0 <_ZN3TCB14initializeIdleEv>
    80001b0c:	00050463          	beqz	a0,80001b14 <main+0x50>
        while (true) {}
    80001b10:	0000006f          	j	80001b10 <main+0x4c>
    }

    _Console::initialize();
    80001b14:	00001097          	auipc	ra,0x1
    80001b18:	0e8080e7          	jalr	232(ra) # 80002bfc <_ZN8_Console10initializeEv>
    uint64* userStack =
        (uint64*)MemoryAllocator::mem_alloc(
    80001b1c:	00008537          	lui	a0,0x8
    80001b20:	00002097          	auipc	ra,0x2
    80001b24:	8a4080e7          	jalr	-1884(ra) # 800033c4 <_ZN15MemoryAllocator9mem_allocEm>
    80001b28:	00050493          	mv	s1,a0
            DEFAULT_STACK_SIZE * sizeof(uint64)
        );

    uint64* systemStack =
        (uint64*)MemoryAllocator::mem_alloc(
    80001b2c:	00008537          	lui	a0,0x8
    80001b30:	00002097          	auipc	ra,0x2
    80001b34:	894080e7          	jalr	-1900(ra) # 800033c4 <_ZN15MemoryAllocator9mem_allocEm>
    80001b38:	00050713          	mv	a4,a0
            DEFAULT_STACK_SIZE * sizeof(uint64)
        );

    if (userStack == nullptr || systemStack == nullptr) {
    80001b3c:	02048a63          	beqz	s1,80001b70 <main+0xac>
    80001b40:	02050863          	beqz	a0,80001b70 <main+0xac>
        while (true) {}
    }

    thread_t userMainThread = nullptr;
    80001b44:	fc043823          	sd	zero,-48(s0)

    if (TCB::create(
    80001b48:	00000793          	li	a5,0
    80001b4c:	00048693          	mv	a3,s1
    80001b50:	00000613          	li	a2,0
    80001b54:	00000597          	auipc	a1,0x0
    80001b58:	f4858593          	addi	a1,a1,-184 # 80001a9c <_ZL15userMainWrapperPv>
    80001b5c:	fd040513          	addi	a0,s0,-48
    80001b60:	00001097          	auipc	ra,0x1
    80001b64:	aa0080e7          	jalr	-1376(ra) # 80002600 <_ZN3TCB6createEPPS_PFvPvES2_PmS5_b>
    80001b68:	00050663          	beqz	a0,80001b74 <main+0xb0>
            nullptr,
            userStack,
            systemStack,
            false
        ) != 0) {
        while (true) {}
    80001b6c:	0000006f          	j	80001b6c <main+0xa8>
        while (true) {}
    80001b70:	0000006f          	j	80001b70 <main+0xac>
        return x;
    }

    static uint64 r_sie() {
        uint64 x;
        __asm__ volatile("csrr %0, sie" : "=r"(x));
    80001b74:	104027f3          	csrr	a5,sie
        }
    Riscv::w_sie(
    80001b78:	2007e793          	ori	a5,a5,512
        return x;
    }

    static void w_sie(uint64 x) {
        __asm__ volatile("csrw sie, %0" : : "r"(x));
    80001b7c:	10479073          	csrw	sie,a5
        __asm__ volatile("csrr %0, sstatus" : "=r"(value));
    80001b80:	100027f3          	csrr	a5,sstatus
    Riscv::r_sie() | Riscv::SIE_SEIE
);

    Riscv::w_sstatus(
    80001b84:	0027e793          	ori	a5,a5,2
        __asm__ volatile("csrw sstatus, %0" : : "r"(value));
    80001b88:	10079073          	csrw	sstatus,a5
        return finished;
    }

    bool isBlocked() const { return blocked;}

    void setBlocked(bool b) {blocked = b;}
    80001b8c:	fd843783          	ld	a5,-40(s0)
    80001b90:	00100713          	li	a4,1
    80001b94:	08e784a3          	sb	a4,137(a5)
        Riscv::r_sstatus() | Riscv::SSTATUS_SIE
    );

    mainThread->setBlocked(true);

    thread_dispatch();
    80001b98:	00000097          	auipc	ra,0x0
    80001b9c:	828080e7          	jalr	-2008(ra) # 800013c0 <_Z15thread_dispatchv>

    while (true) {
    80001ba0:	0000006f          	j	80001ba0 <main+0xdc>

0000000080001ba4 <_ZN15SleepingThreads3putEP3TCBm>:

SleepingThreads::Elem* SleepingThreads::head = nullptr;

int SleepingThreads::put(TCB* thread, time_t sleepTime)
{
    if (thread == nullptr || sleepTime == 0) {
    80001ba4:	06050863          	beqz	a0,80001c14 <_ZN15SleepingThreads3putEP3TCBm+0x70>
{
    80001ba8:	fe010113          	addi	sp,sp,-32
    80001bac:	00113c23          	sd	ra,24(sp)
    80001bb0:	00813823          	sd	s0,16(sp)
    80001bb4:	00913423          	sd	s1,8(sp)
    80001bb8:	01213023          	sd	s2,0(sp)
    80001bbc:	02010413          	addi	s0,sp,32
    80001bc0:	00050493          	mv	s1,a0
    80001bc4:	00058913          	mv	s2,a1
    if (thread == nullptr || sleepTime == 0) {
    80001bc8:	04058a63          	beqz	a1,80001c1c <_ZN15SleepingThreads3putEP3TCBm+0x78>
        return -1;
    }

    Elem* newElem = new Elem;
    80001bcc:	01800513          	li	a0,24
    80001bd0:	00000097          	auipc	ra,0x0
    80001bd4:	9a0080e7          	jalr	-1632(ra) # 80001570 <_Znwm>

    if (newElem == nullptr) {
    80001bd8:	04050663          	beqz	a0,80001c24 <_ZN15SleepingThreads3putEP3TCBm+0x80>
        return -1;
    }

    newElem->thread = thread;
    80001bdc:	00953023          	sd	s1,0(a0) # 8000 <_entry-0x7fff8000>
    newElem->time = sleepTime;
    80001be0:	01253423          	sd	s2,8(a0)
    newElem->next = head;
    80001be4:	0000a797          	auipc	a5,0xa
    80001be8:	f6c78793          	addi	a5,a5,-148 # 8000bb50 <_ZN15SleepingThreads4headE>
    80001bec:	0007b703          	ld	a4,0(a5)
    80001bf0:	00e53823          	sd	a4,16(a0)

    head = newElem;
    80001bf4:	00a7b023          	sd	a0,0(a5)

    return 0;
    80001bf8:	00000513          	li	a0,0
}
    80001bfc:	01813083          	ld	ra,24(sp)
    80001c00:	01013403          	ld	s0,16(sp)
    80001c04:	00813483          	ld	s1,8(sp)
    80001c08:	00013903          	ld	s2,0(sp)
    80001c0c:	02010113          	addi	sp,sp,32
    80001c10:	00008067          	ret
        return -1;
    80001c14:	fff00513          	li	a0,-1
}
    80001c18:	00008067          	ret
        return -1;
    80001c1c:	fff00513          	li	a0,-1
    80001c20:	fddff06f          	j	80001bfc <_ZN15SleepingThreads3putEP3TCBm+0x58>
        return -1;
    80001c24:	fff00513          	li	a0,-1
    80001c28:	fd5ff06f          	j	80001bfc <_ZN15SleepingThreads3putEP3TCBm+0x58>

0000000080001c2c <_ZN15SleepingThreads4tickEv>:

void SleepingThreads::tick() {
    80001c2c:	fd010113          	addi	sp,sp,-48
    80001c30:	02113423          	sd	ra,40(sp)
    80001c34:	02813023          	sd	s0,32(sp)
    80001c38:	00913c23          	sd	s1,24(sp)
    80001c3c:	01213823          	sd	s2,16(sp)
    80001c40:	01313423          	sd	s3,8(sp)
    80001c44:	03010413          	addi	s0,sp,48

    if (head == nullptr) {
    80001c48:	0000a497          	auipc	s1,0xa
    80001c4c:	f084b483          	ld	s1,-248(s1) # 8000bb50 <_ZN15SleepingThreads4headE>
    80001c50:	08048263          	beqz	s1,80001cd4 <_ZN15SleepingThreads4tickEv+0xa8>
        return;
    }

    Elem* current = head;
    Elem* previous = nullptr;
    80001c54:	00000913          	li	s2,0
    80001c58:	0240006f          	j	80001c7c <_ZN15SleepingThreads4tickEv+0x50>
    80001c5c:	00098493          	mv	s1,s3
    80001c60:	01c0006f          	j	80001c7c <_ZN15SleepingThreads4tickEv+0x50>

        if (current->time == 0) {
            Elem* finished = current;

            if (previous == nullptr) {
                head = current->next;
    80001c64:	0104b983          	ld	s3,16(s1)
    80001c68:	0000a797          	auipc	a5,0xa
    80001c6c:	ef37b423          	sd	s3,-280(a5) # 8000bb50 <_ZN15SleepingThreads4headE>
                current = head;
    80001c70:	0380006f          	j	80001ca8 <_ZN15SleepingThreads4tickEv+0x7c>
            finished->thread->setBlocked(false);
            Scheduler::put(finished->thread);

            delete finished;
        } else {
            previous = current;
    80001c74:	00048913          	mv	s2,s1
            current = current->next;
    80001c78:	0104b483          	ld	s1,16(s1)
    while (current != nullptr) {
    80001c7c:	04048c63          	beqz	s1,80001cd4 <_ZN15SleepingThreads4tickEv+0xa8>
        if (current->time > 0) {
    80001c80:	0084b783          	ld	a5,8(s1)
    80001c84:	00078663          	beqz	a5,80001c90 <_ZN15SleepingThreads4tickEv+0x64>
            current->time--;
    80001c88:	fff78793          	addi	a5,a5,-1
    80001c8c:	00f4b423          	sd	a5,8(s1)
        if (current->time == 0) {
    80001c90:	0084b783          	ld	a5,8(s1)
    80001c94:	fe0790e3          	bnez	a5,80001c74 <_ZN15SleepingThreads4tickEv+0x48>
            if (previous == nullptr) {
    80001c98:	fc0906e3          	beqz	s2,80001c64 <_ZN15SleepingThreads4tickEv+0x38>
                previous->next = current->next;
    80001c9c:	0104b783          	ld	a5,16(s1)
    80001ca0:	00f93823          	sd	a5,16(s2)
                current = current->next;
    80001ca4:	0104b983          	ld	s3,16(s1)
            finished->thread->setBlocked(false);
    80001ca8:	0004b783          	ld	a5,0(s1)
    80001cac:	080784a3          	sb	zero,137(a5)
            Scheduler::put(finished->thread);
    80001cb0:	0004b503          	ld	a0,0(s1)
    80001cb4:	00000097          	auipc	ra,0x0
    80001cb8:	d4c080e7          	jalr	-692(ra) # 80001a00 <_ZN9Scheduler3putEP3TCB>
            delete finished;
    80001cbc:	fa0480e3          	beqz	s1,80001c5c <_ZN15SleepingThreads4tickEv+0x30>
    80001cc0:	00048513          	mv	a0,s1
    80001cc4:	00000097          	auipc	ra,0x0
    80001cc8:	8fc080e7          	jalr	-1796(ra) # 800015c0 <_ZdlPv>
    80001ccc:	00098493          	mv	s1,s3
    80001cd0:	fadff06f          	j	80001c7c <_ZN15SleepingThreads4tickEv+0x50>
        }
    }
    80001cd4:	02813083          	ld	ra,40(sp)
    80001cd8:	02013403          	ld	s0,32(sp)
    80001cdc:	01813483          	ld	s1,24(sp)
    80001ce0:	01013903          	ld	s2,16(sp)
    80001ce4:	00813983          	ld	s3,8(sp)
    80001ce8:	03010113          	addi	sp,sp,48
    80001cec:	00008067          	ret

0000000080001cf0 <_ZN6ThreadD1Ev>:
Thread::Thread()
    : myHandle(nullptr),
      body(nullptr),
      arg(nullptr) {}

Thread::~Thread() {}
    80001cf0:	ff010113          	addi	sp,sp,-16
    80001cf4:	00813423          	sd	s0,8(sp)
    80001cf8:	01010413          	addi	s0,sp,16
    80001cfc:	00813403          	ld	s0,8(sp)
    80001d00:	01010113          	addi	sp,sp,16
    80001d04:	00008067          	ret

0000000080001d08 <_ZZN6Thread5startEvENUlPvE_4_FUNES0_>:
    return thread_create(
        &myHandle,
        [](void* argument) {
            Thread* thread = static_cast<Thread*>(argument);

            if (thread != nullptr) {
    80001d08:	02050863          	beqz	a0,80001d38 <_ZZN6Thread5startEvENUlPvE_4_FUNES0_+0x30>
        [](void* argument) {
    80001d0c:	ff010113          	addi	sp,sp,-16
    80001d10:	00113423          	sd	ra,8(sp)
    80001d14:	00813023          	sd	s0,0(sp)
    80001d18:	01010413          	addi	s0,sp,16
                thread->run();
    80001d1c:	00053783          	ld	a5,0(a0)
    80001d20:	0107b783          	ld	a5,16(a5)
    80001d24:	000780e7          	jalr	a5
            }
        },
    80001d28:	00813083          	ld	ra,8(sp)
    80001d2c:	00013403          	ld	s0,0(sp)
    80001d30:	01010113          	addi	sp,sp,16
    80001d34:	00008067          	ret
    80001d38:	00008067          	ret

0000000080001d3c <_ZN6ThreadD0Ev>:
Thread::~Thread() {}
    80001d3c:	ff010113          	addi	sp,sp,-16
    80001d40:	00113423          	sd	ra,8(sp)
    80001d44:	00813023          	sd	s0,0(sp)
    80001d48:	01010413          	addi	s0,sp,16
    80001d4c:	00000097          	auipc	ra,0x0
    80001d50:	874080e7          	jalr	-1932(ra) # 800015c0 <_ZdlPv>
    80001d54:	00813083          	ld	ra,8(sp)
    80001d58:	00013403          	ld	s0,0(sp)
    80001d5c:	01010113          	addi	sp,sp,16
    80001d60:	00008067          	ret

0000000080001d64 <_ZN9SemaphoreD1Ev>:
Semaphore::Semaphore(unsigned init)
    : myHandle(nullptr) {
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore() {
    80001d64:	0000a797          	auipc	a5,0xa
    80001d68:	b4c78793          	addi	a5,a5,-1204 # 8000b8b0 <_ZTV9Semaphore+0x10>
    80001d6c:	00f53023          	sd	a5,0(a0)
    if (myHandle != nullptr) {
    80001d70:	00853503          	ld	a0,8(a0)
    80001d74:	02050663          	beqz	a0,80001da0 <_ZN9SemaphoreD1Ev+0x3c>
Semaphore::~Semaphore() {
    80001d78:	ff010113          	addi	sp,sp,-16
    80001d7c:	00113423          	sd	ra,8(sp)
    80001d80:	00813023          	sd	s0,0(sp)
    80001d84:	01010413          	addi	s0,sp,16
        sem_close(myHandle);
    80001d88:	fffff097          	auipc	ra,0xfffff
    80001d8c:	690080e7          	jalr	1680(ra) # 80001418 <_Z9sem_closeP10_Semaphore>
        myHandle = nullptr;
    }
}
    80001d90:	00813083          	ld	ra,8(sp)
    80001d94:	00013403          	ld	s0,0(sp)
    80001d98:	01010113          	addi	sp,sp,16
    80001d9c:	00008067          	ret
    80001da0:	00008067          	ret

0000000080001da4 <_ZN9SemaphoreD0Ev>:
Semaphore::~Semaphore() {
    80001da4:	fe010113          	addi	sp,sp,-32
    80001da8:	00113c23          	sd	ra,24(sp)
    80001dac:	00813823          	sd	s0,16(sp)
    80001db0:	00913423          	sd	s1,8(sp)
    80001db4:	02010413          	addi	s0,sp,32
    80001db8:	00050493          	mv	s1,a0
}
    80001dbc:	00000097          	auipc	ra,0x0
    80001dc0:	fa8080e7          	jalr	-88(ra) # 80001d64 <_ZN9SemaphoreD1Ev>
    80001dc4:	00048513          	mv	a0,s1
    80001dc8:	fffff097          	auipc	ra,0xfffff
    80001dcc:	7f8080e7          	jalr	2040(ra) # 800015c0 <_ZdlPv>
    80001dd0:	01813083          	ld	ra,24(sp)
    80001dd4:	01013403          	ld	s0,16(sp)
    80001dd8:	00813483          	ld	s1,8(sp)
    80001ddc:	02010113          	addi	sp,sp,32
    80001de0:	00008067          	ret

0000000080001de4 <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void*), void* arg)
    80001de4:	ff010113          	addi	sp,sp,-16
    80001de8:	00813423          	sd	s0,8(sp)
    80001dec:	01010413          	addi	s0,sp,16
      arg(arg)
    80001df0:	0000a797          	auipc	a5,0xa
    80001df4:	a9878793          	addi	a5,a5,-1384 # 8000b888 <_ZTV6Thread+0x10>
    80001df8:	00f53023          	sd	a5,0(a0)
    80001dfc:	00053423          	sd	zero,8(a0)
    80001e00:	00b53823          	sd	a1,16(a0)
    80001e04:	00c53c23          	sd	a2,24(a0)
}
    80001e08:	00813403          	ld	s0,8(sp)
    80001e0c:	01010113          	addi	sp,sp,16
    80001e10:	00008067          	ret

0000000080001e14 <_ZN6ThreadC1Ev>:
Thread::Thread()
    80001e14:	ff010113          	addi	sp,sp,-16
    80001e18:	00813423          	sd	s0,8(sp)
    80001e1c:	01010413          	addi	s0,sp,16
      arg(nullptr) {}
    80001e20:	0000a797          	auipc	a5,0xa
    80001e24:	a6878793          	addi	a5,a5,-1432 # 8000b888 <_ZTV6Thread+0x10>
    80001e28:	00f53023          	sd	a5,0(a0)
    80001e2c:	00053423          	sd	zero,8(a0)
    80001e30:	00053823          	sd	zero,16(a0)
    80001e34:	00053c23          	sd	zero,24(a0)
    80001e38:	00813403          	ld	s0,8(sp)
    80001e3c:	01010113          	addi	sp,sp,16
    80001e40:	00008067          	ret

0000000080001e44 <_ZN6Thread5startEv>:
int Thread::start() {
    80001e44:	ff010113          	addi	sp,sp,-16
    80001e48:	00113423          	sd	ra,8(sp)
    80001e4c:	00813023          	sd	s0,0(sp)
    80001e50:	01010413          	addi	s0,sp,16
    if (body != nullptr) {
    80001e54:	01053583          	ld	a1,16(a0)
    80001e58:	02058263          	beqz	a1,80001e7c <_ZN6Thread5startEv+0x38>
        return thread_create(&myHandle, body, arg);
    80001e5c:	01853603          	ld	a2,24(a0)
    80001e60:	00850513          	addi	a0,a0,8
    80001e64:	fffff097          	auipc	ra,0xfffff
    80001e68:	474080e7          	jalr	1140(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
}
    80001e6c:	00813083          	ld	ra,8(sp)
    80001e70:	00013403          	ld	s0,0(sp)
    80001e74:	01010113          	addi	sp,sp,16
    80001e78:	00008067          	ret
    return thread_create(
    80001e7c:	00050613          	mv	a2,a0
    80001e80:	00000597          	auipc	a1,0x0
    80001e84:	e8858593          	addi	a1,a1,-376 # 80001d08 <_ZZN6Thread5startEvENUlPvE_4_FUNES0_>
    80001e88:	00850513          	addi	a0,a0,8
    80001e8c:	fffff097          	auipc	ra,0xfffff
    80001e90:	44c080e7          	jalr	1100(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    80001e94:	fd9ff06f          	j	80001e6c <_ZN6Thread5startEv+0x28>

0000000080001e98 <_ZN6Thread8dispatchEv>:
void Thread::dispatch() {
    80001e98:	ff010113          	addi	sp,sp,-16
    80001e9c:	00113423          	sd	ra,8(sp)
    80001ea0:	00813023          	sd	s0,0(sp)
    80001ea4:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80001ea8:	fffff097          	auipc	ra,0xfffff
    80001eac:	518080e7          	jalr	1304(ra) # 800013c0 <_Z15thread_dispatchv>
}
    80001eb0:	00813083          	ld	ra,8(sp)
    80001eb4:	00013403          	ld	s0,0(sp)
    80001eb8:	01010113          	addi	sp,sp,16
    80001ebc:	00008067          	ret

0000000080001ec0 <_ZN14PeriodicThread3runEv>:
void PeriodicThread::terminate() {
    terminated = true;
}

void PeriodicThread::run()
{
    80001ec0:	fe010113          	addi	sp,sp,-32
    80001ec4:	00113c23          	sd	ra,24(sp)
    80001ec8:	00813823          	sd	s0,16(sp)
    80001ecc:	00913423          	sd	s1,8(sp)
    80001ed0:	02010413          	addi	s0,sp,32
    80001ed4:	00050493          	mv	s1,a0
    80001ed8:	00c0006f          	j	80001ee4 <_ZN14PeriodicThread3runEv+0x24>
        }

        if (period == 0) {
            Thread::dispatch();
        } else {
            time_sleep(period);
    80001edc:	fffff097          	auipc	ra,0xfffff
    80001ee0:	66c080e7          	jalr	1644(ra) # 80001548 <_Z10time_sleepm>
    while (!terminated) {
    80001ee4:	0284c783          	lbu	a5,40(s1)
    80001ee8:	02079863          	bnez	a5,80001f18 <_ZN14PeriodicThread3runEv+0x58>
        periodicActivation();
    80001eec:	0004b783          	ld	a5,0(s1)
    80001ef0:	0187b783          	ld	a5,24(a5)
    80001ef4:	00048513          	mv	a0,s1
    80001ef8:	000780e7          	jalr	a5
        if (terminated) {
    80001efc:	0284c783          	lbu	a5,40(s1)
    80001f00:	00079c63          	bnez	a5,80001f18 <_ZN14PeriodicThread3runEv+0x58>
        if (period == 0) {
    80001f04:	0204b503          	ld	a0,32(s1)
    80001f08:	fc051ae3          	bnez	a0,80001edc <_ZN14PeriodicThread3runEv+0x1c>
            Thread::dispatch();
    80001f0c:	00000097          	auipc	ra,0x0
    80001f10:	f8c080e7          	jalr	-116(ra) # 80001e98 <_ZN6Thread8dispatchEv>
    80001f14:	fd1ff06f          	j	80001ee4 <_ZN14PeriodicThread3runEv+0x24>
        }
    }
}
    80001f18:	01813083          	ld	ra,24(sp)
    80001f1c:	01013403          	ld	s0,16(sp)
    80001f20:	00813483          	ld	s1,8(sp)
    80001f24:	02010113          	addi	sp,sp,32
    80001f28:	00008067          	ret

0000000080001f2c <_ZN6Thread5sleepEm>:
int Thread::sleep(time_t time) {
    80001f2c:	ff010113          	addi	sp,sp,-16
    80001f30:	00113423          	sd	ra,8(sp)
    80001f34:	00813023          	sd	s0,0(sp)
    80001f38:	01010413          	addi	s0,sp,16
    return time_sleep(time);
    80001f3c:	fffff097          	auipc	ra,0xfffff
    80001f40:	60c080e7          	jalr	1548(ra) # 80001548 <_Z10time_sleepm>
}
    80001f44:	00813083          	ld	ra,8(sp)
    80001f48:	00013403          	ld	s0,0(sp)
    80001f4c:	01010113          	addi	sp,sp,16
    80001f50:	00008067          	ret

0000000080001f54 <_ZN9SemaphoreC1Ej>:
Semaphore::Semaphore(unsigned init)
    80001f54:	ff010113          	addi	sp,sp,-16
    80001f58:	00113423          	sd	ra,8(sp)
    80001f5c:	00813023          	sd	s0,0(sp)
    80001f60:	01010413          	addi	s0,sp,16
    : myHandle(nullptr) {
    80001f64:	0000a797          	auipc	a5,0xa
    80001f68:	94c78793          	addi	a5,a5,-1716 # 8000b8b0 <_ZTV9Semaphore+0x10>
    80001f6c:	00f53023          	sd	a5,0(a0)
    80001f70:	00053423          	sd	zero,8(a0)
    sem_open(&myHandle, init);
    80001f74:	00850513          	addi	a0,a0,8
    80001f78:	fffff097          	auipc	ra,0xfffff
    80001f7c:	468080e7          	jalr	1128(ra) # 800013e0 <_Z8sem_openPP10_Semaphorej>
}
    80001f80:	00813083          	ld	ra,8(sp)
    80001f84:	00013403          	ld	s0,0(sp)
    80001f88:	01010113          	addi	sp,sp,16
    80001f8c:	00008067          	ret

0000000080001f90 <_ZN9Semaphore4waitEv>:
int Semaphore::wait() {
    80001f90:	ff010113          	addi	sp,sp,-16
    80001f94:	00113423          	sd	ra,8(sp)
    80001f98:	00813023          	sd	s0,0(sp)
    80001f9c:	01010413          	addi	s0,sp,16
    return sem_wait(myHandle);
    80001fa0:	00853503          	ld	a0,8(a0)
    80001fa4:	fffff097          	auipc	ra,0xfffff
    80001fa8:	49c080e7          	jalr	1180(ra) # 80001440 <_Z8sem_waitP10_Semaphore>
}
    80001fac:	00813083          	ld	ra,8(sp)
    80001fb0:	00013403          	ld	s0,0(sp)
    80001fb4:	01010113          	addi	sp,sp,16
    80001fb8:	00008067          	ret

0000000080001fbc <_ZN9Semaphore6signalEv>:
int Semaphore::signal() {
    80001fbc:	ff010113          	addi	sp,sp,-16
    80001fc0:	00113423          	sd	ra,8(sp)
    80001fc4:	00813023          	sd	s0,0(sp)
    80001fc8:	01010413          	addi	s0,sp,16
    return sem_signal(myHandle);
    80001fcc:	00853503          	ld	a0,8(a0)
    80001fd0:	fffff097          	auipc	ra,0xfffff
    80001fd4:	498080e7          	jalr	1176(ra) # 80001468 <_Z10sem_signalP10_Semaphore>
}
    80001fd8:	00813083          	ld	ra,8(sp)
    80001fdc:	00013403          	ld	s0,0(sp)
    80001fe0:	01010113          	addi	sp,sp,16
    80001fe4:	00008067          	ret

0000000080001fe8 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(),
    80001fe8:	fe010113          	addi	sp,sp,-32
    80001fec:	00113c23          	sd	ra,24(sp)
    80001ff0:	00813823          	sd	s0,16(sp)
    80001ff4:	00913423          	sd	s1,8(sp)
    80001ff8:	01213023          	sd	s2,0(sp)
    80001ffc:	02010413          	addi	s0,sp,32
    80002000:	00050493          	mv	s1,a0
    80002004:	00058913          	mv	s2,a1
    terminated(false) {}
    80002008:	00000097          	auipc	ra,0x0
    8000200c:	e0c080e7          	jalr	-500(ra) # 80001e14 <_ZN6ThreadC1Ev>
    80002010:	0000a797          	auipc	a5,0xa
    80002014:	8c078793          	addi	a5,a5,-1856 # 8000b8d0 <_ZTV14PeriodicThread+0x10>
    80002018:	00f4b023          	sd	a5,0(s1)
    8000201c:	0324b023          	sd	s2,32(s1)
    80002020:	02048423          	sb	zero,40(s1)
    80002024:	01813083          	ld	ra,24(sp)
    80002028:	01013403          	ld	s0,16(sp)
    8000202c:	00813483          	ld	s1,8(sp)
    80002030:	00013903          	ld	s2,0(sp)
    80002034:	02010113          	addi	sp,sp,32
    80002038:	00008067          	ret

000000008000203c <_ZN14PeriodicThread9terminateEv>:
void PeriodicThread::terminate() {
    8000203c:	ff010113          	addi	sp,sp,-16
    80002040:	00813423          	sd	s0,8(sp)
    80002044:	01010413          	addi	s0,sp,16
    terminated = true;
    80002048:	00100793          	li	a5,1
    8000204c:	02f50423          	sb	a5,40(a0)
}
    80002050:	00813403          	ld	s0,8(sp)
    80002054:	01010113          	addi	sp,sp,16
    80002058:	00008067          	ret

000000008000205c <_ZN7Console4getcEv>:

char Console::getc()
{
    8000205c:	ff010113          	addi	sp,sp,-16
    80002060:	00113423          	sd	ra,8(sp)
    80002064:	00813023          	sd	s0,0(sp)
    80002068:	01010413          	addi	s0,sp,16
    return ::getc();
    8000206c:	fffff097          	auipc	ra,0xfffff
    80002070:	494080e7          	jalr	1172(ra) # 80001500 <_Z4getcv>
}
    80002074:	00813083          	ld	ra,8(sp)
    80002078:	00013403          	ld	s0,0(sp)
    8000207c:	01010113          	addi	sp,sp,16
    80002080:	00008067          	ret

0000000080002084 <_ZN7Console4putcEc>:

void Console::putc(char c)
{
    80002084:	ff010113          	addi	sp,sp,-16
    80002088:	00113423          	sd	ra,8(sp)
    8000208c:	00813023          	sd	s0,0(sp)
    80002090:	01010413          	addi	s0,sp,16
    ::putc(c);
    80002094:	fffff097          	auipc	ra,0xfffff
    80002098:	490080e7          	jalr	1168(ra) # 80001524 <_Z4putcc>
    8000209c:	00813083          	ld	ra,8(sp)
    800020a0:	00013403          	ld	s0,0(sp)
    800020a4:	01010113          	addi	sp,sp,16
    800020a8:	00008067          	ret

00000000800020ac <_ZN6Thread3runEv>:
    static void dispatch();
    static int sleep(time_t);

protected:
    Thread();
    virtual void run() {}
    800020ac:	ff010113          	addi	sp,sp,-16
    800020b0:	00813423          	sd	s0,8(sp)
    800020b4:	01010413          	addi	s0,sp,16
    800020b8:	00813403          	ld	s0,8(sp)
    800020bc:	01010113          	addi	sp,sp,16
    800020c0:	00008067          	ret

00000000800020c4 <_ZN14PeriodicThread18periodicActivationEv>:
public:
    void terminate();

protected:
    PeriodicThread(time_t period);
    virtual void periodicActivation() {}
    800020c4:	ff010113          	addi	sp,sp,-16
    800020c8:	00813423          	sd	s0,8(sp)
    800020cc:	01010413          	addi	s0,sp,16
    800020d0:	00813403          	ld	s0,8(sp)
    800020d4:	01010113          	addi	sp,sp,16
    800020d8:	00008067          	ret

00000000800020dc <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread {
    800020dc:	ff010113          	addi	sp,sp,-16
    800020e0:	00813423          	sd	s0,8(sp)
    800020e4:	01010413          	addi	s0,sp,16
    800020e8:	00009797          	auipc	a5,0x9
    800020ec:	7e878793          	addi	a5,a5,2024 # 8000b8d0 <_ZTV14PeriodicThread+0x10>
    800020f0:	00f53023          	sd	a5,0(a0)
    800020f4:	00813403          	ld	s0,8(sp)
    800020f8:	01010113          	addi	sp,sp,16
    800020fc:	00008067          	ret

0000000080002100 <_ZN14PeriodicThreadD0Ev>:
    80002100:	ff010113          	addi	sp,sp,-16
    80002104:	00113423          	sd	ra,8(sp)
    80002108:	00813023          	sd	s0,0(sp)
    8000210c:	01010413          	addi	s0,sp,16
    80002110:	00009797          	auipc	a5,0x9
    80002114:	7c078793          	addi	a5,a5,1984 # 8000b8d0 <_ZTV14PeriodicThread+0x10>
    80002118:	00f53023          	sd	a5,0(a0)
    8000211c:	fffff097          	auipc	ra,0xfffff
    80002120:	4a4080e7          	jalr	1188(ra) # 800015c0 <_ZdlPv>
    80002124:	00813083          	ld	ra,8(sp)
    80002128:	00013403          	ld	s0,0(sp)
    8000212c:	01010113          	addi	sp,sp,16
    80002130:	00008067          	ret

0000000080002134 <_ZN10_SemaphoreC1Ej>:

#include "../h/Riscv.hpp"
#include "../h/TCB.hpp"
#include "../h/Scheduler.hpp"

_Semaphore::_Semaphore (unsigned value) {
    80002134:	ff010113          	addi	sp,sp,-16
    80002138:	00813423          	sd	s0,8(sp)
    8000213c:	01010413          	addi	s0,sp,16
    this->value = value;
    80002140:	00b52023          	sw	a1,0(a0)
    this->head = nullptr;
    80002144:	00053423          	sd	zero,8(a0)
    this->tail = nullptr;
    80002148:	00053823          	sd	zero,16(a0)
}
    8000214c:	00813403          	ld	s0,8(sp)
    80002150:	01010113          	addi	sp,sp,16
    80002154:	00008067          	ret

0000000080002158 <_ZN10_Semaphore4lockEv>:
    unlock();

    return 0;
}

void _Semaphore::lock() {
    80002158:	ff010113          	addi	sp,sp,-16
    8000215c:	00113423          	sd	ra,8(sp)
    80002160:	00813023          	sd	s0,0(sp)
    80002164:	01010413          	addi	s0,sp,16
    Riscv::pushOff();
    80002168:	00001097          	auipc	ra,0x1
    8000216c:	128080e7          	jalr	296(ra) # 80003290 <_ZN5Riscv7pushOffEv>
}
    80002170:	00813083          	ld	ra,8(sp)
    80002174:	00013403          	ld	s0,0(sp)
    80002178:	01010113          	addi	sp,sp,16
    8000217c:	00008067          	ret

0000000080002180 <_ZN10_Semaphore6unlockEv>:

void _Semaphore::unlock() {
    80002180:	ff010113          	addi	sp,sp,-16
    80002184:	00113423          	sd	ra,8(sp)
    80002188:	00813023          	sd	s0,0(sp)
    8000218c:	01010413          	addi	s0,sp,16
    Riscv::popOff();
    80002190:	00001097          	auipc	ra,0x1
    80002194:	154080e7          	jalr	340(ra) # 800032e4 <_ZN5Riscv6popOffEv>
}
    80002198:	00813083          	ld	ra,8(sp)
    8000219c:	00013403          	ld	s0,0(sp)
    800021a0:	01010113          	addi	sp,sp,16
    800021a4:	00008067          	ret

00000000800021a8 <_ZN10_Semaphore6wait_nEj>:
    if (n == 0) return 0;
    800021a8:	00059663          	bnez	a1,800021b4 <_ZN10_Semaphore6wait_nEj+0xc>
    800021ac:	00000513          	li	a0,0
}
    800021b0:	00008067          	ret
int _Semaphore::wait_n(unsigned n) {
    800021b4:	fd010113          	addi	sp,sp,-48
    800021b8:	02113423          	sd	ra,40(sp)
    800021bc:	02813023          	sd	s0,32(sp)
    800021c0:	00913c23          	sd	s1,24(sp)
    800021c4:	01213823          	sd	s2,16(sp)
    800021c8:	01313423          	sd	s3,8(sp)
    800021cc:	03010413          	addi	s0,sp,48
    800021d0:	00050493          	mv	s1,a0
    800021d4:	00058913          	mv	s2,a1
    lock();
    800021d8:	00000097          	auipc	ra,0x0
    800021dc:	f80080e7          	jalr	-128(ra) # 80002158 <_ZN10_Semaphore4lockEv>
    if (value >= static_cast<int>(n)) {
    800021e0:	0004a583          	lw	a1,0(s1)
    800021e4:	0009079b          	sext.w	a5,s2
    800021e8:	06f5de63          	bge	a1,a5,80002264 <_ZN10_Semaphore6wait_nEj+0xbc>
    TCB* thread = TCB::running;
    800021ec:	0000a797          	auipc	a5,0xa
    800021f0:	8f47b783          	ld	a5,-1804(a5) # 8000bae0 <_GLOBAL_OFFSET_TABLE_+0x40>
    800021f4:	0007b983          	ld	s3,0(a5)
    BlockedThread* newThread = new BlockedThread;
    800021f8:	01800513          	li	a0,24
    800021fc:	fffff097          	auipc	ra,0xfffff
    80002200:	374080e7          	jalr	884(ra) # 80001570 <_Znwm>
    if (!newThread) {
    80002204:	06050e63          	beqz	a0,80002280 <_ZN10_Semaphore6wait_nEj+0xd8>
    newThread->data = thread;
    80002208:	01353023          	sd	s3,0(a0)
    newThread->requested = n;
    8000220c:	01252423          	sw	s2,8(a0)
    newThread->next = nullptr;
    80002210:	00053823          	sd	zero,16(a0)
    static int createMain(TCB** handle);
    static uint64 getRunningUserStackTop();
    static uint64 getRunningSystemStackTop();
    static void runThreadWrapper();
    void setSemaphoreWaitResult(int result) {
        semaphoreWaitResult = result;
    80002214:	0809ae23          	sw	zero,156(s3)
    void setBlocked(bool b) {blocked = b;}
    80002218:	00100793          	li	a5,1
    8000221c:	08f984a3          	sb	a5,137(s3)
    if (!tail) {
    80002220:	0104b783          	ld	a5,16(s1)
    80002224:	06078863          	beqz	a5,80002294 <_ZN10_Semaphore6wait_nEj+0xec>
        tail->next = newThread;
    80002228:	00a7b823          	sd	a0,16(a5)
        tail = newThread;
    8000222c:	00a4b823          	sd	a0,16(s1)
    unlock();
    80002230:	00048513          	mv	a0,s1
    80002234:	00000097          	auipc	ra,0x0
    80002238:	f4c080e7          	jalr	-180(ra) # 80002180 <_ZN10_Semaphore6unlockEv>
    TCB::dispatch();
    8000223c:	00000097          	auipc	ra,0x0
    80002240:	4d0080e7          	jalr	1232(ra) # 8000270c <_ZN3TCB8dispatchEv>
    }

    int getSemaphoreWaitResult() const {
        return semaphoreWaitResult;
    80002244:	09c9a503          	lw	a0,156(s3)
}
    80002248:	02813083          	ld	ra,40(sp)
    8000224c:	02013403          	ld	s0,32(sp)
    80002250:	01813483          	ld	s1,24(sp)
    80002254:	01013903          	ld	s2,16(sp)
    80002258:	00813983          	ld	s3,8(sp)
    8000225c:	03010113          	addi	sp,sp,48
    80002260:	00008067          	ret
        value -= n;
    80002264:	412585bb          	subw	a1,a1,s2
    80002268:	00b4a023          	sw	a1,0(s1)
        unlock();
    8000226c:	00048513          	mv	a0,s1
    80002270:	00000097          	auipc	ra,0x0
    80002274:	f10080e7          	jalr	-240(ra) # 80002180 <_ZN10_Semaphore6unlockEv>
        return 0;
    80002278:	00000513          	li	a0,0
    8000227c:	fcdff06f          	j	80002248 <_ZN10_Semaphore6wait_nEj+0xa0>
        unlock();
    80002280:	00048513          	mv	a0,s1
    80002284:	00000097          	auipc	ra,0x0
    80002288:	efc080e7          	jalr	-260(ra) # 80002180 <_ZN10_Semaphore6unlockEv>
        return -1;
    8000228c:	fff00513          	li	a0,-1
    80002290:	fb9ff06f          	j	80002248 <_ZN10_Semaphore6wait_nEj+0xa0>
        head = tail = newThread;
    80002294:	00a4b823          	sd	a0,16(s1)
    80002298:	00a4b423          	sd	a0,8(s1)
    8000229c:	f95ff06f          	j	80002230 <_ZN10_Semaphore6wait_nEj+0x88>

00000000800022a0 <_ZN10_Semaphore4waitEv>:
int _Semaphore::wait() {
    800022a0:	ff010113          	addi	sp,sp,-16
    800022a4:	00113423          	sd	ra,8(sp)
    800022a8:	00813023          	sd	s0,0(sp)
    800022ac:	01010413          	addi	s0,sp,16
    return wait_n(1);
    800022b0:	00100593          	li	a1,1
    800022b4:	00000097          	auipc	ra,0x0
    800022b8:	ef4080e7          	jalr	-268(ra) # 800021a8 <_ZN10_Semaphore6wait_nEj>
}
    800022bc:	00813083          	ld	ra,8(sp)
    800022c0:	00013403          	ld	s0,0(sp)
    800022c4:	01010113          	addi	sp,sp,16
    800022c8:	00008067          	ret

00000000800022cc <_ZN10_Semaphore8signal_nEj>:
    if (n == 0) return 0;
    800022cc:	00059663          	bnez	a1,800022d8 <_ZN10_Semaphore8signal_nEj+0xc>
}
    800022d0:	00000513          	li	a0,0
    800022d4:	00008067          	ret
int _Semaphore::signal_n(unsigned n) {
    800022d8:	fe010113          	addi	sp,sp,-32
    800022dc:	00113c23          	sd	ra,24(sp)
    800022e0:	00813823          	sd	s0,16(sp)
    800022e4:	00913423          	sd	s1,8(sp)
    800022e8:	01213023          	sd	s2,0(sp)
    800022ec:	02010413          	addi	s0,sp,32
    800022f0:	00050913          	mv	s2,a0
    800022f4:	00058493          	mv	s1,a1
    lock();
    800022f8:	00000097          	auipc	ra,0x0
    800022fc:	e60080e7          	jalr	-416(ra) # 80002158 <_ZN10_Semaphore4lockEv>
    value += n;
    80002300:	00092583          	lw	a1,0(s2)
    80002304:	009584bb          	addw	s1,a1,s1
    80002308:	00992023          	sw	s1,0(s2)
    8000230c:	01c0006f          	j	80002328 <_ZN10_Semaphore8signal_nEj+0x5c>
            tail = nullptr;
    80002310:	00093823          	sd	zero,16(s2)
        semaphoreWaitResult = result;
    80002314:	08052e23          	sw	zero,156(a0)
    void setBlocked(bool b) {blocked = b;}
    80002318:	080504a3          	sb	zero,137(a0)
        Scheduler::put(thread);
    8000231c:	fffff097          	auipc	ra,0xfffff
    80002320:	6e4080e7          	jalr	1764(ra) # 80001a00 <_ZN9Scheduler3putEP3TCB>
        delete oldHead;
    80002324:	02049c63          	bnez	s1,8000235c <_ZN10_Semaphore8signal_nEj+0x90>
    while (head &&
    80002328:	00893483          	ld	s1,8(s2)
    8000232c:	04048063          	beqz	s1,8000236c <_ZN10_Semaphore8signal_nEj+0xa0>
           value >= static_cast<int>(head->requested)) {
    80002330:	00092783          	lw	a5,0(s2)
    80002334:	0084a703          	lw	a4,8(s1)
    80002338:	0007069b          	sext.w	a3,a4
    while (head &&
    8000233c:	02d7c863          	blt	a5,a3,8000236c <_ZN10_Semaphore8signal_nEj+0xa0>
        TCB* thread = oldHead->data;
    80002340:	0004b503          	ld	a0,0(s1)
        value -= oldHead->requested;
    80002344:	40e787bb          	subw	a5,a5,a4
    80002348:	00f92023          	sw	a5,0(s2)
        head = head->next;
    8000234c:	0104b783          	ld	a5,16(s1)
    80002350:	00f93423          	sd	a5,8(s2)
        if (!head) {
    80002354:	fc0790e3          	bnez	a5,80002314 <_ZN10_Semaphore8signal_nEj+0x48>
    80002358:	fb9ff06f          	j	80002310 <_ZN10_Semaphore8signal_nEj+0x44>
        delete oldHead;
    8000235c:	00048513          	mv	a0,s1
    80002360:	fffff097          	auipc	ra,0xfffff
    80002364:	260080e7          	jalr	608(ra) # 800015c0 <_ZdlPv>
    80002368:	fc1ff06f          	j	80002328 <_ZN10_Semaphore8signal_nEj+0x5c>
    unlock();
    8000236c:	00090513          	mv	a0,s2
    80002370:	00000097          	auipc	ra,0x0
    80002374:	e10080e7          	jalr	-496(ra) # 80002180 <_ZN10_Semaphore6unlockEv>
}
    80002378:	00000513          	li	a0,0
    8000237c:	01813083          	ld	ra,24(sp)
    80002380:	01013403          	ld	s0,16(sp)
    80002384:	00813483          	ld	s1,8(sp)
    80002388:	00013903          	ld	s2,0(sp)
    8000238c:	02010113          	addi	sp,sp,32
    80002390:	00008067          	ret

0000000080002394 <_ZN10_Semaphore6signalEv>:
int _Semaphore::signal() {
    80002394:	ff010113          	addi	sp,sp,-16
    80002398:	00113423          	sd	ra,8(sp)
    8000239c:	00813023          	sd	s0,0(sp)
    800023a0:	01010413          	addi	s0,sp,16
    return signal_n(1);
    800023a4:	00100593          	li	a1,1
    800023a8:	00000097          	auipc	ra,0x0
    800023ac:	f24080e7          	jalr	-220(ra) # 800022cc <_ZN10_Semaphore8signal_nEj>
}
    800023b0:	00813083          	ld	ra,8(sp)
    800023b4:	00013403          	ld	s0,0(sp)
    800023b8:	01010113          	addi	sp,sp,16
    800023bc:	00008067          	ret

00000000800023c0 <_ZN10_Semaphore5closeEv>:

int _Semaphore::close() {
    800023c0:	fe010113          	addi	sp,sp,-32
    800023c4:	00113c23          	sd	ra,24(sp)
    800023c8:	00813823          	sd	s0,16(sp)
    800023cc:	00913423          	sd	s1,8(sp)
    800023d0:	01213023          	sd	s2,0(sp)
    800023d4:	02010413          	addi	s0,sp,32
    800023d8:	00050913          	mv	s2,a0
    lock();
    800023dc:	00000097          	auipc	ra,0x0
    800023e0:	d7c080e7          	jalr	-644(ra) # 80002158 <_ZN10_Semaphore4lockEv>

    while (head) {
    800023e4:	00893483          	ld	s1,8(s2)
    800023e8:	02048c63          	beqz	s1,80002420 <_ZN10_Semaphore5closeEv+0x60>
        BlockedThread* oldHead = head;
        TCB* thread = oldHead->data;
    800023ec:	0004b503          	ld	a0,0(s1)

        head = head->next;
    800023f0:	0104b783          	ld	a5,16(s1)
    800023f4:	00f93423          	sd	a5,8(s2)
        semaphoreWaitResult = result;
    800023f8:	fff00793          	li	a5,-1
    800023fc:	08f52e23          	sw	a5,156(a0)
    void setBlocked(bool b) {blocked = b;}
    80002400:	080504a3          	sb	zero,137(a0)

        thread->setSemaphoreWaitResult(-1);
        thread->setBlocked(false);
        Scheduler::put(thread);
    80002404:	fffff097          	auipc	ra,0xfffff
    80002408:	5fc080e7          	jalr	1532(ra) # 80001a00 <_ZN9Scheduler3putEP3TCB>

        delete oldHead;
    8000240c:	fc048ce3          	beqz	s1,800023e4 <_ZN10_Semaphore5closeEv+0x24>
    80002410:	00048513          	mv	a0,s1
    80002414:	fffff097          	auipc	ra,0xfffff
    80002418:	1ac080e7          	jalr	428(ra) # 800015c0 <_ZdlPv>
    8000241c:	fc9ff06f          	j	800023e4 <_ZN10_Semaphore5closeEv+0x24>
    }

    tail = nullptr;
    80002420:	00093823          	sd	zero,16(s2)

    unlock();
    80002424:	00090513          	mv	a0,s2
    80002428:	00000097          	auipc	ra,0x0
    8000242c:	d58080e7          	jalr	-680(ra) # 80002180 <_ZN10_Semaphore6unlockEv>

    return 0;
}
    80002430:	00000513          	li	a0,0
    80002434:	01813083          	ld	ra,24(sp)
    80002438:	01013403          	ld	s0,16(sp)
    8000243c:	00813483          	ld	s1,8(sp)
    80002440:	00013903          	ld	s2,0(sp)
    80002444:	02010113          	addi	sp,sp,32
    80002448:	00008067          	ret

000000008000244c <_ZN10_Semaphore7tryWaitEv>:

int _Semaphore::tryWait() {
    8000244c:	fe010113          	addi	sp,sp,-32
    80002450:	00113c23          	sd	ra,24(sp)
    80002454:	00813823          	sd	s0,16(sp)
    80002458:	00913423          	sd	s1,8(sp)
    8000245c:	02010413          	addi	s0,sp,32
    80002460:	00050493          	mv	s1,a0
    lock();
    80002464:	00000097          	auipc	ra,0x0
    80002468:	cf4080e7          	jalr	-780(ra) # 80002158 <_ZN10_Semaphore4lockEv>
    if (value <= 0) {
    8000246c:	0004a783          	lw	a5,0(s1)
    80002470:	02f05863          	blez	a5,800024a0 <_ZN10_Semaphore7tryWaitEv+0x54>
        unlock();
        return -1;
    }
    value--;
    80002474:	fff7879b          	addiw	a5,a5,-1
    80002478:	00f4a023          	sw	a5,0(s1)
    unlock();
    8000247c:	00048513          	mv	a0,s1
    80002480:	00000097          	auipc	ra,0x0
    80002484:	d00080e7          	jalr	-768(ra) # 80002180 <_ZN10_Semaphore6unlockEv>
    return 0;
    80002488:	00000513          	li	a0,0
}
    8000248c:	01813083          	ld	ra,24(sp)
    80002490:	01013403          	ld	s0,16(sp)
    80002494:	00813483          	ld	s1,8(sp)
    80002498:	02010113          	addi	sp,sp,32
    8000249c:	00008067          	ret
        unlock();
    800024a0:	00048513          	mv	a0,s1
    800024a4:	00000097          	auipc	ra,0x0
    800024a8:	cdc080e7          	jalr	-804(ra) # 80002180 <_ZN10_Semaphore6unlockEv>
        return -1;
    800024ac:	fff00513          	li	a0,-1
    800024b0:	fddff06f          	j	8000248c <_ZN10_Semaphore7tryWaitEv+0x40>

00000000800024b4 <_ZN3TCB8idleBodyEPv>:
    dispatch();

    return 0;
}

void TCB::idleBody(void*) {
    800024b4:	ff010113          	addi	sp,sp,-16
    800024b8:	00813423          	sd	s0,8(sp)
    800024bc:	01010413          	addi	s0,sp,16
        __asm__ volatile("csrw sip, %0" : : "r"(x));
    }

    static void ms_sstatus(uint64 mask)
    {
        __asm__ volatile("csrs sstatus, %0" : : "r"(mask));
    800024c0:	00200793          	li	a5,2
    800024c4:	1007a073          	csrs	sstatus,a5
    Riscv::ms_sstatus(Riscv::SSTATUS_SIE);
    while (true) {
    800024c8:	0000006f          	j	800024c8 <_ZN3TCB8idleBodyEPv+0x14>

00000000800024cc <_Z8printHexm>:
{
    800024cc:	fe010113          	addi	sp,sp,-32
    800024d0:	00113c23          	sd	ra,24(sp)
    800024d4:	00813823          	sd	s0,16(sp)
    800024d8:	00913423          	sd	s1,8(sp)
    800024dc:	01213023          	sd	s2,0(sp)
    800024e0:	02010413          	addi	s0,sp,32
    800024e4:	00050913          	mv	s2,a0
    __putc('0');
    800024e8:	03000513          	li	a0,48
    800024ec:	00007097          	auipc	ra,0x7
    800024f0:	800080e7          	jalr	-2048(ra) # 80008cec <__putc>
    __putc('x');
    800024f4:	07800513          	li	a0,120
    800024f8:	00006097          	auipc	ra,0x6
    800024fc:	7f4080e7          	jalr	2036(ra) # 80008cec <__putc>
    for (int i = 15; i >= 0; i--) {
    80002500:	00f00493          	li	s1,15
    80002504:	0140006f          	j	80002518 <_Z8printHexm+0x4c>
            __putc('A' + digit - 10);
    80002508:	03750513          	addi	a0,a0,55
    8000250c:	00006097          	auipc	ra,0x6
    80002510:	7e0080e7          	jalr	2016(ra) # 80008cec <__putc>
    for (int i = 15; i >= 0; i--) {
    80002514:	fff4849b          	addiw	s1,s1,-1
    80002518:	0204c463          	bltz	s1,80002540 <_Z8printHexm+0x74>
        uint8 digit = (value >> (i * 4)) & 0xF;
    8000251c:	0024951b          	slliw	a0,s1,0x2
    80002520:	00a95533          	srl	a0,s2,a0
    80002524:	00f57513          	andi	a0,a0,15
        if (digit < 10)
    80002528:	00900793          	li	a5,9
    8000252c:	fca7eee3          	bltu	a5,a0,80002508 <_Z8printHexm+0x3c>
            __putc('0' + digit);
    80002530:	03050513          	addi	a0,a0,48
    80002534:	00006097          	auipc	ra,0x6
    80002538:	7b8080e7          	jalr	1976(ra) # 80008cec <__putc>
    8000253c:	fd9ff06f          	j	80002514 <_Z8printHexm+0x48>
    __putc('\n');
    80002540:	00a00513          	li	a0,10
    80002544:	00006097          	auipc	ra,0x6
    80002548:	7a8080e7          	jalr	1960(ra) # 80008cec <__putc>
}
    8000254c:	01813083          	ld	ra,24(sp)
    80002550:	01013403          	ld	s0,16(sp)
    80002554:	00813483          	ld	s1,8(sp)
    80002558:	00013903          	ld	s2,0(sp)
    8000255c:	02010113          	addi	sp,sp,32
    80002560:	00008067          	ret

0000000080002564 <_ZN3TCBC1EPFvPvES0_PmS3_b>:
TCB::TCB(Body body,
    80002564:	ff010113          	addi	sp,sp,-16
    80002568:	00813423          	sd	s0,8(sp)
    8000256c:	01010413          	addi	s0,sp,16
    this->body = body;
    80002570:	00b53023          	sd	a1,0(a0)
    this->arg = arg;
    80002574:	00c53423          	sd	a2,8(a0)
    this->stack = stack;
    80002578:	00d53823          	sd	a3,16(a0)
    this->systemStack = systemStack;
    8000257c:	08e53823          	sd	a4,144(a0)
    this->finished = false;
    80002580:	08050423          	sb	zero,136(a0)
    this->blocked = false;
    80002584:	080504a3          	sb	zero,137(a0)
    this->semaphoreWaitResult = 0;
    80002588:	08052e23          	sw	zero,156(a0)
    this->systemThread = systemThread;
    8000258c:	08f50c23          	sb	a5,152(a0)
    context = {};
    80002590:	00053c23          	sd	zero,24(a0)
    80002594:	02053023          	sd	zero,32(a0)
    80002598:	02053423          	sd	zero,40(a0)
    8000259c:	02053823          	sd	zero,48(a0)
    800025a0:	02053c23          	sd	zero,56(a0)
    800025a4:	04053023          	sd	zero,64(a0)
    800025a8:	04053423          	sd	zero,72(a0)
    800025ac:	04053823          	sd	zero,80(a0)
    800025b0:	04053c23          	sd	zero,88(a0)
    800025b4:	06053023          	sd	zero,96(a0)
    800025b8:	06053423          	sd	zero,104(a0)
    800025bc:	06053823          	sd	zero,112(a0)
    800025c0:	06053c23          	sd	zero,120(a0)
    800025c4:	08053023          	sd	zero,128(a0)
    if (body != nullptr) {
    800025c8:	02058263          	beqz	a1,800025ec <_ZN3TCBC1EPFvPvES0_PmS3_b+0x88>
        context.ra = (uint64)&threadStart;
    800025cc:	00009797          	auipc	a5,0x9
    800025d0:	5247b783          	ld	a5,1316(a5) # 8000baf0 <_GLOBAL_OFFSET_TABLE_+0x50>
    800025d4:	00f53c23          	sd	a5,24(a0)
        uint64 top = (uint64)&stack[DEFAULT_STACK_SIZE];
        return top & ~((uint64)0xF);
    }

    uint64 getSystemStackTop() const {
        if (systemStack == nullptr) return 0;
    800025d8:	02070063          	beqz	a4,800025f8 <_ZN3TCBC1EPFvPvES0_PmS3_b+0x94>

        uint64 top = (uint64)&systemStack[DEFAULT_STACK_SIZE];
    800025dc:	000087b7          	lui	a5,0x8
    800025e0:	00f70733          	add	a4,a4,a5

        return top & ~((uint64)0xF);
    800025e4:	ff077713          	andi	a4,a4,-16
        context.systemSp = getSystemStackTop();
    800025e8:	02e53023          	sd	a4,32(a0)
}
    800025ec:	00813403          	ld	s0,8(sp)
    800025f0:	01010113          	addi	sp,sp,16
    800025f4:	00008067          	ret
        if (systemStack == nullptr) return 0;
    800025f8:	00000713          	li	a4,0
    800025fc:	fedff06f          	j	800025e8 <_ZN3TCBC1EPFvPvES0_PmS3_b+0x84>

0000000080002600 <_ZN3TCB6createEPPS_PFvPvES2_PmS5_b>:
    if (handle == nullptr) return -1;
    80002600:	0c050c63          	beqz	a0,800026d8 <_ZN3TCB6createEPPS_PFvPvES2_PmS5_b+0xd8>
{
    80002604:	fb010113          	addi	sp,sp,-80
    80002608:	04113423          	sd	ra,72(sp)
    8000260c:	04813023          	sd	s0,64(sp)
    80002610:	02913c23          	sd	s1,56(sp)
    80002614:	03213823          	sd	s2,48(sp)
    80002618:	03313423          	sd	s3,40(sp)
    8000261c:	03413023          	sd	s4,32(sp)
    80002620:	01513c23          	sd	s5,24(sp)
    80002624:	01613823          	sd	s6,16(sp)
    80002628:	01713423          	sd	s7,8(sp)
    8000262c:	05010413          	addi	s0,sp,80
    80002630:	00050913          	mv	s2,a0
    80002634:	00058993          	mv	s3,a1
    80002638:	00060a13          	mv	s4,a2
    8000263c:	00068a93          	mv	s5,a3
    80002640:	00070b13          	mv	s6,a4
    80002644:	00078b93          	mv	s7,a5
    );
    80002648:	0a000513          	li	a0,160
    8000264c:	fffff097          	auipc	ra,0xfffff
    80002650:	f24080e7          	jalr	-220(ra) # 80001570 <_Znwm>
    80002654:	00050493          	mv	s1,a0
    80002658:	000b8793          	mv	a5,s7
    8000265c:	000b0713          	mv	a4,s6
    80002660:	000a8693          	mv	a3,s5
    80002664:	000a0613          	mv	a2,s4
    80002668:	00098593          	mv	a1,s3
    8000266c:	00000097          	auipc	ra,0x0
    80002670:	ef8080e7          	jalr	-264(ra) # 80002564 <_ZN3TCBC1EPFvPvES0_PmS3_b>
    if (newThread == nullptr) {
    80002674:	04048463          	beqz	s1,800026bc <_ZN3TCB6createEPPS_PFvPvES2_PmS5_b+0xbc>
    *handle = newThread;
    80002678:	00993023          	sd	s1,0(s2)
    if (body == nullptr) {
    8000267c:	04098663          	beqz	s3,800026c8 <_ZN3TCB6createEPPS_PFvPvES2_PmS5_b+0xc8>
        Scheduler::put(newThread);
    80002680:	00048513          	mv	a0,s1
    80002684:	fffff097          	auipc	ra,0xfffff
    80002688:	37c080e7          	jalr	892(ra) # 80001a00 <_ZN9Scheduler3putEP3TCB>
    return 0;
    8000268c:	00000513          	li	a0,0
}
    80002690:	04813083          	ld	ra,72(sp)
    80002694:	04013403          	ld	s0,64(sp)
    80002698:	03813483          	ld	s1,56(sp)
    8000269c:	03013903          	ld	s2,48(sp)
    800026a0:	02813983          	ld	s3,40(sp)
    800026a4:	02013a03          	ld	s4,32(sp)
    800026a8:	01813a83          	ld	s5,24(sp)
    800026ac:	01013b03          	ld	s6,16(sp)
    800026b0:	00813b83          	ld	s7,8(sp)
    800026b4:	05010113          	addi	sp,sp,80
    800026b8:	00008067          	ret
        *handle = nullptr;
    800026bc:	00093023          	sd	zero,0(s2)
        return -1;
    800026c0:	fff00513          	li	a0,-1
    800026c4:	fcdff06f          	j	80002690 <_ZN3TCB6createEPPS_PFvPvES2_PmS5_b+0x90>
        running = newThread;
    800026c8:	00009797          	auipc	a5,0x9
    800026cc:	4897b823          	sd	s1,1168(a5) # 8000bb58 <_ZN3TCB7runningE>
    return 0;
    800026d0:	00000513          	li	a0,0
    800026d4:	fbdff06f          	j	80002690 <_ZN3TCB6createEPPS_PFvPvES2_PmS5_b+0x90>
    if (handle == nullptr) return -1;
    800026d8:	fff00513          	li	a0,-1
}
    800026dc:	00008067          	ret

00000000800026e0 <_ZN3TCB6createEPPS_PFvPvES2_PmS5_>:
{
    800026e0:	ff010113          	addi	sp,sp,-16
    800026e4:	00113423          	sd	ra,8(sp)
    800026e8:	00813023          	sd	s0,0(sp)
    800026ec:	01010413          	addi	s0,sp,16
    return create(
    800026f0:	00000793          	li	a5,0
    800026f4:	00000097          	auipc	ra,0x0
    800026f8:	f0c080e7          	jalr	-244(ra) # 80002600 <_ZN3TCB6createEPPS_PFvPvES2_PmS5_b>
}
    800026fc:	00813083          	ld	ra,8(sp)
    80002700:	00013403          	ld	s0,0(sp)
    80002704:	01010113          	addi	sp,sp,16
    80002708:	00008067          	ret

000000008000270c <_ZN3TCB8dispatchEv>:
{
    8000270c:	fe010113          	addi	sp,sp,-32
    80002710:	00113c23          	sd	ra,24(sp)
    80002714:	00813823          	sd	s0,16(sp)
    80002718:	00913423          	sd	s1,8(sp)
    8000271c:	02010413          	addi	s0,sp,32
    TCB* old = running;
    80002720:	00009497          	auipc	s1,0x9
    80002724:	4384b483          	ld	s1,1080(s1) # 8000bb58 <_ZN3TCB7runningE>
    if (old == nullptr) {
    80002728:	06048463          	beqz	s1,80002790 <_ZN3TCB8dispatchEv+0x84>
    if (old != idle &&
    8000272c:	00009797          	auipc	a5,0x9
    80002730:	4347b783          	ld	a5,1076(a5) # 8000bb60 <_ZN3TCB4idleE>
        !old->isFinished() &&
    80002734:	00978a63          	beq	a5,s1,80002748 <_ZN3TCB8dispatchEv+0x3c>
        return finished;
    80002738:	0884c783          	lbu	a5,136(s1)
    if (old != idle &&
    8000273c:	00079663          	bnez	a5,80002748 <_ZN3TCB8dispatchEv+0x3c>
    bool isBlocked() const { return blocked;}
    80002740:	0894c783          	lbu	a5,137(s1)
        !old->isFinished() &&
    80002744:	04078e63          	beqz	a5,800027a0 <_ZN3TCB8dispatchEv+0x94>
    TCB* next = Scheduler::get();
    80002748:	fffff097          	auipc	ra,0xfffff
    8000274c:	250080e7          	jalr	592(ra) # 80001998 <_ZN9Scheduler3getEv>
    80002750:	00050593          	mv	a1,a0
    if (next == nullptr) {
    80002754:	04050e63          	beqz	a0,800027b0 <_ZN3TCB8dispatchEv+0xa4>
    if (next == nullptr) {
    80002758:	06058263          	beqz	a1,800027bc <_ZN3TCB8dispatchEv+0xb0>
    running = next;
    8000275c:	00009797          	auipc	a5,0x9
    80002760:	3fc78793          	addi	a5,a5,1020 # 8000bb58 <_ZN3TCB7runningE>
    80002764:	00b7b023          	sd	a1,0(a5)
        timeSliceCounter = 0;
    80002768:	0007b823          	sd	zero,16(a5)
    contextSwitch(
    8000276c:	01858593          	addi	a1,a1,24
    80002770:	01848513          	addi	a0,s1,24
    80002774:	fffff097          	auipc	ra,0xfffff
    80002778:	a1c080e7          	jalr	-1508(ra) # 80001190 <contextSwitch>
}
    8000277c:	01813083          	ld	ra,24(sp)
    80002780:	01013403          	ld	s0,16(sp)
    80002784:	00813483          	ld	s1,8(sp)
    80002788:	02010113          	addi	sp,sp,32
    8000278c:	00008067          	ret
        __putc('O');
    80002790:	04f00513          	li	a0,79
    80002794:	00006097          	auipc	ra,0x6
    80002798:	558080e7          	jalr	1368(ra) # 80008cec <__putc>
        while (true) {}
    8000279c:	0000006f          	j	8000279c <_ZN3TCB8dispatchEv+0x90>
        Scheduler::put(old);
    800027a0:	00048513          	mv	a0,s1
    800027a4:	fffff097          	auipc	ra,0xfffff
    800027a8:	25c080e7          	jalr	604(ra) # 80001a00 <_ZN9Scheduler3putEP3TCB>
    800027ac:	f9dff06f          	j	80002748 <_ZN3TCB8dispatchEv+0x3c>
        next = idle;
    800027b0:	00009597          	auipc	a1,0x9
    800027b4:	3b05b583          	ld	a1,944(a1) # 8000bb60 <_ZN3TCB4idleE>
    800027b8:	fa1ff06f          	j	80002758 <_ZN3TCB8dispatchEv+0x4c>
        __putc('Z');
    800027bc:	05a00513          	li	a0,90
    800027c0:	00006097          	auipc	ra,0x6
    800027c4:	52c080e7          	jalr	1324(ra) # 80008cec <__putc>
        while (true) {}
    800027c8:	0000006f          	j	800027c8 <_ZN3TCB8dispatchEv+0xbc>

00000000800027cc <_ZN3TCB4exitEv>:
    if (running == nullptr) {
    800027cc:	00009797          	auipc	a5,0x9
    800027d0:	38c7b783          	ld	a5,908(a5) # 8000bb58 <_ZN3TCB7runningE>
    800027d4:	02078463          	beqz	a5,800027fc <_ZN3TCB4exitEv+0x30>
{
    800027d8:	ff010113          	addi	sp,sp,-16
    800027dc:	00113423          	sd	ra,8(sp)
    800027e0:	00813023          	sd	s0,0(sp)
    800027e4:	01010413          	addi	s0,sp,16
    running->finished = true;
    800027e8:	00100713          	li	a4,1
    800027ec:	08e78423          	sb	a4,136(a5)
    dispatch();
    800027f0:	00000097          	auipc	ra,0x0
    800027f4:	f1c080e7          	jalr	-228(ra) # 8000270c <_ZN3TCB8dispatchEv>
    while (true) {
    800027f8:	0000006f          	j	800027f8 <_ZN3TCB4exitEv+0x2c>
}
    800027fc:	fff00513          	li	a0,-1
    80002800:	00008067          	ret

0000000080002804 <_ZN3TCB13threadWrapperEv>:
{
    80002804:	fe010113          	addi	sp,sp,-32
    80002808:	00113c23          	sd	ra,24(sp)
    8000280c:	00813823          	sd	s0,16(sp)
    80002810:	00913423          	sd	s1,8(sp)
    80002814:	02010413          	addi	s0,sp,32
    running->body(running->arg);
    80002818:	00009497          	auipc	s1,0x9
    8000281c:	34048493          	addi	s1,s1,832 # 8000bb58 <_ZN3TCB7runningE>
    80002820:	0004b783          	ld	a5,0(s1)
    80002824:	0007b703          	ld	a4,0(a5)
    80002828:	0087b503          	ld	a0,8(a5)
    8000282c:	000700e7          	jalr	a4
    if (running->isSystemThread()) {
    80002830:	0004b783          	ld	a5,0(s1)
        return systemThread;
    80002834:	0987c783          	lbu	a5,152(a5)
    80002838:	00078863          	beqz	a5,80002848 <_ZN3TCB13threadWrapperEv+0x44>
        TCB::exit();
    8000283c:	00000097          	auipc	ra,0x0
    80002840:	f90080e7          	jalr	-112(ra) # 800027cc <_ZN3TCB4exitEv>
    while (true) {}
    80002844:	0000006f          	j	80002844 <_ZN3TCB13threadWrapperEv+0x40>
        thread_exit();
    80002848:	fffff097          	auipc	ra,0xfffff
    8000284c:	b54080e7          	jalr	-1196(ra) # 8000139c <_Z11thread_exitv>
    80002850:	ff5ff06f          	j	80002844 <_ZN3TCB13threadWrapperEv+0x40>

0000000080002854 <_ZN3TCB16runThreadWrapperEv>:
{
    80002854:	ff010113          	addi	sp,sp,-16
    80002858:	00113423          	sd	ra,8(sp)
    8000285c:	00813023          	sd	s0,0(sp)
    80002860:	01010413          	addi	s0,sp,16
    threadWrapper();
    80002864:	00000097          	auipc	ra,0x0
    80002868:	fa0080e7          	jalr	-96(ra) # 80002804 <_ZN3TCB13threadWrapperEv>

000000008000286c <_ZN3TCB10createMainEPPS_>:
    if (!handle) return -1;
    8000286c:	0c050063          	beqz	a0,8000292c <_ZN3TCB10createMainEPPS_+0xc0>
int TCB::createMain(TCB **handle) {
    80002870:	fd010113          	addi	sp,sp,-48
    80002874:	02113423          	sd	ra,40(sp)
    80002878:	02813023          	sd	s0,32(sp)
    8000287c:	00913c23          	sd	s1,24(sp)
    80002880:	01213823          	sd	s2,16(sp)
    80002884:	01313423          	sd	s3,8(sp)
    80002888:	03010413          	addi	s0,sp,48
    8000288c:	00050913          	mv	s2,a0
    uint64* systemStack = (uint64*)MemoryAllocator::mem_alloc(
    80002890:	00008537          	lui	a0,0x8
    80002894:	00001097          	auipc	ra,0x1
    80002898:	b30080e7          	jalr	-1232(ra) # 800033c4 <_ZN15MemoryAllocator9mem_allocEm>
    8000289c:	00050993          	mv	s3,a0
    if (!systemStack) {
    800028a0:	06050463          	beqz	a0,80002908 <_ZN3TCB10createMainEPPS_+0x9c>
            );
    800028a4:	0a000513          	li	a0,160
    800028a8:	fffff097          	auipc	ra,0xfffff
    800028ac:	cc8080e7          	jalr	-824(ra) # 80001570 <_Znwm>
    800028b0:	00050493          	mv	s1,a0
    800028b4:	00100793          	li	a5,1
    800028b8:	00098713          	mv	a4,s3
    800028bc:	00000693          	li	a3,0
    800028c0:	00000613          	li	a2,0
    800028c4:	00000593          	li	a1,0
    800028c8:	00000097          	auipc	ra,0x0
    800028cc:	c9c080e7          	jalr	-868(ra) # 80002564 <_ZN3TCBC1EPFvPvES0_PmS3_b>
    if (!mainThread) {
    800028d0:	04048263          	beqz	s1,80002914 <_ZN3TCB10createMainEPPS_+0xa8>
    running = mainThread;
    800028d4:	00009797          	auipc	a5,0x9
    800028d8:	2897b223          	sd	s1,644(a5) # 8000bb58 <_ZN3TCB7runningE>
    *handle = mainThread;
    800028dc:	00993023          	sd	s1,0(s2)
        __asm__ volatile("csrw sscratch, %0" : : "r"(value));
    800028e0:	00000793          	li	a5,0
    800028e4:	14079073          	csrw	sscratch,a5
    return 0;
    800028e8:	00000513          	li	a0,0
}
    800028ec:	02813083          	ld	ra,40(sp)
    800028f0:	02013403          	ld	s0,32(sp)
    800028f4:	01813483          	ld	s1,24(sp)
    800028f8:	01013903          	ld	s2,16(sp)
    800028fc:	00813983          	ld	s3,8(sp)
    80002900:	03010113          	addi	sp,sp,48
    80002904:	00008067          	ret
        *handle = nullptr;
    80002908:	00093023          	sd	zero,0(s2)
        return -1;
    8000290c:	fff00513          	li	a0,-1
    80002910:	fddff06f          	j	800028ec <_ZN3TCB10createMainEPPS_+0x80>
        MemoryAllocator::mem_free(systemStack);
    80002914:	00098513          	mv	a0,s3
    80002918:	00001097          	auipc	ra,0x1
    8000291c:	b64080e7          	jalr	-1180(ra) # 8000347c <_ZN15MemoryAllocator8mem_freeEPv>
        *handle = nullptr;
    80002920:	00093023          	sd	zero,0(s2)
        return -1;
    80002924:	fff00513          	li	a0,-1
    80002928:	fc5ff06f          	j	800028ec <_ZN3TCB10createMainEPPS_+0x80>
    if (!handle) return -1;
    8000292c:	fff00513          	li	a0,-1
}
    80002930:	00008067          	ret

0000000080002934 <_ZN3TCB5sleepEm>:
    if (sleepTime == 0) {
    80002934:	00051663          	bnez	a0,80002940 <_ZN3TCB5sleepEm+0xc>
        return 0;
    80002938:	00000513          	li	a0,0
}
    8000293c:	00008067          	ret
int TCB::sleep(time_t sleepTime) {
    80002940:	ff010113          	addi	sp,sp,-16
    80002944:	00113423          	sd	ra,8(sp)
    80002948:	00813023          	sd	s0,0(sp)
    8000294c:	01010413          	addi	s0,sp,16
    80002950:	00050593          	mv	a1,a0
    running->setBlocked(true);
    80002954:	00009517          	auipc	a0,0x9
    80002958:	20453503          	ld	a0,516(a0) # 8000bb58 <_ZN3TCB7runningE>
    void setBlocked(bool b) {blocked = b;}
    8000295c:	00100793          	li	a5,1
    80002960:	08f504a3          	sb	a5,137(a0)
    int result = SleepingThreads::put(running, sleepTime);
    80002964:	fffff097          	auipc	ra,0xfffff
    80002968:	240080e7          	jalr	576(ra) # 80001ba4 <_ZN15SleepingThreads3putEP3TCBm>
    if (result < 0) {
    8000296c:	02054063          	bltz	a0,8000298c <_ZN3TCB5sleepEm+0x58>
    dispatch();
    80002970:	00000097          	auipc	ra,0x0
    80002974:	d9c080e7          	jalr	-612(ra) # 8000270c <_ZN3TCB8dispatchEv>
    return 0;
    80002978:	00000513          	li	a0,0
}
    8000297c:	00813083          	ld	ra,8(sp)
    80002980:	00013403          	ld	s0,0(sp)
    80002984:	01010113          	addi	sp,sp,16
    80002988:	00008067          	ret
        running->setBlocked(false);
    8000298c:	00009797          	auipc	a5,0x9
    80002990:	1cc7b783          	ld	a5,460(a5) # 8000bb58 <_ZN3TCB7runningE>
    80002994:	080784a3          	sb	zero,137(a5)
        return -1;
    80002998:	fff00513          	li	a0,-1
    8000299c:	fe1ff06f          	j	8000297c <_ZN3TCB5sleepEm+0x48>

00000000800029a0 <_ZN3TCB14initializeIdleEv>:
    }
}

int TCB::initializeIdle() {
    800029a0:	fe010113          	addi	sp,sp,-32
    800029a4:	00113c23          	sd	ra,24(sp)
    800029a8:	00813823          	sd	s0,16(sp)
    800029ac:	00913423          	sd	s1,8(sp)
    800029b0:	01213023          	sd	s2,0(sp)
    800029b4:	02010413          	addi	s0,sp,32
    uint64* systemStack =
        (uint64*)MemoryAllocator::mem_alloc(
    800029b8:	00008537          	lui	a0,0x8
    800029bc:	00001097          	auipc	ra,0x1
    800029c0:	a08080e7          	jalr	-1528(ra) # 800033c4 <_ZN15MemoryAllocator9mem_allocEm>
            DEFAULT_STACK_SIZE * sizeof(uint64)
        );

    if (systemStack == nullptr) {
    800029c4:	06050a63          	beqz	a0,80002a38 <_ZN3TCB14initializeIdleEv+0x98>
    800029c8:	00050493          	mv	s1,a0
        &idleBody,
        nullptr,
        nullptr,
        systemStack,
        true
    );
    800029cc:	0a000513          	li	a0,160
    800029d0:	fffff097          	auipc	ra,0xfffff
    800029d4:	ba0080e7          	jalr	-1120(ra) # 80001570 <_Znwm>
    800029d8:	00050913          	mv	s2,a0
    800029dc:	00100793          	li	a5,1
    800029e0:	00048713          	mv	a4,s1
    800029e4:	00000693          	li	a3,0
    800029e8:	00000613          	li	a2,0
    800029ec:	00000597          	auipc	a1,0x0
    800029f0:	ac858593          	addi	a1,a1,-1336 # 800024b4 <_ZN3TCB8idleBodyEPv>
    800029f4:	00000097          	auipc	ra,0x0
    800029f8:	b70080e7          	jalr	-1168(ra) # 80002564 <_ZN3TCBC1EPFvPvES0_PmS3_b>
    TCB::idle = new TCB(
    800029fc:	00009797          	auipc	a5,0x9
    80002a00:	1727b223          	sd	s2,356(a5) # 8000bb60 <_ZN3TCB4idleE>

    if (TCB::idle == nullptr) {
    80002a04:	02090063          	beqz	s2,80002a24 <_ZN3TCB14initializeIdleEv+0x84>
        MemoryAllocator::mem_free(systemStack);
        return -1;
    }

    return 0;
    80002a08:	00000513          	li	a0,0
}
    80002a0c:	01813083          	ld	ra,24(sp)
    80002a10:	01013403          	ld	s0,16(sp)
    80002a14:	00813483          	ld	s1,8(sp)
    80002a18:	00013903          	ld	s2,0(sp)
    80002a1c:	02010113          	addi	sp,sp,32
    80002a20:	00008067          	ret
        MemoryAllocator::mem_free(systemStack);
    80002a24:	00048513          	mv	a0,s1
    80002a28:	00001097          	auipc	ra,0x1
    80002a2c:	a54080e7          	jalr	-1452(ra) # 8000347c <_ZN15MemoryAllocator8mem_freeEPv>
        return -1;
    80002a30:	fff00513          	li	a0,-1
    80002a34:	fd9ff06f          	j	80002a0c <_ZN3TCB14initializeIdleEv+0x6c>
        return -1;
    80002a38:	fff00513          	li	a0,-1
    80002a3c:	fd1ff06f          	j	80002a0c <_ZN3TCB14initializeIdleEv+0x6c>

0000000080002a40 <_ZN3TCB22getRunningUserStackTopEv>:

uint64 TCB::getRunningUserStackTop() {
    80002a40:	ff010113          	addi	sp,sp,-16
    80002a44:	00813423          	sd	s0,8(sp)
    80002a48:	01010413          	addi	s0,sp,16
    if (running == nullptr) {
    80002a4c:	00009797          	auipc	a5,0x9
    80002a50:	10c7b783          	ld	a5,268(a5) # 8000bb58 <_ZN3TCB7runningE>
    80002a54:	02078263          	beqz	a5,80002a78 <_ZN3TCB22getRunningUserStackTopEv+0x38>
        if (stack == nullptr) return 0;
    80002a58:	0107b503          	ld	a0,16(a5)
    80002a5c:	02050263          	beqz	a0,80002a80 <_ZN3TCB22getRunningUserStackTopEv+0x40>
        uint64 top = (uint64)&stack[DEFAULT_STACK_SIZE];
    80002a60:	000087b7          	lui	a5,0x8
    80002a64:	00f50533          	add	a0,a0,a5
        return top & ~((uint64)0xF);
    80002a68:	ff057513          	andi	a0,a0,-16
        return 0;
    }

    return running->getUserStackTop();
}
    80002a6c:	00813403          	ld	s0,8(sp)
    80002a70:	01010113          	addi	sp,sp,16
    80002a74:	00008067          	ret
        return 0;
    80002a78:	00000513          	li	a0,0
    80002a7c:	ff1ff06f          	j	80002a6c <_ZN3TCB22getRunningUserStackTopEv+0x2c>
        if (stack == nullptr) return 0;
    80002a80:	00000513          	li	a0,0
    80002a84:	fe9ff06f          	j	80002a6c <_ZN3TCB22getRunningUserStackTopEv+0x2c>

0000000080002a88 <_ZN3TCB24getRunningSystemStackTopEv>:

uint64 TCB::getRunningSystemStackTop() {
    80002a88:	ff010113          	addi	sp,sp,-16
    80002a8c:	00813423          	sd	s0,8(sp)
    80002a90:	01010413          	addi	s0,sp,16
    if (running == nullptr) {
    80002a94:	00009797          	auipc	a5,0x9
    80002a98:	0c47b783          	ld	a5,196(a5) # 8000bb58 <_ZN3TCB7runningE>
    80002a9c:	02078263          	beqz	a5,80002ac0 <_ZN3TCB24getRunningSystemStackTopEv+0x38>
        if (systemStack == nullptr) return 0;
    80002aa0:	0907b503          	ld	a0,144(a5)
    80002aa4:	02050263          	beqz	a0,80002ac8 <_ZN3TCB24getRunningSystemStackTopEv+0x40>
        uint64 top = (uint64)&systemStack[DEFAULT_STACK_SIZE];
    80002aa8:	000087b7          	lui	a5,0x8
    80002aac:	00f50533          	add	a0,a0,a5
        return top & ~((uint64)0xF);
    80002ab0:	ff057513          	andi	a0,a0,-16
        return 0;
    }

    return running->getSystemStackTop();
}
    80002ab4:	00813403          	ld	s0,8(sp)
    80002ab8:	01010113          	addi	sp,sp,16
    80002abc:	00008067          	ret
        return 0;
    80002ac0:	00000513          	li	a0,0
    80002ac4:	ff1ff06f          	j	80002ab4 <_ZN3TCB24getRunningSystemStackTopEv+0x2c>
        if (systemStack == nullptr) return 0;
    80002ac8:	00000513          	li	a0,0
    80002acc:	fe9ff06f          	j	80002ab4 <_ZN3TCB24getRunningSystemStackTopEv+0x2c>

0000000080002ad0 <threadWrapperC>:

extern "C" void threadWrapperC()
{
    80002ad0:	ff010113          	addi	sp,sp,-16
    80002ad4:	00113423          	sd	ra,8(sp)
    80002ad8:	00813023          	sd	s0,0(sp)
    80002adc:	01010413          	addi	s0,sp,16
    TCB::runThreadWrapper();
    80002ae0:	00000097          	auipc	ra,0x0
    80002ae4:	d74080e7          	jalr	-652(ra) # 80002854 <_ZN3TCB16runThreadWrapperEv>

0000000080002ae8 <getRunningUserStackTopC>:
}

extern "C" uint64 getRunningUserStackTopC() {
    80002ae8:	ff010113          	addi	sp,sp,-16
    80002aec:	00113423          	sd	ra,8(sp)
    80002af0:	00813023          	sd	s0,0(sp)
    80002af4:	01010413          	addi	s0,sp,16
    return TCB::getRunningUserStackTop();
    80002af8:	00000097          	auipc	ra,0x0
    80002afc:	f48080e7          	jalr	-184(ra) # 80002a40 <_ZN3TCB22getRunningUserStackTopEv>
}
    80002b00:	00813083          	ld	ra,8(sp)
    80002b04:	00013403          	ld	s0,0(sp)
    80002b08:	01010113          	addi	sp,sp,16
    80002b0c:	00008067          	ret

0000000080002b10 <getRunningSystemStackTopC>:

extern "C" uint64 getRunningSystemStackTopC() {
    80002b10:	ff010113          	addi	sp,sp,-16
    80002b14:	00113423          	sd	ra,8(sp)
    80002b18:	00813023          	sd	s0,0(sp)
    80002b1c:	01010413          	addi	s0,sp,16
    return TCB::getRunningSystemStackTop();
    80002b20:	00000097          	auipc	ra,0x0
    80002b24:	f68080e7          	jalr	-152(ra) # 80002a88 <_ZN3TCB24getRunningSystemStackTopEv>
}
    80002b28:	00813083          	ld	ra,8(sp)
    80002b2c:	00013403          	ld	s0,0(sp)
    80002b30:	01010113          	addi	sp,sp,16
    80002b34:	00008067          	ret

0000000080002b38 <isRunningSystemThreadC>:

extern "C" uint64 isRunningSystemThreadC()
{
    80002b38:	ff010113          	addi	sp,sp,-16
    80002b3c:	00813423          	sd	s0,8(sp)
    80002b40:	01010413          	addi	s0,sp,16
    if (TCB::running == nullptr) {
    80002b44:	00009797          	auipc	a5,0x9
    80002b48:	0147b783          	ld	a5,20(a5) # 8000bb58 <_ZN3TCB7runningE>
    80002b4c:	00078e63          	beqz	a5,80002b68 <isRunningSystemThreadC+0x30>
        return systemThread;
    80002b50:	0987c783          	lbu	a5,152(a5)
        return 1;
    }

    return TCB::running->isSystemThread() ? 1 : 0;
    80002b54:	00078e63          	beqz	a5,80002b70 <isRunningSystemThreadC+0x38>
    80002b58:	00100513          	li	a0,1
}
    80002b5c:	00813403          	ld	s0,8(sp)
    80002b60:	01010113          	addi	sp,sp,16
    80002b64:	00008067          	ret
        return 1;
    80002b68:	00100513          	li	a0,1
    80002b6c:	ff1ff06f          	j	80002b5c <isRunningSystemThreadC+0x24>
    return TCB::running->isSystemThread() ? 1 : 0;
    80002b70:	00000513          	li	a0,0
    80002b74:	fe9ff06f          	j	80002b5c <isRunningSystemThreadC+0x24>

0000000080002b78 <_ZL17readConsoleStatusv>:
volatile uint64 _Console::txReadyCount = 0;
extern "C" {
void uartinit();
int uartgetc();
}
static uint8 readConsoleStatus() {
    80002b78:	ff010113          	addi	sp,sp,-16
    80002b7c:	00813423          	sd	s0,8(sp)
    80002b80:	01010413          	addi	s0,sp,16
    return *(volatile uint8*)CONSOLE_STATUS;
    80002b84:	00009797          	auipc	a5,0x9
    80002b88:	f2c7b783          	ld	a5,-212(a5) # 8000bab0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002b8c:	0007b783          	ld	a5,0(a5)
    80002b90:	0007c503          	lbu	a0,0(a5)
}
    80002b94:	0ff57513          	andi	a0,a0,255
    80002b98:	00813403          	ld	s0,8(sp)
    80002b9c:	01010113          	addi	sp,sp,16
    80002ba0:	00008067          	ret

0000000080002ba4 <_ZN8_Console12outputWorkerEPv>:
        inputBuffer->tryPut(c);
    }
}

void _Console::outputWorker(void*)
{
    80002ba4:	fe010113          	addi	sp,sp,-32
    80002ba8:	00113c23          	sd	ra,24(sp)
    80002bac:	00813823          	sd	s0,16(sp)
    80002bb0:	00913423          	sd	s1,8(sp)
    80002bb4:	02010413          	addi	s0,sp,32
    while (true) {
        char c = outputBuffer->get();
    80002bb8:	00009517          	auipc	a0,0x9
    80002bbc:	fb853503          	ld	a0,-72(a0) # 8000bb70 <_ZN8_Console12outputBufferE>
    80002bc0:	fffff097          	auipc	ra,0xfffff
    80002bc4:	ba0080e7          	jalr	-1120(ra) # 80001760 <_ZN12KernelBuffer3getEv>
    80002bc8:	00050493          	mv	s1,a0
        while (!(readConsoleStatus() & CONSOLE_TX_STATUS_BIT)) {
    80002bcc:	00000097          	auipc	ra,0x0
    80002bd0:	fac080e7          	jalr	-84(ra) # 80002b78 <_ZL17readConsoleStatusv>
    80002bd4:	02057793          	andi	a5,a0,32
    80002bd8:	00078c63          	beqz	a5,80002bf0 <_ZN8_Console12outputWorkerEPv+0x4c>
            TCB::dispatch();
        }

        *(volatile uint8*)CONSOLE_TX_DATA = c;
    80002bdc:	00009797          	auipc	a5,0x9
    80002be0:	ef47b783          	ld	a5,-268(a5) # 8000bad0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80002be4:	0007b783          	ld	a5,0(a5)
    80002be8:	00978023          	sb	s1,0(a5)
    }
    80002bec:	fcdff06f          	j	80002bb8 <_ZN8_Console12outputWorkerEPv+0x14>
            TCB::dispatch();
    80002bf0:	00000097          	auipc	ra,0x0
    80002bf4:	b1c080e7          	jalr	-1252(ra) # 8000270c <_ZN3TCB8dispatchEv>
        while (!(readConsoleStatus() & CONSOLE_TX_STATUS_BIT)) {
    80002bf8:	fd5ff06f          	j	80002bcc <_ZN8_Console12outputWorkerEPv+0x28>

0000000080002bfc <_ZN8_Console10initializeEv>:
{
    80002bfc:	fe010113          	addi	sp,sp,-32
    80002c00:	00113c23          	sd	ra,24(sp)
    80002c04:	00813823          	sd	s0,16(sp)
    80002c08:	00913423          	sd	s1,8(sp)
    80002c0c:	01213023          	sd	s2,0(sp)
    80002c10:	02010413          	addi	s0,sp,32
    inputBuffer = new KernelBuffer();
    80002c14:	16000513          	li	a0,352
    80002c18:	fffff097          	auipc	ra,0xfffff
    80002c1c:	958080e7          	jalr	-1704(ra) # 80001570 <_Znwm>
    80002c20:	00050493          	mv	s1,a0
    80002c24:	fffff097          	auipc	ra,0xfffff
    80002c28:	a3c080e7          	jalr	-1476(ra) # 80001660 <_ZN12KernelBufferC1Ev>
    80002c2c:	00009797          	auipc	a5,0x9
    80002c30:	f497b623          	sd	s1,-180(a5) # 8000bb78 <_ZN8_Console11inputBufferE>
    outputBuffer = new KernelBuffer();
    80002c34:	16000513          	li	a0,352
    80002c38:	fffff097          	auipc	ra,0xfffff
    80002c3c:	938080e7          	jalr	-1736(ra) # 80001570 <_Znwm>
    80002c40:	00050493          	mv	s1,a0
    80002c44:	fffff097          	auipc	ra,0xfffff
    80002c48:	a1c080e7          	jalr	-1508(ra) # 80001660 <_ZN12KernelBufferC1Ev>
    80002c4c:	00009797          	auipc	a5,0x9
    80002c50:	f297b223          	sd	s1,-220(a5) # 8000bb70 <_ZN8_Console12outputBufferE>
        (uint64*)MemoryAllocator::mem_alloc(
    80002c54:	00008537          	lui	a0,0x8
    80002c58:	00000097          	auipc	ra,0x0
    80002c5c:	76c080e7          	jalr	1900(ra) # 800033c4 <_ZN15MemoryAllocator9mem_allocEm>
    80002c60:	00050493          	mv	s1,a0
    if (systemStack == nullptr) {
    80002c64:	06050063          	beqz	a0,80002cc4 <_ZN8_Console10initializeEv+0xc8>
    if (TCB::create(
    80002c68:	00100793          	li	a5,1
    80002c6c:	00050713          	mv	a4,a0
    80002c70:	00000693          	li	a3,0
    80002c74:	00000613          	li	a2,0
    80002c78:	00000597          	auipc	a1,0x0
    80002c7c:	f2c58593          	addi	a1,a1,-212 # 80002ba4 <_ZN8_Console12outputWorkerEPv>
    80002c80:	00009517          	auipc	a0,0x9
    80002c84:	f0050513          	addi	a0,a0,-256 # 8000bb80 <_ZN8_Console12outputThreadE>
    80002c88:	00000097          	auipc	ra,0x0
    80002c8c:	978080e7          	jalr	-1672(ra) # 80002600 <_ZN3TCB6createEPPS_PFvPvES2_PmS5_b>
    80002c90:	04051663          	bnez	a0,80002cdc <_ZN8_Console10initializeEv+0xe0>
    volatile uint8* uart =
    80002c94:	00009797          	auipc	a5,0x9
    80002c98:	e147b783          	ld	a5,-492(a5) # 8000baa8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002c9c:	0007b783          	ld	a5,0(a5)
    uart[3] = 0x03;  // LCR: 8 bita, bez pariteta, 1 stop bit
    80002ca0:	00300713          	li	a4,3
    80002ca4:	00e781a3          	sb	a4,3(a5)
    uart[1] = 0x00;  // IER: svi prekidi ugašeni
    80002ca8:	000780a3          	sb	zero,1(a5)
    uart[2] = 0x07;
    80002cac:	00700713          	li	a4,7
    80002cb0:	00e78123          	sb	a4,2(a5)
    uart[4] = 0x0B;
    80002cb4:	00b00713          	li	a4,11
    80002cb8:	00e78223          	sb	a4,4(a5)
    uart[1] = 0x01;
    80002cbc:	00100713          	li	a4,1
    80002cc0:	00e780a3          	sb	a4,1(a5)
}
    80002cc4:	01813083          	ld	ra,24(sp)
    80002cc8:	01013403          	ld	s0,16(sp)
    80002ccc:	00813483          	ld	s1,8(sp)
    80002cd0:	00013903          	ld	s2,0(sp)
    80002cd4:	02010113          	addi	sp,sp,32
    80002cd8:	00008067          	ret
        MemoryAllocator::mem_free(systemStack);
    80002cdc:	00048513          	mv	a0,s1
    80002ce0:	00000097          	auipc	ra,0x0
    80002ce4:	79c080e7          	jalr	1948(ra) # 8000347c <_ZN15MemoryAllocator8mem_freeEPv>
        return;
    80002ce8:	fddff06f          	j	80002cc4 <_ZN8_Console10initializeEv+0xc8>
    80002cec:	00050913          	mv	s2,a0
    inputBuffer = new KernelBuffer();
    80002cf0:	00048513          	mv	a0,s1
    80002cf4:	fffff097          	auipc	ra,0xfffff
    80002cf8:	8cc080e7          	jalr	-1844(ra) # 800015c0 <_ZdlPv>
    80002cfc:	00090513          	mv	a0,s2
    80002d00:	0000a097          	auipc	ra,0xa
    80002d04:	018080e7          	jalr	24(ra) # 8000cd18 <_Unwind_Resume>
    80002d08:	00050913          	mv	s2,a0
    outputBuffer = new KernelBuffer();
    80002d0c:	00048513          	mv	a0,s1
    80002d10:	fffff097          	auipc	ra,0xfffff
    80002d14:	8b0080e7          	jalr	-1872(ra) # 800015c0 <_ZdlPv>
    80002d18:	00090513          	mv	a0,s2
    80002d1c:	0000a097          	auipc	ra,0xa
    80002d20:	ffc080e7          	jalr	-4(ra) # 8000cd18 <_Unwind_Resume>

0000000080002d24 <_ZN8_Console4getcEv>:
char _Console::getc() {
    80002d24:	ff010113          	addi	sp,sp,-16
    80002d28:	00113423          	sd	ra,8(sp)
    80002d2c:	00813023          	sd	s0,0(sp)
    80002d30:	01010413          	addi	s0,sp,16
    return inputBuffer->get();
    80002d34:	00009517          	auipc	a0,0x9
    80002d38:	e4453503          	ld	a0,-444(a0) # 8000bb78 <_ZN8_Console11inputBufferE>
    80002d3c:	fffff097          	auipc	ra,0xfffff
    80002d40:	a24080e7          	jalr	-1500(ra) # 80001760 <_ZN12KernelBuffer3getEv>
}
    80002d44:	00813083          	ld	ra,8(sp)
    80002d48:	00013403          	ld	s0,0(sp)
    80002d4c:	01010113          	addi	sp,sp,16
    80002d50:	00008067          	ret

0000000080002d54 <_ZN8_Console4putcEc>:
{
    80002d54:	ff010113          	addi	sp,sp,-16
    80002d58:	00113423          	sd	ra,8(sp)
    80002d5c:	00813023          	sd	s0,0(sp)
    80002d60:	01010413          	addi	s0,sp,16
    80002d64:	00050593          	mv	a1,a0
    outputBuffer->put(c);
    80002d68:	00009517          	auipc	a0,0x9
    80002d6c:	e0853503          	ld	a0,-504(a0) # 8000bb70 <_ZN8_Console12outputBufferE>
    80002d70:	fffff097          	auipc	ra,0xfffff
    80002d74:	958080e7          	jalr	-1704(ra) # 800016c8 <_ZN12KernelBuffer3putEc>
}
    80002d78:	00813083          	ld	ra,8(sp)
    80002d7c:	00013403          	ld	s0,0(sp)
    80002d80:	01010113          	addi	sp,sp,16
    80002d84:	00008067          	ret

0000000080002d88 <_ZN8_Console15handleInterruptEv>:
{
    80002d88:	ff010113          	addi	sp,sp,-16
    80002d8c:	00113423          	sd	ra,8(sp)
    80002d90:	00813023          	sd	s0,0(sp)
    80002d94:	01010413          	addi	s0,sp,16
    while (readConsoleStatus() & CONSOLE_RX_STATUS_BIT) {
    80002d98:	00000097          	auipc	ra,0x0
    80002d9c:	de0080e7          	jalr	-544(ra) # 80002b78 <_ZL17readConsoleStatusv>
    80002da0:	00157513          	andi	a0,a0,1
    80002da4:	02050663          	beqz	a0,80002dd0 <_ZN8_Console15handleInterruptEv+0x48>
        char c = *(volatile uint8*)CONSOLE_RX_DATA;
    80002da8:	00009797          	auipc	a5,0x9
    80002dac:	d007b783          	ld	a5,-768(a5) # 8000baa8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80002db0:	0007b783          	ld	a5,0(a5)
    80002db4:	0007c583          	lbu	a1,0(a5)
        inputBuffer->tryPut(c);
    80002db8:	0ff5f593          	andi	a1,a1,255
    80002dbc:	00009517          	auipc	a0,0x9
    80002dc0:	dbc53503          	ld	a0,-580(a0) # 8000bb78 <_ZN8_Console11inputBufferE>
    80002dc4:	fffff097          	auipc	ra,0xfffff
    80002dc8:	a34080e7          	jalr	-1484(ra) # 800017f8 <_ZN12KernelBuffer6tryPutEc>
    while (readConsoleStatus() & CONSOLE_RX_STATUS_BIT) {
    80002dcc:	fcdff06f          	j	80002d98 <_ZN8_Console15handleInterruptEv+0x10>
}
    80002dd0:	00813083          	ld	ra,8(sp)
    80002dd4:	00013403          	ld	s0,0(sp)
    80002dd8:	01010113          	addi	sp,sp,16
    80002ddc:	00008067          	ret

0000000080002de0 <_ZN5Riscv20handleSupervisorTrapEPm>:
volatile uint64 debugExternalInterruptEntered = 0;
volatile int lastInterruptId = -1;
volatile uint64 consoleInterruptCount = 0;
volatile uint8 lastIir = 0;

void Riscv::handleSupervisorTrap(uint64* registers) {
    80002de0:	fd010113          	addi	sp,sp,-48
    80002de4:	02113423          	sd	ra,40(sp)
    80002de8:	02813023          	sd	s0,32(sp)
    80002dec:	00913c23          	sd	s1,24(sp)
    80002df0:	01213823          	sd	s2,16(sp)
    80002df4:	01313423          	sd	s3,8(sp)
    80002df8:	01413023          	sd	s4,0(sp)
    80002dfc:	03010413          	addi	s0,sp,48
    80002e00:	00050493          	mv	s1,a0
        __asm__ volatile("csrr %0, scause" : "=r"(value));
    80002e04:	14202973          	csrr	s2,scause
    uint64 scause = r_scause();

    if ((scause & (1UL << 63)) == 0 &&
    80002e08:	00094a63          	bltz	s2,80002e1c <_ZN5Riscv20handleSupervisorTrapEPm+0x3c>
    80002e0c:	00800793          	li	a5,8
    80002e10:	00f90663          	beq	s2,a5,80002e1c <_ZN5Riscv20handleSupervisorTrapEPm+0x3c>
    scause != 8 &&
    80002e14:	00900793          	li	a5,9
    80002e18:	0cf91a63          	bne	s2,a5,80002eec <_ZN5Riscv20handleSupervisorTrapEPm+0x10c>
        __putc('V');
        __putc(':');
        printHex(r_stval());
    }

    if (scause == 8 || scause == 9) {
    80002e1c:	ff890793          	addi	a5,s2,-8
    80002e20:	00100713          	li	a4,1
    80002e24:	14f77863          	bgeu	a4,a5,80002f74 <_ZN5Riscv20handleSupervisorTrapEPm+0x194>
            }
        }

        // w_sepc(sepc);
        return;
    } else if (scause == 0x8000000000000009UL) {
    80002e28:	fff00793          	li	a5,-1
    80002e2c:	03f79793          	slli	a5,a5,0x3f
    80002e30:	00978793          	addi	a5,a5,9
    80002e34:	38f90a63          	beq	s2,a5,800031c8 <_ZN5Riscv20handleSupervisorTrapEPm+0x3e8>
        if (interruptId != 0) {
            plic_complete(interruptId);
        }

        return;
    } else if (scause == 0x8000000000000001UL) {
    80002e38:	fff00793          	li	a5,-1
    80002e3c:	03f79793          	slli	a5,a5,0x3f
    80002e40:	00178793          	addi	a5,a5,1
    80002e44:	3af90c63          	beq	s2,a5,800031fc <_ZN5Riscv20handleSupervisorTrapEPm+0x41c>
            w_sepc(sepc);
        }

        return;
    } else {
        __putc('?');
    80002e48:	03f00513          	li	a0,63
    80002e4c:	00006097          	auipc	ra,0x6
    80002e50:	ea0080e7          	jalr	-352(ra) # 80008cec <__putc>
        __putc('\n');
    80002e54:	00a00513          	li	a0,10
    80002e58:	00006097          	auipc	ra,0x6
    80002e5c:	e94080e7          	jalr	-364(ra) # 80008cec <__putc>

        __putc('C');
    80002e60:	04300513          	li	a0,67
    80002e64:	00006097          	auipc	ra,0x6
    80002e68:	e88080e7          	jalr	-376(ra) # 80008cec <__putc>
        __putc(':');
    80002e6c:	03a00513          	li	a0,58
    80002e70:	00006097          	auipc	ra,0x6
    80002e74:	e7c080e7          	jalr	-388(ra) # 80008cec <__putc>
        printHex(scause);
    80002e78:	00090513          	mv	a0,s2
    80002e7c:	fffff097          	auipc	ra,0xfffff
    80002e80:	650080e7          	jalr	1616(ra) # 800024cc <_Z8printHexm>

        __putc('E');
    80002e84:	04500513          	li	a0,69
    80002e88:	00006097          	auipc	ra,0x6
    80002e8c:	e64080e7          	jalr	-412(ra) # 80008cec <__putc>
        __putc(':');
    80002e90:	03a00513          	li	a0,58
    80002e94:	00006097          	auipc	ra,0x6
    80002e98:	e58080e7          	jalr	-424(ra) # 80008cec <__putc>
        __asm__ volatile("csrr %0, sepc" : "=r"(value));
    80002e9c:	14102573          	csrr	a0,sepc
        printHex(Riscv::r_sepc());
    80002ea0:	fffff097          	auipc	ra,0xfffff
    80002ea4:	62c080e7          	jalr	1580(ra) # 800024cc <_Z8printHexm>

        __putc('V');
    80002ea8:	05600513          	li	a0,86
    80002eac:	00006097          	auipc	ra,0x6
    80002eb0:	e40080e7          	jalr	-448(ra) # 80008cec <__putc>
        __putc(':');
    80002eb4:	03a00513          	li	a0,58
    80002eb8:	00006097          	auipc	ra,0x6
    80002ebc:	e34080e7          	jalr	-460(ra) # 80008cec <__putc>
        __asm__ volatile("csrr %0, stval" : "=r"(value));
    80002ec0:	14302573          	csrr	a0,stval
        printHex(Riscv::r_stval());
    80002ec4:	fffff097          	auipc	ra,0xfffff
    80002ec8:	608080e7          	jalr	1544(ra) # 800024cc <_Z8printHexm>
    }
}
    80002ecc:	02813083          	ld	ra,40(sp)
    80002ed0:	02013403          	ld	s0,32(sp)
    80002ed4:	01813483          	ld	s1,24(sp)
    80002ed8:	01013903          	ld	s2,16(sp)
    80002edc:	00813983          	ld	s3,8(sp)
    80002ee0:	00013a03          	ld	s4,0(sp)
    80002ee4:	03010113          	addi	sp,sp,48
    80002ee8:	00008067          	ret
        __putc('?');
    80002eec:	03f00513          	li	a0,63
    80002ef0:	00006097          	auipc	ra,0x6
    80002ef4:	dfc080e7          	jalr	-516(ra) # 80008cec <__putc>
        __putc('\n');
    80002ef8:	00a00513          	li	a0,10
    80002efc:	00006097          	auipc	ra,0x6
    80002f00:	df0080e7          	jalr	-528(ra) # 80008cec <__putc>
        __putc('C');
    80002f04:	04300513          	li	a0,67
    80002f08:	00006097          	auipc	ra,0x6
    80002f0c:	de4080e7          	jalr	-540(ra) # 80008cec <__putc>
        __putc(':');
    80002f10:	03a00513          	li	a0,58
    80002f14:	00006097          	auipc	ra,0x6
    80002f18:	dd8080e7          	jalr	-552(ra) # 80008cec <__putc>
        printHex(scause);
    80002f1c:	00090513          	mv	a0,s2
    80002f20:	fffff097          	auipc	ra,0xfffff
    80002f24:	5ac080e7          	jalr	1452(ra) # 800024cc <_Z8printHexm>
        __putc('E');
    80002f28:	04500513          	li	a0,69
    80002f2c:	00006097          	auipc	ra,0x6
    80002f30:	dc0080e7          	jalr	-576(ra) # 80008cec <__putc>
        __putc(':');
    80002f34:	03a00513          	li	a0,58
    80002f38:	00006097          	auipc	ra,0x6
    80002f3c:	db4080e7          	jalr	-588(ra) # 80008cec <__putc>
        __asm__ volatile("csrr %0, sepc" : "=r"(value));
    80002f40:	14102573          	csrr	a0,sepc
        printHex(r_sepc());
    80002f44:	fffff097          	auipc	ra,0xfffff
    80002f48:	588080e7          	jalr	1416(ra) # 800024cc <_Z8printHexm>
        __putc('V');
    80002f4c:	05600513          	li	a0,86
    80002f50:	00006097          	auipc	ra,0x6
    80002f54:	d9c080e7          	jalr	-612(ra) # 80008cec <__putc>
        __putc(':');
    80002f58:	03a00513          	li	a0,58
    80002f5c:	00006097          	auipc	ra,0x6
    80002f60:	d90080e7          	jalr	-624(ra) # 80008cec <__putc>
        __asm__ volatile("csrr %0, stval" : "=r"(value));
    80002f64:	14302573          	csrr	a0,stval
        printHex(r_stval());
    80002f68:	fffff097          	auipc	ra,0xfffff
    80002f6c:	564080e7          	jalr	1380(ra) # 800024cc <_Z8printHexm>
    80002f70:	eadff06f          	j	80002e1c <_ZN5Riscv20handleSupervisorTrapEPm+0x3c>
        registers[32] += 4;
    80002f74:	1004b783          	ld	a5,256(s1)
    80002f78:	00478793          	addi	a5,a5,4
    80002f7c:	10f4b023          	sd	a5,256(s1)
        uint64 syscallCode = registers[10];
    80002f80:	0504b783          	ld	a5,80(s1)
        if (syscallCode == 0x01) {
    80002f84:	06e78863          	beq	a5,a4,80002ff4 <_ZN5Riscv20handleSupervisorTrapEPm+0x214>
        } else if (syscallCode == 0x02) {
    80002f88:	00200713          	li	a4,2
    80002f8c:	08e78063          	beq	a5,a4,8000300c <_ZN5Riscv20handleSupervisorTrapEPm+0x22c>
        } else if (syscallCode == 0x11) {
    80002f90:	01100713          	li	a4,17
    80002f94:	08e78663          	beq	a5,a4,80003020 <_ZN5Riscv20handleSupervisorTrapEPm+0x240>
        } else if (syscallCode == 0x12) {
    80002f98:	01200713          	li	a4,18
    80002f9c:	0ae78463          	beq	a5,a4,80003044 <_ZN5Riscv20handleSupervisorTrapEPm+0x264>
        } else if (syscallCode == 0x13) {
    80002fa0:	01300713          	li	a4,19
    80002fa4:	0ae78863          	beq	a5,a4,80003054 <_ZN5Riscv20handleSupervisorTrapEPm+0x274>
        } else if (syscallCode == 0x21) {
    80002fa8:	02100713          	li	a4,33
    80002fac:	0ae78c63          	beq	a5,a4,80003064 <_ZN5Riscv20handleSupervisorTrapEPm+0x284>
        } else if (syscallCode == 0x22) {
    80002fb0:	02200713          	li	a4,34
    80002fb4:	10e78263          	beq	a5,a4,800030b8 <_ZN5Riscv20handleSupervisorTrapEPm+0x2d8>
        } else if (syscallCode == 0x23) {
    80002fb8:	02300713          	li	a4,35
    80002fbc:	12e78e63          	beq	a5,a4,800030f8 <_ZN5Riscv20handleSupervisorTrapEPm+0x318>
        } else if (syscallCode == 0x24) {
    80002fc0:	02400713          	li	a4,36
    80002fc4:	14e78c63          	beq	a5,a4,8000311c <_ZN5Riscv20handleSupervisorTrapEPm+0x33c>
        } else if (syscallCode == 0x25) {
    80002fc8:	02500713          	li	a4,37
    80002fcc:	16e78a63          	beq	a5,a4,80003140 <_ZN5Riscv20handleSupervisorTrapEPm+0x360>
        } else if (syscallCode == 0x26) {
    80002fd0:	02600713          	li	a4,38
    80002fd4:	18e78a63          	beq	a5,a4,80003168 <_ZN5Riscv20handleSupervisorTrapEPm+0x388>
        } else if (syscallCode == 0x41) {
    80002fd8:	04100713          	li	a4,65
    80002fdc:	1ae78a63          	beq	a5,a4,80003190 <_ZN5Riscv20handleSupervisorTrapEPm+0x3b0>
        } else if (syscallCode == 0x42) {
    80002fe0:	04200713          	li	a4,66
    80002fe4:	1ae78e63          	beq	a5,a4,800031a0 <_ZN5Riscv20handleSupervisorTrapEPm+0x3c0>
        } else if (syscallCode == 0x31) {
    80002fe8:	03100713          	li	a4,49
    80002fec:	1ce78463          	beq	a5,a4,800031b4 <_ZN5Riscv20handleSupervisorTrapEPm+0x3d4>
            while (true) {
    80002ff0:	0000006f          	j	80002ff0 <_ZN5Riscv20handleSupervisorTrapEPm+0x210>
            size_t numOfBlocks = registers[11];
    80002ff4:	0584b503          	ld	a0,88(s1)
            void* result = MemoryAllocator::mem_alloc(
    80002ff8:	00651513          	slli	a0,a0,0x6
    80002ffc:	00000097          	auipc	ra,0x0
    80003000:	3c8080e7          	jalr	968(ra) # 800033c4 <_ZN15MemoryAllocator9mem_allocEm>
            registers[10] = (uint64)result;
    80003004:	04a4b823          	sd	a0,80(s1)
    80003008:	ec5ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
            int result = MemoryAllocator::mem_free(ptr);
    8000300c:	0584b503          	ld	a0,88(s1)
    80003010:	00000097          	auipc	ra,0x0
    80003014:	46c080e7          	jalr	1132(ra) # 8000347c <_ZN15MemoryAllocator8mem_freeEPv>
            registers[10] = (uint64) (result);
    80003018:	04a4b823          	sd	a0,80(s1)
    8000301c:	eb1ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
            int result = TCB::create(
    80003020:	0784b703          	ld	a4,120(s1)
    80003024:	0704b683          	ld	a3,112(s1)
    80003028:	0684b603          	ld	a2,104(s1)
    8000302c:	0604b583          	ld	a1,96(s1)
    80003030:	0584b503          	ld	a0,88(s1)
    80003034:	fffff097          	auipc	ra,0xfffff
    80003038:	6ac080e7          	jalr	1708(ra) # 800026e0 <_ZN3TCB6createEPPS_PFvPvES2_PmS5_>
            registers[10] = (uint64)result;
    8000303c:	04a4b823          	sd	a0,80(s1)
    80003040:	e8dff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
            int result = TCB::exit();
    80003044:	fffff097          	auipc	ra,0xfffff
    80003048:	788080e7          	jalr	1928(ra) # 800027cc <_ZN3TCB4exitEv>
            registers[10] = (uint64) result;
    8000304c:	04a4b823          	sd	a0,80(s1)
    80003050:	e7dff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
            TCB::dispatch();
    80003054:	fffff097          	auipc	ra,0xfffff
    80003058:	6b8080e7          	jalr	1720(ra) # 8000270c <_ZN3TCB8dispatchEv>
            registers[10] = 0;
    8000305c:	0404b823          	sd	zero,80(s1)
    80003060:	e6dff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
            sem_t* handle = (sem_t*)registers[11];
    80003064:	0584b983          	ld	s3,88(s1)
            unsigned init = (unsigned)registers[12];
    80003068:	0604aa03          	lw	s4,96(s1)
            if (!handle) {
    8000306c:	00099863          	bnez	s3,8000307c <_ZN5Riscv20handleSupervisorTrapEPm+0x29c>
                registers[10] = (uint64)-1;
    80003070:	fff00793          	li	a5,-1
    80003074:	04f4b823          	sd	a5,80(s1)
    80003078:	e55ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
                _Semaphore* sem = new _Semaphore(init);
    8000307c:	01800513          	li	a0,24
    80003080:	ffffe097          	auipc	ra,0xffffe
    80003084:	4f0080e7          	jalr	1264(ra) # 80001570 <_Znwm>
    80003088:	00050913          	mv	s2,a0
    8000308c:	000a0593          	mv	a1,s4
    80003090:	fffff097          	auipc	ra,0xfffff
    80003094:	0a4080e7          	jalr	164(ra) # 80002134 <_ZN10_SemaphoreC1Ej>
                if (!sem) {
    80003098:	00090863          	beqz	s2,800030a8 <_ZN5Riscv20handleSupervisorTrapEPm+0x2c8>
                    *handle = sem;
    8000309c:	0129b023          	sd	s2,0(s3)
                    registers[10] = 0;
    800030a0:	0404b823          	sd	zero,80(s1)
    800030a4:	e29ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
                    *handle = nullptr;
    800030a8:	0009b023          	sd	zero,0(s3)
                    registers[10] = (uint64)-1;
    800030ac:	fff00793          	li	a5,-1
    800030b0:	04f4b823          	sd	a5,80(s1)
    800030b4:	e19ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
            _Semaphore* sem = (_Semaphore*)registers[11];
    800030b8:	0584b983          	ld	s3,88(s1)
            if (!sem) {
    800030bc:	00099863          	bnez	s3,800030cc <_ZN5Riscv20handleSupervisorTrapEPm+0x2ec>
                registers[10] = (uint64)-1;
    800030c0:	fff00793          	li	a5,-1
    800030c4:	04f4b823          	sd	a5,80(s1)
    800030c8:	e05ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
                int result = sem->close();
    800030cc:	00098513          	mv	a0,s3
    800030d0:	fffff097          	auipc	ra,0xfffff
    800030d4:	2f0080e7          	jalr	752(ra) # 800023c0 <_ZN10_Semaphore5closeEv>
    800030d8:	00050913          	mv	s2,a0
                if (result == 0) {
    800030dc:	00050663          	beqz	a0,800030e8 <_ZN5Riscv20handleSupervisorTrapEPm+0x308>
                registers[10] = (uint64)result;
    800030e0:	0524b823          	sd	s2,80(s1)
    800030e4:	de9ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
                    delete sem;
    800030e8:	00098513          	mv	a0,s3
    800030ec:	ffffe097          	auipc	ra,0xffffe
    800030f0:	4d4080e7          	jalr	1236(ra) # 800015c0 <_ZdlPv>
    800030f4:	fedff06f          	j	800030e0 <_ZN5Riscv20handleSupervisorTrapEPm+0x300>
            _Semaphore* sem = (_Semaphore*)registers[11];
    800030f8:	0584b503          	ld	a0,88(s1)
            registers[10] = sem ? (uint64) sem->wait() : (uint64)-1;
    800030fc:	00051863          	bnez	a0,8000310c <_ZN5Riscv20handleSupervisorTrapEPm+0x32c>
    80003100:	fff00793          	li	a5,-1
    80003104:	04f4b823          	sd	a5,80(s1)
    80003108:	dc5ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
    8000310c:	fffff097          	auipc	ra,0xfffff
    80003110:	194080e7          	jalr	404(ra) # 800022a0 <_ZN10_Semaphore4waitEv>
    80003114:	00050793          	mv	a5,a0
    80003118:	fedff06f          	j	80003104 <_ZN5Riscv20handleSupervisorTrapEPm+0x324>
            _Semaphore* sem = (_Semaphore*)registers[11];
    8000311c:	0584b503          	ld	a0,88(s1)
            registers[10] = sem ? (uint64) sem->signal() : (uint64)-1;
    80003120:	00051863          	bnez	a0,80003130 <_ZN5Riscv20handleSupervisorTrapEPm+0x350>
    80003124:	fff00793          	li	a5,-1
    80003128:	04f4b823          	sd	a5,80(s1)
    8000312c:	da1ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
    80003130:	fffff097          	auipc	ra,0xfffff
    80003134:	264080e7          	jalr	612(ra) # 80002394 <_ZN10_Semaphore6signalEv>
    80003138:	00050793          	mv	a5,a0
    8000313c:	fedff06f          	j	80003128 <_ZN5Riscv20handleSupervisorTrapEPm+0x348>
            _Semaphore* sem = (_Semaphore*)registers[11];
    80003140:	0584b503          	ld	a0,88(s1)
            unsigned n = (unsigned)registers[12];
    80003144:	0604a583          	lw	a1,96(s1)
                ? (uint64)sem->wait_n(n)
    80003148:	00051863          	bnez	a0,80003158 <_ZN5Riscv20handleSupervisorTrapEPm+0x378>
    8000314c:	fff00793          	li	a5,-1
            registers[10] = sem
    80003150:	04f4b823          	sd	a5,80(s1)
    80003154:	d79ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
                ? (uint64)sem->wait_n(n)
    80003158:	fffff097          	auipc	ra,0xfffff
    8000315c:	050080e7          	jalr	80(ra) # 800021a8 <_ZN10_Semaphore6wait_nEj>
    80003160:	00050793          	mv	a5,a0
    80003164:	fedff06f          	j	80003150 <_ZN5Riscv20handleSupervisorTrapEPm+0x370>
            _Semaphore* sem = (_Semaphore*)registers[11];
    80003168:	0584b503          	ld	a0,88(s1)
            unsigned n = (unsigned)registers[12];
    8000316c:	0604a583          	lw	a1,96(s1)
                ? (uint64)sem->signal_n(n)
    80003170:	00051863          	bnez	a0,80003180 <_ZN5Riscv20handleSupervisorTrapEPm+0x3a0>
    80003174:	fff00793          	li	a5,-1
            registers[10] = sem
    80003178:	04f4b823          	sd	a5,80(s1)
    8000317c:	d51ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
                ? (uint64)sem->signal_n(n)
    80003180:	fffff097          	auipc	ra,0xfffff
    80003184:	14c080e7          	jalr	332(ra) # 800022cc <_ZN10_Semaphore8signal_nEj>
    80003188:	00050793          	mv	a5,a0
    8000318c:	fedff06f          	j	80003178 <_ZN5Riscv20handleSupervisorTrapEPm+0x398>
            char c = _Console::getc();
    80003190:	00000097          	auipc	ra,0x0
    80003194:	b94080e7          	jalr	-1132(ra) # 80002d24 <_ZN8_Console4getcEv>
            registers[10] = (uint64)c;
    80003198:	04a4b823          	sd	a0,80(s1)
    8000319c:	d31ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
            _Console::putc(c);
    800031a0:	0584c503          	lbu	a0,88(s1)
    800031a4:	00000097          	auipc	ra,0x0
    800031a8:	bb0080e7          	jalr	-1104(ra) # 80002d54 <_ZN8_Console4putcEc>
            registers[10] = 0;
    800031ac:	0404b823          	sd	zero,80(s1)
    800031b0:	d1dff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
            registers[10] = TCB::sleep(time);
    800031b4:	0584b503          	ld	a0,88(s1)
    800031b8:	fffff097          	auipc	ra,0xfffff
    800031bc:	77c080e7          	jalr	1916(ra) # 80002934 <_ZN3TCB5sleepEm>
    800031c0:	04a4b823          	sd	a0,80(s1)
    800031c4:	d09ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
        int interruptId = plic_claim();
    800031c8:	00004097          	auipc	ra,0x4
    800031cc:	2bc080e7          	jalr	700(ra) # 80007484 <plic_claim>
    800031d0:	00050493          	mv	s1,a0
        if (interruptId == CONSOLE_IRQ) {
    800031d4:	00a00793          	li	a5,10
    800031d8:	00f50c63          	beq	a0,a5,800031f0 <_ZN5Riscv20handleSupervisorTrapEPm+0x410>
        if (interruptId != 0) {
    800031dc:	ce0488e3          	beqz	s1,80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
            plic_complete(interruptId);
    800031e0:	00048513          	mv	a0,s1
    800031e4:	00004097          	auipc	ra,0x4
    800031e8:	2d8080e7          	jalr	728(ra) # 800074bc <plic_complete>
        return;
    800031ec:	ce1ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
            _Console::handleInterrupt();
    800031f0:	00000097          	auipc	ra,0x0
    800031f4:	b98080e7          	jalr	-1128(ra) # 80002d88 <_ZN8_Console15handleInterruptEv>
    800031f8:	fe5ff06f          	j	800031dc <_ZN5Riscv20handleSupervisorTrapEPm+0x3fc>
        __asm__ volatile("csrc sstatus, %0" : : "r"(mask));
    }

    static void mc_sip(uint64 mask)
    {
        __asm__ volatile("csrc sip, %0" : : "r"(mask));
    800031fc:	00200793          	li	a5,2
    80003200:	1447b073          	csrc	sip,a5
        SleepingThreads::tick();
    80003204:	fffff097          	auipc	ra,0xfffff
    80003208:	a28080e7          	jalr	-1496(ra) # 80001c2c <_ZN15SleepingThreads4tickEv>
        timeSliceCounter++;
    8000320c:	00009717          	auipc	a4,0x9
    80003210:	8b473703          	ld	a4,-1868(a4) # 8000bac0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003214:	00073783          	ld	a5,0(a4)
    80003218:	00178793          	addi	a5,a5,1
    8000321c:	00f73023          	sd	a5,0(a4)
        if (TCB::getTimeSliceCounter() >= DEFAULT_TIME_SLICE) {
    80003220:	00100713          	li	a4,1
    80003224:	caf774e3          	bgeu	a4,a5,80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
        __asm__ volatile("csrr %0, sepc" : "=r"(value));
    80003228:	141024f3          	csrr	s1,sepc
        __asm__ volatile("csrr %0, sstatus" : "=r"(value));
    8000322c:	10002973          	csrr	s2,sstatus
        timeSliceCounter = 0;
    80003230:	00009797          	auipc	a5,0x9
    80003234:	8907b783          	ld	a5,-1904(a5) # 8000bac0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003238:	0007b023          	sd	zero,0(a5)
            TCB::dispatch();
    8000323c:	fffff097          	auipc	ra,0xfffff
    80003240:	4d0080e7          	jalr	1232(ra) # 8000270c <_ZN3TCB8dispatchEv>
        __asm__ volatile("csrw sstatus, %0" : : "r"(value));
    80003244:	10091073          	csrw	sstatus,s2
        __asm__ volatile("csrw sepc, %0" : : "r"(value));
    80003248:	14149073          	csrw	sepc,s1
        return;
    8000324c:	c81ff06f          	j	80002ecc <_ZN5Riscv20handleSupervisorTrapEPm+0xec>
    80003250:	00050493          	mv	s1,a0
                _Semaphore* sem = new _Semaphore(init);
    80003254:	00090513          	mv	a0,s2
    80003258:	ffffe097          	auipc	ra,0xffffe
    8000325c:	368080e7          	jalr	872(ra) # 800015c0 <_ZdlPv>
    80003260:	00048513          	mv	a0,s1
    80003264:	0000a097          	auipc	ra,0xa
    80003268:	ab4080e7          	jalr	-1356(ra) # 8000cd18 <_Unwind_Resume>

000000008000326c <_ZN5Riscv17interruptsEnabledEv>:

int Riscv::interruptLockDepth = 0;
bool Riscv::interruptsWereEnabled = false;

bool Riscv::interruptsEnabled() {
    8000326c:	ff010113          	addi	sp,sp,-16
    80003270:	00813423          	sd	s0,8(sp)
    80003274:	01010413          	addi	s0,sp,16
        __asm__ volatile("csrr %0, sstatus" : "=r"(value));
    80003278:	10002573          	csrr	a0,sstatus
    return r_sstatus() & SSTATUS_SIE;
    8000327c:	00257513          	andi	a0,a0,2
}
    80003280:	00a03533          	snez	a0,a0
    80003284:	00813403          	ld	s0,8(sp)
    80003288:	01010113          	addi	sp,sp,16
    8000328c:	00008067          	ret

0000000080003290 <_ZN5Riscv7pushOffEv>:

void Riscv::pushOff() {
    80003290:	ff010113          	addi	sp,sp,-16
    80003294:	00113423          	sd	ra,8(sp)
    80003298:	00813023          	sd	s0,0(sp)
    8000329c:	01010413          	addi	s0,sp,16
    bool enabled = interruptsEnabled();
    800032a0:	00000097          	auipc	ra,0x0
    800032a4:	fcc080e7          	jalr	-52(ra) # 8000326c <_ZN5Riscv17interruptsEnabledEv>
    800032a8:	100027f3          	csrr	a5,sstatus

    uint64 sstatus = r_sstatus();
    w_sstatus(sstatus & ~SSTATUS_SIE);
    800032ac:	ffd7f793          	andi	a5,a5,-3
        __asm__ volatile("csrw sstatus, %0" : : "r"(value));
    800032b0:	10079073          	csrw	sstatus,a5

    if (interruptLockDepth == 0) interruptsWereEnabled = enabled;
    800032b4:	00009797          	auipc	a5,0x9
    800032b8:	9047a783          	lw	a5,-1788(a5) # 8000bbb8 <_ZN5Riscv18interruptLockDepthE>
    800032bc:	00079663          	bnez	a5,800032c8 <_ZN5Riscv7pushOffEv+0x38>
    800032c0:	00009717          	auipc	a4,0x9
    800032c4:	8ea70e23          	sb	a0,-1796(a4) # 8000bbbc <_ZN5Riscv21interruptsWereEnabledE>
    interruptLockDepth++;
    800032c8:	0017879b          	addiw	a5,a5,1
    800032cc:	00009717          	auipc	a4,0x9
    800032d0:	8ef72623          	sw	a5,-1812(a4) # 8000bbb8 <_ZN5Riscv18interruptLockDepthE>
}
    800032d4:	00813083          	ld	ra,8(sp)
    800032d8:	00013403          	ld	s0,0(sp)
    800032dc:	01010113          	addi	sp,sp,16
    800032e0:	00008067          	ret

00000000800032e4 <_ZN5Riscv6popOffEv>:

void Riscv::popOff() {
    800032e4:	ff010113          	addi	sp,sp,-16
    800032e8:	00113423          	sd	ra,8(sp)
    800032ec:	00813023          	sd	s0,0(sp)
    800032f0:	01010413          	addi	s0,sp,16
    if (interruptsEnabled()) {
    800032f4:	00000097          	auipc	ra,0x0
    800032f8:	f78080e7          	jalr	-136(ra) # 8000326c <_ZN5Riscv17interruptsEnabledEv>
    800032fc:	02051e63          	bnez	a0,80003338 <_ZN5Riscv6popOffEv+0x54>
        // Greska prekidi ne bi smeli da budu ukljuceni
        return;
    }
    if (interruptLockDepth <= 0) {
    80003300:	00009797          	auipc	a5,0x9
    80003304:	8b87a783          	lw	a5,-1864(a5) # 8000bbb8 <_ZN5Riscv18interruptLockDepthE>
    80003308:	02f05863          	blez	a5,80003338 <_ZN5Riscv6popOffEv+0x54>
        //Greska unlock bez odgovarajuceg locka
        return;
    }

    interruptLockDepth--;
    8000330c:	fff7879b          	addiw	a5,a5,-1
    80003310:	0007871b          	sext.w	a4,a5
    80003314:	00009697          	auipc	a3,0x9
    80003318:	8af6a223          	sw	a5,-1884(a3) # 8000bbb8 <_ZN5Riscv18interruptLockDepthE>
    if (interruptLockDepth == 0 && interruptsWereEnabled) {
    8000331c:	00071e63          	bnez	a4,80003338 <_ZN5Riscv6popOffEv+0x54>
    80003320:	00009797          	auipc	a5,0x9
    80003324:	89c7c783          	lbu	a5,-1892(a5) # 8000bbbc <_ZN5Riscv21interruptsWereEnabledE>
    80003328:	00078863          	beqz	a5,80003338 <_ZN5Riscv6popOffEv+0x54>
        __asm__ volatile("csrr %0, sstatus" : "=r"(value));
    8000332c:	100027f3          	csrr	a5,sstatus
        uint64 sstatus = r_sstatus();
        w_sstatus(sstatus | SSTATUS_SIE);
    80003330:	0027e793          	ori	a5,a5,2
        __asm__ volatile("csrw sstatus, %0" : : "r"(value));
    80003334:	10079073          	csrw	sstatus,a5
    }
}
    80003338:	00813083          	ld	ra,8(sp)
    8000333c:	00013403          	ld	s0,0(sp)
    80003340:	01010113          	addi	sp,sp,16
    80003344:	00008067          	ret

0000000080003348 <handleSupervisorTrapC>:

extern "C" void handleSupervisorTrapC(uint64* registers)
{
    80003348:	ff010113          	addi	sp,sp,-16
    8000334c:	00113423          	sd	ra,8(sp)
    80003350:	00813023          	sd	s0,0(sp)
    80003354:	01010413          	addi	s0,sp,16
    Riscv::handleSupervisorTrap(registers);
    80003358:	00000097          	auipc	ra,0x0
    8000335c:	a88080e7          	jalr	-1400(ra) # 80002de0 <_ZN5Riscv20handleSupervisorTrapEPm>
    80003360:	00813083          	ld	ra,8(sp)
    80003364:	00013403          	ld	s0,0(sp)
    80003368:	01010113          	addi	sp,sp,16
    8000336c:	00008067          	ret

0000000080003370 <_ZN15MemoryAllocator10initializeEv>:

// radimo sa zaglavljem jer moramo da znamo koliko nam je segment veliki

MemoryAllocator::FreeMem* MemoryAllocator::freeMemHead = nullptr;

void MemoryAllocator::initialize() {
    80003370:	ff010113          	addi	sp,sp,-16
    80003374:	00813423          	sd	s0,8(sp)
    80003378:	01010413          	addi	s0,sp,16
    freeMemHead = (FreeMem*) HEAP_START_ADDR;
    8000337c:	00008697          	auipc	a3,0x8
    80003380:	73c6b683          	ld	a3,1852(a3) # 8000bab8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80003384:	0006b783          	ld	a5,0(a3)
    80003388:	00009717          	auipc	a4,0x9
    8000338c:	86870713          	addi	a4,a4,-1944 # 8000bbf0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003390:	00f73023          	sd	a5,0(a4)
    freeMemHead->next = nullptr;
    80003394:	0007b023          	sd	zero,0(a5)
    freeMemHead->size = ((char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR)/MEM_BLOCK_SIZE;
    80003398:	00008797          	auipc	a5,0x8
    8000339c:	7507b783          	ld	a5,1872(a5) # 8000bae8 <_GLOBAL_OFFSET_TABLE_+0x48>
    800033a0:	0007b783          	ld	a5,0(a5)
    800033a4:	0006b683          	ld	a3,0(a3)
    800033a8:	40d787b3          	sub	a5,a5,a3
    800033ac:	00073703          	ld	a4,0(a4)
    800033b0:	0067d793          	srli	a5,a5,0x6
    800033b4:	00f73423          	sd	a5,8(a4)
    // prva zagrada je broj bajtova u heap-u, deljenjem sa velicinom dobija se broj blokova
}
    800033b8:	00813403          	ld	s0,8(sp)
    800033bc:	01010113          	addi	sp,sp,16
    800033c0:	00008067          	ret

00000000800033c4 <_ZN15MemoryAllocator9mem_allocEm>:

void* MemoryAllocator::mem_alloc(size_t size) {
    800033c4:	ff010113          	addi	sp,sp,-16
    800033c8:	00813423          	sd	s0,8(sp)
    800033cc:	01010413          	addi	s0,sp,16
    if (size == 0 || freeMemHead == nullptr) {
    800033d0:	0a050263          	beqz	a0,80003474 <_ZN15MemoryAllocator9mem_allocEm+0xb0>
    800033d4:	00050793          	mv	a5,a0
    800033d8:	00009517          	auipc	a0,0x9
    800033dc:	81853503          	ld	a0,-2024(a0) # 8000bbf0 <_ZN15MemoryAllocator11freeMemHeadE>
    800033e0:	04050863          	beqz	a0,80003430 <_ZN15MemoryAllocator9mem_allocEm+0x6c>
        return nullptr;
    }

    const size_t blocks = (size + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE;
    800033e4:	03f78793          	addi	a5,a5,63
    800033e8:	0067d793          	srli	a5,a5,0x6
    const size_t requiredBlocks = blocks + 1;
    800033ec:	00178793          	addi	a5,a5,1
    FreeMem* prev = nullptr;
    800033f0:	00000613          	li	a2,0

    for (FreeMem* curr = freeMemHead; curr != nullptr; prev = curr, curr = curr->next) {
    800033f4:	02050e63          	beqz	a0,80003430 <_ZN15MemoryAllocator9mem_allocEm+0x6c>
        if (curr->size < requiredBlocks) continue;
    800033f8:	00853703          	ld	a4,8(a0)
    800033fc:	04f76063          	bltu	a4,a5,8000343c <_ZN15MemoryAllocator9mem_allocEm+0x78>
        FreeMem* allocated = curr;
        if (curr->size == requiredBlocks) {
    80003400:	04f70463          	beq	a4,a5,80003448 <_ZN15MemoryAllocator9mem_allocEm+0x84>
            } else {
                freeMemHead = curr->next;
            }
        } else {
            FreeMem* newFragment = (FreeMem*)(
                        (char*)(curr) + requiredBlocks * MEM_BLOCK_SIZE
    80003404:	00679693          	slli	a3,a5,0x6
            FreeMem* newFragment = (FreeMem*)(
    80003408:	00d506b3          	add	a3,a0,a3
                    );

            newFragment->size = curr->size - requiredBlocks;
    8000340c:	40f70733          	sub	a4,a4,a5
    80003410:	00e6b423          	sd	a4,8(a3)
            newFragment->next = curr->next;
    80003414:	00053703          	ld	a4,0(a0)
    80003418:	00e6b023          	sd	a4,0(a3)

            if (prev) {
    8000341c:	04060663          	beqz	a2,80003468 <_ZN15MemoryAllocator9mem_allocEm+0xa4>
                prev->next = newFragment;
    80003420:	00d63023          	sd	a3,0(a2)
            } else {
                freeMemHead = newFragment;
            }
        }
        allocated->size = requiredBlocks;
    80003424:	00f53423          	sd	a5,8(a0)
        allocated->next = nullptr;
    80003428:	00053023          	sd	zero,0(a0)

        return (char*) (allocated) + MEM_BLOCK_SIZE;
    8000342c:	04050513          	addi	a0,a0,64
    }
    return nullptr;
}
    80003430:	00813403          	ld	s0,8(sp)
    80003434:	01010113          	addi	sp,sp,16
    80003438:	00008067          	ret
    for (FreeMem* curr = freeMemHead; curr != nullptr; prev = curr, curr = curr->next) {
    8000343c:	00050613          	mv	a2,a0
    80003440:	00053503          	ld	a0,0(a0)
    80003444:	fb1ff06f          	j	800033f4 <_ZN15MemoryAllocator9mem_allocEm+0x30>
            if (prev != nullptr) {
    80003448:	00060863          	beqz	a2,80003458 <_ZN15MemoryAllocator9mem_allocEm+0x94>
                prev->next = curr->next;
    8000344c:	00053703          	ld	a4,0(a0)
    80003450:	00e63023          	sd	a4,0(a2)
    80003454:	fd1ff06f          	j	80003424 <_ZN15MemoryAllocator9mem_allocEm+0x60>
                freeMemHead = curr->next;
    80003458:	00053703          	ld	a4,0(a0)
    8000345c:	00008697          	auipc	a3,0x8
    80003460:	78e6ba23          	sd	a4,1940(a3) # 8000bbf0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003464:	fc1ff06f          	j	80003424 <_ZN15MemoryAllocator9mem_allocEm+0x60>
                freeMemHead = newFragment;
    80003468:	00008717          	auipc	a4,0x8
    8000346c:	78d73423          	sd	a3,1928(a4) # 8000bbf0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003470:	fb5ff06f          	j	80003424 <_ZN15MemoryAllocator9mem_allocEm+0x60>
        return nullptr;
    80003474:	00000513          	li	a0,0
    80003478:	fb9ff06f          	j	80003430 <_ZN15MemoryAllocator9mem_allocEm+0x6c>

000000008000347c <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void *addr) {
    8000347c:	ff010113          	addi	sp,sp,-16
    80003480:	00813423          	sd	s0,8(sp)
    80003484:	01010413          	addi	s0,sp,16
    if (addr == nullptr) return -1;
    80003488:	0a050863          	beqz	a0,80003538 <_ZN15MemoryAllocator8mem_freeEPv+0xbc>
    // Zbog zaglavlja ovako dobijamo tacno jedan blok koji nam treba
    FreeMem* block = (FreeMem*) ((char*)addr - MEM_BLOCK_SIZE);
    8000348c:	fc050693          	addi	a3,a0,-64

    FreeMem* prev = nullptr;
    FreeMem* curr = freeMemHead;
    80003490:	00008797          	auipc	a5,0x8
    80003494:	7607b783          	ld	a5,1888(a5) # 8000bbf0 <_ZN15MemoryAllocator11freeMemHeadE>
    FreeMem* prev = nullptr;
    80003498:	00000713          	li	a4,0
    while (curr != nullptr && (char*) curr < (char*) block) {
    8000349c:	00078a63          	beqz	a5,800034b0 <_ZN15MemoryAllocator8mem_freeEPv+0x34>
    800034a0:	00d7f863          	bgeu	a5,a3,800034b0 <_ZN15MemoryAllocator8mem_freeEPv+0x34>
        prev = curr;
    800034a4:	00078713          	mv	a4,a5
        curr = curr->next;
    800034a8:	0007b783          	ld	a5,0(a5)
    while (curr != nullptr && (char*) curr < (char*) block) {
    800034ac:	ff1ff06f          	j	8000349c <_ZN15MemoryAllocator8mem_freeEPv+0x20>
    }

    block->next = curr;
    800034b0:	fcf53023          	sd	a5,-64(a0)
    if (prev) prev->next = block;
    800034b4:	04070263          	beqz	a4,800034f8 <_ZN15MemoryAllocator8mem_freeEPv+0x7c>
    800034b8:	00d73023          	sd	a3,0(a4)
    else freeMemHead = block;

    //Spajanje bloka sa sledecim slobodnim segmentom
    if (block->next && (char*)block + block->size * MEM_BLOCK_SIZE
    800034bc:	fc053783          	ld	a5,-64(a0)
    800034c0:	00078a63          	beqz	a5,800034d4 <_ZN15MemoryAllocator8mem_freeEPv+0x58>
    800034c4:	fc853583          	ld	a1,-56(a0)
    800034c8:	00659613          	slli	a2,a1,0x6
    800034cc:	00c68633          	add	a2,a3,a2
    800034d0:	02c78a63          	beq	a5,a2,80003504 <_ZN15MemoryAllocator8mem_freeEPv+0x88>
        block->size += block->next->size;
        block->next = block->next->next;
    }

    //Spajanje sa prethodnim
    if (prev && (char*)prev + prev->size * MEM_BLOCK_SIZE == (char*)block) {
    800034d4:	06070663          	beqz	a4,80003540 <_ZN15MemoryAllocator8mem_freeEPv+0xc4>
    800034d8:	00873603          	ld	a2,8(a4)
    800034dc:	00661793          	slli	a5,a2,0x6
    800034e0:	00f707b3          	add	a5,a4,a5
    800034e4:	02d78c63          	beq	a5,a3,8000351c <_ZN15MemoryAllocator8mem_freeEPv+0xa0>
        prev->size += block->size;
        prev->next = block->next;
    }

    return 0;
    800034e8:	00000513          	li	a0,0

    800034ec:	00813403          	ld	s0,8(sp)
    800034f0:	01010113          	addi	sp,sp,16
    800034f4:	00008067          	ret
    else freeMemHead = block;
    800034f8:	00008797          	auipc	a5,0x8
    800034fc:	6ed7bc23          	sd	a3,1784(a5) # 8000bbf0 <_ZN15MemoryAllocator11freeMemHeadE>
    80003500:	fbdff06f          	j	800034bc <_ZN15MemoryAllocator8mem_freeEPv+0x40>
        block->size += block->next->size;
    80003504:	0087b603          	ld	a2,8(a5)
    80003508:	00c585b3          	add	a1,a1,a2
    8000350c:	fcb53423          	sd	a1,-56(a0)
        block->next = block->next->next;
    80003510:	0007b783          	ld	a5,0(a5)
    80003514:	fcf53023          	sd	a5,-64(a0)
    80003518:	fbdff06f          	j	800034d4 <_ZN15MemoryAllocator8mem_freeEPv+0x58>
        prev->size += block->size;
    8000351c:	fc853783          	ld	a5,-56(a0)
    80003520:	00f60633          	add	a2,a2,a5
    80003524:	00c73423          	sd	a2,8(a4)
        prev->next = block->next;
    80003528:	fc053783          	ld	a5,-64(a0)
    8000352c:	00f73023          	sd	a5,0(a4)
    return 0;
    80003530:	00000513          	li	a0,0
    80003534:	fb9ff06f          	j	800034ec <_ZN15MemoryAllocator8mem_freeEPv+0x70>
    if (addr == nullptr) return -1;
    80003538:	fff00513          	li	a0,-1
    8000353c:	fb1ff06f          	j	800034ec <_ZN15MemoryAllocator8mem_freeEPv+0x70>
    return 0;
    80003540:	00000513          	li	a0,0
    80003544:	fa9ff06f          	j	800034ec <_ZN15MemoryAllocator8mem_freeEPv+0x70>

0000000080003548 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    80003548:	fe010113          	addi	sp,sp,-32
    8000354c:	00113c23          	sd	ra,24(sp)
    80003550:	00813823          	sd	s0,16(sp)
    80003554:	00913423          	sd	s1,8(sp)
    80003558:	01213023          	sd	s2,0(sp)
    8000355c:	02010413          	addi	s0,sp,32
    80003560:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80003564:	00000913          	li	s2,0
    80003568:	00c0006f          	j	80003574 <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    8000356c:	ffffe097          	auipc	ra,0xffffe
    80003570:	e54080e7          	jalr	-428(ra) # 800013c0 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    80003574:	ffffe097          	auipc	ra,0xffffe
    80003578:	f8c080e7          	jalr	-116(ra) # 80001500 <_Z4getcv>
    8000357c:	0005059b          	sext.w	a1,a0
    80003580:	01b00793          	li	a5,27
    80003584:	02f58a63          	beq	a1,a5,800035b8 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    80003588:	0084b503          	ld	a0,8(s1)
    8000358c:	00003097          	auipc	ra,0x3
    80003590:	418080e7          	jalr	1048(ra) # 800069a4 <_ZN6Buffer3putEi>
        i++;
    80003594:	0019071b          	addiw	a4,s2,1
    80003598:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    8000359c:	0004a683          	lw	a3,0(s1)
    800035a0:	0026979b          	slliw	a5,a3,0x2
    800035a4:	00d787bb          	addw	a5,a5,a3
    800035a8:	0017979b          	slliw	a5,a5,0x1
    800035ac:	02f767bb          	remw	a5,a4,a5
    800035b0:	fc0792e3          	bnez	a5,80003574 <_ZL16producerKeyboardPv+0x2c>
    800035b4:	fb9ff06f          	j	8000356c <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    800035b8:	00100793          	li	a5,1
    800035bc:	00008717          	auipc	a4,0x8
    800035c0:	62f72e23          	sw	a5,1596(a4) # 8000bbf8 <_ZL9threadEnd>
    data->buffer->put('!');
    800035c4:	02100593          	li	a1,33
    800035c8:	0084b503          	ld	a0,8(s1)
    800035cc:	00003097          	auipc	ra,0x3
    800035d0:	3d8080e7          	jalr	984(ra) # 800069a4 <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    800035d4:	0104b503          	ld	a0,16(s1)
    800035d8:	ffffe097          	auipc	ra,0xffffe
    800035dc:	e90080e7          	jalr	-368(ra) # 80001468 <_Z10sem_signalP10_Semaphore>
}
    800035e0:	01813083          	ld	ra,24(sp)
    800035e4:	01013403          	ld	s0,16(sp)
    800035e8:	00813483          	ld	s1,8(sp)
    800035ec:	00013903          	ld	s2,0(sp)
    800035f0:	02010113          	addi	sp,sp,32
    800035f4:	00008067          	ret

00000000800035f8 <_ZL8producerPv>:

static void producer(void *arg) {
    800035f8:	fe010113          	addi	sp,sp,-32
    800035fc:	00113c23          	sd	ra,24(sp)
    80003600:	00813823          	sd	s0,16(sp)
    80003604:	00913423          	sd	s1,8(sp)
    80003608:	01213023          	sd	s2,0(sp)
    8000360c:	02010413          	addi	s0,sp,32
    80003610:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003614:	00000913          	li	s2,0
    80003618:	00c0006f          	j	80003624 <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    8000361c:	ffffe097          	auipc	ra,0xffffe
    80003620:	da4080e7          	jalr	-604(ra) # 800013c0 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80003624:	00008797          	auipc	a5,0x8
    80003628:	5d47a783          	lw	a5,1492(a5) # 8000bbf8 <_ZL9threadEnd>
    8000362c:	02079e63          	bnez	a5,80003668 <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    80003630:	0004a583          	lw	a1,0(s1)
    80003634:	0305859b          	addiw	a1,a1,48
    80003638:	0084b503          	ld	a0,8(s1)
    8000363c:	00003097          	auipc	ra,0x3
    80003640:	368080e7          	jalr	872(ra) # 800069a4 <_ZN6Buffer3putEi>
        i++;
    80003644:	0019071b          	addiw	a4,s2,1
    80003648:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    8000364c:	0004a683          	lw	a3,0(s1)
    80003650:	0026979b          	slliw	a5,a3,0x2
    80003654:	00d787bb          	addw	a5,a5,a3
    80003658:	0017979b          	slliw	a5,a5,0x1
    8000365c:	02f767bb          	remw	a5,a4,a5
    80003660:	fc0792e3          	bnez	a5,80003624 <_ZL8producerPv+0x2c>
    80003664:	fb9ff06f          	j	8000361c <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    80003668:	0104b503          	ld	a0,16(s1)
    8000366c:	ffffe097          	auipc	ra,0xffffe
    80003670:	dfc080e7          	jalr	-516(ra) # 80001468 <_Z10sem_signalP10_Semaphore>
}
    80003674:	01813083          	ld	ra,24(sp)
    80003678:	01013403          	ld	s0,16(sp)
    8000367c:	00813483          	ld	s1,8(sp)
    80003680:	00013903          	ld	s2,0(sp)
    80003684:	02010113          	addi	sp,sp,32
    80003688:	00008067          	ret

000000008000368c <_ZL8consumerPv>:

static void consumer(void *arg) {
    8000368c:	fd010113          	addi	sp,sp,-48
    80003690:	02113423          	sd	ra,40(sp)
    80003694:	02813023          	sd	s0,32(sp)
    80003698:	00913c23          	sd	s1,24(sp)
    8000369c:	01213823          	sd	s2,16(sp)
    800036a0:	01313423          	sd	s3,8(sp)
    800036a4:	03010413          	addi	s0,sp,48
    800036a8:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800036ac:	00000993          	li	s3,0
    800036b0:	01c0006f          	j	800036cc <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    800036b4:	ffffe097          	auipc	ra,0xffffe
    800036b8:	d0c080e7          	jalr	-756(ra) # 800013c0 <_Z15thread_dispatchv>
    800036bc:	0500006f          	j	8000370c <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    800036c0:	00a00513          	li	a0,10
    800036c4:	ffffe097          	auipc	ra,0xffffe
    800036c8:	e60080e7          	jalr	-416(ra) # 80001524 <_Z4putcc>
    while (!threadEnd) {
    800036cc:	00008797          	auipc	a5,0x8
    800036d0:	52c7a783          	lw	a5,1324(a5) # 8000bbf8 <_ZL9threadEnd>
    800036d4:	06079063          	bnez	a5,80003734 <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    800036d8:	00893503          	ld	a0,8(s2)
    800036dc:	00003097          	auipc	ra,0x3
    800036e0:	358080e7          	jalr	856(ra) # 80006a34 <_ZN6Buffer3getEv>
        i++;
    800036e4:	0019849b          	addiw	s1,s3,1
    800036e8:	0004899b          	sext.w	s3,s1
        putc(key);
    800036ec:	0ff57513          	andi	a0,a0,255
    800036f0:	ffffe097          	auipc	ra,0xffffe
    800036f4:	e34080e7          	jalr	-460(ra) # 80001524 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800036f8:	00092703          	lw	a4,0(s2)
    800036fc:	0027179b          	slliw	a5,a4,0x2
    80003700:	00e787bb          	addw	a5,a5,a4
    80003704:	02f4e7bb          	remw	a5,s1,a5
    80003708:	fa0786e3          	beqz	a5,800036b4 <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    8000370c:	05000793          	li	a5,80
    80003710:	02f4e4bb          	remw	s1,s1,a5
    80003714:	fa049ce3          	bnez	s1,800036cc <_ZL8consumerPv+0x40>
    80003718:	fa9ff06f          	j	800036c0 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    8000371c:	00893503          	ld	a0,8(s2)
    80003720:	00003097          	auipc	ra,0x3
    80003724:	314080e7          	jalr	788(ra) # 80006a34 <_ZN6Buffer3getEv>
        putc(key);
    80003728:	0ff57513          	andi	a0,a0,255
    8000372c:	ffffe097          	auipc	ra,0xffffe
    80003730:	df8080e7          	jalr	-520(ra) # 80001524 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    80003734:	00893503          	ld	a0,8(s2)
    80003738:	00003097          	auipc	ra,0x3
    8000373c:	388080e7          	jalr	904(ra) # 80006ac0 <_ZN6Buffer6getCntEv>
    80003740:	fca04ee3          	bgtz	a0,8000371c <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    80003744:	01093503          	ld	a0,16(s2)
    80003748:	ffffe097          	auipc	ra,0xffffe
    8000374c:	d20080e7          	jalr	-736(ra) # 80001468 <_Z10sem_signalP10_Semaphore>
}
    80003750:	02813083          	ld	ra,40(sp)
    80003754:	02013403          	ld	s0,32(sp)
    80003758:	01813483          	ld	s1,24(sp)
    8000375c:	01013903          	ld	s2,16(sp)
    80003760:	00813983          	ld	s3,8(sp)
    80003764:	03010113          	addi	sp,sp,48
    80003768:	00008067          	ret

000000008000376c <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    8000376c:	f9010113          	addi	sp,sp,-112
    80003770:	06113423          	sd	ra,104(sp)
    80003774:	06813023          	sd	s0,96(sp)
    80003778:	04913c23          	sd	s1,88(sp)
    8000377c:	05213823          	sd	s2,80(sp)
    80003780:	05313423          	sd	s3,72(sp)
    80003784:	05413023          	sd	s4,64(sp)
    80003788:	03513c23          	sd	s5,56(sp)
    8000378c:	03613823          	sd	s6,48(sp)
    80003790:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    80003794:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    80003798:	00006517          	auipc	a0,0x6
    8000379c:	88850513          	addi	a0,a0,-1912 # 80009020 <CONSOLE_STATUS+0x10>
    800037a0:	00002097          	auipc	ra,0x2
    800037a4:	220080e7          	jalr	544(ra) # 800059c0 <_Z11printStringPKc>
    getString(input, 30);
    800037a8:	01e00593          	li	a1,30
    800037ac:	fa040493          	addi	s1,s0,-96
    800037b0:	00048513          	mv	a0,s1
    800037b4:	00002097          	auipc	ra,0x2
    800037b8:	294080e7          	jalr	660(ra) # 80005a48 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800037bc:	00048513          	mv	a0,s1
    800037c0:	00002097          	auipc	ra,0x2
    800037c4:	360080e7          	jalr	864(ra) # 80005b20 <_Z11stringToIntPKc>
    800037c8:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800037cc:	00006517          	auipc	a0,0x6
    800037d0:	87450513          	addi	a0,a0,-1932 # 80009040 <CONSOLE_STATUS+0x30>
    800037d4:	00002097          	auipc	ra,0x2
    800037d8:	1ec080e7          	jalr	492(ra) # 800059c0 <_Z11printStringPKc>
    getString(input, 30);
    800037dc:	01e00593          	li	a1,30
    800037e0:	00048513          	mv	a0,s1
    800037e4:	00002097          	auipc	ra,0x2
    800037e8:	264080e7          	jalr	612(ra) # 80005a48 <_Z9getStringPci>
    n = stringToInt(input);
    800037ec:	00048513          	mv	a0,s1
    800037f0:	00002097          	auipc	ra,0x2
    800037f4:	330080e7          	jalr	816(ra) # 80005b20 <_Z11stringToIntPKc>
    800037f8:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    800037fc:	00006517          	auipc	a0,0x6
    80003800:	86450513          	addi	a0,a0,-1948 # 80009060 <CONSOLE_STATUS+0x50>
    80003804:	00002097          	auipc	ra,0x2
    80003808:	1bc080e7          	jalr	444(ra) # 800059c0 <_Z11printStringPKc>
    8000380c:	00000613          	li	a2,0
    80003810:	00a00593          	li	a1,10
    80003814:	00090513          	mv	a0,s2
    80003818:	00002097          	auipc	ra,0x2
    8000381c:	358080e7          	jalr	856(ra) # 80005b70 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    80003820:	00006517          	auipc	a0,0x6
    80003824:	85850513          	addi	a0,a0,-1960 # 80009078 <CONSOLE_STATUS+0x68>
    80003828:	00002097          	auipc	ra,0x2
    8000382c:	198080e7          	jalr	408(ra) # 800059c0 <_Z11printStringPKc>
    80003830:	00000613          	li	a2,0
    80003834:	00a00593          	li	a1,10
    80003838:	00048513          	mv	a0,s1
    8000383c:	00002097          	auipc	ra,0x2
    80003840:	334080e7          	jalr	820(ra) # 80005b70 <_Z8printIntiii>
    printString(".\n");
    80003844:	00006517          	auipc	a0,0x6
    80003848:	84c50513          	addi	a0,a0,-1972 # 80009090 <CONSOLE_STATUS+0x80>
    8000384c:	00002097          	auipc	ra,0x2
    80003850:	174080e7          	jalr	372(ra) # 800059c0 <_Z11printStringPKc>
    if(threadNum > n) {
    80003854:	0324c463          	blt	s1,s2,8000387c <_Z22producerConsumer_C_APIv+0x110>
    } else if (threadNum < 1) {
    80003858:	03205c63          	blez	s2,80003890 <_Z22producerConsumer_C_APIv+0x124>
    Buffer *buffer = new Buffer(n);
    8000385c:	03800513          	li	a0,56
    80003860:	ffffe097          	auipc	ra,0xffffe
    80003864:	d10080e7          	jalr	-752(ra) # 80001570 <_Znwm>
    80003868:	00050a13          	mv	s4,a0
    8000386c:	00048593          	mv	a1,s1
    80003870:	00003097          	auipc	ra,0x3
    80003874:	098080e7          	jalr	152(ra) # 80006908 <_ZN6BufferC1Ei>
    80003878:	0300006f          	j	800038a8 <_Z22producerConsumer_C_APIv+0x13c>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    8000387c:	00006517          	auipc	a0,0x6
    80003880:	81c50513          	addi	a0,a0,-2020 # 80009098 <CONSOLE_STATUS+0x88>
    80003884:	00002097          	auipc	ra,0x2
    80003888:	13c080e7          	jalr	316(ra) # 800059c0 <_Z11printStringPKc>
        return;
    8000388c:	0140006f          	j	800038a0 <_Z22producerConsumer_C_APIv+0x134>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80003890:	00006517          	auipc	a0,0x6
    80003894:	84850513          	addi	a0,a0,-1976 # 800090d8 <CONSOLE_STATUS+0xc8>
    80003898:	00002097          	auipc	ra,0x2
    8000389c:	128080e7          	jalr	296(ra) # 800059c0 <_Z11printStringPKc>
        return;
    800038a0:	000b0113          	mv	sp,s6
    800038a4:	1500006f          	j	800039f4 <_Z22producerConsumer_C_APIv+0x288>
    sem_open(&waitForAll, 0);
    800038a8:	00000593          	li	a1,0
    800038ac:	00008517          	auipc	a0,0x8
    800038b0:	35450513          	addi	a0,a0,852 # 8000bc00 <_ZL10waitForAll>
    800038b4:	ffffe097          	auipc	ra,0xffffe
    800038b8:	b2c080e7          	jalr	-1236(ra) # 800013e0 <_Z8sem_openPP10_Semaphorej>
    thread_t threads[threadNum];
    800038bc:	00391793          	slli	a5,s2,0x3
    800038c0:	00f78793          	addi	a5,a5,15
    800038c4:	ff07f793          	andi	a5,a5,-16
    800038c8:	40f10133          	sub	sp,sp,a5
    800038cc:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    800038d0:	0019071b          	addiw	a4,s2,1
    800038d4:	00171793          	slli	a5,a4,0x1
    800038d8:	00e787b3          	add	a5,a5,a4
    800038dc:	00379793          	slli	a5,a5,0x3
    800038e0:	00f78793          	addi	a5,a5,15
    800038e4:	ff07f793          	andi	a5,a5,-16
    800038e8:	40f10133          	sub	sp,sp,a5
    800038ec:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    800038f0:	00191613          	slli	a2,s2,0x1
    800038f4:	012607b3          	add	a5,a2,s2
    800038f8:	00379793          	slli	a5,a5,0x3
    800038fc:	00f987b3          	add	a5,s3,a5
    80003900:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80003904:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    80003908:	00008717          	auipc	a4,0x8
    8000390c:	2f873703          	ld	a4,760(a4) # 8000bc00 <_ZL10waitForAll>
    80003910:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    80003914:	00078613          	mv	a2,a5
    80003918:	00000597          	auipc	a1,0x0
    8000391c:	d7458593          	addi	a1,a1,-652 # 8000368c <_ZL8consumerPv>
    80003920:	f9840513          	addi	a0,s0,-104
    80003924:	ffffe097          	auipc	ra,0xffffe
    80003928:	9b4080e7          	jalr	-1612(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    8000392c:	00000493          	li	s1,0
    80003930:	0280006f          	j	80003958 <_Z22producerConsumer_C_APIv+0x1ec>
        thread_create(threads + i,
    80003934:	00000597          	auipc	a1,0x0
    80003938:	c1458593          	addi	a1,a1,-1004 # 80003548 <_ZL16producerKeyboardPv>
                      data + i);
    8000393c:	00179613          	slli	a2,a5,0x1
    80003940:	00f60633          	add	a2,a2,a5
    80003944:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    80003948:	00c98633          	add	a2,s3,a2
    8000394c:	ffffe097          	auipc	ra,0xffffe
    80003950:	98c080e7          	jalr	-1652(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80003954:	0014849b          	addiw	s1,s1,1
    80003958:	0524d263          	bge	s1,s2,8000399c <_Z22producerConsumer_C_APIv+0x230>
        data[i].id = i;
    8000395c:	00149793          	slli	a5,s1,0x1
    80003960:	009787b3          	add	a5,a5,s1
    80003964:	00379793          	slli	a5,a5,0x3
    80003968:	00f987b3          	add	a5,s3,a5
    8000396c:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80003970:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80003974:	00008717          	auipc	a4,0x8
    80003978:	28c73703          	ld	a4,652(a4) # 8000bc00 <_ZL10waitForAll>
    8000397c:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80003980:	00048793          	mv	a5,s1
    80003984:	00349513          	slli	a0,s1,0x3
    80003988:	00aa8533          	add	a0,s5,a0
    8000398c:	fa9054e3          	blez	s1,80003934 <_Z22producerConsumer_C_APIv+0x1c8>
    80003990:	00000597          	auipc	a1,0x0
    80003994:	c6858593          	addi	a1,a1,-920 # 800035f8 <_ZL8producerPv>
    80003998:	fa5ff06f          	j	8000393c <_Z22producerConsumer_C_APIv+0x1d0>
    thread_dispatch();
    8000399c:	ffffe097          	auipc	ra,0xffffe
    800039a0:	a24080e7          	jalr	-1500(ra) # 800013c0 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    800039a4:	00000493          	li	s1,0
    800039a8:	00994e63          	blt	s2,s1,800039c4 <_Z22producerConsumer_C_APIv+0x258>
        sem_wait(waitForAll);
    800039ac:	00008517          	auipc	a0,0x8
    800039b0:	25453503          	ld	a0,596(a0) # 8000bc00 <_ZL10waitForAll>
    800039b4:	ffffe097          	auipc	ra,0xffffe
    800039b8:	a8c080e7          	jalr	-1396(ra) # 80001440 <_Z8sem_waitP10_Semaphore>
    for (int i = 0; i <= threadNum; i++) {
    800039bc:	0014849b          	addiw	s1,s1,1
    800039c0:	fe9ff06f          	j	800039a8 <_Z22producerConsumer_C_APIv+0x23c>
    sem_close(waitForAll);
    800039c4:	00008517          	auipc	a0,0x8
    800039c8:	23c53503          	ld	a0,572(a0) # 8000bc00 <_ZL10waitForAll>
    800039cc:	ffffe097          	auipc	ra,0xffffe
    800039d0:	a4c080e7          	jalr	-1460(ra) # 80001418 <_Z9sem_closeP10_Semaphore>
    delete buffer;
    800039d4:	000a0e63          	beqz	s4,800039f0 <_Z22producerConsumer_C_APIv+0x284>
    800039d8:	000a0513          	mv	a0,s4
    800039dc:	00003097          	auipc	ra,0x3
    800039e0:	16c080e7          	jalr	364(ra) # 80006b48 <_ZN6BufferD1Ev>
    800039e4:	000a0513          	mv	a0,s4
    800039e8:	ffffe097          	auipc	ra,0xffffe
    800039ec:	bd8080e7          	jalr	-1064(ra) # 800015c0 <_ZdlPv>
    800039f0:	000b0113          	mv	sp,s6

}
    800039f4:	f9040113          	addi	sp,s0,-112
    800039f8:	06813083          	ld	ra,104(sp)
    800039fc:	06013403          	ld	s0,96(sp)
    80003a00:	05813483          	ld	s1,88(sp)
    80003a04:	05013903          	ld	s2,80(sp)
    80003a08:	04813983          	ld	s3,72(sp)
    80003a0c:	04013a03          	ld	s4,64(sp)
    80003a10:	03813a83          	ld	s5,56(sp)
    80003a14:	03013b03          	ld	s6,48(sp)
    80003a18:	07010113          	addi	sp,sp,112
    80003a1c:	00008067          	ret
    80003a20:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    80003a24:	000a0513          	mv	a0,s4
    80003a28:	ffffe097          	auipc	ra,0xffffe
    80003a2c:	b98080e7          	jalr	-1128(ra) # 800015c0 <_ZdlPv>
    80003a30:	00048513          	mv	a0,s1
    80003a34:	00009097          	auipc	ra,0x9
    80003a38:	2e4080e7          	jalr	740(ra) # 8000cd18 <_Unwind_Resume>

0000000080003a3c <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80003a3c:	fe010113          	addi	sp,sp,-32
    80003a40:	00113c23          	sd	ra,24(sp)
    80003a44:	00813823          	sd	s0,16(sp)
    80003a48:	00913423          	sd	s1,8(sp)
    80003a4c:	01213023          	sd	s2,0(sp)
    80003a50:	02010413          	addi	s0,sp,32
    80003a54:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80003a58:	00100793          	li	a5,1
    80003a5c:	02a7f863          	bgeu	a5,a0,80003a8c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80003a60:	00a00793          	li	a5,10
    80003a64:	02f577b3          	remu	a5,a0,a5
    80003a68:	02078e63          	beqz	a5,80003aa4 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80003a6c:	fff48513          	addi	a0,s1,-1
    80003a70:	00000097          	auipc	ra,0x0
    80003a74:	fcc080e7          	jalr	-52(ra) # 80003a3c <_ZL9fibonaccim>
    80003a78:	00050913          	mv	s2,a0
    80003a7c:	ffe48513          	addi	a0,s1,-2
    80003a80:	00000097          	auipc	ra,0x0
    80003a84:	fbc080e7          	jalr	-68(ra) # 80003a3c <_ZL9fibonaccim>
    80003a88:	00a90533          	add	a0,s2,a0
}
    80003a8c:	01813083          	ld	ra,24(sp)
    80003a90:	01013403          	ld	s0,16(sp)
    80003a94:	00813483          	ld	s1,8(sp)
    80003a98:	00013903          	ld	s2,0(sp)
    80003a9c:	02010113          	addi	sp,sp,32
    80003aa0:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80003aa4:	ffffe097          	auipc	ra,0xffffe
    80003aa8:	91c080e7          	jalr	-1764(ra) # 800013c0 <_Z15thread_dispatchv>
    80003aac:	fc1ff06f          	j	80003a6c <_ZL9fibonaccim+0x30>

0000000080003ab0 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80003ab0:	fe010113          	addi	sp,sp,-32
    80003ab4:	00113c23          	sd	ra,24(sp)
    80003ab8:	00813823          	sd	s0,16(sp)
    80003abc:	00913423          	sd	s1,8(sp)
    80003ac0:	01213023          	sd	s2,0(sp)
    80003ac4:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80003ac8:	00000913          	li	s2,0
    80003acc:	0380006f          	j	80003b04 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80003ad0:	ffffe097          	auipc	ra,0xffffe
    80003ad4:	8f0080e7          	jalr	-1808(ra) # 800013c0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003ad8:	00148493          	addi	s1,s1,1
    80003adc:	000027b7          	lui	a5,0x2
    80003ae0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003ae4:	0097ee63          	bltu	a5,s1,80003b00 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003ae8:	00000713          	li	a4,0
    80003aec:	000077b7          	lui	a5,0x7
    80003af0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003af4:	fce7eee3          	bltu	a5,a4,80003ad0 <_ZN7WorkerA11workerBodyAEPv+0x20>
    80003af8:	00170713          	addi	a4,a4,1
    80003afc:	ff1ff06f          	j	80003aec <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80003b00:	00190913          	addi	s2,s2,1
    80003b04:	00900793          	li	a5,9
    80003b08:	0527e063          	bltu	a5,s2,80003b48 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80003b0c:	00005517          	auipc	a0,0x5
    80003b10:	5fc50513          	addi	a0,a0,1532 # 80009108 <CONSOLE_STATUS+0xf8>
    80003b14:	00002097          	auipc	ra,0x2
    80003b18:	eac080e7          	jalr	-340(ra) # 800059c0 <_Z11printStringPKc>
    80003b1c:	00000613          	li	a2,0
    80003b20:	00a00593          	li	a1,10
    80003b24:	0009051b          	sext.w	a0,s2
    80003b28:	00002097          	auipc	ra,0x2
    80003b2c:	048080e7          	jalr	72(ra) # 80005b70 <_Z8printIntiii>
    80003b30:	00006517          	auipc	a0,0x6
    80003b34:	82850513          	addi	a0,a0,-2008 # 80009358 <CONSOLE_STATUS+0x348>
    80003b38:	00002097          	auipc	ra,0x2
    80003b3c:	e88080e7          	jalr	-376(ra) # 800059c0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003b40:	00000493          	li	s1,0
    80003b44:	f99ff06f          	j	80003adc <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80003b48:	00005517          	auipc	a0,0x5
    80003b4c:	5c850513          	addi	a0,a0,1480 # 80009110 <CONSOLE_STATUS+0x100>
    80003b50:	00002097          	auipc	ra,0x2
    80003b54:	e70080e7          	jalr	-400(ra) # 800059c0 <_Z11printStringPKc>
    finishedA = true;
    80003b58:	00100793          	li	a5,1
    80003b5c:	00008717          	auipc	a4,0x8
    80003b60:	0af70623          	sb	a5,172(a4) # 8000bc08 <_ZL9finishedA>
}
    80003b64:	01813083          	ld	ra,24(sp)
    80003b68:	01013403          	ld	s0,16(sp)
    80003b6c:	00813483          	ld	s1,8(sp)
    80003b70:	00013903          	ld	s2,0(sp)
    80003b74:	02010113          	addi	sp,sp,32
    80003b78:	00008067          	ret

0000000080003b7c <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80003b7c:	fe010113          	addi	sp,sp,-32
    80003b80:	00113c23          	sd	ra,24(sp)
    80003b84:	00813823          	sd	s0,16(sp)
    80003b88:	00913423          	sd	s1,8(sp)
    80003b8c:	01213023          	sd	s2,0(sp)
    80003b90:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003b94:	00000913          	li	s2,0
    80003b98:	0380006f          	j	80003bd0 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80003b9c:	ffffe097          	auipc	ra,0xffffe
    80003ba0:	824080e7          	jalr	-2012(ra) # 800013c0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003ba4:	00148493          	addi	s1,s1,1
    80003ba8:	000027b7          	lui	a5,0x2
    80003bac:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003bb0:	0097ee63          	bltu	a5,s1,80003bcc <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003bb4:	00000713          	li	a4,0
    80003bb8:	000077b7          	lui	a5,0x7
    80003bbc:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003bc0:	fce7eee3          	bltu	a5,a4,80003b9c <_ZN7WorkerB11workerBodyBEPv+0x20>
    80003bc4:	00170713          	addi	a4,a4,1
    80003bc8:	ff1ff06f          	j	80003bb8 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80003bcc:	00190913          	addi	s2,s2,1
    80003bd0:	00f00793          	li	a5,15
    80003bd4:	0527e063          	bltu	a5,s2,80003c14 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80003bd8:	00005517          	auipc	a0,0x5
    80003bdc:	54850513          	addi	a0,a0,1352 # 80009120 <CONSOLE_STATUS+0x110>
    80003be0:	00002097          	auipc	ra,0x2
    80003be4:	de0080e7          	jalr	-544(ra) # 800059c0 <_Z11printStringPKc>
    80003be8:	00000613          	li	a2,0
    80003bec:	00a00593          	li	a1,10
    80003bf0:	0009051b          	sext.w	a0,s2
    80003bf4:	00002097          	auipc	ra,0x2
    80003bf8:	f7c080e7          	jalr	-132(ra) # 80005b70 <_Z8printIntiii>
    80003bfc:	00005517          	auipc	a0,0x5
    80003c00:	75c50513          	addi	a0,a0,1884 # 80009358 <CONSOLE_STATUS+0x348>
    80003c04:	00002097          	auipc	ra,0x2
    80003c08:	dbc080e7          	jalr	-580(ra) # 800059c0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003c0c:	00000493          	li	s1,0
    80003c10:	f99ff06f          	j	80003ba8 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    80003c14:	00005517          	auipc	a0,0x5
    80003c18:	51450513          	addi	a0,a0,1300 # 80009128 <CONSOLE_STATUS+0x118>
    80003c1c:	00002097          	auipc	ra,0x2
    80003c20:	da4080e7          	jalr	-604(ra) # 800059c0 <_Z11printStringPKc>
    finishedB = true;
    80003c24:	00100793          	li	a5,1
    80003c28:	00008717          	auipc	a4,0x8
    80003c2c:	fef700a3          	sb	a5,-31(a4) # 8000bc09 <_ZL9finishedB>
    thread_dispatch();
    80003c30:	ffffd097          	auipc	ra,0xffffd
    80003c34:	790080e7          	jalr	1936(ra) # 800013c0 <_Z15thread_dispatchv>
}
    80003c38:	01813083          	ld	ra,24(sp)
    80003c3c:	01013403          	ld	s0,16(sp)
    80003c40:	00813483          	ld	s1,8(sp)
    80003c44:	00013903          	ld	s2,0(sp)
    80003c48:	02010113          	addi	sp,sp,32
    80003c4c:	00008067          	ret

0000000080003c50 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80003c50:	fe010113          	addi	sp,sp,-32
    80003c54:	00113c23          	sd	ra,24(sp)
    80003c58:	00813823          	sd	s0,16(sp)
    80003c5c:	00913423          	sd	s1,8(sp)
    80003c60:	01213023          	sd	s2,0(sp)
    80003c64:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80003c68:	00000493          	li	s1,0
    80003c6c:	0400006f          	j	80003cac <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80003c70:	00005517          	auipc	a0,0x5
    80003c74:	4c850513          	addi	a0,a0,1224 # 80009138 <CONSOLE_STATUS+0x128>
    80003c78:	00002097          	auipc	ra,0x2
    80003c7c:	d48080e7          	jalr	-696(ra) # 800059c0 <_Z11printStringPKc>
    80003c80:	00000613          	li	a2,0
    80003c84:	00a00593          	li	a1,10
    80003c88:	00048513          	mv	a0,s1
    80003c8c:	00002097          	auipc	ra,0x2
    80003c90:	ee4080e7          	jalr	-284(ra) # 80005b70 <_Z8printIntiii>
    80003c94:	00005517          	auipc	a0,0x5
    80003c98:	6c450513          	addi	a0,a0,1732 # 80009358 <CONSOLE_STATUS+0x348>
    80003c9c:	00002097          	auipc	ra,0x2
    80003ca0:	d24080e7          	jalr	-732(ra) # 800059c0 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80003ca4:	0014849b          	addiw	s1,s1,1
    80003ca8:	0ff4f493          	andi	s1,s1,255
    80003cac:	00200793          	li	a5,2
    80003cb0:	fc97f0e3          	bgeu	a5,s1,80003c70 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80003cb4:	00005517          	auipc	a0,0x5
    80003cb8:	48c50513          	addi	a0,a0,1164 # 80009140 <CONSOLE_STATUS+0x130>
    80003cbc:	00002097          	auipc	ra,0x2
    80003cc0:	d04080e7          	jalr	-764(ra) # 800059c0 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80003cc4:	00700313          	li	t1,7
    thread_dispatch();
    80003cc8:	ffffd097          	auipc	ra,0xffffd
    80003ccc:	6f8080e7          	jalr	1784(ra) # 800013c0 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80003cd0:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80003cd4:	00005517          	auipc	a0,0x5
    80003cd8:	47c50513          	addi	a0,a0,1148 # 80009150 <CONSOLE_STATUS+0x140>
    80003cdc:	00002097          	auipc	ra,0x2
    80003ce0:	ce4080e7          	jalr	-796(ra) # 800059c0 <_Z11printStringPKc>
    80003ce4:	00000613          	li	a2,0
    80003ce8:	00a00593          	li	a1,10
    80003cec:	0009051b          	sext.w	a0,s2
    80003cf0:	00002097          	auipc	ra,0x2
    80003cf4:	e80080e7          	jalr	-384(ra) # 80005b70 <_Z8printIntiii>
    80003cf8:	00005517          	auipc	a0,0x5
    80003cfc:	66050513          	addi	a0,a0,1632 # 80009358 <CONSOLE_STATUS+0x348>
    80003d00:	00002097          	auipc	ra,0x2
    80003d04:	cc0080e7          	jalr	-832(ra) # 800059c0 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    80003d08:	00c00513          	li	a0,12
    80003d0c:	00000097          	auipc	ra,0x0
    80003d10:	d30080e7          	jalr	-720(ra) # 80003a3c <_ZL9fibonaccim>
    80003d14:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80003d18:	00005517          	auipc	a0,0x5
    80003d1c:	44050513          	addi	a0,a0,1088 # 80009158 <CONSOLE_STATUS+0x148>
    80003d20:	00002097          	auipc	ra,0x2
    80003d24:	ca0080e7          	jalr	-864(ra) # 800059c0 <_Z11printStringPKc>
    80003d28:	00000613          	li	a2,0
    80003d2c:	00a00593          	li	a1,10
    80003d30:	0009051b          	sext.w	a0,s2
    80003d34:	00002097          	auipc	ra,0x2
    80003d38:	e3c080e7          	jalr	-452(ra) # 80005b70 <_Z8printIntiii>
    80003d3c:	00005517          	auipc	a0,0x5
    80003d40:	61c50513          	addi	a0,a0,1564 # 80009358 <CONSOLE_STATUS+0x348>
    80003d44:	00002097          	auipc	ra,0x2
    80003d48:	c7c080e7          	jalr	-900(ra) # 800059c0 <_Z11printStringPKc>
    80003d4c:	0400006f          	j	80003d8c <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80003d50:	00005517          	auipc	a0,0x5
    80003d54:	3e850513          	addi	a0,a0,1000 # 80009138 <CONSOLE_STATUS+0x128>
    80003d58:	00002097          	auipc	ra,0x2
    80003d5c:	c68080e7          	jalr	-920(ra) # 800059c0 <_Z11printStringPKc>
    80003d60:	00000613          	li	a2,0
    80003d64:	00a00593          	li	a1,10
    80003d68:	00048513          	mv	a0,s1
    80003d6c:	00002097          	auipc	ra,0x2
    80003d70:	e04080e7          	jalr	-508(ra) # 80005b70 <_Z8printIntiii>
    80003d74:	00005517          	auipc	a0,0x5
    80003d78:	5e450513          	addi	a0,a0,1508 # 80009358 <CONSOLE_STATUS+0x348>
    80003d7c:	00002097          	auipc	ra,0x2
    80003d80:	c44080e7          	jalr	-956(ra) # 800059c0 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80003d84:	0014849b          	addiw	s1,s1,1
    80003d88:	0ff4f493          	andi	s1,s1,255
    80003d8c:	00500793          	li	a5,5
    80003d90:	fc97f0e3          	bgeu	a5,s1,80003d50 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80003d94:	00005517          	auipc	a0,0x5
    80003d98:	37c50513          	addi	a0,a0,892 # 80009110 <CONSOLE_STATUS+0x100>
    80003d9c:	00002097          	auipc	ra,0x2
    80003da0:	c24080e7          	jalr	-988(ra) # 800059c0 <_Z11printStringPKc>
    finishedC = true;
    80003da4:	00100793          	li	a5,1
    80003da8:	00008717          	auipc	a4,0x8
    80003dac:	e6f70123          	sb	a5,-414(a4) # 8000bc0a <_ZL9finishedC>
    thread_dispatch();
    80003db0:	ffffd097          	auipc	ra,0xffffd
    80003db4:	610080e7          	jalr	1552(ra) # 800013c0 <_Z15thread_dispatchv>
}
    80003db8:	01813083          	ld	ra,24(sp)
    80003dbc:	01013403          	ld	s0,16(sp)
    80003dc0:	00813483          	ld	s1,8(sp)
    80003dc4:	00013903          	ld	s2,0(sp)
    80003dc8:	02010113          	addi	sp,sp,32
    80003dcc:	00008067          	ret

0000000080003dd0 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80003dd0:	fe010113          	addi	sp,sp,-32
    80003dd4:	00113c23          	sd	ra,24(sp)
    80003dd8:	00813823          	sd	s0,16(sp)
    80003ddc:	00913423          	sd	s1,8(sp)
    80003de0:	01213023          	sd	s2,0(sp)
    80003de4:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80003de8:	00a00493          	li	s1,10
    80003dec:	0400006f          	j	80003e2c <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003df0:	00005517          	auipc	a0,0x5
    80003df4:	37850513          	addi	a0,a0,888 # 80009168 <CONSOLE_STATUS+0x158>
    80003df8:	00002097          	auipc	ra,0x2
    80003dfc:	bc8080e7          	jalr	-1080(ra) # 800059c0 <_Z11printStringPKc>
    80003e00:	00000613          	li	a2,0
    80003e04:	00a00593          	li	a1,10
    80003e08:	00048513          	mv	a0,s1
    80003e0c:	00002097          	auipc	ra,0x2
    80003e10:	d64080e7          	jalr	-668(ra) # 80005b70 <_Z8printIntiii>
    80003e14:	00005517          	auipc	a0,0x5
    80003e18:	54450513          	addi	a0,a0,1348 # 80009358 <CONSOLE_STATUS+0x348>
    80003e1c:	00002097          	auipc	ra,0x2
    80003e20:	ba4080e7          	jalr	-1116(ra) # 800059c0 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80003e24:	0014849b          	addiw	s1,s1,1
    80003e28:	0ff4f493          	andi	s1,s1,255
    80003e2c:	00c00793          	li	a5,12
    80003e30:	fc97f0e3          	bgeu	a5,s1,80003df0 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    80003e34:	00005517          	auipc	a0,0x5
    80003e38:	33c50513          	addi	a0,a0,828 # 80009170 <CONSOLE_STATUS+0x160>
    80003e3c:	00002097          	auipc	ra,0x2
    80003e40:	b84080e7          	jalr	-1148(ra) # 800059c0 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80003e44:	00500313          	li	t1,5
    thread_dispatch();
    80003e48:	ffffd097          	auipc	ra,0xffffd
    80003e4c:	578080e7          	jalr	1400(ra) # 800013c0 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80003e50:	01000513          	li	a0,16
    80003e54:	00000097          	auipc	ra,0x0
    80003e58:	be8080e7          	jalr	-1048(ra) # 80003a3c <_ZL9fibonaccim>
    80003e5c:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80003e60:	00005517          	auipc	a0,0x5
    80003e64:	32050513          	addi	a0,a0,800 # 80009180 <CONSOLE_STATUS+0x170>
    80003e68:	00002097          	auipc	ra,0x2
    80003e6c:	b58080e7          	jalr	-1192(ra) # 800059c0 <_Z11printStringPKc>
    80003e70:	00000613          	li	a2,0
    80003e74:	00a00593          	li	a1,10
    80003e78:	0009051b          	sext.w	a0,s2
    80003e7c:	00002097          	auipc	ra,0x2
    80003e80:	cf4080e7          	jalr	-780(ra) # 80005b70 <_Z8printIntiii>
    80003e84:	00005517          	auipc	a0,0x5
    80003e88:	4d450513          	addi	a0,a0,1236 # 80009358 <CONSOLE_STATUS+0x348>
    80003e8c:	00002097          	auipc	ra,0x2
    80003e90:	b34080e7          	jalr	-1228(ra) # 800059c0 <_Z11printStringPKc>
    80003e94:	0400006f          	j	80003ed4 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003e98:	00005517          	auipc	a0,0x5
    80003e9c:	2d050513          	addi	a0,a0,720 # 80009168 <CONSOLE_STATUS+0x158>
    80003ea0:	00002097          	auipc	ra,0x2
    80003ea4:	b20080e7          	jalr	-1248(ra) # 800059c0 <_Z11printStringPKc>
    80003ea8:	00000613          	li	a2,0
    80003eac:	00a00593          	li	a1,10
    80003eb0:	00048513          	mv	a0,s1
    80003eb4:	00002097          	auipc	ra,0x2
    80003eb8:	cbc080e7          	jalr	-836(ra) # 80005b70 <_Z8printIntiii>
    80003ebc:	00005517          	auipc	a0,0x5
    80003ec0:	49c50513          	addi	a0,a0,1180 # 80009358 <CONSOLE_STATUS+0x348>
    80003ec4:	00002097          	auipc	ra,0x2
    80003ec8:	afc080e7          	jalr	-1284(ra) # 800059c0 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80003ecc:	0014849b          	addiw	s1,s1,1
    80003ed0:	0ff4f493          	andi	s1,s1,255
    80003ed4:	00f00793          	li	a5,15
    80003ed8:	fc97f0e3          	bgeu	a5,s1,80003e98 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80003edc:	00005517          	auipc	a0,0x5
    80003ee0:	2b450513          	addi	a0,a0,692 # 80009190 <CONSOLE_STATUS+0x180>
    80003ee4:	00002097          	auipc	ra,0x2
    80003ee8:	adc080e7          	jalr	-1316(ra) # 800059c0 <_Z11printStringPKc>
    finishedD = true;
    80003eec:	00100793          	li	a5,1
    80003ef0:	00008717          	auipc	a4,0x8
    80003ef4:	d0f70da3          	sb	a5,-741(a4) # 8000bc0b <_ZL9finishedD>
    thread_dispatch();
    80003ef8:	ffffd097          	auipc	ra,0xffffd
    80003efc:	4c8080e7          	jalr	1224(ra) # 800013c0 <_Z15thread_dispatchv>
}
    80003f00:	01813083          	ld	ra,24(sp)
    80003f04:	01013403          	ld	s0,16(sp)
    80003f08:	00813483          	ld	s1,8(sp)
    80003f0c:	00013903          	ld	s2,0(sp)
    80003f10:	02010113          	addi	sp,sp,32
    80003f14:	00008067          	ret

0000000080003f18 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80003f18:	fc010113          	addi	sp,sp,-64
    80003f1c:	02113c23          	sd	ra,56(sp)
    80003f20:	02813823          	sd	s0,48(sp)
    80003f24:	02913423          	sd	s1,40(sp)
    80003f28:	03213023          	sd	s2,32(sp)
    80003f2c:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80003f30:	02000513          	li	a0,32
    80003f34:	ffffd097          	auipc	ra,0xffffd
    80003f38:	63c080e7          	jalr	1596(ra) # 80001570 <_Znwm>
    80003f3c:	00050493          	mv	s1,a0
    WorkerA():Thread() {}
    80003f40:	ffffe097          	auipc	ra,0xffffe
    80003f44:	ed4080e7          	jalr	-300(ra) # 80001e14 <_ZN6ThreadC1Ev>
    80003f48:	00008797          	auipc	a5,0x8
    80003f4c:	9c078793          	addi	a5,a5,-1600 # 8000b908 <_ZTV7WorkerA+0x10>
    80003f50:	00f4b023          	sd	a5,0(s1)
    threads[0] = new WorkerA();
    80003f54:	fc943023          	sd	s1,-64(s0)
    printString("ThreadA created\n");
    80003f58:	00005517          	auipc	a0,0x5
    80003f5c:	24850513          	addi	a0,a0,584 # 800091a0 <CONSOLE_STATUS+0x190>
    80003f60:	00002097          	auipc	ra,0x2
    80003f64:	a60080e7          	jalr	-1440(ra) # 800059c0 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80003f68:	02000513          	li	a0,32
    80003f6c:	ffffd097          	auipc	ra,0xffffd
    80003f70:	604080e7          	jalr	1540(ra) # 80001570 <_Znwm>
    80003f74:	00050493          	mv	s1,a0
    WorkerB():Thread() {}
    80003f78:	ffffe097          	auipc	ra,0xffffe
    80003f7c:	e9c080e7          	jalr	-356(ra) # 80001e14 <_ZN6ThreadC1Ev>
    80003f80:	00008797          	auipc	a5,0x8
    80003f84:	9b078793          	addi	a5,a5,-1616 # 8000b930 <_ZTV7WorkerB+0x10>
    80003f88:	00f4b023          	sd	a5,0(s1)
    threads[1] = new WorkerB();
    80003f8c:	fc943423          	sd	s1,-56(s0)
    printString("ThreadB created\n");
    80003f90:	00005517          	auipc	a0,0x5
    80003f94:	22850513          	addi	a0,a0,552 # 800091b8 <CONSOLE_STATUS+0x1a8>
    80003f98:	00002097          	auipc	ra,0x2
    80003f9c:	a28080e7          	jalr	-1496(ra) # 800059c0 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80003fa0:	02000513          	li	a0,32
    80003fa4:	ffffd097          	auipc	ra,0xffffd
    80003fa8:	5cc080e7          	jalr	1484(ra) # 80001570 <_Znwm>
    80003fac:	00050493          	mv	s1,a0
    WorkerC():Thread() {}
    80003fb0:	ffffe097          	auipc	ra,0xffffe
    80003fb4:	e64080e7          	jalr	-412(ra) # 80001e14 <_ZN6ThreadC1Ev>
    80003fb8:	00008797          	auipc	a5,0x8
    80003fbc:	9a078793          	addi	a5,a5,-1632 # 8000b958 <_ZTV7WorkerC+0x10>
    80003fc0:	00f4b023          	sd	a5,0(s1)
    threads[2] = new WorkerC();
    80003fc4:	fc943823          	sd	s1,-48(s0)
    printString("ThreadC created\n");
    80003fc8:	00005517          	auipc	a0,0x5
    80003fcc:	20850513          	addi	a0,a0,520 # 800091d0 <CONSOLE_STATUS+0x1c0>
    80003fd0:	00002097          	auipc	ra,0x2
    80003fd4:	9f0080e7          	jalr	-1552(ra) # 800059c0 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80003fd8:	02000513          	li	a0,32
    80003fdc:	ffffd097          	auipc	ra,0xffffd
    80003fe0:	594080e7          	jalr	1428(ra) # 80001570 <_Znwm>
    80003fe4:	00050493          	mv	s1,a0
    WorkerD():Thread() {}
    80003fe8:	ffffe097          	auipc	ra,0xffffe
    80003fec:	e2c080e7          	jalr	-468(ra) # 80001e14 <_ZN6ThreadC1Ev>
    80003ff0:	00008797          	auipc	a5,0x8
    80003ff4:	99078793          	addi	a5,a5,-1648 # 8000b980 <_ZTV7WorkerD+0x10>
    80003ff8:	00f4b023          	sd	a5,0(s1)
    threads[3] = new WorkerD();
    80003ffc:	fc943c23          	sd	s1,-40(s0)
    printString("ThreadD created\n");
    80004000:	00005517          	auipc	a0,0x5
    80004004:	1e850513          	addi	a0,a0,488 # 800091e8 <CONSOLE_STATUS+0x1d8>
    80004008:	00002097          	auipc	ra,0x2
    8000400c:	9b8080e7          	jalr	-1608(ra) # 800059c0 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80004010:	00000493          	li	s1,0
    80004014:	00300793          	li	a5,3
    80004018:	0297c663          	blt	a5,s1,80004044 <_Z20Threads_CPP_API_testv+0x12c>
        threads[i]->start();
    8000401c:	00349793          	slli	a5,s1,0x3
    80004020:	fe040713          	addi	a4,s0,-32
    80004024:	00f707b3          	add	a5,a4,a5
    80004028:	fe07b503          	ld	a0,-32(a5)
    8000402c:	ffffe097          	auipc	ra,0xffffe
    80004030:	e18080e7          	jalr	-488(ra) # 80001e44 <_ZN6Thread5startEv>
    for(int i=0; i<4; i++) {
    80004034:	0014849b          	addiw	s1,s1,1
    80004038:	fddff06f          	j	80004014 <_Z20Threads_CPP_API_testv+0xfc>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        Thread::dispatch();
    8000403c:	ffffe097          	auipc	ra,0xffffe
    80004040:	e5c080e7          	jalr	-420(ra) # 80001e98 <_ZN6Thread8dispatchEv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004044:	00008797          	auipc	a5,0x8
    80004048:	bc47c783          	lbu	a5,-1084(a5) # 8000bc08 <_ZL9finishedA>
    8000404c:	fe0788e3          	beqz	a5,8000403c <_Z20Threads_CPP_API_testv+0x124>
    80004050:	00008797          	auipc	a5,0x8
    80004054:	bb97c783          	lbu	a5,-1095(a5) # 8000bc09 <_ZL9finishedB>
    80004058:	fe0782e3          	beqz	a5,8000403c <_Z20Threads_CPP_API_testv+0x124>
    8000405c:	00008797          	auipc	a5,0x8
    80004060:	bae7c783          	lbu	a5,-1106(a5) # 8000bc0a <_ZL9finishedC>
    80004064:	fc078ce3          	beqz	a5,8000403c <_Z20Threads_CPP_API_testv+0x124>
    80004068:	00008797          	auipc	a5,0x8
    8000406c:	ba37c783          	lbu	a5,-1117(a5) # 8000bc0b <_ZL9finishedD>
    80004070:	fc0786e3          	beqz	a5,8000403c <_Z20Threads_CPP_API_testv+0x124>
    80004074:	fc040493          	addi	s1,s0,-64
    80004078:	0080006f          	j	80004080 <_Z20Threads_CPP_API_testv+0x168>
    }

    for (auto thread: threads) { delete thread; }
    8000407c:	00848493          	addi	s1,s1,8
    80004080:	fe040793          	addi	a5,s0,-32
    80004084:	08f48663          	beq	s1,a5,80004110 <_Z20Threads_CPP_API_testv+0x1f8>
    80004088:	0004b503          	ld	a0,0(s1)
    8000408c:	fe0508e3          	beqz	a0,8000407c <_Z20Threads_CPP_API_testv+0x164>
    80004090:	00053783          	ld	a5,0(a0)
    80004094:	0087b783          	ld	a5,8(a5)
    80004098:	000780e7          	jalr	a5
    8000409c:	fe1ff06f          	j	8000407c <_Z20Threads_CPP_API_testv+0x164>
    800040a0:	00050913          	mv	s2,a0
    threads[0] = new WorkerA();
    800040a4:	00048513          	mv	a0,s1
    800040a8:	ffffd097          	auipc	ra,0xffffd
    800040ac:	518080e7          	jalr	1304(ra) # 800015c0 <_ZdlPv>
    800040b0:	00090513          	mv	a0,s2
    800040b4:	00009097          	auipc	ra,0x9
    800040b8:	c64080e7          	jalr	-924(ra) # 8000cd18 <_Unwind_Resume>
    800040bc:	00050913          	mv	s2,a0
    threads[1] = new WorkerB();
    800040c0:	00048513          	mv	a0,s1
    800040c4:	ffffd097          	auipc	ra,0xffffd
    800040c8:	4fc080e7          	jalr	1276(ra) # 800015c0 <_ZdlPv>
    800040cc:	00090513          	mv	a0,s2
    800040d0:	00009097          	auipc	ra,0x9
    800040d4:	c48080e7          	jalr	-952(ra) # 8000cd18 <_Unwind_Resume>
    800040d8:	00050913          	mv	s2,a0
    threads[2] = new WorkerC();
    800040dc:	00048513          	mv	a0,s1
    800040e0:	ffffd097          	auipc	ra,0xffffd
    800040e4:	4e0080e7          	jalr	1248(ra) # 800015c0 <_ZdlPv>
    800040e8:	00090513          	mv	a0,s2
    800040ec:	00009097          	auipc	ra,0x9
    800040f0:	c2c080e7          	jalr	-980(ra) # 8000cd18 <_Unwind_Resume>
    800040f4:	00050913          	mv	s2,a0
    threads[3] = new WorkerD();
    800040f8:	00048513          	mv	a0,s1
    800040fc:	ffffd097          	auipc	ra,0xffffd
    80004100:	4c4080e7          	jalr	1220(ra) # 800015c0 <_ZdlPv>
    80004104:	00090513          	mv	a0,s2
    80004108:	00009097          	auipc	ra,0x9
    8000410c:	c10080e7          	jalr	-1008(ra) # 8000cd18 <_Unwind_Resume>
}
    80004110:	03813083          	ld	ra,56(sp)
    80004114:	03013403          	ld	s0,48(sp)
    80004118:	02813483          	ld	s1,40(sp)
    8000411c:	02013903          	ld	s2,32(sp)
    80004120:	04010113          	addi	sp,sp,64
    80004124:	00008067          	ret

0000000080004128 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80004128:	ff010113          	addi	sp,sp,-16
    8000412c:	00113423          	sd	ra,8(sp)
    80004130:	00813023          	sd	s0,0(sp)
    80004134:	01010413          	addi	s0,sp,16
    80004138:	00007797          	auipc	a5,0x7
    8000413c:	7d078793          	addi	a5,a5,2000 # 8000b908 <_ZTV7WorkerA+0x10>
    80004140:	00f53023          	sd	a5,0(a0)
    80004144:	ffffe097          	auipc	ra,0xffffe
    80004148:	bac080e7          	jalr	-1108(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    8000414c:	00813083          	ld	ra,8(sp)
    80004150:	00013403          	ld	s0,0(sp)
    80004154:	01010113          	addi	sp,sp,16
    80004158:	00008067          	ret

000000008000415c <_ZN7WorkerAD0Ev>:
    8000415c:	fe010113          	addi	sp,sp,-32
    80004160:	00113c23          	sd	ra,24(sp)
    80004164:	00813823          	sd	s0,16(sp)
    80004168:	00913423          	sd	s1,8(sp)
    8000416c:	02010413          	addi	s0,sp,32
    80004170:	00050493          	mv	s1,a0
    80004174:	00007797          	auipc	a5,0x7
    80004178:	79478793          	addi	a5,a5,1940 # 8000b908 <_ZTV7WorkerA+0x10>
    8000417c:	00f53023          	sd	a5,0(a0)
    80004180:	ffffe097          	auipc	ra,0xffffe
    80004184:	b70080e7          	jalr	-1168(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    80004188:	00048513          	mv	a0,s1
    8000418c:	ffffd097          	auipc	ra,0xffffd
    80004190:	434080e7          	jalr	1076(ra) # 800015c0 <_ZdlPv>
    80004194:	01813083          	ld	ra,24(sp)
    80004198:	01013403          	ld	s0,16(sp)
    8000419c:	00813483          	ld	s1,8(sp)
    800041a0:	02010113          	addi	sp,sp,32
    800041a4:	00008067          	ret

00000000800041a8 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    800041a8:	ff010113          	addi	sp,sp,-16
    800041ac:	00113423          	sd	ra,8(sp)
    800041b0:	00813023          	sd	s0,0(sp)
    800041b4:	01010413          	addi	s0,sp,16
    800041b8:	00007797          	auipc	a5,0x7
    800041bc:	77878793          	addi	a5,a5,1912 # 8000b930 <_ZTV7WorkerB+0x10>
    800041c0:	00f53023          	sd	a5,0(a0)
    800041c4:	ffffe097          	auipc	ra,0xffffe
    800041c8:	b2c080e7          	jalr	-1236(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    800041cc:	00813083          	ld	ra,8(sp)
    800041d0:	00013403          	ld	s0,0(sp)
    800041d4:	01010113          	addi	sp,sp,16
    800041d8:	00008067          	ret

00000000800041dc <_ZN7WorkerBD0Ev>:
    800041dc:	fe010113          	addi	sp,sp,-32
    800041e0:	00113c23          	sd	ra,24(sp)
    800041e4:	00813823          	sd	s0,16(sp)
    800041e8:	00913423          	sd	s1,8(sp)
    800041ec:	02010413          	addi	s0,sp,32
    800041f0:	00050493          	mv	s1,a0
    800041f4:	00007797          	auipc	a5,0x7
    800041f8:	73c78793          	addi	a5,a5,1852 # 8000b930 <_ZTV7WorkerB+0x10>
    800041fc:	00f53023          	sd	a5,0(a0)
    80004200:	ffffe097          	auipc	ra,0xffffe
    80004204:	af0080e7          	jalr	-1296(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    80004208:	00048513          	mv	a0,s1
    8000420c:	ffffd097          	auipc	ra,0xffffd
    80004210:	3b4080e7          	jalr	948(ra) # 800015c0 <_ZdlPv>
    80004214:	01813083          	ld	ra,24(sp)
    80004218:	01013403          	ld	s0,16(sp)
    8000421c:	00813483          	ld	s1,8(sp)
    80004220:	02010113          	addi	sp,sp,32
    80004224:	00008067          	ret

0000000080004228 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80004228:	ff010113          	addi	sp,sp,-16
    8000422c:	00113423          	sd	ra,8(sp)
    80004230:	00813023          	sd	s0,0(sp)
    80004234:	01010413          	addi	s0,sp,16
    80004238:	00007797          	auipc	a5,0x7
    8000423c:	72078793          	addi	a5,a5,1824 # 8000b958 <_ZTV7WorkerC+0x10>
    80004240:	00f53023          	sd	a5,0(a0)
    80004244:	ffffe097          	auipc	ra,0xffffe
    80004248:	aac080e7          	jalr	-1364(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    8000424c:	00813083          	ld	ra,8(sp)
    80004250:	00013403          	ld	s0,0(sp)
    80004254:	01010113          	addi	sp,sp,16
    80004258:	00008067          	ret

000000008000425c <_ZN7WorkerCD0Ev>:
    8000425c:	fe010113          	addi	sp,sp,-32
    80004260:	00113c23          	sd	ra,24(sp)
    80004264:	00813823          	sd	s0,16(sp)
    80004268:	00913423          	sd	s1,8(sp)
    8000426c:	02010413          	addi	s0,sp,32
    80004270:	00050493          	mv	s1,a0
    80004274:	00007797          	auipc	a5,0x7
    80004278:	6e478793          	addi	a5,a5,1764 # 8000b958 <_ZTV7WorkerC+0x10>
    8000427c:	00f53023          	sd	a5,0(a0)
    80004280:	ffffe097          	auipc	ra,0xffffe
    80004284:	a70080e7          	jalr	-1424(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    80004288:	00048513          	mv	a0,s1
    8000428c:	ffffd097          	auipc	ra,0xffffd
    80004290:	334080e7          	jalr	820(ra) # 800015c0 <_ZdlPv>
    80004294:	01813083          	ld	ra,24(sp)
    80004298:	01013403          	ld	s0,16(sp)
    8000429c:	00813483          	ld	s1,8(sp)
    800042a0:	02010113          	addi	sp,sp,32
    800042a4:	00008067          	ret

00000000800042a8 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    800042a8:	ff010113          	addi	sp,sp,-16
    800042ac:	00113423          	sd	ra,8(sp)
    800042b0:	00813023          	sd	s0,0(sp)
    800042b4:	01010413          	addi	s0,sp,16
    800042b8:	00007797          	auipc	a5,0x7
    800042bc:	6c878793          	addi	a5,a5,1736 # 8000b980 <_ZTV7WorkerD+0x10>
    800042c0:	00f53023          	sd	a5,0(a0)
    800042c4:	ffffe097          	auipc	ra,0xffffe
    800042c8:	a2c080e7          	jalr	-1492(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    800042cc:	00813083          	ld	ra,8(sp)
    800042d0:	00013403          	ld	s0,0(sp)
    800042d4:	01010113          	addi	sp,sp,16
    800042d8:	00008067          	ret

00000000800042dc <_ZN7WorkerDD0Ev>:
    800042dc:	fe010113          	addi	sp,sp,-32
    800042e0:	00113c23          	sd	ra,24(sp)
    800042e4:	00813823          	sd	s0,16(sp)
    800042e8:	00913423          	sd	s1,8(sp)
    800042ec:	02010413          	addi	s0,sp,32
    800042f0:	00050493          	mv	s1,a0
    800042f4:	00007797          	auipc	a5,0x7
    800042f8:	68c78793          	addi	a5,a5,1676 # 8000b980 <_ZTV7WorkerD+0x10>
    800042fc:	00f53023          	sd	a5,0(a0)
    80004300:	ffffe097          	auipc	ra,0xffffe
    80004304:	9f0080e7          	jalr	-1552(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    80004308:	00048513          	mv	a0,s1
    8000430c:	ffffd097          	auipc	ra,0xffffd
    80004310:	2b4080e7          	jalr	692(ra) # 800015c0 <_ZdlPv>
    80004314:	01813083          	ld	ra,24(sp)
    80004318:	01013403          	ld	s0,16(sp)
    8000431c:	00813483          	ld	s1,8(sp)
    80004320:	02010113          	addi	sp,sp,32
    80004324:	00008067          	ret

0000000080004328 <_ZN7WorkerA3runEv>:
    void run() override {
    80004328:	ff010113          	addi	sp,sp,-16
    8000432c:	00113423          	sd	ra,8(sp)
    80004330:	00813023          	sd	s0,0(sp)
    80004334:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80004338:	00000593          	li	a1,0
    8000433c:	fffff097          	auipc	ra,0xfffff
    80004340:	774080e7          	jalr	1908(ra) # 80003ab0 <_ZN7WorkerA11workerBodyAEPv>
    }
    80004344:	00813083          	ld	ra,8(sp)
    80004348:	00013403          	ld	s0,0(sp)
    8000434c:	01010113          	addi	sp,sp,16
    80004350:	00008067          	ret

0000000080004354 <_ZN7WorkerB3runEv>:
    void run() override {
    80004354:	ff010113          	addi	sp,sp,-16
    80004358:	00113423          	sd	ra,8(sp)
    8000435c:	00813023          	sd	s0,0(sp)
    80004360:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80004364:	00000593          	li	a1,0
    80004368:	00000097          	auipc	ra,0x0
    8000436c:	814080e7          	jalr	-2028(ra) # 80003b7c <_ZN7WorkerB11workerBodyBEPv>
    }
    80004370:	00813083          	ld	ra,8(sp)
    80004374:	00013403          	ld	s0,0(sp)
    80004378:	01010113          	addi	sp,sp,16
    8000437c:	00008067          	ret

0000000080004380 <_ZN7WorkerC3runEv>:
    void run() override {
    80004380:	ff010113          	addi	sp,sp,-16
    80004384:	00113423          	sd	ra,8(sp)
    80004388:	00813023          	sd	s0,0(sp)
    8000438c:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80004390:	00000593          	li	a1,0
    80004394:	00000097          	auipc	ra,0x0
    80004398:	8bc080e7          	jalr	-1860(ra) # 80003c50 <_ZN7WorkerC11workerBodyCEPv>
    }
    8000439c:	00813083          	ld	ra,8(sp)
    800043a0:	00013403          	ld	s0,0(sp)
    800043a4:	01010113          	addi	sp,sp,16
    800043a8:	00008067          	ret

00000000800043ac <_ZN7WorkerD3runEv>:
    void run() override {
    800043ac:	ff010113          	addi	sp,sp,-16
    800043b0:	00113423          	sd	ra,8(sp)
    800043b4:	00813023          	sd	s0,0(sp)
    800043b8:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    800043bc:	00000593          	li	a1,0
    800043c0:	00000097          	auipc	ra,0x0
    800043c4:	a10080e7          	jalr	-1520(ra) # 80003dd0 <_ZN7WorkerD11workerBodyDEPv>
    }
    800043c8:	00813083          	ld	ra,8(sp)
    800043cc:	00013403          	ld	s0,0(sp)
    800043d0:	01010113          	addi	sp,sp,16
    800043d4:	00008067          	ret

00000000800043d8 <_Z20testConsumerProducerv>:

        td->sem->signal();
    }
};

void testConsumerProducer() {
    800043d8:	f8010113          	addi	sp,sp,-128
    800043dc:	06113c23          	sd	ra,120(sp)
    800043e0:	06813823          	sd	s0,112(sp)
    800043e4:	06913423          	sd	s1,104(sp)
    800043e8:	07213023          	sd	s2,96(sp)
    800043ec:	05313c23          	sd	s3,88(sp)
    800043f0:	05413823          	sd	s4,80(sp)
    800043f4:	05513423          	sd	s5,72(sp)
    800043f8:	05613023          	sd	s6,64(sp)
    800043fc:	03713c23          	sd	s7,56(sp)
    80004400:	03813823          	sd	s8,48(sp)
    80004404:	03913423          	sd	s9,40(sp)
    80004408:	08010413          	addi	s0,sp,128
    delete waitForAll;
    for (int i = 0; i < threadNum; i++) {
        delete producers[i];
    }
    delete consumer;
    delete buffer;
    8000440c:	00010c13          	mv	s8,sp
    printString("Unesite broj proizvodjaca?\n");
    80004410:	00005517          	auipc	a0,0x5
    80004414:	c1050513          	addi	a0,a0,-1008 # 80009020 <CONSOLE_STATUS+0x10>
    80004418:	00001097          	auipc	ra,0x1
    8000441c:	5a8080e7          	jalr	1448(ra) # 800059c0 <_Z11printStringPKc>
    getString(input, 30);
    80004420:	01e00593          	li	a1,30
    80004424:	f8040493          	addi	s1,s0,-128
    80004428:	00048513          	mv	a0,s1
    8000442c:	00001097          	auipc	ra,0x1
    80004430:	61c080e7          	jalr	1564(ra) # 80005a48 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80004434:	00048513          	mv	a0,s1
    80004438:	00001097          	auipc	ra,0x1
    8000443c:	6e8080e7          	jalr	1768(ra) # 80005b20 <_Z11stringToIntPKc>
    80004440:	00050993          	mv	s3,a0
    printString("Unesite velicinu bafera?\n");
    80004444:	00005517          	auipc	a0,0x5
    80004448:	bfc50513          	addi	a0,a0,-1028 # 80009040 <CONSOLE_STATUS+0x30>
    8000444c:	00001097          	auipc	ra,0x1
    80004450:	574080e7          	jalr	1396(ra) # 800059c0 <_Z11printStringPKc>
    getString(input, 30);
    80004454:	01e00593          	li	a1,30
    80004458:	00048513          	mv	a0,s1
    8000445c:	00001097          	auipc	ra,0x1
    80004460:	5ec080e7          	jalr	1516(ra) # 80005a48 <_Z9getStringPci>
    n = stringToInt(input);
    80004464:	00048513          	mv	a0,s1
    80004468:	00001097          	auipc	ra,0x1
    8000446c:	6b8080e7          	jalr	1720(ra) # 80005b20 <_Z11stringToIntPKc>
    80004470:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca ");
    80004474:	00005517          	auipc	a0,0x5
    80004478:	bec50513          	addi	a0,a0,-1044 # 80009060 <CONSOLE_STATUS+0x50>
    8000447c:	00001097          	auipc	ra,0x1
    80004480:	544080e7          	jalr	1348(ra) # 800059c0 <_Z11printStringPKc>
    printInt(threadNum);
    80004484:	00000613          	li	a2,0
    80004488:	00a00593          	li	a1,10
    8000448c:	00098513          	mv	a0,s3
    80004490:	00001097          	auipc	ra,0x1
    80004494:	6e0080e7          	jalr	1760(ra) # 80005b70 <_Z8printIntiii>
    printString(" i velicina bafera ");
    80004498:	00005517          	auipc	a0,0x5
    8000449c:	be050513          	addi	a0,a0,-1056 # 80009078 <CONSOLE_STATUS+0x68>
    800044a0:	00001097          	auipc	ra,0x1
    800044a4:	520080e7          	jalr	1312(ra) # 800059c0 <_Z11printStringPKc>
    printInt(n);
    800044a8:	00000613          	li	a2,0
    800044ac:	00a00593          	li	a1,10
    800044b0:	00048513          	mv	a0,s1
    800044b4:	00001097          	auipc	ra,0x1
    800044b8:	6bc080e7          	jalr	1724(ra) # 80005b70 <_Z8printIntiii>
    printString(".\n");
    800044bc:	00005517          	auipc	a0,0x5
    800044c0:	bd450513          	addi	a0,a0,-1068 # 80009090 <CONSOLE_STATUS+0x80>
    800044c4:	00001097          	auipc	ra,0x1
    800044c8:	4fc080e7          	jalr	1276(ra) # 800059c0 <_Z11printStringPKc>
    if (threadNum > n) {
    800044cc:	0334c463          	blt	s1,s3,800044f4 <_Z20testConsumerProducerv+0x11c>
    } else if (threadNum < 1) {
    800044d0:	03305c63          	blez	s3,80004508 <_Z20testConsumerProducerv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    800044d4:	03800513          	li	a0,56
    800044d8:	ffffd097          	auipc	ra,0xffffd
    800044dc:	098080e7          	jalr	152(ra) # 80001570 <_Znwm>
    800044e0:	00050a93          	mv	s5,a0
    800044e4:	00048593          	mv	a1,s1
    800044e8:	00001097          	auipc	ra,0x1
    800044ec:	7a8080e7          	jalr	1960(ra) # 80005c90 <_ZN9BufferCPPC1Ei>
    800044f0:	0300006f          	j	80004520 <_Z20testConsumerProducerv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    800044f4:	00005517          	auipc	a0,0x5
    800044f8:	ba450513          	addi	a0,a0,-1116 # 80009098 <CONSOLE_STATUS+0x88>
    800044fc:	00001097          	auipc	ra,0x1
    80004500:	4c4080e7          	jalr	1220(ra) # 800059c0 <_Z11printStringPKc>
        return;
    80004504:	0140006f          	j	80004518 <_Z20testConsumerProducerv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80004508:	00005517          	auipc	a0,0x5
    8000450c:	bd050513          	addi	a0,a0,-1072 # 800090d8 <CONSOLE_STATUS+0xc8>
    80004510:	00001097          	auipc	ra,0x1
    80004514:	4b0080e7          	jalr	1200(ra) # 800059c0 <_Z11printStringPKc>
        return;
    80004518:	000c0113          	mv	sp,s8
    8000451c:	2140006f          	j	80004730 <_Z20testConsumerProducerv+0x358>
    waitForAll = new Semaphore(0);
    80004520:	01000513          	li	a0,16
    80004524:	ffffd097          	auipc	ra,0xffffd
    80004528:	04c080e7          	jalr	76(ra) # 80001570 <_Znwm>
    8000452c:	00050913          	mv	s2,a0
    80004530:	00000593          	li	a1,0
    80004534:	ffffe097          	auipc	ra,0xffffe
    80004538:	a20080e7          	jalr	-1504(ra) # 80001f54 <_ZN9SemaphoreC1Ej>
    8000453c:	00007797          	auipc	a5,0x7
    80004540:	6d27be23          	sd	s2,1756(a5) # 8000bc18 <_ZL10waitForAll>
    Thread *producers[threadNum];
    80004544:	00399793          	slli	a5,s3,0x3
    80004548:	00f78793          	addi	a5,a5,15
    8000454c:	ff07f793          	andi	a5,a5,-16
    80004550:	40f10133          	sub	sp,sp,a5
    80004554:	00010a13          	mv	s4,sp
    thread_data threadData[threadNum + 1];
    80004558:	0019871b          	addiw	a4,s3,1
    8000455c:	00171793          	slli	a5,a4,0x1
    80004560:	00e787b3          	add	a5,a5,a4
    80004564:	00379793          	slli	a5,a5,0x3
    80004568:	00f78793          	addi	a5,a5,15
    8000456c:	ff07f793          	andi	a5,a5,-16
    80004570:	40f10133          	sub	sp,sp,a5
    80004574:	00010b13          	mv	s6,sp
    threadData[threadNum].id = threadNum;
    80004578:	00199493          	slli	s1,s3,0x1
    8000457c:	013484b3          	add	s1,s1,s3
    80004580:	00349493          	slli	s1,s1,0x3
    80004584:	009b04b3          	add	s1,s6,s1
    80004588:	0134a023          	sw	s3,0(s1)
    threadData[threadNum].buffer = buffer;
    8000458c:	0154b423          	sd	s5,8(s1)
    threadData[threadNum].sem = waitForAll;
    80004590:	0124b823          	sd	s2,16(s1)
    Thread *consumer = new Consumer(&threadData[threadNum]);
    80004594:	02800513          	li	a0,40
    80004598:	ffffd097          	auipc	ra,0xffffd
    8000459c:	fd8080e7          	jalr	-40(ra) # 80001570 <_Znwm>
    800045a0:	00050b93          	mv	s7,a0
    Consumer(thread_data *_td) : Thread(), td(_td) {}
    800045a4:	ffffe097          	auipc	ra,0xffffe
    800045a8:	870080e7          	jalr	-1936(ra) # 80001e14 <_ZN6ThreadC1Ev>
    800045ac:	00007797          	auipc	a5,0x7
    800045b0:	44c78793          	addi	a5,a5,1100 # 8000b9f8 <_ZTV8Consumer+0x10>
    800045b4:	00fbb023          	sd	a5,0(s7)
    800045b8:	029bb023          	sd	s1,32(s7)
    consumer->start();
    800045bc:	000b8513          	mv	a0,s7
    800045c0:	ffffe097          	auipc	ra,0xffffe
    800045c4:	884080e7          	jalr	-1916(ra) # 80001e44 <_ZN6Thread5startEv>
    threadData[0].id = 0;
    800045c8:	000b2023          	sw	zero,0(s6)
    threadData[0].buffer = buffer;
    800045cc:	015b3423          	sd	s5,8(s6)
    threadData[0].sem = waitForAll;
    800045d0:	00007797          	auipc	a5,0x7
    800045d4:	6487b783          	ld	a5,1608(a5) # 8000bc18 <_ZL10waitForAll>
    800045d8:	00fb3823          	sd	a5,16(s6)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    800045dc:	02800513          	li	a0,40
    800045e0:	ffffd097          	auipc	ra,0xffffd
    800045e4:	f90080e7          	jalr	-112(ra) # 80001570 <_Znwm>
    800045e8:	00050493          	mv	s1,a0
    ProducerKeyborad(thread_data *_td) : Thread(), td(_td) {}
    800045ec:	ffffe097          	auipc	ra,0xffffe
    800045f0:	828080e7          	jalr	-2008(ra) # 80001e14 <_ZN6ThreadC1Ev>
    800045f4:	00007797          	auipc	a5,0x7
    800045f8:	3b478793          	addi	a5,a5,948 # 8000b9a8 <_ZTV16ProducerKeyborad+0x10>
    800045fc:	00f4b023          	sd	a5,0(s1)
    80004600:	0364b023          	sd	s6,32(s1)
    producers[0] = new ProducerKeyborad(&threadData[0]);
    80004604:	009a3023          	sd	s1,0(s4)
    producers[0]->start();
    80004608:	00048513          	mv	a0,s1
    8000460c:	ffffe097          	auipc	ra,0xffffe
    80004610:	838080e7          	jalr	-1992(ra) # 80001e44 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80004614:	00100913          	li	s2,1
    80004618:	0300006f          	j	80004648 <_Z20testConsumerProducerv+0x270>
    Producer(thread_data *_td) : Thread(), td(_td) {}
    8000461c:	00007797          	auipc	a5,0x7
    80004620:	3b478793          	addi	a5,a5,948 # 8000b9d0 <_ZTV8Producer+0x10>
    80004624:	00fcb023          	sd	a5,0(s9)
    80004628:	029cb023          	sd	s1,32(s9)
        producers[i] = new Producer(&threadData[i]);
    8000462c:	00391793          	slli	a5,s2,0x3
    80004630:	00fa07b3          	add	a5,s4,a5
    80004634:	0197b023          	sd	s9,0(a5)
        producers[i]->start();
    80004638:	000c8513          	mv	a0,s9
    8000463c:	ffffe097          	auipc	ra,0xffffe
    80004640:	808080e7          	jalr	-2040(ra) # 80001e44 <_ZN6Thread5startEv>
    for (int i = 1; i < threadNum; i++) {
    80004644:	0019091b          	addiw	s2,s2,1
    80004648:	05395263          	bge	s2,s3,8000468c <_Z20testConsumerProducerv+0x2b4>
        threadData[i].id = i;
    8000464c:	00191493          	slli	s1,s2,0x1
    80004650:	012484b3          	add	s1,s1,s2
    80004654:	00349493          	slli	s1,s1,0x3
    80004658:	009b04b3          	add	s1,s6,s1
    8000465c:	0124a023          	sw	s2,0(s1)
        threadData[i].buffer = buffer;
    80004660:	0154b423          	sd	s5,8(s1)
        threadData[i].sem = waitForAll;
    80004664:	00007797          	auipc	a5,0x7
    80004668:	5b47b783          	ld	a5,1460(a5) # 8000bc18 <_ZL10waitForAll>
    8000466c:	00f4b823          	sd	a5,16(s1)
        producers[i] = new Producer(&threadData[i]);
    80004670:	02800513          	li	a0,40
    80004674:	ffffd097          	auipc	ra,0xffffd
    80004678:	efc080e7          	jalr	-260(ra) # 80001570 <_Znwm>
    8000467c:	00050c93          	mv	s9,a0
    Producer(thread_data *_td) : Thread(), td(_td) {}
    80004680:	ffffd097          	auipc	ra,0xffffd
    80004684:	794080e7          	jalr	1940(ra) # 80001e14 <_ZN6ThreadC1Ev>
    80004688:	f95ff06f          	j	8000461c <_Z20testConsumerProducerv+0x244>
    Thread::dispatch();
    8000468c:	ffffe097          	auipc	ra,0xffffe
    80004690:	80c080e7          	jalr	-2036(ra) # 80001e98 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    80004694:	00000493          	li	s1,0
    80004698:	0099ce63          	blt	s3,s1,800046b4 <_Z20testConsumerProducerv+0x2dc>
        waitForAll->wait();
    8000469c:	00007517          	auipc	a0,0x7
    800046a0:	57c53503          	ld	a0,1404(a0) # 8000bc18 <_ZL10waitForAll>
    800046a4:	ffffe097          	auipc	ra,0xffffe
    800046a8:	8ec080e7          	jalr	-1812(ra) # 80001f90 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    800046ac:	0014849b          	addiw	s1,s1,1
    800046b0:	fe9ff06f          	j	80004698 <_Z20testConsumerProducerv+0x2c0>
    delete waitForAll;
    800046b4:	00007517          	auipc	a0,0x7
    800046b8:	56453503          	ld	a0,1380(a0) # 8000bc18 <_ZL10waitForAll>
    800046bc:	00050863          	beqz	a0,800046cc <_Z20testConsumerProducerv+0x2f4>
    800046c0:	00053783          	ld	a5,0(a0)
    800046c4:	0087b783          	ld	a5,8(a5)
    800046c8:	000780e7          	jalr	a5
    for (int i = 0; i <= threadNum; i++) {
    800046cc:	00000493          	li	s1,0
    800046d0:	0080006f          	j	800046d8 <_Z20testConsumerProducerv+0x300>
    for (int i = 0; i < threadNum; i++) {
    800046d4:	0014849b          	addiw	s1,s1,1
    800046d8:	0334d263          	bge	s1,s3,800046fc <_Z20testConsumerProducerv+0x324>
        delete producers[i];
    800046dc:	00349793          	slli	a5,s1,0x3
    800046e0:	00fa07b3          	add	a5,s4,a5
    800046e4:	0007b503          	ld	a0,0(a5)
    800046e8:	fe0506e3          	beqz	a0,800046d4 <_Z20testConsumerProducerv+0x2fc>
    800046ec:	00053783          	ld	a5,0(a0)
    800046f0:	0087b783          	ld	a5,8(a5)
    800046f4:	000780e7          	jalr	a5
    800046f8:	fddff06f          	j	800046d4 <_Z20testConsumerProducerv+0x2fc>
    delete consumer;
    800046fc:	000b8a63          	beqz	s7,80004710 <_Z20testConsumerProducerv+0x338>
    80004700:	000bb783          	ld	a5,0(s7)
    80004704:	0087b783          	ld	a5,8(a5)
    80004708:	000b8513          	mv	a0,s7
    8000470c:	000780e7          	jalr	a5
    delete buffer;
    80004710:	000a8e63          	beqz	s5,8000472c <_Z20testConsumerProducerv+0x354>
    80004714:	000a8513          	mv	a0,s5
    80004718:	00002097          	auipc	ra,0x2
    8000471c:	870080e7          	jalr	-1936(ra) # 80005f88 <_ZN9BufferCPPD1Ev>
    80004720:	000a8513          	mv	a0,s5
    80004724:	ffffd097          	auipc	ra,0xffffd
    80004728:	e9c080e7          	jalr	-356(ra) # 800015c0 <_ZdlPv>
    8000472c:	000c0113          	mv	sp,s8
}
    80004730:	f8040113          	addi	sp,s0,-128
    80004734:	07813083          	ld	ra,120(sp)
    80004738:	07013403          	ld	s0,112(sp)
    8000473c:	06813483          	ld	s1,104(sp)
    80004740:	06013903          	ld	s2,96(sp)
    80004744:	05813983          	ld	s3,88(sp)
    80004748:	05013a03          	ld	s4,80(sp)
    8000474c:	04813a83          	ld	s5,72(sp)
    80004750:	04013b03          	ld	s6,64(sp)
    80004754:	03813b83          	ld	s7,56(sp)
    80004758:	03013c03          	ld	s8,48(sp)
    8000475c:	02813c83          	ld	s9,40(sp)
    80004760:	08010113          	addi	sp,sp,128
    80004764:	00008067          	ret
    80004768:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    8000476c:	000a8513          	mv	a0,s5
    80004770:	ffffd097          	auipc	ra,0xffffd
    80004774:	e50080e7          	jalr	-432(ra) # 800015c0 <_ZdlPv>
    80004778:	00048513          	mv	a0,s1
    8000477c:	00008097          	auipc	ra,0x8
    80004780:	59c080e7          	jalr	1436(ra) # 8000cd18 <_Unwind_Resume>
    80004784:	00050493          	mv	s1,a0
    waitForAll = new Semaphore(0);
    80004788:	00090513          	mv	a0,s2
    8000478c:	ffffd097          	auipc	ra,0xffffd
    80004790:	e34080e7          	jalr	-460(ra) # 800015c0 <_ZdlPv>
    80004794:	00048513          	mv	a0,s1
    80004798:	00008097          	auipc	ra,0x8
    8000479c:	580080e7          	jalr	1408(ra) # 8000cd18 <_Unwind_Resume>
    800047a0:	00050493          	mv	s1,a0
    Thread *consumer = new Consumer(&threadData[threadNum]);
    800047a4:	000b8513          	mv	a0,s7
    800047a8:	ffffd097          	auipc	ra,0xffffd
    800047ac:	e18080e7          	jalr	-488(ra) # 800015c0 <_ZdlPv>
    800047b0:	00048513          	mv	a0,s1
    800047b4:	00008097          	auipc	ra,0x8
    800047b8:	564080e7          	jalr	1380(ra) # 8000cd18 <_Unwind_Resume>
    800047bc:	00050913          	mv	s2,a0
    producers[0] = new ProducerKeyborad(&threadData[0]);
    800047c0:	00048513          	mv	a0,s1
    800047c4:	ffffd097          	auipc	ra,0xffffd
    800047c8:	dfc080e7          	jalr	-516(ra) # 800015c0 <_ZdlPv>
    800047cc:	00090513          	mv	a0,s2
    800047d0:	00008097          	auipc	ra,0x8
    800047d4:	548080e7          	jalr	1352(ra) # 8000cd18 <_Unwind_Resume>
    800047d8:	00050493          	mv	s1,a0
        producers[i] = new Producer(&threadData[i]);
    800047dc:	000c8513          	mv	a0,s9
    800047e0:	ffffd097          	auipc	ra,0xffffd
    800047e4:	de0080e7          	jalr	-544(ra) # 800015c0 <_ZdlPv>
    800047e8:	00048513          	mv	a0,s1
    800047ec:	00008097          	auipc	ra,0x8
    800047f0:	52c080e7          	jalr	1324(ra) # 8000cd18 <_Unwind_Resume>

00000000800047f4 <_ZN8Consumer3runEv>:
    void run() override {
    800047f4:	fd010113          	addi	sp,sp,-48
    800047f8:	02113423          	sd	ra,40(sp)
    800047fc:	02813023          	sd	s0,32(sp)
    80004800:	00913c23          	sd	s1,24(sp)
    80004804:	01213823          	sd	s2,16(sp)
    80004808:	01313423          	sd	s3,8(sp)
    8000480c:	03010413          	addi	s0,sp,48
    80004810:	00050913          	mv	s2,a0
        int i = 0;
    80004814:	00000993          	li	s3,0
    80004818:	0100006f          	j	80004828 <_ZN8Consumer3runEv+0x34>
                Console::putc('\n');
    8000481c:	00a00513          	li	a0,10
    80004820:	ffffe097          	auipc	ra,0xffffe
    80004824:	864080e7          	jalr	-1948(ra) # 80002084 <_ZN7Console4putcEc>
        while (!threadEnd) {
    80004828:	00007797          	auipc	a5,0x7
    8000482c:	3e87a783          	lw	a5,1000(a5) # 8000bc10 <_ZL9threadEnd>
    80004830:	04079a63          	bnez	a5,80004884 <_ZN8Consumer3runEv+0x90>
            int key = td->buffer->get();
    80004834:	02093783          	ld	a5,32(s2)
    80004838:	0087b503          	ld	a0,8(a5)
    8000483c:	00001097          	auipc	ra,0x1
    80004840:	638080e7          	jalr	1592(ra) # 80005e74 <_ZN9BufferCPP3getEv>
            i++;
    80004844:	0019849b          	addiw	s1,s3,1
    80004848:	0004899b          	sext.w	s3,s1
            Console::putc(key);
    8000484c:	0ff57513          	andi	a0,a0,255
    80004850:	ffffe097          	auipc	ra,0xffffe
    80004854:	834080e7          	jalr	-1996(ra) # 80002084 <_ZN7Console4putcEc>
            if (i % 80 == 0) {
    80004858:	05000793          	li	a5,80
    8000485c:	02f4e4bb          	remw	s1,s1,a5
    80004860:	fc0494e3          	bnez	s1,80004828 <_ZN8Consumer3runEv+0x34>
    80004864:	fb9ff06f          	j	8000481c <_ZN8Consumer3runEv+0x28>
            int key = td->buffer->get();
    80004868:	02093783          	ld	a5,32(s2)
    8000486c:	0087b503          	ld	a0,8(a5)
    80004870:	00001097          	auipc	ra,0x1
    80004874:	604080e7          	jalr	1540(ra) # 80005e74 <_ZN9BufferCPP3getEv>
            Console::putc(key);
    80004878:	0ff57513          	andi	a0,a0,255
    8000487c:	ffffe097          	auipc	ra,0xffffe
    80004880:	808080e7          	jalr	-2040(ra) # 80002084 <_ZN7Console4putcEc>
        while (td->buffer->getCnt() > 0) {
    80004884:	02093783          	ld	a5,32(s2)
    80004888:	0087b503          	ld	a0,8(a5)
    8000488c:	00001097          	auipc	ra,0x1
    80004890:	674080e7          	jalr	1652(ra) # 80005f00 <_ZN9BufferCPP6getCntEv>
    80004894:	fca04ae3          	bgtz	a0,80004868 <_ZN8Consumer3runEv+0x74>
        td->sem->signal();
    80004898:	02093783          	ld	a5,32(s2)
    8000489c:	0107b503          	ld	a0,16(a5)
    800048a0:	ffffd097          	auipc	ra,0xffffd
    800048a4:	71c080e7          	jalr	1820(ra) # 80001fbc <_ZN9Semaphore6signalEv>
    }
    800048a8:	02813083          	ld	ra,40(sp)
    800048ac:	02013403          	ld	s0,32(sp)
    800048b0:	01813483          	ld	s1,24(sp)
    800048b4:	01013903          	ld	s2,16(sp)
    800048b8:	00813983          	ld	s3,8(sp)
    800048bc:	03010113          	addi	sp,sp,48
    800048c0:	00008067          	ret

00000000800048c4 <_ZN8ConsumerD1Ev>:
class Consumer : public Thread {
    800048c4:	ff010113          	addi	sp,sp,-16
    800048c8:	00113423          	sd	ra,8(sp)
    800048cc:	00813023          	sd	s0,0(sp)
    800048d0:	01010413          	addi	s0,sp,16
    800048d4:	00007797          	auipc	a5,0x7
    800048d8:	12478793          	addi	a5,a5,292 # 8000b9f8 <_ZTV8Consumer+0x10>
    800048dc:	00f53023          	sd	a5,0(a0)
    800048e0:	ffffd097          	auipc	ra,0xffffd
    800048e4:	410080e7          	jalr	1040(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    800048e8:	00813083          	ld	ra,8(sp)
    800048ec:	00013403          	ld	s0,0(sp)
    800048f0:	01010113          	addi	sp,sp,16
    800048f4:	00008067          	ret

00000000800048f8 <_ZN8ConsumerD0Ev>:
    800048f8:	fe010113          	addi	sp,sp,-32
    800048fc:	00113c23          	sd	ra,24(sp)
    80004900:	00813823          	sd	s0,16(sp)
    80004904:	00913423          	sd	s1,8(sp)
    80004908:	02010413          	addi	s0,sp,32
    8000490c:	00050493          	mv	s1,a0
    80004910:	00007797          	auipc	a5,0x7
    80004914:	0e878793          	addi	a5,a5,232 # 8000b9f8 <_ZTV8Consumer+0x10>
    80004918:	00f53023          	sd	a5,0(a0)
    8000491c:	ffffd097          	auipc	ra,0xffffd
    80004920:	3d4080e7          	jalr	980(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    80004924:	00048513          	mv	a0,s1
    80004928:	ffffd097          	auipc	ra,0xffffd
    8000492c:	c98080e7          	jalr	-872(ra) # 800015c0 <_ZdlPv>
    80004930:	01813083          	ld	ra,24(sp)
    80004934:	01013403          	ld	s0,16(sp)
    80004938:	00813483          	ld	s1,8(sp)
    8000493c:	02010113          	addi	sp,sp,32
    80004940:	00008067          	ret

0000000080004944 <_ZN16ProducerKeyboradD1Ev>:
class ProducerKeyborad : public Thread {
    80004944:	ff010113          	addi	sp,sp,-16
    80004948:	00113423          	sd	ra,8(sp)
    8000494c:	00813023          	sd	s0,0(sp)
    80004950:	01010413          	addi	s0,sp,16
    80004954:	00007797          	auipc	a5,0x7
    80004958:	05478793          	addi	a5,a5,84 # 8000b9a8 <_ZTV16ProducerKeyborad+0x10>
    8000495c:	00f53023          	sd	a5,0(a0)
    80004960:	ffffd097          	auipc	ra,0xffffd
    80004964:	390080e7          	jalr	912(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    80004968:	00813083          	ld	ra,8(sp)
    8000496c:	00013403          	ld	s0,0(sp)
    80004970:	01010113          	addi	sp,sp,16
    80004974:	00008067          	ret

0000000080004978 <_ZN16ProducerKeyboradD0Ev>:
    80004978:	fe010113          	addi	sp,sp,-32
    8000497c:	00113c23          	sd	ra,24(sp)
    80004980:	00813823          	sd	s0,16(sp)
    80004984:	00913423          	sd	s1,8(sp)
    80004988:	02010413          	addi	s0,sp,32
    8000498c:	00050493          	mv	s1,a0
    80004990:	00007797          	auipc	a5,0x7
    80004994:	01878793          	addi	a5,a5,24 # 8000b9a8 <_ZTV16ProducerKeyborad+0x10>
    80004998:	00f53023          	sd	a5,0(a0)
    8000499c:	ffffd097          	auipc	ra,0xffffd
    800049a0:	354080e7          	jalr	852(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    800049a4:	00048513          	mv	a0,s1
    800049a8:	ffffd097          	auipc	ra,0xffffd
    800049ac:	c18080e7          	jalr	-1000(ra) # 800015c0 <_ZdlPv>
    800049b0:	01813083          	ld	ra,24(sp)
    800049b4:	01013403          	ld	s0,16(sp)
    800049b8:	00813483          	ld	s1,8(sp)
    800049bc:	02010113          	addi	sp,sp,32
    800049c0:	00008067          	ret

00000000800049c4 <_ZN8ProducerD1Ev>:
class Producer : public Thread {
    800049c4:	ff010113          	addi	sp,sp,-16
    800049c8:	00113423          	sd	ra,8(sp)
    800049cc:	00813023          	sd	s0,0(sp)
    800049d0:	01010413          	addi	s0,sp,16
    800049d4:	00007797          	auipc	a5,0x7
    800049d8:	ffc78793          	addi	a5,a5,-4 # 8000b9d0 <_ZTV8Producer+0x10>
    800049dc:	00f53023          	sd	a5,0(a0)
    800049e0:	ffffd097          	auipc	ra,0xffffd
    800049e4:	310080e7          	jalr	784(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    800049e8:	00813083          	ld	ra,8(sp)
    800049ec:	00013403          	ld	s0,0(sp)
    800049f0:	01010113          	addi	sp,sp,16
    800049f4:	00008067          	ret

00000000800049f8 <_ZN8ProducerD0Ev>:
    800049f8:	fe010113          	addi	sp,sp,-32
    800049fc:	00113c23          	sd	ra,24(sp)
    80004a00:	00813823          	sd	s0,16(sp)
    80004a04:	00913423          	sd	s1,8(sp)
    80004a08:	02010413          	addi	s0,sp,32
    80004a0c:	00050493          	mv	s1,a0
    80004a10:	00007797          	auipc	a5,0x7
    80004a14:	fc078793          	addi	a5,a5,-64 # 8000b9d0 <_ZTV8Producer+0x10>
    80004a18:	00f53023          	sd	a5,0(a0)
    80004a1c:	ffffd097          	auipc	ra,0xffffd
    80004a20:	2d4080e7          	jalr	724(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    80004a24:	00048513          	mv	a0,s1
    80004a28:	ffffd097          	auipc	ra,0xffffd
    80004a2c:	b98080e7          	jalr	-1128(ra) # 800015c0 <_ZdlPv>
    80004a30:	01813083          	ld	ra,24(sp)
    80004a34:	01013403          	ld	s0,16(sp)
    80004a38:	00813483          	ld	s1,8(sp)
    80004a3c:	02010113          	addi	sp,sp,32
    80004a40:	00008067          	ret

0000000080004a44 <_ZN16ProducerKeyborad3runEv>:
    void run() override {
    80004a44:	fe010113          	addi	sp,sp,-32
    80004a48:	00113c23          	sd	ra,24(sp)
    80004a4c:	00813823          	sd	s0,16(sp)
    80004a50:	00913423          	sd	s1,8(sp)
    80004a54:	02010413          	addi	s0,sp,32
    80004a58:	00050493          	mv	s1,a0
        while ((key = getc()) != 0x1b) {
    80004a5c:	ffffd097          	auipc	ra,0xffffd
    80004a60:	aa4080e7          	jalr	-1372(ra) # 80001500 <_Z4getcv>
    80004a64:	0005059b          	sext.w	a1,a0
    80004a68:	01b00793          	li	a5,27
    80004a6c:	00f58c63          	beq	a1,a5,80004a84 <_ZN16ProducerKeyborad3runEv+0x40>
            td->buffer->put(key);
    80004a70:	0204b783          	ld	a5,32(s1)
    80004a74:	0087b503          	ld	a0,8(a5)
    80004a78:	00001097          	auipc	ra,0x1
    80004a7c:	36c080e7          	jalr	876(ra) # 80005de4 <_ZN9BufferCPP3putEi>
        while ((key = getc()) != 0x1b) {
    80004a80:	fddff06f          	j	80004a5c <_ZN16ProducerKeyborad3runEv+0x18>
        threadEnd = 1;
    80004a84:	00100793          	li	a5,1
    80004a88:	00007717          	auipc	a4,0x7
    80004a8c:	18f72423          	sw	a5,392(a4) # 8000bc10 <_ZL9threadEnd>
        td->buffer->put('!');
    80004a90:	0204b783          	ld	a5,32(s1)
    80004a94:	02100593          	li	a1,33
    80004a98:	0087b503          	ld	a0,8(a5)
    80004a9c:	00001097          	auipc	ra,0x1
    80004aa0:	348080e7          	jalr	840(ra) # 80005de4 <_ZN9BufferCPP3putEi>
        td->sem->signal();
    80004aa4:	0204b783          	ld	a5,32(s1)
    80004aa8:	0107b503          	ld	a0,16(a5)
    80004aac:	ffffd097          	auipc	ra,0xffffd
    80004ab0:	510080e7          	jalr	1296(ra) # 80001fbc <_ZN9Semaphore6signalEv>
    }
    80004ab4:	01813083          	ld	ra,24(sp)
    80004ab8:	01013403          	ld	s0,16(sp)
    80004abc:	00813483          	ld	s1,8(sp)
    80004ac0:	02010113          	addi	sp,sp,32
    80004ac4:	00008067          	ret

0000000080004ac8 <_ZN8Producer3runEv>:
    void run() override {
    80004ac8:	fe010113          	addi	sp,sp,-32
    80004acc:	00113c23          	sd	ra,24(sp)
    80004ad0:	00813823          	sd	s0,16(sp)
    80004ad4:	00913423          	sd	s1,8(sp)
    80004ad8:	01213023          	sd	s2,0(sp)
    80004adc:	02010413          	addi	s0,sp,32
    80004ae0:	00050493          	mv	s1,a0
        int i = 0;
    80004ae4:	00000913          	li	s2,0
        while (!threadEnd) {
    80004ae8:	00007797          	auipc	a5,0x7
    80004aec:	1287a783          	lw	a5,296(a5) # 8000bc10 <_ZL9threadEnd>
    80004af0:	04079263          	bnez	a5,80004b34 <_ZN8Producer3runEv+0x6c>
            td->buffer->put(td->id + '0');
    80004af4:	0204b783          	ld	a5,32(s1)
    80004af8:	0007a583          	lw	a1,0(a5)
    80004afc:	0305859b          	addiw	a1,a1,48
    80004b00:	0087b503          	ld	a0,8(a5)
    80004b04:	00001097          	auipc	ra,0x1
    80004b08:	2e0080e7          	jalr	736(ra) # 80005de4 <_ZN9BufferCPP3putEi>
            i++;
    80004b0c:	0019071b          	addiw	a4,s2,1
    80004b10:	0007091b          	sext.w	s2,a4
            Thread::sleep((i + td->id) % 5);
    80004b14:	0204b783          	ld	a5,32(s1)
    80004b18:	0007a783          	lw	a5,0(a5)
    80004b1c:	00e787bb          	addw	a5,a5,a4
    80004b20:	00500513          	li	a0,5
    80004b24:	02a7e53b          	remw	a0,a5,a0
    80004b28:	ffffd097          	auipc	ra,0xffffd
    80004b2c:	404080e7          	jalr	1028(ra) # 80001f2c <_ZN6Thread5sleepEm>
        while (!threadEnd) {
    80004b30:	fb9ff06f          	j	80004ae8 <_ZN8Producer3runEv+0x20>
        td->sem->signal();
    80004b34:	0204b783          	ld	a5,32(s1)
    80004b38:	0107b503          	ld	a0,16(a5)
    80004b3c:	ffffd097          	auipc	ra,0xffffd
    80004b40:	480080e7          	jalr	1152(ra) # 80001fbc <_ZN9Semaphore6signalEv>
    }
    80004b44:	01813083          	ld	ra,24(sp)
    80004b48:	01013403          	ld	s0,16(sp)
    80004b4c:	00813483          	ld	s1,8(sp)
    80004b50:	00013903          	ld	s2,0(sp)
    80004b54:	02010113          	addi	sp,sp,32
    80004b58:	00008067          	ret

0000000080004b5c <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80004b5c:	fe010113          	addi	sp,sp,-32
    80004b60:	00113c23          	sd	ra,24(sp)
    80004b64:	00813823          	sd	s0,16(sp)
    80004b68:	00913423          	sd	s1,8(sp)
    80004b6c:	01213023          	sd	s2,0(sp)
    80004b70:	02010413          	addi	s0,sp,32
    80004b74:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80004b78:	00100793          	li	a5,1
    80004b7c:	02a7f863          	bgeu	a5,a0,80004bac <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80004b80:	00a00793          	li	a5,10
    80004b84:	02f577b3          	remu	a5,a0,a5
    80004b88:	02078e63          	beqz	a5,80004bc4 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004b8c:	fff48513          	addi	a0,s1,-1
    80004b90:	00000097          	auipc	ra,0x0
    80004b94:	fcc080e7          	jalr	-52(ra) # 80004b5c <_ZL9fibonaccim>
    80004b98:	00050913          	mv	s2,a0
    80004b9c:	ffe48513          	addi	a0,s1,-2
    80004ba0:	00000097          	auipc	ra,0x0
    80004ba4:	fbc080e7          	jalr	-68(ra) # 80004b5c <_ZL9fibonaccim>
    80004ba8:	00a90533          	add	a0,s2,a0
}
    80004bac:	01813083          	ld	ra,24(sp)
    80004bb0:	01013403          	ld	s0,16(sp)
    80004bb4:	00813483          	ld	s1,8(sp)
    80004bb8:	00013903          	ld	s2,0(sp)
    80004bbc:	02010113          	addi	sp,sp,32
    80004bc0:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004bc4:	ffffc097          	auipc	ra,0xffffc
    80004bc8:	7fc080e7          	jalr	2044(ra) # 800013c0 <_Z15thread_dispatchv>
    80004bcc:	fc1ff06f          	j	80004b8c <_ZL9fibonaccim+0x30>

0000000080004bd0 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80004bd0:	fe010113          	addi	sp,sp,-32
    80004bd4:	00113c23          	sd	ra,24(sp)
    80004bd8:	00813823          	sd	s0,16(sp)
    80004bdc:	00913423          	sd	s1,8(sp)
    80004be0:	01213023          	sd	s2,0(sp)
    80004be4:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80004be8:	00a00493          	li	s1,10
    80004bec:	0400006f          	j	80004c2c <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004bf0:	00004517          	auipc	a0,0x4
    80004bf4:	57850513          	addi	a0,a0,1400 # 80009168 <CONSOLE_STATUS+0x158>
    80004bf8:	00001097          	auipc	ra,0x1
    80004bfc:	dc8080e7          	jalr	-568(ra) # 800059c0 <_Z11printStringPKc>
    80004c00:	00000613          	li	a2,0
    80004c04:	00a00593          	li	a1,10
    80004c08:	00048513          	mv	a0,s1
    80004c0c:	00001097          	auipc	ra,0x1
    80004c10:	f64080e7          	jalr	-156(ra) # 80005b70 <_Z8printIntiii>
    80004c14:	00004517          	auipc	a0,0x4
    80004c18:	74450513          	addi	a0,a0,1860 # 80009358 <CONSOLE_STATUS+0x348>
    80004c1c:	00001097          	auipc	ra,0x1
    80004c20:	da4080e7          	jalr	-604(ra) # 800059c0 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80004c24:	0014849b          	addiw	s1,s1,1
    80004c28:	0ff4f493          	andi	s1,s1,255
    80004c2c:	00c00793          	li	a5,12
    80004c30:	fc97f0e3          	bgeu	a5,s1,80004bf0 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80004c34:	00004517          	auipc	a0,0x4
    80004c38:	53c50513          	addi	a0,a0,1340 # 80009170 <CONSOLE_STATUS+0x160>
    80004c3c:	00001097          	auipc	ra,0x1
    80004c40:	d84080e7          	jalr	-636(ra) # 800059c0 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80004c44:	00500313          	li	t1,5
    thread_dispatch();
    80004c48:	ffffc097          	auipc	ra,0xffffc
    80004c4c:	778080e7          	jalr	1912(ra) # 800013c0 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80004c50:	01000513          	li	a0,16
    80004c54:	00000097          	auipc	ra,0x0
    80004c58:	f08080e7          	jalr	-248(ra) # 80004b5c <_ZL9fibonaccim>
    80004c5c:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80004c60:	00004517          	auipc	a0,0x4
    80004c64:	52050513          	addi	a0,a0,1312 # 80009180 <CONSOLE_STATUS+0x170>
    80004c68:	00001097          	auipc	ra,0x1
    80004c6c:	d58080e7          	jalr	-680(ra) # 800059c0 <_Z11printStringPKc>
    80004c70:	00000613          	li	a2,0
    80004c74:	00a00593          	li	a1,10
    80004c78:	0009051b          	sext.w	a0,s2
    80004c7c:	00001097          	auipc	ra,0x1
    80004c80:	ef4080e7          	jalr	-268(ra) # 80005b70 <_Z8printIntiii>
    80004c84:	00004517          	auipc	a0,0x4
    80004c88:	6d450513          	addi	a0,a0,1748 # 80009358 <CONSOLE_STATUS+0x348>
    80004c8c:	00001097          	auipc	ra,0x1
    80004c90:	d34080e7          	jalr	-716(ra) # 800059c0 <_Z11printStringPKc>
    80004c94:	0400006f          	j	80004cd4 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004c98:	00004517          	auipc	a0,0x4
    80004c9c:	4d050513          	addi	a0,a0,1232 # 80009168 <CONSOLE_STATUS+0x158>
    80004ca0:	00001097          	auipc	ra,0x1
    80004ca4:	d20080e7          	jalr	-736(ra) # 800059c0 <_Z11printStringPKc>
    80004ca8:	00000613          	li	a2,0
    80004cac:	00a00593          	li	a1,10
    80004cb0:	00048513          	mv	a0,s1
    80004cb4:	00001097          	auipc	ra,0x1
    80004cb8:	ebc080e7          	jalr	-324(ra) # 80005b70 <_Z8printIntiii>
    80004cbc:	00004517          	auipc	a0,0x4
    80004cc0:	69c50513          	addi	a0,a0,1692 # 80009358 <CONSOLE_STATUS+0x348>
    80004cc4:	00001097          	auipc	ra,0x1
    80004cc8:	cfc080e7          	jalr	-772(ra) # 800059c0 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80004ccc:	0014849b          	addiw	s1,s1,1
    80004cd0:	0ff4f493          	andi	s1,s1,255
    80004cd4:	00f00793          	li	a5,15
    80004cd8:	fc97f0e3          	bgeu	a5,s1,80004c98 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80004cdc:	00004517          	auipc	a0,0x4
    80004ce0:	4b450513          	addi	a0,a0,1204 # 80009190 <CONSOLE_STATUS+0x180>
    80004ce4:	00001097          	auipc	ra,0x1
    80004ce8:	cdc080e7          	jalr	-804(ra) # 800059c0 <_Z11printStringPKc>
    finishedD = true;
    80004cec:	00100793          	li	a5,1
    80004cf0:	00007717          	auipc	a4,0x7
    80004cf4:	f2f70823          	sb	a5,-208(a4) # 8000bc20 <_ZL9finishedD>
    thread_dispatch();
    80004cf8:	ffffc097          	auipc	ra,0xffffc
    80004cfc:	6c8080e7          	jalr	1736(ra) # 800013c0 <_Z15thread_dispatchv>
}
    80004d00:	01813083          	ld	ra,24(sp)
    80004d04:	01013403          	ld	s0,16(sp)
    80004d08:	00813483          	ld	s1,8(sp)
    80004d0c:	00013903          	ld	s2,0(sp)
    80004d10:	02010113          	addi	sp,sp,32
    80004d14:	00008067          	ret

0000000080004d18 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80004d18:	fe010113          	addi	sp,sp,-32
    80004d1c:	00113c23          	sd	ra,24(sp)
    80004d20:	00813823          	sd	s0,16(sp)
    80004d24:	00913423          	sd	s1,8(sp)
    80004d28:	01213023          	sd	s2,0(sp)
    80004d2c:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80004d30:	00000493          	li	s1,0
    80004d34:	0400006f          	j	80004d74 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80004d38:	00004517          	auipc	a0,0x4
    80004d3c:	40050513          	addi	a0,a0,1024 # 80009138 <CONSOLE_STATUS+0x128>
    80004d40:	00001097          	auipc	ra,0x1
    80004d44:	c80080e7          	jalr	-896(ra) # 800059c0 <_Z11printStringPKc>
    80004d48:	00000613          	li	a2,0
    80004d4c:	00a00593          	li	a1,10
    80004d50:	00048513          	mv	a0,s1
    80004d54:	00001097          	auipc	ra,0x1
    80004d58:	e1c080e7          	jalr	-484(ra) # 80005b70 <_Z8printIntiii>
    80004d5c:	00004517          	auipc	a0,0x4
    80004d60:	5fc50513          	addi	a0,a0,1532 # 80009358 <CONSOLE_STATUS+0x348>
    80004d64:	00001097          	auipc	ra,0x1
    80004d68:	c5c080e7          	jalr	-932(ra) # 800059c0 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80004d6c:	0014849b          	addiw	s1,s1,1
    80004d70:	0ff4f493          	andi	s1,s1,255
    80004d74:	00200793          	li	a5,2
    80004d78:	fc97f0e3          	bgeu	a5,s1,80004d38 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80004d7c:	00004517          	auipc	a0,0x4
    80004d80:	3c450513          	addi	a0,a0,964 # 80009140 <CONSOLE_STATUS+0x130>
    80004d84:	00001097          	auipc	ra,0x1
    80004d88:	c3c080e7          	jalr	-964(ra) # 800059c0 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004d8c:	00700313          	li	t1,7
    thread_dispatch();
    80004d90:	ffffc097          	auipc	ra,0xffffc
    80004d94:	630080e7          	jalr	1584(ra) # 800013c0 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004d98:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80004d9c:	00004517          	auipc	a0,0x4
    80004da0:	3b450513          	addi	a0,a0,948 # 80009150 <CONSOLE_STATUS+0x140>
    80004da4:	00001097          	auipc	ra,0x1
    80004da8:	c1c080e7          	jalr	-996(ra) # 800059c0 <_Z11printStringPKc>
    80004dac:	00000613          	li	a2,0
    80004db0:	00a00593          	li	a1,10
    80004db4:	0009051b          	sext.w	a0,s2
    80004db8:	00001097          	auipc	ra,0x1
    80004dbc:	db8080e7          	jalr	-584(ra) # 80005b70 <_Z8printIntiii>
    80004dc0:	00004517          	auipc	a0,0x4
    80004dc4:	59850513          	addi	a0,a0,1432 # 80009358 <CONSOLE_STATUS+0x348>
    80004dc8:	00001097          	auipc	ra,0x1
    80004dcc:	bf8080e7          	jalr	-1032(ra) # 800059c0 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80004dd0:	00c00513          	li	a0,12
    80004dd4:	00000097          	auipc	ra,0x0
    80004dd8:	d88080e7          	jalr	-632(ra) # 80004b5c <_ZL9fibonaccim>
    80004ddc:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80004de0:	00004517          	auipc	a0,0x4
    80004de4:	37850513          	addi	a0,a0,888 # 80009158 <CONSOLE_STATUS+0x148>
    80004de8:	00001097          	auipc	ra,0x1
    80004dec:	bd8080e7          	jalr	-1064(ra) # 800059c0 <_Z11printStringPKc>
    80004df0:	00000613          	li	a2,0
    80004df4:	00a00593          	li	a1,10
    80004df8:	0009051b          	sext.w	a0,s2
    80004dfc:	00001097          	auipc	ra,0x1
    80004e00:	d74080e7          	jalr	-652(ra) # 80005b70 <_Z8printIntiii>
    80004e04:	00004517          	auipc	a0,0x4
    80004e08:	55450513          	addi	a0,a0,1364 # 80009358 <CONSOLE_STATUS+0x348>
    80004e0c:	00001097          	auipc	ra,0x1
    80004e10:	bb4080e7          	jalr	-1100(ra) # 800059c0 <_Z11printStringPKc>
    80004e14:	0400006f          	j	80004e54 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80004e18:	00004517          	auipc	a0,0x4
    80004e1c:	32050513          	addi	a0,a0,800 # 80009138 <CONSOLE_STATUS+0x128>
    80004e20:	00001097          	auipc	ra,0x1
    80004e24:	ba0080e7          	jalr	-1120(ra) # 800059c0 <_Z11printStringPKc>
    80004e28:	00000613          	li	a2,0
    80004e2c:	00a00593          	li	a1,10
    80004e30:	00048513          	mv	a0,s1
    80004e34:	00001097          	auipc	ra,0x1
    80004e38:	d3c080e7          	jalr	-708(ra) # 80005b70 <_Z8printIntiii>
    80004e3c:	00004517          	auipc	a0,0x4
    80004e40:	51c50513          	addi	a0,a0,1308 # 80009358 <CONSOLE_STATUS+0x348>
    80004e44:	00001097          	auipc	ra,0x1
    80004e48:	b7c080e7          	jalr	-1156(ra) # 800059c0 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004e4c:	0014849b          	addiw	s1,s1,1
    80004e50:	0ff4f493          	andi	s1,s1,255
    80004e54:	00500793          	li	a5,5
    80004e58:	fc97f0e3          	bgeu	a5,s1,80004e18 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80004e5c:	00004517          	auipc	a0,0x4
    80004e60:	2b450513          	addi	a0,a0,692 # 80009110 <CONSOLE_STATUS+0x100>
    80004e64:	00001097          	auipc	ra,0x1
    80004e68:	b5c080e7          	jalr	-1188(ra) # 800059c0 <_Z11printStringPKc>
    finishedC = true;
    80004e6c:	00100793          	li	a5,1
    80004e70:	00007717          	auipc	a4,0x7
    80004e74:	daf708a3          	sb	a5,-591(a4) # 8000bc21 <_ZL9finishedC>
    thread_dispatch();
    80004e78:	ffffc097          	auipc	ra,0xffffc
    80004e7c:	548080e7          	jalr	1352(ra) # 800013c0 <_Z15thread_dispatchv>
}
    80004e80:	01813083          	ld	ra,24(sp)
    80004e84:	01013403          	ld	s0,16(sp)
    80004e88:	00813483          	ld	s1,8(sp)
    80004e8c:	00013903          	ld	s2,0(sp)
    80004e90:	02010113          	addi	sp,sp,32
    80004e94:	00008067          	ret

0000000080004e98 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80004e98:	fe010113          	addi	sp,sp,-32
    80004e9c:	00113c23          	sd	ra,24(sp)
    80004ea0:	00813823          	sd	s0,16(sp)
    80004ea4:	00913423          	sd	s1,8(sp)
    80004ea8:	01213023          	sd	s2,0(sp)
    80004eac:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80004eb0:	00000913          	li	s2,0
    80004eb4:	0380006f          	j	80004eec <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80004eb8:	ffffc097          	auipc	ra,0xffffc
    80004ebc:	508080e7          	jalr	1288(ra) # 800013c0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004ec0:	00148493          	addi	s1,s1,1
    80004ec4:	000027b7          	lui	a5,0x2
    80004ec8:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004ecc:	0097ee63          	bltu	a5,s1,80004ee8 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004ed0:	00000713          	li	a4,0
    80004ed4:	000077b7          	lui	a5,0x7
    80004ed8:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004edc:	fce7eee3          	bltu	a5,a4,80004eb8 <_ZL11workerBodyBPv+0x20>
    80004ee0:	00170713          	addi	a4,a4,1
    80004ee4:	ff1ff06f          	j	80004ed4 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80004ee8:	00190913          	addi	s2,s2,1
    80004eec:	00f00793          	li	a5,15
    80004ef0:	0527e063          	bltu	a5,s2,80004f30 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80004ef4:	00004517          	auipc	a0,0x4
    80004ef8:	22c50513          	addi	a0,a0,556 # 80009120 <CONSOLE_STATUS+0x110>
    80004efc:	00001097          	auipc	ra,0x1
    80004f00:	ac4080e7          	jalr	-1340(ra) # 800059c0 <_Z11printStringPKc>
    80004f04:	00000613          	li	a2,0
    80004f08:	00a00593          	li	a1,10
    80004f0c:	0009051b          	sext.w	a0,s2
    80004f10:	00001097          	auipc	ra,0x1
    80004f14:	c60080e7          	jalr	-928(ra) # 80005b70 <_Z8printIntiii>
    80004f18:	00004517          	auipc	a0,0x4
    80004f1c:	44050513          	addi	a0,a0,1088 # 80009358 <CONSOLE_STATUS+0x348>
    80004f20:	00001097          	auipc	ra,0x1
    80004f24:	aa0080e7          	jalr	-1376(ra) # 800059c0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004f28:	00000493          	li	s1,0
    80004f2c:	f99ff06f          	j	80004ec4 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80004f30:	00004517          	auipc	a0,0x4
    80004f34:	1f850513          	addi	a0,a0,504 # 80009128 <CONSOLE_STATUS+0x118>
    80004f38:	00001097          	auipc	ra,0x1
    80004f3c:	a88080e7          	jalr	-1400(ra) # 800059c0 <_Z11printStringPKc>
    finishedB = true;
    80004f40:	00100793          	li	a5,1
    80004f44:	00007717          	auipc	a4,0x7
    80004f48:	ccf70f23          	sb	a5,-802(a4) # 8000bc22 <_ZL9finishedB>
    thread_dispatch();
    80004f4c:	ffffc097          	auipc	ra,0xffffc
    80004f50:	474080e7          	jalr	1140(ra) # 800013c0 <_Z15thread_dispatchv>
}
    80004f54:	01813083          	ld	ra,24(sp)
    80004f58:	01013403          	ld	s0,16(sp)
    80004f5c:	00813483          	ld	s1,8(sp)
    80004f60:	00013903          	ld	s2,0(sp)
    80004f64:	02010113          	addi	sp,sp,32
    80004f68:	00008067          	ret

0000000080004f6c <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80004f6c:	fe010113          	addi	sp,sp,-32
    80004f70:	00113c23          	sd	ra,24(sp)
    80004f74:	00813823          	sd	s0,16(sp)
    80004f78:	00913423          	sd	s1,8(sp)
    80004f7c:	01213023          	sd	s2,0(sp)
    80004f80:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80004f84:	00000913          	li	s2,0
    80004f88:	0380006f          	j	80004fc0 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80004f8c:	ffffc097          	auipc	ra,0xffffc
    80004f90:	434080e7          	jalr	1076(ra) # 800013c0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004f94:	00148493          	addi	s1,s1,1
    80004f98:	000027b7          	lui	a5,0x2
    80004f9c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004fa0:	0097ee63          	bltu	a5,s1,80004fbc <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004fa4:	00000713          	li	a4,0
    80004fa8:	000077b7          	lui	a5,0x7
    80004fac:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004fb0:	fce7eee3          	bltu	a5,a4,80004f8c <_ZL11workerBodyAPv+0x20>
    80004fb4:	00170713          	addi	a4,a4,1
    80004fb8:	ff1ff06f          	j	80004fa8 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004fbc:	00190913          	addi	s2,s2,1
    80004fc0:	00900793          	li	a5,9
    80004fc4:	0527e063          	bltu	a5,s2,80005004 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80004fc8:	00004517          	auipc	a0,0x4
    80004fcc:	14050513          	addi	a0,a0,320 # 80009108 <CONSOLE_STATUS+0xf8>
    80004fd0:	00001097          	auipc	ra,0x1
    80004fd4:	9f0080e7          	jalr	-1552(ra) # 800059c0 <_Z11printStringPKc>
    80004fd8:	00000613          	li	a2,0
    80004fdc:	00a00593          	li	a1,10
    80004fe0:	0009051b          	sext.w	a0,s2
    80004fe4:	00001097          	auipc	ra,0x1
    80004fe8:	b8c080e7          	jalr	-1140(ra) # 80005b70 <_Z8printIntiii>
    80004fec:	00004517          	auipc	a0,0x4
    80004ff0:	36c50513          	addi	a0,a0,876 # 80009358 <CONSOLE_STATUS+0x348>
    80004ff4:	00001097          	auipc	ra,0x1
    80004ff8:	9cc080e7          	jalr	-1588(ra) # 800059c0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80004ffc:	00000493          	li	s1,0
    80005000:	f99ff06f          	j	80004f98 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80005004:	00004517          	auipc	a0,0x4
    80005008:	10c50513          	addi	a0,a0,268 # 80009110 <CONSOLE_STATUS+0x100>
    8000500c:	00001097          	auipc	ra,0x1
    80005010:	9b4080e7          	jalr	-1612(ra) # 800059c0 <_Z11printStringPKc>
    finishedA = true;
    80005014:	00100793          	li	a5,1
    80005018:	00007717          	auipc	a4,0x7
    8000501c:	c0f705a3          	sb	a5,-1013(a4) # 8000bc23 <_ZL9finishedA>
}
    80005020:	01813083          	ld	ra,24(sp)
    80005024:	01013403          	ld	s0,16(sp)
    80005028:	00813483          	ld	s1,8(sp)
    8000502c:	00013903          	ld	s2,0(sp)
    80005030:	02010113          	addi	sp,sp,32
    80005034:	00008067          	ret

0000000080005038 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80005038:	fd010113          	addi	sp,sp,-48
    8000503c:	02113423          	sd	ra,40(sp)
    80005040:	02813023          	sd	s0,32(sp)
    80005044:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80005048:	00000613          	li	a2,0
    8000504c:	00000597          	auipc	a1,0x0
    80005050:	f2058593          	addi	a1,a1,-224 # 80004f6c <_ZL11workerBodyAPv>
    80005054:	fd040513          	addi	a0,s0,-48
    80005058:	ffffc097          	auipc	ra,0xffffc
    8000505c:	280080e7          	jalr	640(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    80005060:	00004517          	auipc	a0,0x4
    80005064:	14050513          	addi	a0,a0,320 # 800091a0 <CONSOLE_STATUS+0x190>
    80005068:	00001097          	auipc	ra,0x1
    8000506c:	958080e7          	jalr	-1704(ra) # 800059c0 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80005070:	00000613          	li	a2,0
    80005074:	00000597          	auipc	a1,0x0
    80005078:	e2458593          	addi	a1,a1,-476 # 80004e98 <_ZL11workerBodyBPv>
    8000507c:	fd840513          	addi	a0,s0,-40
    80005080:	ffffc097          	auipc	ra,0xffffc
    80005084:	258080e7          	jalr	600(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    80005088:	00004517          	auipc	a0,0x4
    8000508c:	13050513          	addi	a0,a0,304 # 800091b8 <CONSOLE_STATUS+0x1a8>
    80005090:	00001097          	auipc	ra,0x1
    80005094:	930080e7          	jalr	-1744(ra) # 800059c0 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80005098:	00000613          	li	a2,0
    8000509c:	00000597          	auipc	a1,0x0
    800050a0:	c7c58593          	addi	a1,a1,-900 # 80004d18 <_ZL11workerBodyCPv>
    800050a4:	fe040513          	addi	a0,s0,-32
    800050a8:	ffffc097          	auipc	ra,0xffffc
    800050ac:	230080e7          	jalr	560(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    800050b0:	00004517          	auipc	a0,0x4
    800050b4:	12050513          	addi	a0,a0,288 # 800091d0 <CONSOLE_STATUS+0x1c0>
    800050b8:	00001097          	auipc	ra,0x1
    800050bc:	908080e7          	jalr	-1784(ra) # 800059c0 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    800050c0:	00000613          	li	a2,0
    800050c4:	00000597          	auipc	a1,0x0
    800050c8:	b0c58593          	addi	a1,a1,-1268 # 80004bd0 <_ZL11workerBodyDPv>
    800050cc:	fe840513          	addi	a0,s0,-24
    800050d0:	ffffc097          	auipc	ra,0xffffc
    800050d4:	208080e7          	jalr	520(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    800050d8:	00004517          	auipc	a0,0x4
    800050dc:	11050513          	addi	a0,a0,272 # 800091e8 <CONSOLE_STATUS+0x1d8>
    800050e0:	00001097          	auipc	ra,0x1
    800050e4:	8e0080e7          	jalr	-1824(ra) # 800059c0 <_Z11printStringPKc>
    800050e8:	00c0006f          	j	800050f4 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800050ec:	ffffc097          	auipc	ra,0xffffc
    800050f0:	2d4080e7          	jalr	724(ra) # 800013c0 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800050f4:	00007797          	auipc	a5,0x7
    800050f8:	b2f7c783          	lbu	a5,-1233(a5) # 8000bc23 <_ZL9finishedA>
    800050fc:	fe0788e3          	beqz	a5,800050ec <_Z18Threads_C_API_testv+0xb4>
    80005100:	00007797          	auipc	a5,0x7
    80005104:	b227c783          	lbu	a5,-1246(a5) # 8000bc22 <_ZL9finishedB>
    80005108:	fe0782e3          	beqz	a5,800050ec <_Z18Threads_C_API_testv+0xb4>
    8000510c:	00007797          	auipc	a5,0x7
    80005110:	b157c783          	lbu	a5,-1259(a5) # 8000bc21 <_ZL9finishedC>
    80005114:	fc078ce3          	beqz	a5,800050ec <_Z18Threads_C_API_testv+0xb4>
    80005118:	00007797          	auipc	a5,0x7
    8000511c:	b087c783          	lbu	a5,-1272(a5) # 8000bc20 <_ZL9finishedD>
    80005120:	fc0786e3          	beqz	a5,800050ec <_Z18Threads_C_API_testv+0xb4>
    }

}
    80005124:	02813083          	ld	ra,40(sp)
    80005128:	02013403          	ld	s0,32(sp)
    8000512c:	03010113          	addi	sp,sp,48
    80005130:	00008067          	ret

0000000080005134 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80005134:	fd010113          	addi	sp,sp,-48
    80005138:	02113423          	sd	ra,40(sp)
    8000513c:	02813023          	sd	s0,32(sp)
    80005140:	00913c23          	sd	s1,24(sp)
    80005144:	01213823          	sd	s2,16(sp)
    80005148:	01313423          	sd	s3,8(sp)
    8000514c:	03010413          	addi	s0,sp,48
    80005150:	00050993          	mv	s3,a0
    80005154:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80005158:	00000913          	li	s2,0
    8000515c:	00c0006f          	j	80005168 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80005160:	ffffd097          	auipc	ra,0xffffd
    80005164:	d38080e7          	jalr	-712(ra) # 80001e98 <_ZN6Thread8dispatchEv>
    while ((key = getc()) != 0x1b) {
    80005168:	ffffc097          	auipc	ra,0xffffc
    8000516c:	398080e7          	jalr	920(ra) # 80001500 <_Z4getcv>
    80005170:	0005059b          	sext.w	a1,a0
    80005174:	01b00793          	li	a5,27
    80005178:	02f58a63          	beq	a1,a5,800051ac <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    8000517c:	0084b503          	ld	a0,8(s1)
    80005180:	00001097          	auipc	ra,0x1
    80005184:	c64080e7          	jalr	-924(ra) # 80005de4 <_ZN9BufferCPP3putEi>
        i++;
    80005188:	0019071b          	addiw	a4,s2,1
    8000518c:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80005190:	0004a683          	lw	a3,0(s1)
    80005194:	0026979b          	slliw	a5,a3,0x2
    80005198:	00d787bb          	addw	a5,a5,a3
    8000519c:	0017979b          	slliw	a5,a5,0x1
    800051a0:	02f767bb          	remw	a5,a4,a5
    800051a4:	fc0792e3          	bnez	a5,80005168 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    800051a8:	fb9ff06f          	j	80005160 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
        }
    }

    threadEnd = 1;
    800051ac:	00100793          	li	a5,1
    800051b0:	00007717          	auipc	a4,0x7
    800051b4:	a6f72c23          	sw	a5,-1416(a4) # 8000bc28 <_ZL9threadEnd>
    td->buffer->put('!');
    800051b8:	0209b783          	ld	a5,32(s3)
    800051bc:	02100593          	li	a1,33
    800051c0:	0087b503          	ld	a0,8(a5)
    800051c4:	00001097          	auipc	ra,0x1
    800051c8:	c20080e7          	jalr	-992(ra) # 80005de4 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    800051cc:	0104b503          	ld	a0,16(s1)
    800051d0:	ffffd097          	auipc	ra,0xffffd
    800051d4:	dec080e7          	jalr	-532(ra) # 80001fbc <_ZN9Semaphore6signalEv>
}
    800051d8:	02813083          	ld	ra,40(sp)
    800051dc:	02013403          	ld	s0,32(sp)
    800051e0:	01813483          	ld	s1,24(sp)
    800051e4:	01013903          	ld	s2,16(sp)
    800051e8:	00813983          	ld	s3,8(sp)
    800051ec:	03010113          	addi	sp,sp,48
    800051f0:	00008067          	ret

00000000800051f4 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    800051f4:	fe010113          	addi	sp,sp,-32
    800051f8:	00113c23          	sd	ra,24(sp)
    800051fc:	00813823          	sd	s0,16(sp)
    80005200:	00913423          	sd	s1,8(sp)
    80005204:	01213023          	sd	s2,0(sp)
    80005208:	02010413          	addi	s0,sp,32
    8000520c:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80005210:	00000913          	li	s2,0
    80005214:	00c0006f          	j	80005220 <_ZN12ProducerSync8producerEPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            Thread::dispatch();
    80005218:	ffffd097          	auipc	ra,0xffffd
    8000521c:	c80080e7          	jalr	-896(ra) # 80001e98 <_ZN6Thread8dispatchEv>
    while (!threadEnd) {
    80005220:	00007797          	auipc	a5,0x7
    80005224:	a087a783          	lw	a5,-1528(a5) # 8000bc28 <_ZL9threadEnd>
    80005228:	02079e63          	bnez	a5,80005264 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    8000522c:	0004a583          	lw	a1,0(s1)
    80005230:	0305859b          	addiw	a1,a1,48
    80005234:	0084b503          	ld	a0,8(s1)
    80005238:	00001097          	auipc	ra,0x1
    8000523c:	bac080e7          	jalr	-1108(ra) # 80005de4 <_ZN9BufferCPP3putEi>
        i++;
    80005240:	0019071b          	addiw	a4,s2,1
    80005244:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80005248:	0004a683          	lw	a3,0(s1)
    8000524c:	0026979b          	slliw	a5,a3,0x2
    80005250:	00d787bb          	addw	a5,a5,a3
    80005254:	0017979b          	slliw	a5,a5,0x1
    80005258:	02f767bb          	remw	a5,a4,a5
    8000525c:	fc0792e3          	bnez	a5,80005220 <_ZN12ProducerSync8producerEPv+0x2c>
    80005260:	fb9ff06f          	j	80005218 <_ZN12ProducerSync8producerEPv+0x24>
        }
    }

    data->wait->signal();
    80005264:	0104b503          	ld	a0,16(s1)
    80005268:	ffffd097          	auipc	ra,0xffffd
    8000526c:	d54080e7          	jalr	-684(ra) # 80001fbc <_ZN9Semaphore6signalEv>
}
    80005270:	01813083          	ld	ra,24(sp)
    80005274:	01013403          	ld	s0,16(sp)
    80005278:	00813483          	ld	s1,8(sp)
    8000527c:	00013903          	ld	s2,0(sp)
    80005280:	02010113          	addi	sp,sp,32
    80005284:	00008067          	ret

0000000080005288 <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    80005288:	fd010113          	addi	sp,sp,-48
    8000528c:	02113423          	sd	ra,40(sp)
    80005290:	02813023          	sd	s0,32(sp)
    80005294:	00913c23          	sd	s1,24(sp)
    80005298:	01213823          	sd	s2,16(sp)
    8000529c:	01313423          	sd	s3,8(sp)
    800052a0:	01413023          	sd	s4,0(sp)
    800052a4:	03010413          	addi	s0,sp,48
    800052a8:	00050993          	mv	s3,a0
    800052ac:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800052b0:	00000a13          	li	s4,0
    800052b4:	01c0006f          	j	800052d0 <_ZN12ConsumerSync8consumerEPv+0x48>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
    800052b8:	ffffd097          	auipc	ra,0xffffd
    800052bc:	be0080e7          	jalr	-1056(ra) # 80001e98 <_ZN6Thread8dispatchEv>
    800052c0:	0500006f          	j	80005310 <_ZN12ConsumerSync8consumerEPv+0x88>
        }

        if (i % 80 == 0) {
            putc('\n');
    800052c4:	00a00513          	li	a0,10
    800052c8:	ffffc097          	auipc	ra,0xffffc
    800052cc:	25c080e7          	jalr	604(ra) # 80001524 <_Z4putcc>
    while (!threadEnd) {
    800052d0:	00007797          	auipc	a5,0x7
    800052d4:	9587a783          	lw	a5,-1704(a5) # 8000bc28 <_ZL9threadEnd>
    800052d8:	06079263          	bnez	a5,8000533c <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    800052dc:	00893503          	ld	a0,8(s2)
    800052e0:	00001097          	auipc	ra,0x1
    800052e4:	b94080e7          	jalr	-1132(ra) # 80005e74 <_ZN9BufferCPP3getEv>
        i++;
    800052e8:	001a049b          	addiw	s1,s4,1
    800052ec:	00048a1b          	sext.w	s4,s1
        putc(key);
    800052f0:	0ff57513          	andi	a0,a0,255
    800052f4:	ffffc097          	auipc	ra,0xffffc
    800052f8:	230080e7          	jalr	560(ra) # 80001524 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800052fc:	00092703          	lw	a4,0(s2)
    80005300:	0027179b          	slliw	a5,a4,0x2
    80005304:	00e787bb          	addw	a5,a5,a4
    80005308:	02f4e7bb          	remw	a5,s1,a5
    8000530c:	fa0786e3          	beqz	a5,800052b8 <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80005310:	05000793          	li	a5,80
    80005314:	02f4e4bb          	remw	s1,s1,a5
    80005318:	fa049ce3          	bnez	s1,800052d0 <_ZN12ConsumerSync8consumerEPv+0x48>
    8000531c:	fa9ff06f          	j	800052c4 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80005320:	0209b783          	ld	a5,32(s3)
    80005324:	0087b503          	ld	a0,8(a5)
    80005328:	00001097          	auipc	ra,0x1
    8000532c:	b4c080e7          	jalr	-1204(ra) # 80005e74 <_ZN9BufferCPP3getEv>
        Console::putc(key);
    80005330:	0ff57513          	andi	a0,a0,255
    80005334:	ffffd097          	auipc	ra,0xffffd
    80005338:	d50080e7          	jalr	-688(ra) # 80002084 <_ZN7Console4putcEc>
    while (td->buffer->getCnt() > 0) {
    8000533c:	0209b783          	ld	a5,32(s3)
    80005340:	0087b503          	ld	a0,8(a5)
    80005344:	00001097          	auipc	ra,0x1
    80005348:	bbc080e7          	jalr	-1092(ra) # 80005f00 <_ZN9BufferCPP6getCntEv>
    8000534c:	fca04ae3          	bgtz	a0,80005320 <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    80005350:	01093503          	ld	a0,16(s2)
    80005354:	ffffd097          	auipc	ra,0xffffd
    80005358:	c68080e7          	jalr	-920(ra) # 80001fbc <_ZN9Semaphore6signalEv>
}
    8000535c:	02813083          	ld	ra,40(sp)
    80005360:	02013403          	ld	s0,32(sp)
    80005364:	01813483          	ld	s1,24(sp)
    80005368:	01013903          	ld	s2,16(sp)
    8000536c:	00813983          	ld	s3,8(sp)
    80005370:	00013a03          	ld	s4,0(sp)
    80005374:	03010113          	addi	sp,sp,48
    80005378:	00008067          	ret

000000008000537c <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    8000537c:	f8010113          	addi	sp,sp,-128
    80005380:	06113c23          	sd	ra,120(sp)
    80005384:	06813823          	sd	s0,112(sp)
    80005388:	06913423          	sd	s1,104(sp)
    8000538c:	07213023          	sd	s2,96(sp)
    80005390:	05313c23          	sd	s3,88(sp)
    80005394:	05413823          	sd	s4,80(sp)
    80005398:	05513423          	sd	s5,72(sp)
    8000539c:	05613023          	sd	s6,64(sp)
    800053a0:	03713c23          	sd	s7,56(sp)
    800053a4:	03813823          	sd	s8,48(sp)
    800053a8:	03913423          	sd	s9,40(sp)
    800053ac:	08010413          	addi	s0,sp,128
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    800053b0:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    800053b4:	00004517          	auipc	a0,0x4
    800053b8:	c6c50513          	addi	a0,a0,-916 # 80009020 <CONSOLE_STATUS+0x10>
    800053bc:	00000097          	auipc	ra,0x0
    800053c0:	604080e7          	jalr	1540(ra) # 800059c0 <_Z11printStringPKc>
    getString(input, 30);
    800053c4:	01e00593          	li	a1,30
    800053c8:	f8040493          	addi	s1,s0,-128
    800053cc:	00048513          	mv	a0,s1
    800053d0:	00000097          	auipc	ra,0x0
    800053d4:	678080e7          	jalr	1656(ra) # 80005a48 <_Z9getStringPci>
    threadNum = stringToInt(input);
    800053d8:	00048513          	mv	a0,s1
    800053dc:	00000097          	auipc	ra,0x0
    800053e0:	744080e7          	jalr	1860(ra) # 80005b20 <_Z11stringToIntPKc>
    800053e4:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    800053e8:	00004517          	auipc	a0,0x4
    800053ec:	c5850513          	addi	a0,a0,-936 # 80009040 <CONSOLE_STATUS+0x30>
    800053f0:	00000097          	auipc	ra,0x0
    800053f4:	5d0080e7          	jalr	1488(ra) # 800059c0 <_Z11printStringPKc>
    getString(input, 30);
    800053f8:	01e00593          	li	a1,30
    800053fc:	00048513          	mv	a0,s1
    80005400:	00000097          	auipc	ra,0x0
    80005404:	648080e7          	jalr	1608(ra) # 80005a48 <_Z9getStringPci>
    n = stringToInt(input);
    80005408:	00048513          	mv	a0,s1
    8000540c:	00000097          	auipc	ra,0x0
    80005410:	714080e7          	jalr	1812(ra) # 80005b20 <_Z11stringToIntPKc>
    80005414:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80005418:	00004517          	auipc	a0,0x4
    8000541c:	c4850513          	addi	a0,a0,-952 # 80009060 <CONSOLE_STATUS+0x50>
    80005420:	00000097          	auipc	ra,0x0
    80005424:	5a0080e7          	jalr	1440(ra) # 800059c0 <_Z11printStringPKc>
    80005428:	00000613          	li	a2,0
    8000542c:	00a00593          	li	a1,10
    80005430:	00090513          	mv	a0,s2
    80005434:	00000097          	auipc	ra,0x0
    80005438:	73c080e7          	jalr	1852(ra) # 80005b70 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    8000543c:	00004517          	auipc	a0,0x4
    80005440:	c3c50513          	addi	a0,a0,-964 # 80009078 <CONSOLE_STATUS+0x68>
    80005444:	00000097          	auipc	ra,0x0
    80005448:	57c080e7          	jalr	1404(ra) # 800059c0 <_Z11printStringPKc>
    8000544c:	00000613          	li	a2,0
    80005450:	00a00593          	li	a1,10
    80005454:	00048513          	mv	a0,s1
    80005458:	00000097          	auipc	ra,0x0
    8000545c:	718080e7          	jalr	1816(ra) # 80005b70 <_Z8printIntiii>
    printString(".\n");
    80005460:	00004517          	auipc	a0,0x4
    80005464:	c3050513          	addi	a0,a0,-976 # 80009090 <CONSOLE_STATUS+0x80>
    80005468:	00000097          	auipc	ra,0x0
    8000546c:	558080e7          	jalr	1368(ra) # 800059c0 <_Z11printStringPKc>
    if(threadNum > n) {
    80005470:	0324c463          	blt	s1,s2,80005498 <_Z29producerConsumer_CPP_Sync_APIv+0x11c>
    } else if (threadNum < 1) {
    80005474:	03205c63          	blez	s2,800054ac <_Z29producerConsumer_CPP_Sync_APIv+0x130>
    BufferCPP *buffer = new BufferCPP(n);
    80005478:	03800513          	li	a0,56
    8000547c:	ffffc097          	auipc	ra,0xffffc
    80005480:	0f4080e7          	jalr	244(ra) # 80001570 <_Znwm>
    80005484:	00050a93          	mv	s5,a0
    80005488:	00048593          	mv	a1,s1
    8000548c:	00001097          	auipc	ra,0x1
    80005490:	804080e7          	jalr	-2044(ra) # 80005c90 <_ZN9BufferCPPC1Ei>
    80005494:	0300006f          	j	800054c4 <_Z29producerConsumer_CPP_Sync_APIv+0x148>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80005498:	00004517          	auipc	a0,0x4
    8000549c:	c0050513          	addi	a0,a0,-1024 # 80009098 <CONSOLE_STATUS+0x88>
    800054a0:	00000097          	auipc	ra,0x0
    800054a4:	520080e7          	jalr	1312(ra) # 800059c0 <_Z11printStringPKc>
        return;
    800054a8:	0140006f          	j	800054bc <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    800054ac:	00004517          	auipc	a0,0x4
    800054b0:	c2c50513          	addi	a0,a0,-980 # 800090d8 <CONSOLE_STATUS+0xc8>
    800054b4:	00000097          	auipc	ra,0x0
    800054b8:	50c080e7          	jalr	1292(ra) # 800059c0 <_Z11printStringPKc>
        return;
    800054bc:	000b8113          	mv	sp,s7
    800054c0:	2380006f          	j	800056f8 <_Z29producerConsumer_CPP_Sync_APIv+0x37c>
    waitForAll = new Semaphore(0);
    800054c4:	01000513          	li	a0,16
    800054c8:	ffffc097          	auipc	ra,0xffffc
    800054cc:	0a8080e7          	jalr	168(ra) # 80001570 <_Znwm>
    800054d0:	00050493          	mv	s1,a0
    800054d4:	00000593          	li	a1,0
    800054d8:	ffffd097          	auipc	ra,0xffffd
    800054dc:	a7c080e7          	jalr	-1412(ra) # 80001f54 <_ZN9SemaphoreC1Ej>
    800054e0:	00006797          	auipc	a5,0x6
    800054e4:	7497b823          	sd	s1,1872(a5) # 8000bc30 <_ZL10waitForAll>
    Thread* threads[threadNum];
    800054e8:	00391793          	slli	a5,s2,0x3
    800054ec:	00f78793          	addi	a5,a5,15
    800054f0:	ff07f793          	andi	a5,a5,-16
    800054f4:	40f10133          	sub	sp,sp,a5
    800054f8:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    800054fc:	0019071b          	addiw	a4,s2,1
    80005500:	00171793          	slli	a5,a4,0x1
    80005504:	00e787b3          	add	a5,a5,a4
    80005508:	00379793          	slli	a5,a5,0x3
    8000550c:	00f78793          	addi	a5,a5,15
    80005510:	ff07f793          	andi	a5,a5,-16
    80005514:	40f10133          	sub	sp,sp,a5
    80005518:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    8000551c:	00191c13          	slli	s8,s2,0x1
    80005520:	012c07b3          	add	a5,s8,s2
    80005524:	00379793          	slli	a5,a5,0x3
    80005528:	00fa07b3          	add	a5,s4,a5
    8000552c:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    80005530:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    80005534:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    80005538:	02800513          	li	a0,40
    8000553c:	ffffc097          	auipc	ra,0xffffc
    80005540:	034080e7          	jalr	52(ra) # 80001570 <_Znwm>
    80005544:	00050b13          	mv	s6,a0
    80005548:	012c0c33          	add	s8,s8,s2
    8000554c:	003c1c13          	slli	s8,s8,0x3
    80005550:	018a0c33          	add	s8,s4,s8
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    80005554:	ffffd097          	auipc	ra,0xffffd
    80005558:	8c0080e7          	jalr	-1856(ra) # 80001e14 <_ZN6ThreadC1Ev>
    8000555c:	00006797          	auipc	a5,0x6
    80005560:	51478793          	addi	a5,a5,1300 # 8000ba70 <_ZTV12ConsumerSync+0x10>
    80005564:	00fb3023          	sd	a5,0(s6)
    80005568:	038b3023          	sd	s8,32(s6)
    consumerThread->start();
    8000556c:	000b0513          	mv	a0,s6
    80005570:	ffffd097          	auipc	ra,0xffffd
    80005574:	8d4080e7          	jalr	-1836(ra) # 80001e44 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    80005578:	00000493          	li	s1,0
    8000557c:	0380006f          	j	800055b4 <_Z29producerConsumer_CPP_Sync_APIv+0x238>
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80005580:	00006797          	auipc	a5,0x6
    80005584:	4c878793          	addi	a5,a5,1224 # 8000ba48 <_ZTV12ProducerSync+0x10>
    80005588:	00fcb023          	sd	a5,0(s9)
    8000558c:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerSync(data+i);
    80005590:	00349793          	slli	a5,s1,0x3
    80005594:	00f987b3          	add	a5,s3,a5
    80005598:	0197b023          	sd	s9,0(a5)
        threads[i]->start();
    8000559c:	00349793          	slli	a5,s1,0x3
    800055a0:	00f987b3          	add	a5,s3,a5
    800055a4:	0007b503          	ld	a0,0(a5)
    800055a8:	ffffd097          	auipc	ra,0xffffd
    800055ac:	89c080e7          	jalr	-1892(ra) # 80001e44 <_ZN6Thread5startEv>
    for (int i = 0; i < threadNum; i++) {
    800055b0:	0014849b          	addiw	s1,s1,1
    800055b4:	0b24d063          	bge	s1,s2,80005654 <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
        data[i].id = i;
    800055b8:	00149793          	slli	a5,s1,0x1
    800055bc:	009787b3          	add	a5,a5,s1
    800055c0:	00379793          	slli	a5,a5,0x3
    800055c4:	00fa07b3          	add	a5,s4,a5
    800055c8:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    800055cc:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    800055d0:	00006717          	auipc	a4,0x6
    800055d4:	66073703          	ld	a4,1632(a4) # 8000bc30 <_ZL10waitForAll>
    800055d8:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    800055dc:	02905863          	blez	s1,8000560c <_Z29producerConsumer_CPP_Sync_APIv+0x290>
            threads[i] = new ProducerSync(data+i);
    800055e0:	02800513          	li	a0,40
    800055e4:	ffffc097          	auipc	ra,0xffffc
    800055e8:	f8c080e7          	jalr	-116(ra) # 80001570 <_Znwm>
    800055ec:	00050c93          	mv	s9,a0
    800055f0:	00149c13          	slli	s8,s1,0x1
    800055f4:	009c0c33          	add	s8,s8,s1
    800055f8:	003c1c13          	slli	s8,s8,0x3
    800055fc:	018a0c33          	add	s8,s4,s8
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    80005600:	ffffd097          	auipc	ra,0xffffd
    80005604:	814080e7          	jalr	-2028(ra) # 80001e14 <_ZN6ThreadC1Ev>
    80005608:	f79ff06f          	j	80005580 <_Z29producerConsumer_CPP_Sync_APIv+0x204>
            threads[i] = new ProducerKeyboard(data+i);
    8000560c:	02800513          	li	a0,40
    80005610:	ffffc097          	auipc	ra,0xffffc
    80005614:	f60080e7          	jalr	-160(ra) # 80001570 <_Znwm>
    80005618:	00050c93          	mv	s9,a0
    8000561c:	00149c13          	slli	s8,s1,0x1
    80005620:	009c0c33          	add	s8,s8,s1
    80005624:	003c1c13          	slli	s8,s8,0x3
    80005628:	018a0c33          	add	s8,s4,s8
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    8000562c:	ffffc097          	auipc	ra,0xffffc
    80005630:	7e8080e7          	jalr	2024(ra) # 80001e14 <_ZN6ThreadC1Ev>
    80005634:	00006797          	auipc	a5,0x6
    80005638:	3ec78793          	addi	a5,a5,1004 # 8000ba20 <_ZTV16ProducerKeyboard+0x10>
    8000563c:	00fcb023          	sd	a5,0(s9)
    80005640:	038cb023          	sd	s8,32(s9)
            threads[i] = new ProducerKeyboard(data+i);
    80005644:	00349793          	slli	a5,s1,0x3
    80005648:	00f987b3          	add	a5,s3,a5
    8000564c:	0197b023          	sd	s9,0(a5)
    80005650:	f4dff06f          	j	8000559c <_Z29producerConsumer_CPP_Sync_APIv+0x220>
    Thread::dispatch();
    80005654:	ffffd097          	auipc	ra,0xffffd
    80005658:	844080e7          	jalr	-1980(ra) # 80001e98 <_ZN6Thread8dispatchEv>
    for (int i = 0; i <= threadNum; i++) {
    8000565c:	00000493          	li	s1,0
    80005660:	00994e63          	blt	s2,s1,8000567c <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        waitForAll->wait();
    80005664:	00006517          	auipc	a0,0x6
    80005668:	5cc53503          	ld	a0,1484(a0) # 8000bc30 <_ZL10waitForAll>
    8000566c:	ffffd097          	auipc	ra,0xffffd
    80005670:	924080e7          	jalr	-1756(ra) # 80001f90 <_ZN9Semaphore4waitEv>
    for (int i = 0; i <= threadNum; i++) {
    80005674:	0014849b          	addiw	s1,s1,1
    80005678:	fe9ff06f          	j	80005660 <_Z29producerConsumer_CPP_Sync_APIv+0x2e4>
    for (int i = 0; i < threadNum; i++) {
    8000567c:	00000493          	li	s1,0
    80005680:	0080006f          	j	80005688 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    80005684:	0014849b          	addiw	s1,s1,1
    80005688:	0324d263          	bge	s1,s2,800056ac <_Z29producerConsumer_CPP_Sync_APIv+0x330>
        delete threads[i];
    8000568c:	00349793          	slli	a5,s1,0x3
    80005690:	00f987b3          	add	a5,s3,a5
    80005694:	0007b503          	ld	a0,0(a5)
    80005698:	fe0506e3          	beqz	a0,80005684 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    8000569c:	00053783          	ld	a5,0(a0)
    800056a0:	0087b783          	ld	a5,8(a5)
    800056a4:	000780e7          	jalr	a5
    800056a8:	fddff06f          	j	80005684 <_Z29producerConsumer_CPP_Sync_APIv+0x308>
    delete consumerThread;
    800056ac:	000b0a63          	beqz	s6,800056c0 <_Z29producerConsumer_CPP_Sync_APIv+0x344>
    800056b0:	000b3783          	ld	a5,0(s6)
    800056b4:	0087b783          	ld	a5,8(a5)
    800056b8:	000b0513          	mv	a0,s6
    800056bc:	000780e7          	jalr	a5
    delete waitForAll;
    800056c0:	00006517          	auipc	a0,0x6
    800056c4:	57053503          	ld	a0,1392(a0) # 8000bc30 <_ZL10waitForAll>
    800056c8:	00050863          	beqz	a0,800056d8 <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
    800056cc:	00053783          	ld	a5,0(a0)
    800056d0:	0087b783          	ld	a5,8(a5)
    800056d4:	000780e7          	jalr	a5
    delete buffer;
    800056d8:	000a8e63          	beqz	s5,800056f4 <_Z29producerConsumer_CPP_Sync_APIv+0x378>
    800056dc:	000a8513          	mv	a0,s5
    800056e0:	00001097          	auipc	ra,0x1
    800056e4:	8a8080e7          	jalr	-1880(ra) # 80005f88 <_ZN9BufferCPPD1Ev>
    800056e8:	000a8513          	mv	a0,s5
    800056ec:	ffffc097          	auipc	ra,0xffffc
    800056f0:	ed4080e7          	jalr	-300(ra) # 800015c0 <_ZdlPv>
    800056f4:	000b8113          	mv	sp,s7

}
    800056f8:	f8040113          	addi	sp,s0,-128
    800056fc:	07813083          	ld	ra,120(sp)
    80005700:	07013403          	ld	s0,112(sp)
    80005704:	06813483          	ld	s1,104(sp)
    80005708:	06013903          	ld	s2,96(sp)
    8000570c:	05813983          	ld	s3,88(sp)
    80005710:	05013a03          	ld	s4,80(sp)
    80005714:	04813a83          	ld	s5,72(sp)
    80005718:	04013b03          	ld	s6,64(sp)
    8000571c:	03813b83          	ld	s7,56(sp)
    80005720:	03013c03          	ld	s8,48(sp)
    80005724:	02813c83          	ld	s9,40(sp)
    80005728:	08010113          	addi	sp,sp,128
    8000572c:	00008067          	ret
    80005730:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    80005734:	000a8513          	mv	a0,s5
    80005738:	ffffc097          	auipc	ra,0xffffc
    8000573c:	e88080e7          	jalr	-376(ra) # 800015c0 <_ZdlPv>
    80005740:	00048513          	mv	a0,s1
    80005744:	00007097          	auipc	ra,0x7
    80005748:	5d4080e7          	jalr	1492(ra) # 8000cd18 <_Unwind_Resume>
    8000574c:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    80005750:	00048513          	mv	a0,s1
    80005754:	ffffc097          	auipc	ra,0xffffc
    80005758:	e6c080e7          	jalr	-404(ra) # 800015c0 <_ZdlPv>
    8000575c:	00090513          	mv	a0,s2
    80005760:	00007097          	auipc	ra,0x7
    80005764:	5b8080e7          	jalr	1464(ra) # 8000cd18 <_Unwind_Resume>
    80005768:	00050493          	mv	s1,a0
    consumerThread = new ConsumerSync(data+threadNum);
    8000576c:	000b0513          	mv	a0,s6
    80005770:	ffffc097          	auipc	ra,0xffffc
    80005774:	e50080e7          	jalr	-432(ra) # 800015c0 <_ZdlPv>
    80005778:	00048513          	mv	a0,s1
    8000577c:	00007097          	auipc	ra,0x7
    80005780:	59c080e7          	jalr	1436(ra) # 8000cd18 <_Unwind_Resume>
    80005784:	00050493          	mv	s1,a0
            threads[i] = new ProducerSync(data+i);
    80005788:	000c8513          	mv	a0,s9
    8000578c:	ffffc097          	auipc	ra,0xffffc
    80005790:	e34080e7          	jalr	-460(ra) # 800015c0 <_ZdlPv>
    80005794:	00048513          	mv	a0,s1
    80005798:	00007097          	auipc	ra,0x7
    8000579c:	580080e7          	jalr	1408(ra) # 8000cd18 <_Unwind_Resume>
    800057a0:	00050493          	mv	s1,a0
            threads[i] = new ProducerKeyboard(data+i);
    800057a4:	000c8513          	mv	a0,s9
    800057a8:	ffffc097          	auipc	ra,0xffffc
    800057ac:	e18080e7          	jalr	-488(ra) # 800015c0 <_ZdlPv>
    800057b0:	00048513          	mv	a0,s1
    800057b4:	00007097          	auipc	ra,0x7
    800057b8:	564080e7          	jalr	1380(ra) # 8000cd18 <_Unwind_Resume>

00000000800057bc <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    800057bc:	ff010113          	addi	sp,sp,-16
    800057c0:	00113423          	sd	ra,8(sp)
    800057c4:	00813023          	sd	s0,0(sp)
    800057c8:	01010413          	addi	s0,sp,16
    800057cc:	00006797          	auipc	a5,0x6
    800057d0:	2a478793          	addi	a5,a5,676 # 8000ba70 <_ZTV12ConsumerSync+0x10>
    800057d4:	00f53023          	sd	a5,0(a0)
    800057d8:	ffffc097          	auipc	ra,0xffffc
    800057dc:	518080e7          	jalr	1304(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    800057e0:	00813083          	ld	ra,8(sp)
    800057e4:	00013403          	ld	s0,0(sp)
    800057e8:	01010113          	addi	sp,sp,16
    800057ec:	00008067          	ret

00000000800057f0 <_ZN12ConsumerSyncD0Ev>:
    800057f0:	fe010113          	addi	sp,sp,-32
    800057f4:	00113c23          	sd	ra,24(sp)
    800057f8:	00813823          	sd	s0,16(sp)
    800057fc:	00913423          	sd	s1,8(sp)
    80005800:	02010413          	addi	s0,sp,32
    80005804:	00050493          	mv	s1,a0
    80005808:	00006797          	auipc	a5,0x6
    8000580c:	26878793          	addi	a5,a5,616 # 8000ba70 <_ZTV12ConsumerSync+0x10>
    80005810:	00f53023          	sd	a5,0(a0)
    80005814:	ffffc097          	auipc	ra,0xffffc
    80005818:	4dc080e7          	jalr	1244(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    8000581c:	00048513          	mv	a0,s1
    80005820:	ffffc097          	auipc	ra,0xffffc
    80005824:	da0080e7          	jalr	-608(ra) # 800015c0 <_ZdlPv>
    80005828:	01813083          	ld	ra,24(sp)
    8000582c:	01013403          	ld	s0,16(sp)
    80005830:	00813483          	ld	s1,8(sp)
    80005834:	02010113          	addi	sp,sp,32
    80005838:	00008067          	ret

000000008000583c <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    8000583c:	ff010113          	addi	sp,sp,-16
    80005840:	00113423          	sd	ra,8(sp)
    80005844:	00813023          	sd	s0,0(sp)
    80005848:	01010413          	addi	s0,sp,16
    8000584c:	00006797          	auipc	a5,0x6
    80005850:	1fc78793          	addi	a5,a5,508 # 8000ba48 <_ZTV12ProducerSync+0x10>
    80005854:	00f53023          	sd	a5,0(a0)
    80005858:	ffffc097          	auipc	ra,0xffffc
    8000585c:	498080e7          	jalr	1176(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    80005860:	00813083          	ld	ra,8(sp)
    80005864:	00013403          	ld	s0,0(sp)
    80005868:	01010113          	addi	sp,sp,16
    8000586c:	00008067          	ret

0000000080005870 <_ZN12ProducerSyncD0Ev>:
    80005870:	fe010113          	addi	sp,sp,-32
    80005874:	00113c23          	sd	ra,24(sp)
    80005878:	00813823          	sd	s0,16(sp)
    8000587c:	00913423          	sd	s1,8(sp)
    80005880:	02010413          	addi	s0,sp,32
    80005884:	00050493          	mv	s1,a0
    80005888:	00006797          	auipc	a5,0x6
    8000588c:	1c078793          	addi	a5,a5,448 # 8000ba48 <_ZTV12ProducerSync+0x10>
    80005890:	00f53023          	sd	a5,0(a0)
    80005894:	ffffc097          	auipc	ra,0xffffc
    80005898:	45c080e7          	jalr	1116(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    8000589c:	00048513          	mv	a0,s1
    800058a0:	ffffc097          	auipc	ra,0xffffc
    800058a4:	d20080e7          	jalr	-736(ra) # 800015c0 <_ZdlPv>
    800058a8:	01813083          	ld	ra,24(sp)
    800058ac:	01013403          	ld	s0,16(sp)
    800058b0:	00813483          	ld	s1,8(sp)
    800058b4:	02010113          	addi	sp,sp,32
    800058b8:	00008067          	ret

00000000800058bc <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    800058bc:	ff010113          	addi	sp,sp,-16
    800058c0:	00113423          	sd	ra,8(sp)
    800058c4:	00813023          	sd	s0,0(sp)
    800058c8:	01010413          	addi	s0,sp,16
    800058cc:	00006797          	auipc	a5,0x6
    800058d0:	15478793          	addi	a5,a5,340 # 8000ba20 <_ZTV16ProducerKeyboard+0x10>
    800058d4:	00f53023          	sd	a5,0(a0)
    800058d8:	ffffc097          	auipc	ra,0xffffc
    800058dc:	418080e7          	jalr	1048(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    800058e0:	00813083          	ld	ra,8(sp)
    800058e4:	00013403          	ld	s0,0(sp)
    800058e8:	01010113          	addi	sp,sp,16
    800058ec:	00008067          	ret

00000000800058f0 <_ZN16ProducerKeyboardD0Ev>:
    800058f0:	fe010113          	addi	sp,sp,-32
    800058f4:	00113c23          	sd	ra,24(sp)
    800058f8:	00813823          	sd	s0,16(sp)
    800058fc:	00913423          	sd	s1,8(sp)
    80005900:	02010413          	addi	s0,sp,32
    80005904:	00050493          	mv	s1,a0
    80005908:	00006797          	auipc	a5,0x6
    8000590c:	11878793          	addi	a5,a5,280 # 8000ba20 <_ZTV16ProducerKeyboard+0x10>
    80005910:	00f53023          	sd	a5,0(a0)
    80005914:	ffffc097          	auipc	ra,0xffffc
    80005918:	3dc080e7          	jalr	988(ra) # 80001cf0 <_ZN6ThreadD1Ev>
    8000591c:	00048513          	mv	a0,s1
    80005920:	ffffc097          	auipc	ra,0xffffc
    80005924:	ca0080e7          	jalr	-864(ra) # 800015c0 <_ZdlPv>
    80005928:	01813083          	ld	ra,24(sp)
    8000592c:	01013403          	ld	s0,16(sp)
    80005930:	00813483          	ld	s1,8(sp)
    80005934:	02010113          	addi	sp,sp,32
    80005938:	00008067          	ret

000000008000593c <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    8000593c:	ff010113          	addi	sp,sp,-16
    80005940:	00113423          	sd	ra,8(sp)
    80005944:	00813023          	sd	s0,0(sp)
    80005948:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    8000594c:	02053583          	ld	a1,32(a0)
    80005950:	fffff097          	auipc	ra,0xfffff
    80005954:	7e4080e7          	jalr	2020(ra) # 80005134 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80005958:	00813083          	ld	ra,8(sp)
    8000595c:	00013403          	ld	s0,0(sp)
    80005960:	01010113          	addi	sp,sp,16
    80005964:	00008067          	ret

0000000080005968 <_ZN12ProducerSync3runEv>:
    void run() override {
    80005968:	ff010113          	addi	sp,sp,-16
    8000596c:	00113423          	sd	ra,8(sp)
    80005970:	00813023          	sd	s0,0(sp)
    80005974:	01010413          	addi	s0,sp,16
        producer(td);
    80005978:	02053583          	ld	a1,32(a0)
    8000597c:	00000097          	auipc	ra,0x0
    80005980:	878080e7          	jalr	-1928(ra) # 800051f4 <_ZN12ProducerSync8producerEPv>
    }
    80005984:	00813083          	ld	ra,8(sp)
    80005988:	00013403          	ld	s0,0(sp)
    8000598c:	01010113          	addi	sp,sp,16
    80005990:	00008067          	ret

0000000080005994 <_ZN12ConsumerSync3runEv>:
    void run() override {
    80005994:	ff010113          	addi	sp,sp,-16
    80005998:	00113423          	sd	ra,8(sp)
    8000599c:	00813023          	sd	s0,0(sp)
    800059a0:	01010413          	addi	s0,sp,16
        consumer(td);
    800059a4:	02053583          	ld	a1,32(a0)
    800059a8:	00000097          	auipc	ra,0x0
    800059ac:	8e0080e7          	jalr	-1824(ra) # 80005288 <_ZN12ConsumerSync8consumerEPv>
    }
    800059b0:	00813083          	ld	ra,8(sp)
    800059b4:	00013403          	ld	s0,0(sp)
    800059b8:	01010113          	addi	sp,sp,16
    800059bc:	00008067          	ret

00000000800059c0 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    800059c0:	fe010113          	addi	sp,sp,-32
    800059c4:	00113c23          	sd	ra,24(sp)
    800059c8:	00813823          	sd	s0,16(sp)
    800059cc:	00913423          	sd	s1,8(sp)
    800059d0:	02010413          	addi	s0,sp,32
    800059d4:	00050493          	mv	s1,a0
    LOCK();
    800059d8:	00100613          	li	a2,1
    800059dc:	00000593          	li	a1,0
    800059e0:	00006517          	auipc	a0,0x6
    800059e4:	25850513          	addi	a0,a0,600 # 8000bc38 <lockPrint>
    800059e8:	ffffc097          	auipc	ra,0xffffc
    800059ec:	880080e7          	jalr	-1920(ra) # 80001268 <copy_and_swap>
    800059f0:	00050863          	beqz	a0,80005a00 <_Z11printStringPKc+0x40>
    800059f4:	ffffc097          	auipc	ra,0xffffc
    800059f8:	9cc080e7          	jalr	-1588(ra) # 800013c0 <_Z15thread_dispatchv>
    800059fc:	fddff06f          	j	800059d8 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80005a00:	0004c503          	lbu	a0,0(s1)
    80005a04:	00050a63          	beqz	a0,80005a18 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80005a08:	ffffc097          	auipc	ra,0xffffc
    80005a0c:	b1c080e7          	jalr	-1252(ra) # 80001524 <_Z4putcc>
        string++;
    80005a10:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80005a14:	fedff06f          	j	80005a00 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80005a18:	00000613          	li	a2,0
    80005a1c:	00100593          	li	a1,1
    80005a20:	00006517          	auipc	a0,0x6
    80005a24:	21850513          	addi	a0,a0,536 # 8000bc38 <lockPrint>
    80005a28:	ffffc097          	auipc	ra,0xffffc
    80005a2c:	840080e7          	jalr	-1984(ra) # 80001268 <copy_and_swap>
    80005a30:	fe0514e3          	bnez	a0,80005a18 <_Z11printStringPKc+0x58>
}
    80005a34:	01813083          	ld	ra,24(sp)
    80005a38:	01013403          	ld	s0,16(sp)
    80005a3c:	00813483          	ld	s1,8(sp)
    80005a40:	02010113          	addi	sp,sp,32
    80005a44:	00008067          	ret

0000000080005a48 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80005a48:	fd010113          	addi	sp,sp,-48
    80005a4c:	02113423          	sd	ra,40(sp)
    80005a50:	02813023          	sd	s0,32(sp)
    80005a54:	00913c23          	sd	s1,24(sp)
    80005a58:	01213823          	sd	s2,16(sp)
    80005a5c:	01313423          	sd	s3,8(sp)
    80005a60:	01413023          	sd	s4,0(sp)
    80005a64:	03010413          	addi	s0,sp,48
    80005a68:	00050993          	mv	s3,a0
    80005a6c:	00058a13          	mv	s4,a1
    LOCK();
    80005a70:	00100613          	li	a2,1
    80005a74:	00000593          	li	a1,0
    80005a78:	00006517          	auipc	a0,0x6
    80005a7c:	1c050513          	addi	a0,a0,448 # 8000bc38 <lockPrint>
    80005a80:	ffffb097          	auipc	ra,0xffffb
    80005a84:	7e8080e7          	jalr	2024(ra) # 80001268 <copy_and_swap>
    80005a88:	00050863          	beqz	a0,80005a98 <_Z9getStringPci+0x50>
    80005a8c:	ffffc097          	auipc	ra,0xffffc
    80005a90:	934080e7          	jalr	-1740(ra) # 800013c0 <_Z15thread_dispatchv>
    80005a94:	fddff06f          	j	80005a70 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80005a98:	00000913          	li	s2,0
    80005a9c:	00090493          	mv	s1,s2
    80005aa0:	0019091b          	addiw	s2,s2,1
    80005aa4:	03495a63          	bge	s2,s4,80005ad8 <_Z9getStringPci+0x90>
        cc = getc();
    80005aa8:	ffffc097          	auipc	ra,0xffffc
    80005aac:	a58080e7          	jalr	-1448(ra) # 80001500 <_Z4getcv>
        if(cc < 1)
    80005ab0:	02050463          	beqz	a0,80005ad8 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80005ab4:	009984b3          	add	s1,s3,s1
    80005ab8:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80005abc:	00a00793          	li	a5,10
    80005ac0:	00f50a63          	beq	a0,a5,80005ad4 <_Z9getStringPci+0x8c>
    80005ac4:	00d00793          	li	a5,13
    80005ac8:	fcf51ae3          	bne	a0,a5,80005a9c <_Z9getStringPci+0x54>
        buf[i++] = c;
    80005acc:	00090493          	mv	s1,s2
    80005ad0:	0080006f          	j	80005ad8 <_Z9getStringPci+0x90>
    80005ad4:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80005ad8:	009984b3          	add	s1,s3,s1
    80005adc:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80005ae0:	00000613          	li	a2,0
    80005ae4:	00100593          	li	a1,1
    80005ae8:	00006517          	auipc	a0,0x6
    80005aec:	15050513          	addi	a0,a0,336 # 8000bc38 <lockPrint>
    80005af0:	ffffb097          	auipc	ra,0xffffb
    80005af4:	778080e7          	jalr	1912(ra) # 80001268 <copy_and_swap>
    80005af8:	fe0514e3          	bnez	a0,80005ae0 <_Z9getStringPci+0x98>
    return buf;
}
    80005afc:	00098513          	mv	a0,s3
    80005b00:	02813083          	ld	ra,40(sp)
    80005b04:	02013403          	ld	s0,32(sp)
    80005b08:	01813483          	ld	s1,24(sp)
    80005b0c:	01013903          	ld	s2,16(sp)
    80005b10:	00813983          	ld	s3,8(sp)
    80005b14:	00013a03          	ld	s4,0(sp)
    80005b18:	03010113          	addi	sp,sp,48
    80005b1c:	00008067          	ret

0000000080005b20 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80005b20:	ff010113          	addi	sp,sp,-16
    80005b24:	00813423          	sd	s0,8(sp)
    80005b28:	01010413          	addi	s0,sp,16
    80005b2c:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80005b30:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80005b34:	0006c603          	lbu	a2,0(a3)
    80005b38:	fd06071b          	addiw	a4,a2,-48
    80005b3c:	0ff77713          	andi	a4,a4,255
    80005b40:	00900793          	li	a5,9
    80005b44:	02e7e063          	bltu	a5,a4,80005b64 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80005b48:	0025179b          	slliw	a5,a0,0x2
    80005b4c:	00a787bb          	addw	a5,a5,a0
    80005b50:	0017979b          	slliw	a5,a5,0x1
    80005b54:	00168693          	addi	a3,a3,1
    80005b58:	00c787bb          	addw	a5,a5,a2
    80005b5c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80005b60:	fd5ff06f          	j	80005b34 <_Z11stringToIntPKc+0x14>
    return n;
}
    80005b64:	00813403          	ld	s0,8(sp)
    80005b68:	01010113          	addi	sp,sp,16
    80005b6c:	00008067          	ret

0000000080005b70 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80005b70:	fc010113          	addi	sp,sp,-64
    80005b74:	02113c23          	sd	ra,56(sp)
    80005b78:	02813823          	sd	s0,48(sp)
    80005b7c:	02913423          	sd	s1,40(sp)
    80005b80:	03213023          	sd	s2,32(sp)
    80005b84:	01313c23          	sd	s3,24(sp)
    80005b88:	04010413          	addi	s0,sp,64
    80005b8c:	00050493          	mv	s1,a0
    80005b90:	00058913          	mv	s2,a1
    80005b94:	00060993          	mv	s3,a2
    LOCK();
    80005b98:	00100613          	li	a2,1
    80005b9c:	00000593          	li	a1,0
    80005ba0:	00006517          	auipc	a0,0x6
    80005ba4:	09850513          	addi	a0,a0,152 # 8000bc38 <lockPrint>
    80005ba8:	ffffb097          	auipc	ra,0xffffb
    80005bac:	6c0080e7          	jalr	1728(ra) # 80001268 <copy_and_swap>
    80005bb0:	00050863          	beqz	a0,80005bc0 <_Z8printIntiii+0x50>
    80005bb4:	ffffc097          	auipc	ra,0xffffc
    80005bb8:	80c080e7          	jalr	-2036(ra) # 800013c0 <_Z15thread_dispatchv>
    80005bbc:	fddff06f          	j	80005b98 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80005bc0:	00098463          	beqz	s3,80005bc8 <_Z8printIntiii+0x58>
    80005bc4:	0804c463          	bltz	s1,80005c4c <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80005bc8:	0004851b          	sext.w	a0,s1
    neg = 0;
    80005bcc:	00000593          	li	a1,0
    }

    i = 0;
    80005bd0:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80005bd4:	0009079b          	sext.w	a5,s2
    80005bd8:	0325773b          	remuw	a4,a0,s2
    80005bdc:	00048613          	mv	a2,s1
    80005be0:	0014849b          	addiw	s1,s1,1
    80005be4:	02071693          	slli	a3,a4,0x20
    80005be8:	0206d693          	srli	a3,a3,0x20
    80005bec:	00006717          	auipc	a4,0x6
    80005bf0:	e9c70713          	addi	a4,a4,-356 # 8000ba88 <digits>
    80005bf4:	00d70733          	add	a4,a4,a3
    80005bf8:	00074683          	lbu	a3,0(a4)
    80005bfc:	fd040713          	addi	a4,s0,-48
    80005c00:	00c70733          	add	a4,a4,a2
    80005c04:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80005c08:	0005071b          	sext.w	a4,a0
    80005c0c:	0325553b          	divuw	a0,a0,s2
    80005c10:	fcf772e3          	bgeu	a4,a5,80005bd4 <_Z8printIntiii+0x64>
    if(neg)
    80005c14:	00058c63          	beqz	a1,80005c2c <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80005c18:	fd040793          	addi	a5,s0,-48
    80005c1c:	009784b3          	add	s1,a5,s1
    80005c20:	02d00793          	li	a5,45
    80005c24:	fef48823          	sb	a5,-16(s1)
    80005c28:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80005c2c:	fff4849b          	addiw	s1,s1,-1
    80005c30:	0204c463          	bltz	s1,80005c58 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80005c34:	fd040793          	addi	a5,s0,-48
    80005c38:	009787b3          	add	a5,a5,s1
    80005c3c:	ff07c503          	lbu	a0,-16(a5)
    80005c40:	ffffc097          	auipc	ra,0xffffc
    80005c44:	8e4080e7          	jalr	-1820(ra) # 80001524 <_Z4putcc>
    80005c48:	fe5ff06f          	j	80005c2c <_Z8printIntiii+0xbc>
        x = -xx;
    80005c4c:	4090053b          	negw	a0,s1
        neg = 1;
    80005c50:	00100593          	li	a1,1
        x = -xx;
    80005c54:	f7dff06f          	j	80005bd0 <_Z8printIntiii+0x60>

    UNLOCK();
    80005c58:	00000613          	li	a2,0
    80005c5c:	00100593          	li	a1,1
    80005c60:	00006517          	auipc	a0,0x6
    80005c64:	fd850513          	addi	a0,a0,-40 # 8000bc38 <lockPrint>
    80005c68:	ffffb097          	auipc	ra,0xffffb
    80005c6c:	600080e7          	jalr	1536(ra) # 80001268 <copy_and_swap>
    80005c70:	fe0514e3          	bnez	a0,80005c58 <_Z8printIntiii+0xe8>
    80005c74:	03813083          	ld	ra,56(sp)
    80005c78:	03013403          	ld	s0,48(sp)
    80005c7c:	02813483          	ld	s1,40(sp)
    80005c80:	02013903          	ld	s2,32(sp)
    80005c84:	01813983          	ld	s3,24(sp)
    80005c88:	04010113          	addi	sp,sp,64
    80005c8c:	00008067          	ret

0000000080005c90 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80005c90:	fd010113          	addi	sp,sp,-48
    80005c94:	02113423          	sd	ra,40(sp)
    80005c98:	02813023          	sd	s0,32(sp)
    80005c9c:	00913c23          	sd	s1,24(sp)
    80005ca0:	01213823          	sd	s2,16(sp)
    80005ca4:	01313423          	sd	s3,8(sp)
    80005ca8:	03010413          	addi	s0,sp,48
    80005cac:	00050493          	mv	s1,a0
    80005cb0:	00058913          	mv	s2,a1
    80005cb4:	0015879b          	addiw	a5,a1,1
    80005cb8:	0007851b          	sext.w	a0,a5
    80005cbc:	00f4a023          	sw	a5,0(s1)
    80005cc0:	0004a823          	sw	zero,16(s1)
    80005cc4:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    80005cc8:	00251513          	slli	a0,a0,0x2
    80005ccc:	ffffb097          	auipc	ra,0xffffb
    80005cd0:	5bc080e7          	jalr	1468(ra) # 80001288 <_Z9mem_allocm>
    80005cd4:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    80005cd8:	01000513          	li	a0,16
    80005cdc:	ffffc097          	auipc	ra,0xffffc
    80005ce0:	894080e7          	jalr	-1900(ra) # 80001570 <_Znwm>
    80005ce4:	00050993          	mv	s3,a0
    80005ce8:	00000593          	li	a1,0
    80005cec:	ffffc097          	auipc	ra,0xffffc
    80005cf0:	268080e7          	jalr	616(ra) # 80001f54 <_ZN9SemaphoreC1Ej>
    80005cf4:	0334b023          	sd	s3,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80005cf8:	01000513          	li	a0,16
    80005cfc:	ffffc097          	auipc	ra,0xffffc
    80005d00:	874080e7          	jalr	-1932(ra) # 80001570 <_Znwm>
    80005d04:	00050993          	mv	s3,a0
    80005d08:	00090593          	mv	a1,s2
    80005d0c:	ffffc097          	auipc	ra,0xffffc
    80005d10:	248080e7          	jalr	584(ra) # 80001f54 <_ZN9SemaphoreC1Ej>
    80005d14:	0134bc23          	sd	s3,24(s1)
    mutexHead = new Semaphore(1);
    80005d18:	01000513          	li	a0,16
    80005d1c:	ffffc097          	auipc	ra,0xffffc
    80005d20:	854080e7          	jalr	-1964(ra) # 80001570 <_Znwm>
    80005d24:	00050913          	mv	s2,a0
    80005d28:	00100593          	li	a1,1
    80005d2c:	ffffc097          	auipc	ra,0xffffc
    80005d30:	228080e7          	jalr	552(ra) # 80001f54 <_ZN9SemaphoreC1Ej>
    80005d34:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80005d38:	01000513          	li	a0,16
    80005d3c:	ffffc097          	auipc	ra,0xffffc
    80005d40:	834080e7          	jalr	-1996(ra) # 80001570 <_Znwm>
    80005d44:	00050913          	mv	s2,a0
    80005d48:	00100593          	li	a1,1
    80005d4c:	ffffc097          	auipc	ra,0xffffc
    80005d50:	208080e7          	jalr	520(ra) # 80001f54 <_ZN9SemaphoreC1Ej>
    80005d54:	0324b823          	sd	s2,48(s1)
}
    80005d58:	02813083          	ld	ra,40(sp)
    80005d5c:	02013403          	ld	s0,32(sp)
    80005d60:	01813483          	ld	s1,24(sp)
    80005d64:	01013903          	ld	s2,16(sp)
    80005d68:	00813983          	ld	s3,8(sp)
    80005d6c:	03010113          	addi	sp,sp,48
    80005d70:	00008067          	ret
    80005d74:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80005d78:	00098513          	mv	a0,s3
    80005d7c:	ffffc097          	auipc	ra,0xffffc
    80005d80:	844080e7          	jalr	-1980(ra) # 800015c0 <_ZdlPv>
    80005d84:	00048513          	mv	a0,s1
    80005d88:	00007097          	auipc	ra,0x7
    80005d8c:	f90080e7          	jalr	-112(ra) # 8000cd18 <_Unwind_Resume>
    80005d90:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80005d94:	00098513          	mv	a0,s3
    80005d98:	ffffc097          	auipc	ra,0xffffc
    80005d9c:	828080e7          	jalr	-2008(ra) # 800015c0 <_ZdlPv>
    80005da0:	00048513          	mv	a0,s1
    80005da4:	00007097          	auipc	ra,0x7
    80005da8:	f74080e7          	jalr	-140(ra) # 8000cd18 <_Unwind_Resume>
    80005dac:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80005db0:	00090513          	mv	a0,s2
    80005db4:	ffffc097          	auipc	ra,0xffffc
    80005db8:	80c080e7          	jalr	-2036(ra) # 800015c0 <_ZdlPv>
    80005dbc:	00048513          	mv	a0,s1
    80005dc0:	00007097          	auipc	ra,0x7
    80005dc4:	f58080e7          	jalr	-168(ra) # 8000cd18 <_Unwind_Resume>
    80005dc8:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80005dcc:	00090513          	mv	a0,s2
    80005dd0:	ffffb097          	auipc	ra,0xffffb
    80005dd4:	7f0080e7          	jalr	2032(ra) # 800015c0 <_ZdlPv>
    80005dd8:	00048513          	mv	a0,s1
    80005ddc:	00007097          	auipc	ra,0x7
    80005de0:	f3c080e7          	jalr	-196(ra) # 8000cd18 <_Unwind_Resume>

0000000080005de4 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80005de4:	fe010113          	addi	sp,sp,-32
    80005de8:	00113c23          	sd	ra,24(sp)
    80005dec:	00813823          	sd	s0,16(sp)
    80005df0:	00913423          	sd	s1,8(sp)
    80005df4:	01213023          	sd	s2,0(sp)
    80005df8:	02010413          	addi	s0,sp,32
    80005dfc:	00050493          	mv	s1,a0
    80005e00:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80005e04:	01853503          	ld	a0,24(a0)
    80005e08:	ffffc097          	auipc	ra,0xffffc
    80005e0c:	188080e7          	jalr	392(ra) # 80001f90 <_ZN9Semaphore4waitEv>

    mutexTail->wait();
    80005e10:	0304b503          	ld	a0,48(s1)
    80005e14:	ffffc097          	auipc	ra,0xffffc
    80005e18:	17c080e7          	jalr	380(ra) # 80001f90 <_ZN9Semaphore4waitEv>
    buffer[tail] = val;
    80005e1c:	0084b783          	ld	a5,8(s1)
    80005e20:	0144a703          	lw	a4,20(s1)
    80005e24:	00271713          	slli	a4,a4,0x2
    80005e28:	00e787b3          	add	a5,a5,a4
    80005e2c:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80005e30:	0144a783          	lw	a5,20(s1)
    80005e34:	0017879b          	addiw	a5,a5,1
    80005e38:	0004a703          	lw	a4,0(s1)
    80005e3c:	02e7e7bb          	remw	a5,a5,a4
    80005e40:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80005e44:	0304b503          	ld	a0,48(s1)
    80005e48:	ffffc097          	auipc	ra,0xffffc
    80005e4c:	174080e7          	jalr	372(ra) # 80001fbc <_ZN9Semaphore6signalEv>

    itemAvailable->signal();
    80005e50:	0204b503          	ld	a0,32(s1)
    80005e54:	ffffc097          	auipc	ra,0xffffc
    80005e58:	168080e7          	jalr	360(ra) # 80001fbc <_ZN9Semaphore6signalEv>

}
    80005e5c:	01813083          	ld	ra,24(sp)
    80005e60:	01013403          	ld	s0,16(sp)
    80005e64:	00813483          	ld	s1,8(sp)
    80005e68:	00013903          	ld	s2,0(sp)
    80005e6c:	02010113          	addi	sp,sp,32
    80005e70:	00008067          	ret

0000000080005e74 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80005e74:	fe010113          	addi	sp,sp,-32
    80005e78:	00113c23          	sd	ra,24(sp)
    80005e7c:	00813823          	sd	s0,16(sp)
    80005e80:	00913423          	sd	s1,8(sp)
    80005e84:	01213023          	sd	s2,0(sp)
    80005e88:	02010413          	addi	s0,sp,32
    80005e8c:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80005e90:	02053503          	ld	a0,32(a0)
    80005e94:	ffffc097          	auipc	ra,0xffffc
    80005e98:	0fc080e7          	jalr	252(ra) # 80001f90 <_ZN9Semaphore4waitEv>

    mutexHead->wait();
    80005e9c:	0284b503          	ld	a0,40(s1)
    80005ea0:	ffffc097          	auipc	ra,0xffffc
    80005ea4:	0f0080e7          	jalr	240(ra) # 80001f90 <_ZN9Semaphore4waitEv>

    int ret = buffer[head];
    80005ea8:	0084b703          	ld	a4,8(s1)
    80005eac:	0104a783          	lw	a5,16(s1)
    80005eb0:	00279693          	slli	a3,a5,0x2
    80005eb4:	00d70733          	add	a4,a4,a3
    80005eb8:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80005ebc:	0017879b          	addiw	a5,a5,1
    80005ec0:	0004a703          	lw	a4,0(s1)
    80005ec4:	02e7e7bb          	remw	a5,a5,a4
    80005ec8:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80005ecc:	0284b503          	ld	a0,40(s1)
    80005ed0:	ffffc097          	auipc	ra,0xffffc
    80005ed4:	0ec080e7          	jalr	236(ra) # 80001fbc <_ZN9Semaphore6signalEv>

    spaceAvailable->signal();
    80005ed8:	0184b503          	ld	a0,24(s1)
    80005edc:	ffffc097          	auipc	ra,0xffffc
    80005ee0:	0e0080e7          	jalr	224(ra) # 80001fbc <_ZN9Semaphore6signalEv>

    return ret;
}
    80005ee4:	00090513          	mv	a0,s2
    80005ee8:	01813083          	ld	ra,24(sp)
    80005eec:	01013403          	ld	s0,16(sp)
    80005ef0:	00813483          	ld	s1,8(sp)
    80005ef4:	00013903          	ld	s2,0(sp)
    80005ef8:	02010113          	addi	sp,sp,32
    80005efc:	00008067          	ret

0000000080005f00 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80005f00:	fe010113          	addi	sp,sp,-32
    80005f04:	00113c23          	sd	ra,24(sp)
    80005f08:	00813823          	sd	s0,16(sp)
    80005f0c:	00913423          	sd	s1,8(sp)
    80005f10:	01213023          	sd	s2,0(sp)
    80005f14:	02010413          	addi	s0,sp,32
    80005f18:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80005f1c:	02853503          	ld	a0,40(a0)
    80005f20:	ffffc097          	auipc	ra,0xffffc
    80005f24:	070080e7          	jalr	112(ra) # 80001f90 <_ZN9Semaphore4waitEv>
    mutexTail->wait();
    80005f28:	0304b503          	ld	a0,48(s1)
    80005f2c:	ffffc097          	auipc	ra,0xffffc
    80005f30:	064080e7          	jalr	100(ra) # 80001f90 <_ZN9Semaphore4waitEv>

    if (tail >= head) {
    80005f34:	0144a783          	lw	a5,20(s1)
    80005f38:	0104a903          	lw	s2,16(s1)
    80005f3c:	0327ce63          	blt	a5,s2,80005f78 <_ZN9BufferCPP6getCntEv+0x78>
        ret = tail - head;
    80005f40:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80005f44:	0304b503          	ld	a0,48(s1)
    80005f48:	ffffc097          	auipc	ra,0xffffc
    80005f4c:	074080e7          	jalr	116(ra) # 80001fbc <_ZN9Semaphore6signalEv>
    mutexHead->signal();
    80005f50:	0284b503          	ld	a0,40(s1)
    80005f54:	ffffc097          	auipc	ra,0xffffc
    80005f58:	068080e7          	jalr	104(ra) # 80001fbc <_ZN9Semaphore6signalEv>

    return ret;
}
    80005f5c:	00090513          	mv	a0,s2
    80005f60:	01813083          	ld	ra,24(sp)
    80005f64:	01013403          	ld	s0,16(sp)
    80005f68:	00813483          	ld	s1,8(sp)
    80005f6c:	00013903          	ld	s2,0(sp)
    80005f70:	02010113          	addi	sp,sp,32
    80005f74:	00008067          	ret
        ret = cap - head + tail;
    80005f78:	0004a703          	lw	a4,0(s1)
    80005f7c:	4127093b          	subw	s2,a4,s2
    80005f80:	00f9093b          	addw	s2,s2,a5
    80005f84:	fc1ff06f          	j	80005f44 <_ZN9BufferCPP6getCntEv+0x44>

0000000080005f88 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80005f88:	fe010113          	addi	sp,sp,-32
    80005f8c:	00113c23          	sd	ra,24(sp)
    80005f90:	00813823          	sd	s0,16(sp)
    80005f94:	00913423          	sd	s1,8(sp)
    80005f98:	02010413          	addi	s0,sp,32
    80005f9c:	00050493          	mv	s1,a0
    Console::putc('\n');
    80005fa0:	00a00513          	li	a0,10
    80005fa4:	ffffc097          	auipc	ra,0xffffc
    80005fa8:	0e0080e7          	jalr	224(ra) # 80002084 <_ZN7Console4putcEc>
    printString("Buffer deleted!\n");
    80005fac:	00003517          	auipc	a0,0x3
    80005fb0:	25450513          	addi	a0,a0,596 # 80009200 <CONSOLE_STATUS+0x1f0>
    80005fb4:	00000097          	auipc	ra,0x0
    80005fb8:	a0c080e7          	jalr	-1524(ra) # 800059c0 <_Z11printStringPKc>
    while (getCnt()) {
    80005fbc:	00048513          	mv	a0,s1
    80005fc0:	00000097          	auipc	ra,0x0
    80005fc4:	f40080e7          	jalr	-192(ra) # 80005f00 <_ZN9BufferCPP6getCntEv>
    80005fc8:	02050c63          	beqz	a0,80006000 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80005fcc:	0084b783          	ld	a5,8(s1)
    80005fd0:	0104a703          	lw	a4,16(s1)
    80005fd4:	00271713          	slli	a4,a4,0x2
    80005fd8:	00e787b3          	add	a5,a5,a4
        Console::putc(ch);
    80005fdc:	0007c503          	lbu	a0,0(a5)
    80005fe0:	ffffc097          	auipc	ra,0xffffc
    80005fe4:	0a4080e7          	jalr	164(ra) # 80002084 <_ZN7Console4putcEc>
        head = (head + 1) % cap;
    80005fe8:	0104a783          	lw	a5,16(s1)
    80005fec:	0017879b          	addiw	a5,a5,1
    80005ff0:	0004a703          	lw	a4,0(s1)
    80005ff4:	02e7e7bb          	remw	a5,a5,a4
    80005ff8:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80005ffc:	fc1ff06f          	j	80005fbc <_ZN9BufferCPPD1Ev+0x34>
    Console::putc('!');
    80006000:	02100513          	li	a0,33
    80006004:	ffffc097          	auipc	ra,0xffffc
    80006008:	080080e7          	jalr	128(ra) # 80002084 <_ZN7Console4putcEc>
    Console::putc('\n');
    8000600c:	00a00513          	li	a0,10
    80006010:	ffffc097          	auipc	ra,0xffffc
    80006014:	074080e7          	jalr	116(ra) # 80002084 <_ZN7Console4putcEc>
    mem_free(buffer);
    80006018:	0084b503          	ld	a0,8(s1)
    8000601c:	ffffb097          	auipc	ra,0xffffb
    80006020:	294080e7          	jalr	660(ra) # 800012b0 <_Z8mem_freePv>
    delete itemAvailable;
    80006024:	0204b503          	ld	a0,32(s1)
    80006028:	00050863          	beqz	a0,80006038 <_ZN9BufferCPPD1Ev+0xb0>
    8000602c:	00053783          	ld	a5,0(a0)
    80006030:	0087b783          	ld	a5,8(a5)
    80006034:	000780e7          	jalr	a5
    delete spaceAvailable;
    80006038:	0184b503          	ld	a0,24(s1)
    8000603c:	00050863          	beqz	a0,8000604c <_ZN9BufferCPPD1Ev+0xc4>
    80006040:	00053783          	ld	a5,0(a0)
    80006044:	0087b783          	ld	a5,8(a5)
    80006048:	000780e7          	jalr	a5
    delete mutexTail;
    8000604c:	0304b503          	ld	a0,48(s1)
    80006050:	00050863          	beqz	a0,80006060 <_ZN9BufferCPPD1Ev+0xd8>
    80006054:	00053783          	ld	a5,0(a0)
    80006058:	0087b783          	ld	a5,8(a5)
    8000605c:	000780e7          	jalr	a5
    delete mutexHead;
    80006060:	0284b503          	ld	a0,40(s1)
    80006064:	00050863          	beqz	a0,80006074 <_ZN9BufferCPPD1Ev+0xec>
    80006068:	00053783          	ld	a5,0(a0)
    8000606c:	0087b783          	ld	a5,8(a5)
    80006070:	000780e7          	jalr	a5
}
    80006074:	01813083          	ld	ra,24(sp)
    80006078:	01013403          	ld	s0,16(sp)
    8000607c:	00813483          	ld	s1,8(sp)
    80006080:	02010113          	addi	sp,sp,32
    80006084:	00008067          	ret

0000000080006088 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"
#include "../h/syscall_c.hpp"
#endif

void userMain() {
    80006088:	fe010113          	addi	sp,sp,-32
    8000608c:	00113c23          	sd	ra,24(sp)
    80006090:	00813823          	sd	s0,16(sp)
    80006094:	00913423          	sd	s1,8(sp)
    80006098:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    8000609c:	00003517          	auipc	a0,0x3
    800060a0:	17c50513          	addi	a0,a0,380 # 80009218 <CONSOLE_STATUS+0x208>
    800060a4:	00000097          	auipc	ra,0x0
    800060a8:	91c080e7          	jalr	-1764(ra) # 800059c0 <_Z11printStringPKc>
    int test = getc() - '0';
    800060ac:	ffffb097          	auipc	ra,0xffffb
    800060b0:	454080e7          	jalr	1108(ra) # 80001500 <_Z4getcv>
    800060b4:	fd05049b          	addiw	s1,a0,-48
    Console::putc((char)test + '0');
    800060b8:	ffffc097          	auipc	ra,0xffffc
    800060bc:	fcc080e7          	jalr	-52(ra) # 80002084 <_ZN7Console4putcEc>
    getc(); // Enter posle broja
    800060c0:	ffffb097          	auipc	ra,0xffffb
    800060c4:	440080e7          	jalr	1088(ra) # 80001500 <_Z4getcv>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    800060c8:	00700793          	li	a5,7
    800060cc:	1097ea63          	bltu	a5,s1,800061e0 <_Z8userMainv+0x158>
    800060d0:	00249493          	slli	s1,s1,0x2
    800060d4:	00003717          	auipc	a4,0x3
    800060d8:	3b470713          	addi	a4,a4,948 # 80009488 <CONSOLE_STATUS+0x478>
    800060dc:	00e484b3          	add	s1,s1,a4
    800060e0:	0004a783          	lw	a5,0(s1)
    800060e4:	00e787b3          	add	a5,a5,a4
    800060e8:	00078067          	jr	a5
        case 1:
#if LEVEL_2_IMPLEMENTED == 1
            Threads_C_API_test();
    800060ec:	fffff097          	auipc	ra,0xfffff
    800060f0:	f4c080e7          	jalr	-180(ra) # 80005038 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    800060f4:	00003517          	auipc	a0,0x3
    800060f8:	14450513          	addi	a0,a0,324 # 80009238 <CONSOLE_STATUS+0x228>
    800060fc:	00000097          	auipc	ra,0x0
    80006100:	8c4080e7          	jalr	-1852(ra) # 800059c0 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
    80006104:	01813083          	ld	ra,24(sp)
    80006108:	01013403          	ld	s0,16(sp)
    8000610c:	00813483          	ld	s1,8(sp)
    80006110:	02010113          	addi	sp,sp,32
    80006114:	00008067          	ret
            Threads_CPP_API_test();
    80006118:	ffffe097          	auipc	ra,0xffffe
    8000611c:	e00080e7          	jalr	-512(ra) # 80003f18 <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80006120:	00003517          	auipc	a0,0x3
    80006124:	15850513          	addi	a0,a0,344 # 80009278 <CONSOLE_STATUS+0x268>
    80006128:	00000097          	auipc	ra,0x0
    8000612c:	898080e7          	jalr	-1896(ra) # 800059c0 <_Z11printStringPKc>
            break;
    80006130:	fd5ff06f          	j	80006104 <_Z8userMainv+0x7c>
            producerConsumer_C_API();
    80006134:	ffffd097          	auipc	ra,0xffffd
    80006138:	638080e7          	jalr	1592(ra) # 8000376c <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    8000613c:	00003517          	auipc	a0,0x3
    80006140:	17c50513          	addi	a0,a0,380 # 800092b8 <CONSOLE_STATUS+0x2a8>
    80006144:	00000097          	auipc	ra,0x0
    80006148:	87c080e7          	jalr	-1924(ra) # 800059c0 <_Z11printStringPKc>
            break;
    8000614c:	fb9ff06f          	j	80006104 <_Z8userMainv+0x7c>
            producerConsumer_CPP_Sync_API();
    80006150:	fffff097          	auipc	ra,0xfffff
    80006154:	22c080e7          	jalr	556(ra) # 8000537c <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80006158:	00003517          	auipc	a0,0x3
    8000615c:	1b050513          	addi	a0,a0,432 # 80009308 <CONSOLE_STATUS+0x2f8>
    80006160:	00000097          	auipc	ra,0x0
    80006164:	860080e7          	jalr	-1952(ra) # 800059c0 <_Z11printStringPKc>
            break;
    80006168:	f9dff06f          	j	80006104 <_Z8userMainv+0x7c>
            printString("ULAZAK U TEST 5\n");
    8000616c:	00003517          	auipc	a0,0x3
    80006170:	1f450513          	addi	a0,a0,500 # 80009360 <CONSOLE_STATUS+0x350>
    80006174:	00000097          	auipc	ra,0x0
    80006178:	84c080e7          	jalr	-1972(ra) # 800059c0 <_Z11printStringPKc>
            testSleeping();
    8000617c:	00000097          	auipc	ra,0x0
    80006180:	11c080e7          	jalr	284(ra) # 80006298 <_Z12testSleepingv>
            printString("TEST 5 (zadatak 4., thread_sleep test C API)\n");
    80006184:	00003517          	auipc	a0,0x3
    80006188:	1f450513          	addi	a0,a0,500 # 80009378 <CONSOLE_STATUS+0x368>
    8000618c:	00000097          	auipc	ra,0x0
    80006190:	834080e7          	jalr	-1996(ra) # 800059c0 <_Z11printStringPKc>
            break;
    80006194:	f71ff06f          	j	80006104 <_Z8userMainv+0x7c>
            testConsumerProducer();
    80006198:	ffffe097          	auipc	ra,0xffffe
    8000619c:	240080e7          	jalr	576(ra) # 800043d8 <_Z20testConsumerProducerv>
            printString("TEST 6 (zadatak 4. CPP API i asinhrona promena konteksta)\n");
    800061a0:	00003517          	auipc	a0,0x3
    800061a4:	20850513          	addi	a0,a0,520 # 800093a8 <CONSOLE_STATUS+0x398>
    800061a8:	00000097          	auipc	ra,0x0
    800061ac:	818080e7          	jalr	-2024(ra) # 800059c0 <_Z11printStringPKc>
            break;
    800061b0:	f55ff06f          	j	80006104 <_Z8userMainv+0x7c>
            System_Mode_test();
    800061b4:	00000097          	auipc	ra,0x0
    800061b8:	658080e7          	jalr	1624(ra) # 8000680c <_Z16System_Mode_testv>
            printString("Test se nije uspesno zavrsio\n");
    800061bc:	00003517          	auipc	a0,0x3
    800061c0:	22c50513          	addi	a0,a0,556 # 800093e8 <CONSOLE_STATUS+0x3d8>
    800061c4:	fffff097          	auipc	ra,0xfffff
    800061c8:	7fc080e7          	jalr	2044(ra) # 800059c0 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    800061cc:	00003517          	auipc	a0,0x3
    800061d0:	23c50513          	addi	a0,a0,572 # 80009408 <CONSOLE_STATUS+0x3f8>
    800061d4:	fffff097          	auipc	ra,0xfffff
    800061d8:	7ec080e7          	jalr	2028(ra) # 800059c0 <_Z11printStringPKc>
            break;
    800061dc:	f29ff06f          	j	80006104 <_Z8userMainv+0x7c>
            printString("Niste uneli odgovarajuci broj za test\n");
    800061e0:	00003517          	auipc	a0,0x3
    800061e4:	28050513          	addi	a0,a0,640 # 80009460 <CONSOLE_STATUS+0x450>
    800061e8:	fffff097          	auipc	ra,0xfffff
    800061ec:	7d8080e7          	jalr	2008(ra) # 800059c0 <_Z11printStringPKc>
    800061f0:	f15ff06f          	j	80006104 <_Z8userMainv+0x7c>

00000000800061f4 <_ZL9sleepyRunPv>:

#include "printing.hpp"

static volatile bool finished[2];

static void sleepyRun(void *arg) {
    800061f4:	fe010113          	addi	sp,sp,-32
    800061f8:	00113c23          	sd	ra,24(sp)
    800061fc:	00813823          	sd	s0,16(sp)
    80006200:	00913423          	sd	s1,8(sp)
    80006204:	01213023          	sd	s2,0(sp)
    80006208:	02010413          	addi	s0,sp,32
    time_t sleep_time = *((time_t *) arg);
    8000620c:	00053903          	ld	s2,0(a0)
    int i = 6;
    80006210:	00600493          	li	s1,6
    while (--i > 0) {
    80006214:	fff4849b          	addiw	s1,s1,-1
    80006218:	04905463          	blez	s1,80006260 <_ZL9sleepyRunPv+0x6c>

        printString("Hello ");
    8000621c:	00003517          	auipc	a0,0x3
    80006220:	28c50513          	addi	a0,a0,652 # 800094a8 <CONSOLE_STATUS+0x498>
    80006224:	fffff097          	auipc	ra,0xfffff
    80006228:	79c080e7          	jalr	1948(ra) # 800059c0 <_Z11printStringPKc>
        printInt(sleep_time);
    8000622c:	00000613          	li	a2,0
    80006230:	00a00593          	li	a1,10
    80006234:	0009051b          	sext.w	a0,s2
    80006238:	00000097          	auipc	ra,0x0
    8000623c:	938080e7          	jalr	-1736(ra) # 80005b70 <_Z8printIntiii>
        printString(" !\n");
    80006240:	00003517          	auipc	a0,0x3
    80006244:	27050513          	addi	a0,a0,624 # 800094b0 <CONSOLE_STATUS+0x4a0>
    80006248:	fffff097          	auipc	ra,0xfffff
    8000624c:	778080e7          	jalr	1912(ra) # 800059c0 <_Z11printStringPKc>
        time_sleep(sleep_time);
    80006250:	00090513          	mv	a0,s2
    80006254:	ffffb097          	auipc	ra,0xffffb
    80006258:	2f4080e7          	jalr	756(ra) # 80001548 <_Z10time_sleepm>
    while (--i > 0) {
    8000625c:	fb9ff06f          	j	80006214 <_ZL9sleepyRunPv+0x20>
    }
    finished[sleep_time/10-1] = true;
    80006260:	00a00793          	li	a5,10
    80006264:	02f95933          	divu	s2,s2,a5
    80006268:	fff90913          	addi	s2,s2,-1
    8000626c:	00006797          	auipc	a5,0x6
    80006270:	9d478793          	addi	a5,a5,-1580 # 8000bc40 <_ZL8finished>
    80006274:	01278933          	add	s2,a5,s2
    80006278:	00100793          	li	a5,1
    8000627c:	00f90023          	sb	a5,0(s2)
}
    80006280:	01813083          	ld	ra,24(sp)
    80006284:	01013403          	ld	s0,16(sp)
    80006288:	00813483          	ld	s1,8(sp)
    8000628c:	00013903          	ld	s2,0(sp)
    80006290:	02010113          	addi	sp,sp,32
    80006294:	00008067          	ret

0000000080006298 <_Z12testSleepingv>:

void testSleeping() {
    80006298:	fc010113          	addi	sp,sp,-64
    8000629c:	02113c23          	sd	ra,56(sp)
    800062a0:	02813823          	sd	s0,48(sp)
    800062a4:	02913423          	sd	s1,40(sp)
    800062a8:	04010413          	addi	s0,sp,64
    const int sleepy_thread_count = 2;
    time_t sleep_times[sleepy_thread_count] = {10, 20};
    800062ac:	00a00793          	li	a5,10
    800062b0:	fcf43823          	sd	a5,-48(s0)
    800062b4:	01400793          	li	a5,20
    800062b8:	fcf43c23          	sd	a5,-40(s0)
    thread_t sleepyThread[sleepy_thread_count];

    for (int i = 0; i < sleepy_thread_count; i++) {
    800062bc:	00000493          	li	s1,0
    800062c0:	02c0006f          	j	800062ec <_Z12testSleepingv+0x54>
        thread_create(&sleepyThread[i], sleepyRun, sleep_times + i);
    800062c4:	00349793          	slli	a5,s1,0x3
    800062c8:	fd040613          	addi	a2,s0,-48
    800062cc:	00f60633          	add	a2,a2,a5
    800062d0:	00000597          	auipc	a1,0x0
    800062d4:	f2458593          	addi	a1,a1,-220 # 800061f4 <_ZL9sleepyRunPv>
    800062d8:	fc040513          	addi	a0,s0,-64
    800062dc:	00f50533          	add	a0,a0,a5
    800062e0:	ffffb097          	auipc	ra,0xffffb
    800062e4:	ff8080e7          	jalr	-8(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    for (int i = 0; i < sleepy_thread_count; i++) {
    800062e8:	0014849b          	addiw	s1,s1,1
    800062ec:	00100793          	li	a5,1
    800062f0:	fc97dae3          	bge	a5,s1,800062c4 <_Z12testSleepingv+0x2c>
    }

    while (!(finished[0] && finished[1])) {}
    800062f4:	00006797          	auipc	a5,0x6
    800062f8:	94c7c783          	lbu	a5,-1716(a5) # 8000bc40 <_ZL8finished>
    800062fc:	fe078ce3          	beqz	a5,800062f4 <_Z12testSleepingv+0x5c>
    80006300:	00006797          	auipc	a5,0x6
    80006304:	9417c783          	lbu	a5,-1727(a5) # 8000bc41 <_ZL8finished+0x1>
    80006308:	fe0786e3          	beqz	a5,800062f4 <_Z12testSleepingv+0x5c>
}
    8000630c:	03813083          	ld	ra,56(sp)
    80006310:	03013403          	ld	s0,48(sp)
    80006314:	02813483          	ld	s1,40(sp)
    80006318:	04010113          	addi	sp,sp,64
    8000631c:	00008067          	ret

0000000080006320 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80006320:	fe010113          	addi	sp,sp,-32
    80006324:	00113c23          	sd	ra,24(sp)
    80006328:	00813823          	sd	s0,16(sp)
    8000632c:	00913423          	sd	s1,8(sp)
    80006330:	01213023          	sd	s2,0(sp)
    80006334:	02010413          	addi	s0,sp,32
    80006338:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    8000633c:	00100793          	li	a5,1
    80006340:	02a7f863          	bgeu	a5,a0,80006370 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80006344:	00a00793          	li	a5,10
    80006348:	02f577b3          	remu	a5,a0,a5
    8000634c:	02078e63          	beqz	a5,80006388 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80006350:	fff48513          	addi	a0,s1,-1
    80006354:	00000097          	auipc	ra,0x0
    80006358:	fcc080e7          	jalr	-52(ra) # 80006320 <_ZL9fibonaccim>
    8000635c:	00050913          	mv	s2,a0
    80006360:	ffe48513          	addi	a0,s1,-2
    80006364:	00000097          	auipc	ra,0x0
    80006368:	fbc080e7          	jalr	-68(ra) # 80006320 <_ZL9fibonaccim>
    8000636c:	00a90533          	add	a0,s2,a0
}
    80006370:	01813083          	ld	ra,24(sp)
    80006374:	01013403          	ld	s0,16(sp)
    80006378:	00813483          	ld	s1,8(sp)
    8000637c:	00013903          	ld	s2,0(sp)
    80006380:	02010113          	addi	sp,sp,32
    80006384:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80006388:	ffffb097          	auipc	ra,0xffffb
    8000638c:	038080e7          	jalr	56(ra) # 800013c0 <_Z15thread_dispatchv>
    80006390:	fc1ff06f          	j	80006350 <_ZL9fibonaccim+0x30>

0000000080006394 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80006394:	fe010113          	addi	sp,sp,-32
    80006398:	00113c23          	sd	ra,24(sp)
    8000639c:	00813823          	sd	s0,16(sp)
    800063a0:	00913423          	sd	s1,8(sp)
    800063a4:	01213023          	sd	s2,0(sp)
    800063a8:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800063ac:	00a00493          	li	s1,10
    800063b0:	0400006f          	j	800063f0 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800063b4:	00003517          	auipc	a0,0x3
    800063b8:	db450513          	addi	a0,a0,-588 # 80009168 <CONSOLE_STATUS+0x158>
    800063bc:	fffff097          	auipc	ra,0xfffff
    800063c0:	604080e7          	jalr	1540(ra) # 800059c0 <_Z11printStringPKc>
    800063c4:	00000613          	li	a2,0
    800063c8:	00a00593          	li	a1,10
    800063cc:	00048513          	mv	a0,s1
    800063d0:	fffff097          	auipc	ra,0xfffff
    800063d4:	7a0080e7          	jalr	1952(ra) # 80005b70 <_Z8printIntiii>
    800063d8:	00003517          	auipc	a0,0x3
    800063dc:	f8050513          	addi	a0,a0,-128 # 80009358 <CONSOLE_STATUS+0x348>
    800063e0:	fffff097          	auipc	ra,0xfffff
    800063e4:	5e0080e7          	jalr	1504(ra) # 800059c0 <_Z11printStringPKc>
    for (; i < 13; i++) {
    800063e8:	0014849b          	addiw	s1,s1,1
    800063ec:	0ff4f493          	andi	s1,s1,255
    800063f0:	00c00793          	li	a5,12
    800063f4:	fc97f0e3          	bgeu	a5,s1,800063b4 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    800063f8:	00003517          	auipc	a0,0x3
    800063fc:	d7850513          	addi	a0,a0,-648 # 80009170 <CONSOLE_STATUS+0x160>
    80006400:	fffff097          	auipc	ra,0xfffff
    80006404:	5c0080e7          	jalr	1472(ra) # 800059c0 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80006408:	00500313          	li	t1,5
    thread_dispatch();
    8000640c:	ffffb097          	auipc	ra,0xffffb
    80006410:	fb4080e7          	jalr	-76(ra) # 800013c0 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80006414:	01000513          	li	a0,16
    80006418:	00000097          	auipc	ra,0x0
    8000641c:	f08080e7          	jalr	-248(ra) # 80006320 <_ZL9fibonaccim>
    80006420:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80006424:	00003517          	auipc	a0,0x3
    80006428:	d5c50513          	addi	a0,a0,-676 # 80009180 <CONSOLE_STATUS+0x170>
    8000642c:	fffff097          	auipc	ra,0xfffff
    80006430:	594080e7          	jalr	1428(ra) # 800059c0 <_Z11printStringPKc>
    80006434:	00000613          	li	a2,0
    80006438:	00a00593          	li	a1,10
    8000643c:	0009051b          	sext.w	a0,s2
    80006440:	fffff097          	auipc	ra,0xfffff
    80006444:	730080e7          	jalr	1840(ra) # 80005b70 <_Z8printIntiii>
    80006448:	00003517          	auipc	a0,0x3
    8000644c:	f1050513          	addi	a0,a0,-240 # 80009358 <CONSOLE_STATUS+0x348>
    80006450:	fffff097          	auipc	ra,0xfffff
    80006454:	570080e7          	jalr	1392(ra) # 800059c0 <_Z11printStringPKc>
    80006458:	0400006f          	j	80006498 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000645c:	00003517          	auipc	a0,0x3
    80006460:	d0c50513          	addi	a0,a0,-756 # 80009168 <CONSOLE_STATUS+0x158>
    80006464:	fffff097          	auipc	ra,0xfffff
    80006468:	55c080e7          	jalr	1372(ra) # 800059c0 <_Z11printStringPKc>
    8000646c:	00000613          	li	a2,0
    80006470:	00a00593          	li	a1,10
    80006474:	00048513          	mv	a0,s1
    80006478:	fffff097          	auipc	ra,0xfffff
    8000647c:	6f8080e7          	jalr	1784(ra) # 80005b70 <_Z8printIntiii>
    80006480:	00003517          	auipc	a0,0x3
    80006484:	ed850513          	addi	a0,a0,-296 # 80009358 <CONSOLE_STATUS+0x348>
    80006488:	fffff097          	auipc	ra,0xfffff
    8000648c:	538080e7          	jalr	1336(ra) # 800059c0 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80006490:	0014849b          	addiw	s1,s1,1
    80006494:	0ff4f493          	andi	s1,s1,255
    80006498:	00f00793          	li	a5,15
    8000649c:	fc97f0e3          	bgeu	a5,s1,8000645c <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800064a0:	00003517          	auipc	a0,0x3
    800064a4:	cf050513          	addi	a0,a0,-784 # 80009190 <CONSOLE_STATUS+0x180>
    800064a8:	fffff097          	auipc	ra,0xfffff
    800064ac:	518080e7          	jalr	1304(ra) # 800059c0 <_Z11printStringPKc>
    finishedD = true;
    800064b0:	00100793          	li	a5,1
    800064b4:	00005717          	auipc	a4,0x5
    800064b8:	78f70723          	sb	a5,1934(a4) # 8000bc42 <_ZL9finishedD>
    thread_dispatch();
    800064bc:	ffffb097          	auipc	ra,0xffffb
    800064c0:	f04080e7          	jalr	-252(ra) # 800013c0 <_Z15thread_dispatchv>
}
    800064c4:	01813083          	ld	ra,24(sp)
    800064c8:	01013403          	ld	s0,16(sp)
    800064cc:	00813483          	ld	s1,8(sp)
    800064d0:	00013903          	ld	s2,0(sp)
    800064d4:	02010113          	addi	sp,sp,32
    800064d8:	00008067          	ret

00000000800064dc <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    800064dc:	fe010113          	addi	sp,sp,-32
    800064e0:	00113c23          	sd	ra,24(sp)
    800064e4:	00813823          	sd	s0,16(sp)
    800064e8:	00913423          	sd	s1,8(sp)
    800064ec:	01213023          	sd	s2,0(sp)
    800064f0:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800064f4:	00000493          	li	s1,0
    800064f8:	0400006f          	j	80006538 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    800064fc:	00003517          	auipc	a0,0x3
    80006500:	c3c50513          	addi	a0,a0,-964 # 80009138 <CONSOLE_STATUS+0x128>
    80006504:	fffff097          	auipc	ra,0xfffff
    80006508:	4bc080e7          	jalr	1212(ra) # 800059c0 <_Z11printStringPKc>
    8000650c:	00000613          	li	a2,0
    80006510:	00a00593          	li	a1,10
    80006514:	00048513          	mv	a0,s1
    80006518:	fffff097          	auipc	ra,0xfffff
    8000651c:	658080e7          	jalr	1624(ra) # 80005b70 <_Z8printIntiii>
    80006520:	00003517          	auipc	a0,0x3
    80006524:	e3850513          	addi	a0,a0,-456 # 80009358 <CONSOLE_STATUS+0x348>
    80006528:	fffff097          	auipc	ra,0xfffff
    8000652c:	498080e7          	jalr	1176(ra) # 800059c0 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80006530:	0014849b          	addiw	s1,s1,1
    80006534:	0ff4f493          	andi	s1,s1,255
    80006538:	00200793          	li	a5,2
    8000653c:	fc97f0e3          	bgeu	a5,s1,800064fc <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80006540:	00003517          	auipc	a0,0x3
    80006544:	c0050513          	addi	a0,a0,-1024 # 80009140 <CONSOLE_STATUS+0x130>
    80006548:	fffff097          	auipc	ra,0xfffff
    8000654c:	478080e7          	jalr	1144(ra) # 800059c0 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80006550:	00700313          	li	t1,7
    thread_dispatch();
    80006554:	ffffb097          	auipc	ra,0xffffb
    80006558:	e6c080e7          	jalr	-404(ra) # 800013c0 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    8000655c:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80006560:	00003517          	auipc	a0,0x3
    80006564:	bf050513          	addi	a0,a0,-1040 # 80009150 <CONSOLE_STATUS+0x140>
    80006568:	fffff097          	auipc	ra,0xfffff
    8000656c:	458080e7          	jalr	1112(ra) # 800059c0 <_Z11printStringPKc>
    80006570:	00000613          	li	a2,0
    80006574:	00a00593          	li	a1,10
    80006578:	0009051b          	sext.w	a0,s2
    8000657c:	fffff097          	auipc	ra,0xfffff
    80006580:	5f4080e7          	jalr	1524(ra) # 80005b70 <_Z8printIntiii>
    80006584:	00003517          	auipc	a0,0x3
    80006588:	dd450513          	addi	a0,a0,-556 # 80009358 <CONSOLE_STATUS+0x348>
    8000658c:	fffff097          	auipc	ra,0xfffff
    80006590:	434080e7          	jalr	1076(ra) # 800059c0 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80006594:	00c00513          	li	a0,12
    80006598:	00000097          	auipc	ra,0x0
    8000659c:	d88080e7          	jalr	-632(ra) # 80006320 <_ZL9fibonaccim>
    800065a0:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800065a4:	00003517          	auipc	a0,0x3
    800065a8:	bb450513          	addi	a0,a0,-1100 # 80009158 <CONSOLE_STATUS+0x148>
    800065ac:	fffff097          	auipc	ra,0xfffff
    800065b0:	414080e7          	jalr	1044(ra) # 800059c0 <_Z11printStringPKc>
    800065b4:	00000613          	li	a2,0
    800065b8:	00a00593          	li	a1,10
    800065bc:	0009051b          	sext.w	a0,s2
    800065c0:	fffff097          	auipc	ra,0xfffff
    800065c4:	5b0080e7          	jalr	1456(ra) # 80005b70 <_Z8printIntiii>
    800065c8:	00003517          	auipc	a0,0x3
    800065cc:	d9050513          	addi	a0,a0,-624 # 80009358 <CONSOLE_STATUS+0x348>
    800065d0:	fffff097          	auipc	ra,0xfffff
    800065d4:	3f0080e7          	jalr	1008(ra) # 800059c0 <_Z11printStringPKc>
    800065d8:	0400006f          	j	80006618 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    800065dc:	00003517          	auipc	a0,0x3
    800065e0:	b5c50513          	addi	a0,a0,-1188 # 80009138 <CONSOLE_STATUS+0x128>
    800065e4:	fffff097          	auipc	ra,0xfffff
    800065e8:	3dc080e7          	jalr	988(ra) # 800059c0 <_Z11printStringPKc>
    800065ec:	00000613          	li	a2,0
    800065f0:	00a00593          	li	a1,10
    800065f4:	00048513          	mv	a0,s1
    800065f8:	fffff097          	auipc	ra,0xfffff
    800065fc:	578080e7          	jalr	1400(ra) # 80005b70 <_Z8printIntiii>
    80006600:	00003517          	auipc	a0,0x3
    80006604:	d5850513          	addi	a0,a0,-680 # 80009358 <CONSOLE_STATUS+0x348>
    80006608:	fffff097          	auipc	ra,0xfffff
    8000660c:	3b8080e7          	jalr	952(ra) # 800059c0 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80006610:	0014849b          	addiw	s1,s1,1
    80006614:	0ff4f493          	andi	s1,s1,255
    80006618:	00500793          	li	a5,5
    8000661c:	fc97f0e3          	bgeu	a5,s1,800065dc <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80006620:	00003517          	auipc	a0,0x3
    80006624:	af050513          	addi	a0,a0,-1296 # 80009110 <CONSOLE_STATUS+0x100>
    80006628:	fffff097          	auipc	ra,0xfffff
    8000662c:	398080e7          	jalr	920(ra) # 800059c0 <_Z11printStringPKc>
    finishedC = true;
    80006630:	00100793          	li	a5,1
    80006634:	00005717          	auipc	a4,0x5
    80006638:	60f707a3          	sb	a5,1551(a4) # 8000bc43 <_ZL9finishedC>
    thread_dispatch();
    8000663c:	ffffb097          	auipc	ra,0xffffb
    80006640:	d84080e7          	jalr	-636(ra) # 800013c0 <_Z15thread_dispatchv>
}
    80006644:	01813083          	ld	ra,24(sp)
    80006648:	01013403          	ld	s0,16(sp)
    8000664c:	00813483          	ld	s1,8(sp)
    80006650:	00013903          	ld	s2,0(sp)
    80006654:	02010113          	addi	sp,sp,32
    80006658:	00008067          	ret

000000008000665c <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    8000665c:	fe010113          	addi	sp,sp,-32
    80006660:	00113c23          	sd	ra,24(sp)
    80006664:	00813823          	sd	s0,16(sp)
    80006668:	00913423          	sd	s1,8(sp)
    8000666c:	01213023          	sd	s2,0(sp)
    80006670:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80006674:	00000913          	li	s2,0
    80006678:	0400006f          	j	800066b8 <_ZL11workerBodyBPv+0x5c>
            thread_dispatch();
    8000667c:	ffffb097          	auipc	ra,0xffffb
    80006680:	d44080e7          	jalr	-700(ra) # 800013c0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80006684:	00148493          	addi	s1,s1,1
    80006688:	000027b7          	lui	a5,0x2
    8000668c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80006690:	0097ee63          	bltu	a5,s1,800066ac <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80006694:	00000713          	li	a4,0
    80006698:	000077b7          	lui	a5,0x7
    8000669c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800066a0:	fce7eee3          	bltu	a5,a4,8000667c <_ZL11workerBodyBPv+0x20>
    800066a4:	00170713          	addi	a4,a4,1
    800066a8:	ff1ff06f          	j	80006698 <_ZL11workerBodyBPv+0x3c>
        if (i == 10) {
    800066ac:	00a00793          	li	a5,10
    800066b0:	04f90663          	beq	s2,a5,800066fc <_ZL11workerBodyBPv+0xa0>
    for (uint64 i = 0; i < 16; i++) {
    800066b4:	00190913          	addi	s2,s2,1
    800066b8:	00f00793          	li	a5,15
    800066bc:	0527e463          	bltu	a5,s2,80006704 <_ZL11workerBodyBPv+0xa8>
        printString("B: i="); printInt(i); printString("\n");
    800066c0:	00003517          	auipc	a0,0x3
    800066c4:	a6050513          	addi	a0,a0,-1440 # 80009120 <CONSOLE_STATUS+0x110>
    800066c8:	fffff097          	auipc	ra,0xfffff
    800066cc:	2f8080e7          	jalr	760(ra) # 800059c0 <_Z11printStringPKc>
    800066d0:	00000613          	li	a2,0
    800066d4:	00a00593          	li	a1,10
    800066d8:	0009051b          	sext.w	a0,s2
    800066dc:	fffff097          	auipc	ra,0xfffff
    800066e0:	494080e7          	jalr	1172(ra) # 80005b70 <_Z8printIntiii>
    800066e4:	00003517          	auipc	a0,0x3
    800066e8:	c7450513          	addi	a0,a0,-908 # 80009358 <CONSOLE_STATUS+0x348>
    800066ec:	fffff097          	auipc	ra,0xfffff
    800066f0:	2d4080e7          	jalr	724(ra) # 800059c0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800066f4:	00000493          	li	s1,0
    800066f8:	f91ff06f          	j	80006688 <_ZL11workerBodyBPv+0x2c>
            asm volatile("csrr t6, sepc");
    800066fc:	14102ff3          	csrr	t6,sepc
    80006700:	fb5ff06f          	j	800066b4 <_ZL11workerBodyBPv+0x58>
    printString("B finished!\n");
    80006704:	00003517          	auipc	a0,0x3
    80006708:	a2450513          	addi	a0,a0,-1500 # 80009128 <CONSOLE_STATUS+0x118>
    8000670c:	fffff097          	auipc	ra,0xfffff
    80006710:	2b4080e7          	jalr	692(ra) # 800059c0 <_Z11printStringPKc>
    finishedB = true;
    80006714:	00100793          	li	a5,1
    80006718:	00005717          	auipc	a4,0x5
    8000671c:	52f70623          	sb	a5,1324(a4) # 8000bc44 <_ZL9finishedB>
    thread_dispatch();
    80006720:	ffffb097          	auipc	ra,0xffffb
    80006724:	ca0080e7          	jalr	-864(ra) # 800013c0 <_Z15thread_dispatchv>
}
    80006728:	01813083          	ld	ra,24(sp)
    8000672c:	01013403          	ld	s0,16(sp)
    80006730:	00813483          	ld	s1,8(sp)
    80006734:	00013903          	ld	s2,0(sp)
    80006738:	02010113          	addi	sp,sp,32
    8000673c:	00008067          	ret

0000000080006740 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80006740:	fe010113          	addi	sp,sp,-32
    80006744:	00113c23          	sd	ra,24(sp)
    80006748:	00813823          	sd	s0,16(sp)
    8000674c:	00913423          	sd	s1,8(sp)
    80006750:	01213023          	sd	s2,0(sp)
    80006754:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80006758:	00000913          	li	s2,0
    8000675c:	0380006f          	j	80006794 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80006760:	ffffb097          	auipc	ra,0xffffb
    80006764:	c60080e7          	jalr	-928(ra) # 800013c0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80006768:	00148493          	addi	s1,s1,1
    8000676c:	000027b7          	lui	a5,0x2
    80006770:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80006774:	0097ee63          	bltu	a5,s1,80006790 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80006778:	00000713          	li	a4,0
    8000677c:	000077b7          	lui	a5,0x7
    80006780:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80006784:	fce7eee3          	bltu	a5,a4,80006760 <_ZL11workerBodyAPv+0x20>
    80006788:	00170713          	addi	a4,a4,1
    8000678c:	ff1ff06f          	j	8000677c <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80006790:	00190913          	addi	s2,s2,1
    80006794:	00900793          	li	a5,9
    80006798:	0527e063          	bltu	a5,s2,800067d8 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    8000679c:	00003517          	auipc	a0,0x3
    800067a0:	96c50513          	addi	a0,a0,-1684 # 80009108 <CONSOLE_STATUS+0xf8>
    800067a4:	fffff097          	auipc	ra,0xfffff
    800067a8:	21c080e7          	jalr	540(ra) # 800059c0 <_Z11printStringPKc>
    800067ac:	00000613          	li	a2,0
    800067b0:	00a00593          	li	a1,10
    800067b4:	0009051b          	sext.w	a0,s2
    800067b8:	fffff097          	auipc	ra,0xfffff
    800067bc:	3b8080e7          	jalr	952(ra) # 80005b70 <_Z8printIntiii>
    800067c0:	00003517          	auipc	a0,0x3
    800067c4:	b9850513          	addi	a0,a0,-1128 # 80009358 <CONSOLE_STATUS+0x348>
    800067c8:	fffff097          	auipc	ra,0xfffff
    800067cc:	1f8080e7          	jalr	504(ra) # 800059c0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800067d0:	00000493          	li	s1,0
    800067d4:	f99ff06f          	j	8000676c <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800067d8:	00003517          	auipc	a0,0x3
    800067dc:	93850513          	addi	a0,a0,-1736 # 80009110 <CONSOLE_STATUS+0x100>
    800067e0:	fffff097          	auipc	ra,0xfffff
    800067e4:	1e0080e7          	jalr	480(ra) # 800059c0 <_Z11printStringPKc>
    finishedA = true;
    800067e8:	00100793          	li	a5,1
    800067ec:	00005717          	auipc	a4,0x5
    800067f0:	44f70ca3          	sb	a5,1113(a4) # 8000bc45 <_ZL9finishedA>
}
    800067f4:	01813083          	ld	ra,24(sp)
    800067f8:	01013403          	ld	s0,16(sp)
    800067fc:	00813483          	ld	s1,8(sp)
    80006800:	00013903          	ld	s2,0(sp)
    80006804:	02010113          	addi	sp,sp,32
    80006808:	00008067          	ret

000000008000680c <_Z16System_Mode_testv>:


void System_Mode_test() {
    8000680c:	fd010113          	addi	sp,sp,-48
    80006810:	02113423          	sd	ra,40(sp)
    80006814:	02813023          	sd	s0,32(sp)
    80006818:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    8000681c:	00000613          	li	a2,0
    80006820:	00000597          	auipc	a1,0x0
    80006824:	f2058593          	addi	a1,a1,-224 # 80006740 <_ZL11workerBodyAPv>
    80006828:	fd040513          	addi	a0,s0,-48
    8000682c:	ffffb097          	auipc	ra,0xffffb
    80006830:	aac080e7          	jalr	-1364(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadA created\n");
    80006834:	00003517          	auipc	a0,0x3
    80006838:	96c50513          	addi	a0,a0,-1684 # 800091a0 <CONSOLE_STATUS+0x190>
    8000683c:	fffff097          	auipc	ra,0xfffff
    80006840:	184080e7          	jalr	388(ra) # 800059c0 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80006844:	00000613          	li	a2,0
    80006848:	00000597          	auipc	a1,0x0
    8000684c:	e1458593          	addi	a1,a1,-492 # 8000665c <_ZL11workerBodyBPv>
    80006850:	fd840513          	addi	a0,s0,-40
    80006854:	ffffb097          	auipc	ra,0xffffb
    80006858:	a84080e7          	jalr	-1404(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadB created\n");
    8000685c:	00003517          	auipc	a0,0x3
    80006860:	95c50513          	addi	a0,a0,-1700 # 800091b8 <CONSOLE_STATUS+0x1a8>
    80006864:	fffff097          	auipc	ra,0xfffff
    80006868:	15c080e7          	jalr	348(ra) # 800059c0 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    8000686c:	00000613          	li	a2,0
    80006870:	00000597          	auipc	a1,0x0
    80006874:	c6c58593          	addi	a1,a1,-916 # 800064dc <_ZL11workerBodyCPv>
    80006878:	fe040513          	addi	a0,s0,-32
    8000687c:	ffffb097          	auipc	ra,0xffffb
    80006880:	a5c080e7          	jalr	-1444(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadC created\n");
    80006884:	00003517          	auipc	a0,0x3
    80006888:	94c50513          	addi	a0,a0,-1716 # 800091d0 <CONSOLE_STATUS+0x1c0>
    8000688c:	fffff097          	auipc	ra,0xfffff
    80006890:	134080e7          	jalr	308(ra) # 800059c0 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80006894:	00000613          	li	a2,0
    80006898:	00000597          	auipc	a1,0x0
    8000689c:	afc58593          	addi	a1,a1,-1284 # 80006394 <_ZL11workerBodyDPv>
    800068a0:	fe840513          	addi	a0,s0,-24
    800068a4:	ffffb097          	auipc	ra,0xffffb
    800068a8:	a34080e7          	jalr	-1484(ra) # 800012d8 <_Z13thread_createPP3TCBPFvPvES2_>
    printString("ThreadD created\n");
    800068ac:	00003517          	auipc	a0,0x3
    800068b0:	93c50513          	addi	a0,a0,-1732 # 800091e8 <CONSOLE_STATUS+0x1d8>
    800068b4:	fffff097          	auipc	ra,0xfffff
    800068b8:	10c080e7          	jalr	268(ra) # 800059c0 <_Z11printStringPKc>
    800068bc:	00c0006f          	j	800068c8 <_Z16System_Mode_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800068c0:	ffffb097          	auipc	ra,0xffffb
    800068c4:	b00080e7          	jalr	-1280(ra) # 800013c0 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800068c8:	00005797          	auipc	a5,0x5
    800068cc:	37d7c783          	lbu	a5,893(a5) # 8000bc45 <_ZL9finishedA>
    800068d0:	fe0788e3          	beqz	a5,800068c0 <_Z16System_Mode_testv+0xb4>
    800068d4:	00005797          	auipc	a5,0x5
    800068d8:	3707c783          	lbu	a5,880(a5) # 8000bc44 <_ZL9finishedB>
    800068dc:	fe0782e3          	beqz	a5,800068c0 <_Z16System_Mode_testv+0xb4>
    800068e0:	00005797          	auipc	a5,0x5
    800068e4:	3637c783          	lbu	a5,867(a5) # 8000bc43 <_ZL9finishedC>
    800068e8:	fc078ce3          	beqz	a5,800068c0 <_Z16System_Mode_testv+0xb4>
    800068ec:	00005797          	auipc	a5,0x5
    800068f0:	3567c783          	lbu	a5,854(a5) # 8000bc42 <_ZL9finishedD>
    800068f4:	fc0786e3          	beqz	a5,800068c0 <_Z16System_Mode_testv+0xb4>
    }

}
    800068f8:	02813083          	ld	ra,40(sp)
    800068fc:	02013403          	ld	s0,32(sp)
    80006900:	03010113          	addi	sp,sp,48
    80006904:	00008067          	ret

0000000080006908 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80006908:	fe010113          	addi	sp,sp,-32
    8000690c:	00113c23          	sd	ra,24(sp)
    80006910:	00813823          	sd	s0,16(sp)
    80006914:	00913423          	sd	s1,8(sp)
    80006918:	01213023          	sd	s2,0(sp)
    8000691c:	02010413          	addi	s0,sp,32
    80006920:	00050493          	mv	s1,a0
    80006924:	00058913          	mv	s2,a1
    80006928:	0015879b          	addiw	a5,a1,1
    8000692c:	0007851b          	sext.w	a0,a5
    80006930:	00f4a023          	sw	a5,0(s1)
    80006934:	0004a823          	sw	zero,16(s1)
    80006938:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)mem_alloc(sizeof(int) * cap);
    8000693c:	00251513          	slli	a0,a0,0x2
    80006940:	ffffb097          	auipc	ra,0xffffb
    80006944:	948080e7          	jalr	-1720(ra) # 80001288 <_Z9mem_allocm>
    80006948:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    8000694c:	00000593          	li	a1,0
    80006950:	02048513          	addi	a0,s1,32
    80006954:	ffffb097          	auipc	ra,0xffffb
    80006958:	a8c080e7          	jalr	-1396(ra) # 800013e0 <_Z8sem_openPP10_Semaphorej>
    sem_open(&spaceAvailable, _cap);
    8000695c:	00090593          	mv	a1,s2
    80006960:	01848513          	addi	a0,s1,24
    80006964:	ffffb097          	auipc	ra,0xffffb
    80006968:	a7c080e7          	jalr	-1412(ra) # 800013e0 <_Z8sem_openPP10_Semaphorej>
    sem_open(&mutexHead, 1);
    8000696c:	00100593          	li	a1,1
    80006970:	02848513          	addi	a0,s1,40
    80006974:	ffffb097          	auipc	ra,0xffffb
    80006978:	a6c080e7          	jalr	-1428(ra) # 800013e0 <_Z8sem_openPP10_Semaphorej>
    sem_open(&mutexTail, 1);
    8000697c:	00100593          	li	a1,1
    80006980:	03048513          	addi	a0,s1,48
    80006984:	ffffb097          	auipc	ra,0xffffb
    80006988:	a5c080e7          	jalr	-1444(ra) # 800013e0 <_Z8sem_openPP10_Semaphorej>
}
    8000698c:	01813083          	ld	ra,24(sp)
    80006990:	01013403          	ld	s0,16(sp)
    80006994:	00813483          	ld	s1,8(sp)
    80006998:	00013903          	ld	s2,0(sp)
    8000699c:	02010113          	addi	sp,sp,32
    800069a0:	00008067          	ret

00000000800069a4 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    800069a4:	fe010113          	addi	sp,sp,-32
    800069a8:	00113c23          	sd	ra,24(sp)
    800069ac:	00813823          	sd	s0,16(sp)
    800069b0:	00913423          	sd	s1,8(sp)
    800069b4:	01213023          	sd	s2,0(sp)
    800069b8:	02010413          	addi	s0,sp,32
    800069bc:	00050493          	mv	s1,a0
    800069c0:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    800069c4:	01853503          	ld	a0,24(a0)
    800069c8:	ffffb097          	auipc	ra,0xffffb
    800069cc:	a78080e7          	jalr	-1416(ra) # 80001440 <_Z8sem_waitP10_Semaphore>

    sem_wait(mutexTail);
    800069d0:	0304b503          	ld	a0,48(s1)
    800069d4:	ffffb097          	auipc	ra,0xffffb
    800069d8:	a6c080e7          	jalr	-1428(ra) # 80001440 <_Z8sem_waitP10_Semaphore>
    buffer[tail] = val;
    800069dc:	0084b783          	ld	a5,8(s1)
    800069e0:	0144a703          	lw	a4,20(s1)
    800069e4:	00271713          	slli	a4,a4,0x2
    800069e8:	00e787b3          	add	a5,a5,a4
    800069ec:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800069f0:	0144a783          	lw	a5,20(s1)
    800069f4:	0017879b          	addiw	a5,a5,1
    800069f8:	0004a703          	lw	a4,0(s1)
    800069fc:	02e7e7bb          	remw	a5,a5,a4
    80006a00:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    80006a04:	0304b503          	ld	a0,48(s1)
    80006a08:	ffffb097          	auipc	ra,0xffffb
    80006a0c:	a60080e7          	jalr	-1440(ra) # 80001468 <_Z10sem_signalP10_Semaphore>

    sem_signal(itemAvailable);
    80006a10:	0204b503          	ld	a0,32(s1)
    80006a14:	ffffb097          	auipc	ra,0xffffb
    80006a18:	a54080e7          	jalr	-1452(ra) # 80001468 <_Z10sem_signalP10_Semaphore>

}
    80006a1c:	01813083          	ld	ra,24(sp)
    80006a20:	01013403          	ld	s0,16(sp)
    80006a24:	00813483          	ld	s1,8(sp)
    80006a28:	00013903          	ld	s2,0(sp)
    80006a2c:	02010113          	addi	sp,sp,32
    80006a30:	00008067          	ret

0000000080006a34 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80006a34:	fe010113          	addi	sp,sp,-32
    80006a38:	00113c23          	sd	ra,24(sp)
    80006a3c:	00813823          	sd	s0,16(sp)
    80006a40:	00913423          	sd	s1,8(sp)
    80006a44:	01213023          	sd	s2,0(sp)
    80006a48:	02010413          	addi	s0,sp,32
    80006a4c:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80006a50:	02053503          	ld	a0,32(a0)
    80006a54:	ffffb097          	auipc	ra,0xffffb
    80006a58:	9ec080e7          	jalr	-1556(ra) # 80001440 <_Z8sem_waitP10_Semaphore>

    sem_wait(mutexHead);
    80006a5c:	0284b503          	ld	a0,40(s1)
    80006a60:	ffffb097          	auipc	ra,0xffffb
    80006a64:	9e0080e7          	jalr	-1568(ra) # 80001440 <_Z8sem_waitP10_Semaphore>

    int ret = buffer[head];
    80006a68:	0084b703          	ld	a4,8(s1)
    80006a6c:	0104a783          	lw	a5,16(s1)
    80006a70:	00279693          	slli	a3,a5,0x2
    80006a74:	00d70733          	add	a4,a4,a3
    80006a78:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80006a7c:	0017879b          	addiw	a5,a5,1
    80006a80:	0004a703          	lw	a4,0(s1)
    80006a84:	02e7e7bb          	remw	a5,a5,a4
    80006a88:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    80006a8c:	0284b503          	ld	a0,40(s1)
    80006a90:	ffffb097          	auipc	ra,0xffffb
    80006a94:	9d8080e7          	jalr	-1576(ra) # 80001468 <_Z10sem_signalP10_Semaphore>

    sem_signal(spaceAvailable);
    80006a98:	0184b503          	ld	a0,24(s1)
    80006a9c:	ffffb097          	auipc	ra,0xffffb
    80006aa0:	9cc080e7          	jalr	-1588(ra) # 80001468 <_Z10sem_signalP10_Semaphore>

    return ret;
}
    80006aa4:	00090513          	mv	a0,s2
    80006aa8:	01813083          	ld	ra,24(sp)
    80006aac:	01013403          	ld	s0,16(sp)
    80006ab0:	00813483          	ld	s1,8(sp)
    80006ab4:	00013903          	ld	s2,0(sp)
    80006ab8:	02010113          	addi	sp,sp,32
    80006abc:	00008067          	ret

0000000080006ac0 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80006ac0:	fe010113          	addi	sp,sp,-32
    80006ac4:	00113c23          	sd	ra,24(sp)
    80006ac8:	00813823          	sd	s0,16(sp)
    80006acc:	00913423          	sd	s1,8(sp)
    80006ad0:	01213023          	sd	s2,0(sp)
    80006ad4:	02010413          	addi	s0,sp,32
    80006ad8:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    80006adc:	02853503          	ld	a0,40(a0)
    80006ae0:	ffffb097          	auipc	ra,0xffffb
    80006ae4:	960080e7          	jalr	-1696(ra) # 80001440 <_Z8sem_waitP10_Semaphore>
    sem_wait(mutexTail);
    80006ae8:	0304b503          	ld	a0,48(s1)
    80006aec:	ffffb097          	auipc	ra,0xffffb
    80006af0:	954080e7          	jalr	-1708(ra) # 80001440 <_Z8sem_waitP10_Semaphore>

    if (tail >= head) {
    80006af4:	0144a783          	lw	a5,20(s1)
    80006af8:	0104a903          	lw	s2,16(s1)
    80006afc:	0327ce63          	blt	a5,s2,80006b38 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    80006b00:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    80006b04:	0304b503          	ld	a0,48(s1)
    80006b08:	ffffb097          	auipc	ra,0xffffb
    80006b0c:	960080e7          	jalr	-1696(ra) # 80001468 <_Z10sem_signalP10_Semaphore>
    sem_signal(mutexHead);
    80006b10:	0284b503          	ld	a0,40(s1)
    80006b14:	ffffb097          	auipc	ra,0xffffb
    80006b18:	954080e7          	jalr	-1708(ra) # 80001468 <_Z10sem_signalP10_Semaphore>

    return ret;
}
    80006b1c:	00090513          	mv	a0,s2
    80006b20:	01813083          	ld	ra,24(sp)
    80006b24:	01013403          	ld	s0,16(sp)
    80006b28:	00813483          	ld	s1,8(sp)
    80006b2c:	00013903          	ld	s2,0(sp)
    80006b30:	02010113          	addi	sp,sp,32
    80006b34:	00008067          	ret
        ret = cap - head + tail;
    80006b38:	0004a703          	lw	a4,0(s1)
    80006b3c:	4127093b          	subw	s2,a4,s2
    80006b40:	00f9093b          	addw	s2,s2,a5
    80006b44:	fc1ff06f          	j	80006b04 <_ZN6Buffer6getCntEv+0x44>

0000000080006b48 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80006b48:	fe010113          	addi	sp,sp,-32
    80006b4c:	00113c23          	sd	ra,24(sp)
    80006b50:	00813823          	sd	s0,16(sp)
    80006b54:	00913423          	sd	s1,8(sp)
    80006b58:	02010413          	addi	s0,sp,32
    80006b5c:	00050493          	mv	s1,a0
    putc('\n');
    80006b60:	00a00513          	li	a0,10
    80006b64:	ffffb097          	auipc	ra,0xffffb
    80006b68:	9c0080e7          	jalr	-1600(ra) # 80001524 <_Z4putcc>
    printString("Buffer deleted!\n");
    80006b6c:	00002517          	auipc	a0,0x2
    80006b70:	69450513          	addi	a0,a0,1684 # 80009200 <CONSOLE_STATUS+0x1f0>
    80006b74:	fffff097          	auipc	ra,0xfffff
    80006b78:	e4c080e7          	jalr	-436(ra) # 800059c0 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80006b7c:	00048513          	mv	a0,s1
    80006b80:	00000097          	auipc	ra,0x0
    80006b84:	f40080e7          	jalr	-192(ra) # 80006ac0 <_ZN6Buffer6getCntEv>
    80006b88:	02a05c63          	blez	a0,80006bc0 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80006b8c:	0084b783          	ld	a5,8(s1)
    80006b90:	0104a703          	lw	a4,16(s1)
    80006b94:	00271713          	slli	a4,a4,0x2
    80006b98:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80006b9c:	0007c503          	lbu	a0,0(a5)
    80006ba0:	ffffb097          	auipc	ra,0xffffb
    80006ba4:	984080e7          	jalr	-1660(ra) # 80001524 <_Z4putcc>
        head = (head + 1) % cap;
    80006ba8:	0104a783          	lw	a5,16(s1)
    80006bac:	0017879b          	addiw	a5,a5,1
    80006bb0:	0004a703          	lw	a4,0(s1)
    80006bb4:	02e7e7bb          	remw	a5,a5,a4
    80006bb8:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80006bbc:	fc1ff06f          	j	80006b7c <_ZN6BufferD1Ev+0x34>
    putc('!');
    80006bc0:	02100513          	li	a0,33
    80006bc4:	ffffb097          	auipc	ra,0xffffb
    80006bc8:	960080e7          	jalr	-1696(ra) # 80001524 <_Z4putcc>
    putc('\n');
    80006bcc:	00a00513          	li	a0,10
    80006bd0:	ffffb097          	auipc	ra,0xffffb
    80006bd4:	954080e7          	jalr	-1708(ra) # 80001524 <_Z4putcc>
    mem_free(buffer);
    80006bd8:	0084b503          	ld	a0,8(s1)
    80006bdc:	ffffa097          	auipc	ra,0xffffa
    80006be0:	6d4080e7          	jalr	1748(ra) # 800012b0 <_Z8mem_freePv>
    sem_close(itemAvailable);
    80006be4:	0204b503          	ld	a0,32(s1)
    80006be8:	ffffb097          	auipc	ra,0xffffb
    80006bec:	830080e7          	jalr	-2000(ra) # 80001418 <_Z9sem_closeP10_Semaphore>
    sem_close(spaceAvailable);
    80006bf0:	0184b503          	ld	a0,24(s1)
    80006bf4:	ffffb097          	auipc	ra,0xffffb
    80006bf8:	824080e7          	jalr	-2012(ra) # 80001418 <_Z9sem_closeP10_Semaphore>
    sem_close(mutexTail);
    80006bfc:	0304b503          	ld	a0,48(s1)
    80006c00:	ffffb097          	auipc	ra,0xffffb
    80006c04:	818080e7          	jalr	-2024(ra) # 80001418 <_Z9sem_closeP10_Semaphore>
    sem_close(mutexHead);
    80006c08:	0284b503          	ld	a0,40(s1)
    80006c0c:	ffffb097          	auipc	ra,0xffffb
    80006c10:	80c080e7          	jalr	-2036(ra) # 80001418 <_Z9sem_closeP10_Semaphore>
}
    80006c14:	01813083          	ld	ra,24(sp)
    80006c18:	01013403          	ld	s0,16(sp)
    80006c1c:	00813483          	ld	s1,8(sp)
    80006c20:	02010113          	addi	sp,sp,32
    80006c24:	00008067          	ret

0000000080006c28 <start>:
    80006c28:	ff010113          	addi	sp,sp,-16
    80006c2c:	00813423          	sd	s0,8(sp)
    80006c30:	01010413          	addi	s0,sp,16
    80006c34:	300027f3          	csrr	a5,mstatus
    80006c38:	ffffe737          	lui	a4,0xffffe
    80006c3c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff194f>
    80006c40:	00e7f7b3          	and	a5,a5,a4
    80006c44:	00001737          	lui	a4,0x1
    80006c48:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80006c4c:	00e7e7b3          	or	a5,a5,a4
    80006c50:	30079073          	csrw	mstatus,a5
    80006c54:	00000797          	auipc	a5,0x0
    80006c58:	16078793          	addi	a5,a5,352 # 80006db4 <system_main>
    80006c5c:	34179073          	csrw	mepc,a5
    80006c60:	00000793          	li	a5,0
    80006c64:	18079073          	csrw	satp,a5
    80006c68:	000107b7          	lui	a5,0x10
    80006c6c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80006c70:	30279073          	csrw	medeleg,a5
    80006c74:	30379073          	csrw	mideleg,a5
    80006c78:	104027f3          	csrr	a5,sie
    80006c7c:	2227e793          	ori	a5,a5,546
    80006c80:	10479073          	csrw	sie,a5
    80006c84:	fff00793          	li	a5,-1
    80006c88:	00a7d793          	srli	a5,a5,0xa
    80006c8c:	3b079073          	csrw	pmpaddr0,a5
    80006c90:	00f00793          	li	a5,15
    80006c94:	3a079073          	csrw	pmpcfg0,a5
    80006c98:	f14027f3          	csrr	a5,mhartid
    80006c9c:	0200c737          	lui	a4,0x200c
    80006ca0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006ca4:	0007869b          	sext.w	a3,a5
    80006ca8:	00269713          	slli	a4,a3,0x2
    80006cac:	000f4637          	lui	a2,0xf4
    80006cb0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006cb4:	00d70733          	add	a4,a4,a3
    80006cb8:	0037979b          	slliw	a5,a5,0x3
    80006cbc:	020046b7          	lui	a3,0x2004
    80006cc0:	00d787b3          	add	a5,a5,a3
    80006cc4:	00c585b3          	add	a1,a1,a2
    80006cc8:	00371693          	slli	a3,a4,0x3
    80006ccc:	00005717          	auipc	a4,0x5
    80006cd0:	f8470713          	addi	a4,a4,-124 # 8000bc50 <timer_scratch>
    80006cd4:	00b7b023          	sd	a1,0(a5)
    80006cd8:	00d70733          	add	a4,a4,a3
    80006cdc:	00f73c23          	sd	a5,24(a4)
    80006ce0:	02c73023          	sd	a2,32(a4)
    80006ce4:	34071073          	csrw	mscratch,a4
    80006ce8:	00000797          	auipc	a5,0x0
    80006cec:	6e878793          	addi	a5,a5,1768 # 800073d0 <timervec>
    80006cf0:	30579073          	csrw	mtvec,a5
    80006cf4:	300027f3          	csrr	a5,mstatus
    80006cf8:	0087e793          	ori	a5,a5,8
    80006cfc:	30079073          	csrw	mstatus,a5
    80006d00:	304027f3          	csrr	a5,mie
    80006d04:	0807e793          	ori	a5,a5,128
    80006d08:	30479073          	csrw	mie,a5
    80006d0c:	f14027f3          	csrr	a5,mhartid
    80006d10:	0007879b          	sext.w	a5,a5
    80006d14:	00078213          	mv	tp,a5
    80006d18:	30200073          	mret
    80006d1c:	00813403          	ld	s0,8(sp)
    80006d20:	01010113          	addi	sp,sp,16
    80006d24:	00008067          	ret

0000000080006d28 <timerinit>:
    80006d28:	ff010113          	addi	sp,sp,-16
    80006d2c:	00813423          	sd	s0,8(sp)
    80006d30:	01010413          	addi	s0,sp,16
    80006d34:	f14027f3          	csrr	a5,mhartid
    80006d38:	0200c737          	lui	a4,0x200c
    80006d3c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80006d40:	0007869b          	sext.w	a3,a5
    80006d44:	00269713          	slli	a4,a3,0x2
    80006d48:	000f4637          	lui	a2,0xf4
    80006d4c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80006d50:	00d70733          	add	a4,a4,a3
    80006d54:	0037979b          	slliw	a5,a5,0x3
    80006d58:	020046b7          	lui	a3,0x2004
    80006d5c:	00d787b3          	add	a5,a5,a3
    80006d60:	00c585b3          	add	a1,a1,a2
    80006d64:	00371693          	slli	a3,a4,0x3
    80006d68:	00005717          	auipc	a4,0x5
    80006d6c:	ee870713          	addi	a4,a4,-280 # 8000bc50 <timer_scratch>
    80006d70:	00b7b023          	sd	a1,0(a5)
    80006d74:	00d70733          	add	a4,a4,a3
    80006d78:	00f73c23          	sd	a5,24(a4)
    80006d7c:	02c73023          	sd	a2,32(a4)
    80006d80:	34071073          	csrw	mscratch,a4
    80006d84:	00000797          	auipc	a5,0x0
    80006d88:	64c78793          	addi	a5,a5,1612 # 800073d0 <timervec>
    80006d8c:	30579073          	csrw	mtvec,a5
    80006d90:	300027f3          	csrr	a5,mstatus
    80006d94:	0087e793          	ori	a5,a5,8
    80006d98:	30079073          	csrw	mstatus,a5
    80006d9c:	304027f3          	csrr	a5,mie
    80006da0:	0807e793          	ori	a5,a5,128
    80006da4:	30479073          	csrw	mie,a5
    80006da8:	00813403          	ld	s0,8(sp)
    80006dac:	01010113          	addi	sp,sp,16
    80006db0:	00008067          	ret

0000000080006db4 <system_main>:
    80006db4:	fe010113          	addi	sp,sp,-32
    80006db8:	00813823          	sd	s0,16(sp)
    80006dbc:	00913423          	sd	s1,8(sp)
    80006dc0:	00113c23          	sd	ra,24(sp)
    80006dc4:	02010413          	addi	s0,sp,32
    80006dc8:	00000097          	auipc	ra,0x0
    80006dcc:	0c4080e7          	jalr	196(ra) # 80006e8c <cpuid>
    80006dd0:	00005497          	auipc	s1,0x5
    80006dd4:	d4048493          	addi	s1,s1,-704 # 8000bb10 <started>
    80006dd8:	02050263          	beqz	a0,80006dfc <system_main+0x48>
    80006ddc:	0004a783          	lw	a5,0(s1)
    80006de0:	0007879b          	sext.w	a5,a5
    80006de4:	fe078ce3          	beqz	a5,80006ddc <system_main+0x28>
    80006de8:	0ff0000f          	fence
    80006dec:	00002517          	auipc	a0,0x2
    80006df0:	6fc50513          	addi	a0,a0,1788 # 800094e8 <CONSOLE_STATUS+0x4d8>
    80006df4:	00001097          	auipc	ra,0x1
    80006df8:	a78080e7          	jalr	-1416(ra) # 8000786c <panic>
    80006dfc:	00001097          	auipc	ra,0x1
    80006e00:	9cc080e7          	jalr	-1588(ra) # 800077c8 <consoleinit>
    80006e04:	00001097          	auipc	ra,0x1
    80006e08:	158080e7          	jalr	344(ra) # 80007f5c <printfinit>
    80006e0c:	00002517          	auipc	a0,0x2
    80006e10:	54c50513          	addi	a0,a0,1356 # 80009358 <CONSOLE_STATUS+0x348>
    80006e14:	00001097          	auipc	ra,0x1
    80006e18:	ab4080e7          	jalr	-1356(ra) # 800078c8 <__printf>
    80006e1c:	00002517          	auipc	a0,0x2
    80006e20:	69c50513          	addi	a0,a0,1692 # 800094b8 <CONSOLE_STATUS+0x4a8>
    80006e24:	00001097          	auipc	ra,0x1
    80006e28:	aa4080e7          	jalr	-1372(ra) # 800078c8 <__printf>
    80006e2c:	00002517          	auipc	a0,0x2
    80006e30:	52c50513          	addi	a0,a0,1324 # 80009358 <CONSOLE_STATUS+0x348>
    80006e34:	00001097          	auipc	ra,0x1
    80006e38:	a94080e7          	jalr	-1388(ra) # 800078c8 <__printf>
    80006e3c:	00001097          	auipc	ra,0x1
    80006e40:	4ac080e7          	jalr	1196(ra) # 800082e8 <kinit>
    80006e44:	00000097          	auipc	ra,0x0
    80006e48:	148080e7          	jalr	328(ra) # 80006f8c <trapinit>
    80006e4c:	00000097          	auipc	ra,0x0
    80006e50:	16c080e7          	jalr	364(ra) # 80006fb8 <trapinithart>
    80006e54:	00000097          	auipc	ra,0x0
    80006e58:	5bc080e7          	jalr	1468(ra) # 80007410 <plicinit>
    80006e5c:	00000097          	auipc	ra,0x0
    80006e60:	5dc080e7          	jalr	1500(ra) # 80007438 <plicinithart>
    80006e64:	00000097          	auipc	ra,0x0
    80006e68:	078080e7          	jalr	120(ra) # 80006edc <userinit>
    80006e6c:	0ff0000f          	fence
    80006e70:	00100793          	li	a5,1
    80006e74:	00002517          	auipc	a0,0x2
    80006e78:	65c50513          	addi	a0,a0,1628 # 800094d0 <CONSOLE_STATUS+0x4c0>
    80006e7c:	00f4a023          	sw	a5,0(s1)
    80006e80:	00001097          	auipc	ra,0x1
    80006e84:	a48080e7          	jalr	-1464(ra) # 800078c8 <__printf>
    80006e88:	0000006f          	j	80006e88 <system_main+0xd4>

0000000080006e8c <cpuid>:
    80006e8c:	ff010113          	addi	sp,sp,-16
    80006e90:	00813423          	sd	s0,8(sp)
    80006e94:	01010413          	addi	s0,sp,16
    80006e98:	00020513          	mv	a0,tp
    80006e9c:	00813403          	ld	s0,8(sp)
    80006ea0:	0005051b          	sext.w	a0,a0
    80006ea4:	01010113          	addi	sp,sp,16
    80006ea8:	00008067          	ret

0000000080006eac <mycpu>:
    80006eac:	ff010113          	addi	sp,sp,-16
    80006eb0:	00813423          	sd	s0,8(sp)
    80006eb4:	01010413          	addi	s0,sp,16
    80006eb8:	00020793          	mv	a5,tp
    80006ebc:	00813403          	ld	s0,8(sp)
    80006ec0:	0007879b          	sext.w	a5,a5
    80006ec4:	00779793          	slli	a5,a5,0x7
    80006ec8:	00006517          	auipc	a0,0x6
    80006ecc:	db850513          	addi	a0,a0,-584 # 8000cc80 <cpus>
    80006ed0:	00f50533          	add	a0,a0,a5
    80006ed4:	01010113          	addi	sp,sp,16
    80006ed8:	00008067          	ret

0000000080006edc <userinit>:
    80006edc:	ff010113          	addi	sp,sp,-16
    80006ee0:	00813423          	sd	s0,8(sp)
    80006ee4:	01010413          	addi	s0,sp,16
    80006ee8:	00813403          	ld	s0,8(sp)
    80006eec:	01010113          	addi	sp,sp,16
    80006ef0:	ffffb317          	auipc	t1,0xffffb
    80006ef4:	bd430067          	jr	-1068(t1) # 80001ac4 <main>

0000000080006ef8 <either_copyout>:
    80006ef8:	ff010113          	addi	sp,sp,-16
    80006efc:	00813023          	sd	s0,0(sp)
    80006f00:	00113423          	sd	ra,8(sp)
    80006f04:	01010413          	addi	s0,sp,16
    80006f08:	02051663          	bnez	a0,80006f34 <either_copyout+0x3c>
    80006f0c:	00058513          	mv	a0,a1
    80006f10:	00060593          	mv	a1,a2
    80006f14:	0006861b          	sext.w	a2,a3
    80006f18:	00002097          	auipc	ra,0x2
    80006f1c:	c5c080e7          	jalr	-932(ra) # 80008b74 <__memmove>
    80006f20:	00813083          	ld	ra,8(sp)
    80006f24:	00013403          	ld	s0,0(sp)
    80006f28:	00000513          	li	a0,0
    80006f2c:	01010113          	addi	sp,sp,16
    80006f30:	00008067          	ret
    80006f34:	00002517          	auipc	a0,0x2
    80006f38:	5dc50513          	addi	a0,a0,1500 # 80009510 <CONSOLE_STATUS+0x500>
    80006f3c:	00001097          	auipc	ra,0x1
    80006f40:	930080e7          	jalr	-1744(ra) # 8000786c <panic>

0000000080006f44 <either_copyin>:
    80006f44:	ff010113          	addi	sp,sp,-16
    80006f48:	00813023          	sd	s0,0(sp)
    80006f4c:	00113423          	sd	ra,8(sp)
    80006f50:	01010413          	addi	s0,sp,16
    80006f54:	02059463          	bnez	a1,80006f7c <either_copyin+0x38>
    80006f58:	00060593          	mv	a1,a2
    80006f5c:	0006861b          	sext.w	a2,a3
    80006f60:	00002097          	auipc	ra,0x2
    80006f64:	c14080e7          	jalr	-1004(ra) # 80008b74 <__memmove>
    80006f68:	00813083          	ld	ra,8(sp)
    80006f6c:	00013403          	ld	s0,0(sp)
    80006f70:	00000513          	li	a0,0
    80006f74:	01010113          	addi	sp,sp,16
    80006f78:	00008067          	ret
    80006f7c:	00002517          	auipc	a0,0x2
    80006f80:	5bc50513          	addi	a0,a0,1468 # 80009538 <CONSOLE_STATUS+0x528>
    80006f84:	00001097          	auipc	ra,0x1
    80006f88:	8e8080e7          	jalr	-1816(ra) # 8000786c <panic>

0000000080006f8c <trapinit>:
    80006f8c:	ff010113          	addi	sp,sp,-16
    80006f90:	00813423          	sd	s0,8(sp)
    80006f94:	01010413          	addi	s0,sp,16
    80006f98:	00813403          	ld	s0,8(sp)
    80006f9c:	00002597          	auipc	a1,0x2
    80006fa0:	5c458593          	addi	a1,a1,1476 # 80009560 <CONSOLE_STATUS+0x550>
    80006fa4:	00006517          	auipc	a0,0x6
    80006fa8:	d5c50513          	addi	a0,a0,-676 # 8000cd00 <tickslock>
    80006fac:	01010113          	addi	sp,sp,16
    80006fb0:	00001317          	auipc	t1,0x1
    80006fb4:	5c830067          	jr	1480(t1) # 80008578 <initlock>

0000000080006fb8 <trapinithart>:
    80006fb8:	ff010113          	addi	sp,sp,-16
    80006fbc:	00813423          	sd	s0,8(sp)
    80006fc0:	01010413          	addi	s0,sp,16
    80006fc4:	00000797          	auipc	a5,0x0
    80006fc8:	2fc78793          	addi	a5,a5,764 # 800072c0 <kernelvec>
    80006fcc:	10579073          	csrw	stvec,a5
    80006fd0:	00813403          	ld	s0,8(sp)
    80006fd4:	01010113          	addi	sp,sp,16
    80006fd8:	00008067          	ret

0000000080006fdc <usertrap>:
    80006fdc:	ff010113          	addi	sp,sp,-16
    80006fe0:	00813423          	sd	s0,8(sp)
    80006fe4:	01010413          	addi	s0,sp,16
    80006fe8:	00813403          	ld	s0,8(sp)
    80006fec:	01010113          	addi	sp,sp,16
    80006ff0:	00008067          	ret

0000000080006ff4 <usertrapret>:
    80006ff4:	ff010113          	addi	sp,sp,-16
    80006ff8:	00813423          	sd	s0,8(sp)
    80006ffc:	01010413          	addi	s0,sp,16
    80007000:	00813403          	ld	s0,8(sp)
    80007004:	01010113          	addi	sp,sp,16
    80007008:	00008067          	ret

000000008000700c <kerneltrap>:
    8000700c:	fe010113          	addi	sp,sp,-32
    80007010:	00813823          	sd	s0,16(sp)
    80007014:	00113c23          	sd	ra,24(sp)
    80007018:	00913423          	sd	s1,8(sp)
    8000701c:	02010413          	addi	s0,sp,32
    80007020:	142025f3          	csrr	a1,scause
    80007024:	100027f3          	csrr	a5,sstatus
    80007028:	0027f793          	andi	a5,a5,2
    8000702c:	10079c63          	bnez	a5,80007144 <kerneltrap+0x138>
    80007030:	142027f3          	csrr	a5,scause
    80007034:	0207ce63          	bltz	a5,80007070 <kerneltrap+0x64>
    80007038:	00002517          	auipc	a0,0x2
    8000703c:	57050513          	addi	a0,a0,1392 # 800095a8 <CONSOLE_STATUS+0x598>
    80007040:	00001097          	auipc	ra,0x1
    80007044:	888080e7          	jalr	-1912(ra) # 800078c8 <__printf>
    80007048:	141025f3          	csrr	a1,sepc
    8000704c:	14302673          	csrr	a2,stval
    80007050:	00002517          	auipc	a0,0x2
    80007054:	56850513          	addi	a0,a0,1384 # 800095b8 <CONSOLE_STATUS+0x5a8>
    80007058:	00001097          	auipc	ra,0x1
    8000705c:	870080e7          	jalr	-1936(ra) # 800078c8 <__printf>
    80007060:	00002517          	auipc	a0,0x2
    80007064:	57050513          	addi	a0,a0,1392 # 800095d0 <CONSOLE_STATUS+0x5c0>
    80007068:	00001097          	auipc	ra,0x1
    8000706c:	804080e7          	jalr	-2044(ra) # 8000786c <panic>
    80007070:	0ff7f713          	andi	a4,a5,255
    80007074:	00900693          	li	a3,9
    80007078:	04d70063          	beq	a4,a3,800070b8 <kerneltrap+0xac>
    8000707c:	fff00713          	li	a4,-1
    80007080:	03f71713          	slli	a4,a4,0x3f
    80007084:	00170713          	addi	a4,a4,1
    80007088:	fae798e3          	bne	a5,a4,80007038 <kerneltrap+0x2c>
    8000708c:	00000097          	auipc	ra,0x0
    80007090:	e00080e7          	jalr	-512(ra) # 80006e8c <cpuid>
    80007094:	06050663          	beqz	a0,80007100 <kerneltrap+0xf4>
    80007098:	144027f3          	csrr	a5,sip
    8000709c:	ffd7f793          	andi	a5,a5,-3
    800070a0:	14479073          	csrw	sip,a5
    800070a4:	01813083          	ld	ra,24(sp)
    800070a8:	01013403          	ld	s0,16(sp)
    800070ac:	00813483          	ld	s1,8(sp)
    800070b0:	02010113          	addi	sp,sp,32
    800070b4:	00008067          	ret
    800070b8:	00000097          	auipc	ra,0x0
    800070bc:	3cc080e7          	jalr	972(ra) # 80007484 <plic_claim>
    800070c0:	00a00793          	li	a5,10
    800070c4:	00050493          	mv	s1,a0
    800070c8:	06f50863          	beq	a0,a5,80007138 <kerneltrap+0x12c>
    800070cc:	fc050ce3          	beqz	a0,800070a4 <kerneltrap+0x98>
    800070d0:	00050593          	mv	a1,a0
    800070d4:	00002517          	auipc	a0,0x2
    800070d8:	4b450513          	addi	a0,a0,1204 # 80009588 <CONSOLE_STATUS+0x578>
    800070dc:	00000097          	auipc	ra,0x0
    800070e0:	7ec080e7          	jalr	2028(ra) # 800078c8 <__printf>
    800070e4:	01013403          	ld	s0,16(sp)
    800070e8:	01813083          	ld	ra,24(sp)
    800070ec:	00048513          	mv	a0,s1
    800070f0:	00813483          	ld	s1,8(sp)
    800070f4:	02010113          	addi	sp,sp,32
    800070f8:	00000317          	auipc	t1,0x0
    800070fc:	3c430067          	jr	964(t1) # 800074bc <plic_complete>
    80007100:	00006517          	auipc	a0,0x6
    80007104:	c0050513          	addi	a0,a0,-1024 # 8000cd00 <tickslock>
    80007108:	00001097          	auipc	ra,0x1
    8000710c:	494080e7          	jalr	1172(ra) # 8000859c <acquire>
    80007110:	00005717          	auipc	a4,0x5
    80007114:	a0470713          	addi	a4,a4,-1532 # 8000bb14 <ticks>
    80007118:	00072783          	lw	a5,0(a4)
    8000711c:	00006517          	auipc	a0,0x6
    80007120:	be450513          	addi	a0,a0,-1052 # 8000cd00 <tickslock>
    80007124:	0017879b          	addiw	a5,a5,1
    80007128:	00f72023          	sw	a5,0(a4)
    8000712c:	00001097          	auipc	ra,0x1
    80007130:	53c080e7          	jalr	1340(ra) # 80008668 <release>
    80007134:	f65ff06f          	j	80007098 <kerneltrap+0x8c>
    80007138:	00001097          	auipc	ra,0x1
    8000713c:	098080e7          	jalr	152(ra) # 800081d0 <uartintr>
    80007140:	fa5ff06f          	j	800070e4 <kerneltrap+0xd8>
    80007144:	00002517          	auipc	a0,0x2
    80007148:	42450513          	addi	a0,a0,1060 # 80009568 <CONSOLE_STATUS+0x558>
    8000714c:	00000097          	auipc	ra,0x0
    80007150:	720080e7          	jalr	1824(ra) # 8000786c <panic>

0000000080007154 <clockintr>:
    80007154:	fe010113          	addi	sp,sp,-32
    80007158:	00813823          	sd	s0,16(sp)
    8000715c:	00913423          	sd	s1,8(sp)
    80007160:	00113c23          	sd	ra,24(sp)
    80007164:	02010413          	addi	s0,sp,32
    80007168:	00006497          	auipc	s1,0x6
    8000716c:	b9848493          	addi	s1,s1,-1128 # 8000cd00 <tickslock>
    80007170:	00048513          	mv	a0,s1
    80007174:	00001097          	auipc	ra,0x1
    80007178:	428080e7          	jalr	1064(ra) # 8000859c <acquire>
    8000717c:	00005717          	auipc	a4,0x5
    80007180:	99870713          	addi	a4,a4,-1640 # 8000bb14 <ticks>
    80007184:	00072783          	lw	a5,0(a4)
    80007188:	01013403          	ld	s0,16(sp)
    8000718c:	01813083          	ld	ra,24(sp)
    80007190:	00048513          	mv	a0,s1
    80007194:	0017879b          	addiw	a5,a5,1
    80007198:	00813483          	ld	s1,8(sp)
    8000719c:	00f72023          	sw	a5,0(a4)
    800071a0:	02010113          	addi	sp,sp,32
    800071a4:	00001317          	auipc	t1,0x1
    800071a8:	4c430067          	jr	1220(t1) # 80008668 <release>

00000000800071ac <devintr>:
    800071ac:	142027f3          	csrr	a5,scause
    800071b0:	00000513          	li	a0,0
    800071b4:	0007c463          	bltz	a5,800071bc <devintr+0x10>
    800071b8:	00008067          	ret
    800071bc:	fe010113          	addi	sp,sp,-32
    800071c0:	00813823          	sd	s0,16(sp)
    800071c4:	00113c23          	sd	ra,24(sp)
    800071c8:	00913423          	sd	s1,8(sp)
    800071cc:	02010413          	addi	s0,sp,32
    800071d0:	0ff7f713          	andi	a4,a5,255
    800071d4:	00900693          	li	a3,9
    800071d8:	04d70c63          	beq	a4,a3,80007230 <devintr+0x84>
    800071dc:	fff00713          	li	a4,-1
    800071e0:	03f71713          	slli	a4,a4,0x3f
    800071e4:	00170713          	addi	a4,a4,1
    800071e8:	00e78c63          	beq	a5,a4,80007200 <devintr+0x54>
    800071ec:	01813083          	ld	ra,24(sp)
    800071f0:	01013403          	ld	s0,16(sp)
    800071f4:	00813483          	ld	s1,8(sp)
    800071f8:	02010113          	addi	sp,sp,32
    800071fc:	00008067          	ret
    80007200:	00000097          	auipc	ra,0x0
    80007204:	c8c080e7          	jalr	-884(ra) # 80006e8c <cpuid>
    80007208:	06050663          	beqz	a0,80007274 <devintr+0xc8>
    8000720c:	144027f3          	csrr	a5,sip
    80007210:	ffd7f793          	andi	a5,a5,-3
    80007214:	14479073          	csrw	sip,a5
    80007218:	01813083          	ld	ra,24(sp)
    8000721c:	01013403          	ld	s0,16(sp)
    80007220:	00813483          	ld	s1,8(sp)
    80007224:	00200513          	li	a0,2
    80007228:	02010113          	addi	sp,sp,32
    8000722c:	00008067          	ret
    80007230:	00000097          	auipc	ra,0x0
    80007234:	254080e7          	jalr	596(ra) # 80007484 <plic_claim>
    80007238:	00a00793          	li	a5,10
    8000723c:	00050493          	mv	s1,a0
    80007240:	06f50663          	beq	a0,a5,800072ac <devintr+0x100>
    80007244:	00100513          	li	a0,1
    80007248:	fa0482e3          	beqz	s1,800071ec <devintr+0x40>
    8000724c:	00048593          	mv	a1,s1
    80007250:	00002517          	auipc	a0,0x2
    80007254:	33850513          	addi	a0,a0,824 # 80009588 <CONSOLE_STATUS+0x578>
    80007258:	00000097          	auipc	ra,0x0
    8000725c:	670080e7          	jalr	1648(ra) # 800078c8 <__printf>
    80007260:	00048513          	mv	a0,s1
    80007264:	00000097          	auipc	ra,0x0
    80007268:	258080e7          	jalr	600(ra) # 800074bc <plic_complete>
    8000726c:	00100513          	li	a0,1
    80007270:	f7dff06f          	j	800071ec <devintr+0x40>
    80007274:	00006517          	auipc	a0,0x6
    80007278:	a8c50513          	addi	a0,a0,-1396 # 8000cd00 <tickslock>
    8000727c:	00001097          	auipc	ra,0x1
    80007280:	320080e7          	jalr	800(ra) # 8000859c <acquire>
    80007284:	00005717          	auipc	a4,0x5
    80007288:	89070713          	addi	a4,a4,-1904 # 8000bb14 <ticks>
    8000728c:	00072783          	lw	a5,0(a4)
    80007290:	00006517          	auipc	a0,0x6
    80007294:	a7050513          	addi	a0,a0,-1424 # 8000cd00 <tickslock>
    80007298:	0017879b          	addiw	a5,a5,1
    8000729c:	00f72023          	sw	a5,0(a4)
    800072a0:	00001097          	auipc	ra,0x1
    800072a4:	3c8080e7          	jalr	968(ra) # 80008668 <release>
    800072a8:	f65ff06f          	j	8000720c <devintr+0x60>
    800072ac:	00001097          	auipc	ra,0x1
    800072b0:	f24080e7          	jalr	-220(ra) # 800081d0 <uartintr>
    800072b4:	fadff06f          	j	80007260 <devintr+0xb4>
	...

00000000800072c0 <kernelvec>:
    800072c0:	f0010113          	addi	sp,sp,-256
    800072c4:	00113023          	sd	ra,0(sp)
    800072c8:	00213423          	sd	sp,8(sp)
    800072cc:	00313823          	sd	gp,16(sp)
    800072d0:	00413c23          	sd	tp,24(sp)
    800072d4:	02513023          	sd	t0,32(sp)
    800072d8:	02613423          	sd	t1,40(sp)
    800072dc:	02713823          	sd	t2,48(sp)
    800072e0:	02813c23          	sd	s0,56(sp)
    800072e4:	04913023          	sd	s1,64(sp)
    800072e8:	04a13423          	sd	a0,72(sp)
    800072ec:	04b13823          	sd	a1,80(sp)
    800072f0:	04c13c23          	sd	a2,88(sp)
    800072f4:	06d13023          	sd	a3,96(sp)
    800072f8:	06e13423          	sd	a4,104(sp)
    800072fc:	06f13823          	sd	a5,112(sp)
    80007300:	07013c23          	sd	a6,120(sp)
    80007304:	09113023          	sd	a7,128(sp)
    80007308:	09213423          	sd	s2,136(sp)
    8000730c:	09313823          	sd	s3,144(sp)
    80007310:	09413c23          	sd	s4,152(sp)
    80007314:	0b513023          	sd	s5,160(sp)
    80007318:	0b613423          	sd	s6,168(sp)
    8000731c:	0b713823          	sd	s7,176(sp)
    80007320:	0b813c23          	sd	s8,184(sp)
    80007324:	0d913023          	sd	s9,192(sp)
    80007328:	0da13423          	sd	s10,200(sp)
    8000732c:	0db13823          	sd	s11,208(sp)
    80007330:	0dc13c23          	sd	t3,216(sp)
    80007334:	0fd13023          	sd	t4,224(sp)
    80007338:	0fe13423          	sd	t5,232(sp)
    8000733c:	0ff13823          	sd	t6,240(sp)
    80007340:	ccdff0ef          	jal	ra,8000700c <kerneltrap>
    80007344:	00013083          	ld	ra,0(sp)
    80007348:	00813103          	ld	sp,8(sp)
    8000734c:	01013183          	ld	gp,16(sp)
    80007350:	02013283          	ld	t0,32(sp)
    80007354:	02813303          	ld	t1,40(sp)
    80007358:	03013383          	ld	t2,48(sp)
    8000735c:	03813403          	ld	s0,56(sp)
    80007360:	04013483          	ld	s1,64(sp)
    80007364:	04813503          	ld	a0,72(sp)
    80007368:	05013583          	ld	a1,80(sp)
    8000736c:	05813603          	ld	a2,88(sp)
    80007370:	06013683          	ld	a3,96(sp)
    80007374:	06813703          	ld	a4,104(sp)
    80007378:	07013783          	ld	a5,112(sp)
    8000737c:	07813803          	ld	a6,120(sp)
    80007380:	08013883          	ld	a7,128(sp)
    80007384:	08813903          	ld	s2,136(sp)
    80007388:	09013983          	ld	s3,144(sp)
    8000738c:	09813a03          	ld	s4,152(sp)
    80007390:	0a013a83          	ld	s5,160(sp)
    80007394:	0a813b03          	ld	s6,168(sp)
    80007398:	0b013b83          	ld	s7,176(sp)
    8000739c:	0b813c03          	ld	s8,184(sp)
    800073a0:	0c013c83          	ld	s9,192(sp)
    800073a4:	0c813d03          	ld	s10,200(sp)
    800073a8:	0d013d83          	ld	s11,208(sp)
    800073ac:	0d813e03          	ld	t3,216(sp)
    800073b0:	0e013e83          	ld	t4,224(sp)
    800073b4:	0e813f03          	ld	t5,232(sp)
    800073b8:	0f013f83          	ld	t6,240(sp)
    800073bc:	10010113          	addi	sp,sp,256
    800073c0:	10200073          	sret
    800073c4:	00000013          	nop
    800073c8:	00000013          	nop
    800073cc:	00000013          	nop

00000000800073d0 <timervec>:
    800073d0:	34051573          	csrrw	a0,mscratch,a0
    800073d4:	00b53023          	sd	a1,0(a0)
    800073d8:	00c53423          	sd	a2,8(a0)
    800073dc:	00d53823          	sd	a3,16(a0)
    800073e0:	01853583          	ld	a1,24(a0)
    800073e4:	02053603          	ld	a2,32(a0)
    800073e8:	0005b683          	ld	a3,0(a1)
    800073ec:	00c686b3          	add	a3,a3,a2
    800073f0:	00d5b023          	sd	a3,0(a1)
    800073f4:	00200593          	li	a1,2
    800073f8:	14459073          	csrw	sip,a1
    800073fc:	01053683          	ld	a3,16(a0)
    80007400:	00853603          	ld	a2,8(a0)
    80007404:	00053583          	ld	a1,0(a0)
    80007408:	34051573          	csrrw	a0,mscratch,a0
    8000740c:	30200073          	mret

0000000080007410 <plicinit>:
    80007410:	ff010113          	addi	sp,sp,-16
    80007414:	00813423          	sd	s0,8(sp)
    80007418:	01010413          	addi	s0,sp,16
    8000741c:	00813403          	ld	s0,8(sp)
    80007420:	0c0007b7          	lui	a5,0xc000
    80007424:	00100713          	li	a4,1
    80007428:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000742c:	00e7a223          	sw	a4,4(a5)
    80007430:	01010113          	addi	sp,sp,16
    80007434:	00008067          	ret

0000000080007438 <plicinithart>:
    80007438:	ff010113          	addi	sp,sp,-16
    8000743c:	00813023          	sd	s0,0(sp)
    80007440:	00113423          	sd	ra,8(sp)
    80007444:	01010413          	addi	s0,sp,16
    80007448:	00000097          	auipc	ra,0x0
    8000744c:	a44080e7          	jalr	-1468(ra) # 80006e8c <cpuid>
    80007450:	0085171b          	slliw	a4,a0,0x8
    80007454:	0c0027b7          	lui	a5,0xc002
    80007458:	00e787b3          	add	a5,a5,a4
    8000745c:	40200713          	li	a4,1026
    80007460:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80007464:	00813083          	ld	ra,8(sp)
    80007468:	00013403          	ld	s0,0(sp)
    8000746c:	00d5151b          	slliw	a0,a0,0xd
    80007470:	0c2017b7          	lui	a5,0xc201
    80007474:	00a78533          	add	a0,a5,a0
    80007478:	00052023          	sw	zero,0(a0)
    8000747c:	01010113          	addi	sp,sp,16
    80007480:	00008067          	ret

0000000080007484 <plic_claim>:
    80007484:	ff010113          	addi	sp,sp,-16
    80007488:	00813023          	sd	s0,0(sp)
    8000748c:	00113423          	sd	ra,8(sp)
    80007490:	01010413          	addi	s0,sp,16
    80007494:	00000097          	auipc	ra,0x0
    80007498:	9f8080e7          	jalr	-1544(ra) # 80006e8c <cpuid>
    8000749c:	00813083          	ld	ra,8(sp)
    800074a0:	00013403          	ld	s0,0(sp)
    800074a4:	00d5151b          	slliw	a0,a0,0xd
    800074a8:	0c2017b7          	lui	a5,0xc201
    800074ac:	00a78533          	add	a0,a5,a0
    800074b0:	00452503          	lw	a0,4(a0)
    800074b4:	01010113          	addi	sp,sp,16
    800074b8:	00008067          	ret

00000000800074bc <plic_complete>:
    800074bc:	fe010113          	addi	sp,sp,-32
    800074c0:	00813823          	sd	s0,16(sp)
    800074c4:	00913423          	sd	s1,8(sp)
    800074c8:	00113c23          	sd	ra,24(sp)
    800074cc:	02010413          	addi	s0,sp,32
    800074d0:	00050493          	mv	s1,a0
    800074d4:	00000097          	auipc	ra,0x0
    800074d8:	9b8080e7          	jalr	-1608(ra) # 80006e8c <cpuid>
    800074dc:	01813083          	ld	ra,24(sp)
    800074e0:	01013403          	ld	s0,16(sp)
    800074e4:	00d5179b          	slliw	a5,a0,0xd
    800074e8:	0c201737          	lui	a4,0xc201
    800074ec:	00f707b3          	add	a5,a4,a5
    800074f0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800074f4:	00813483          	ld	s1,8(sp)
    800074f8:	02010113          	addi	sp,sp,32
    800074fc:	00008067          	ret

0000000080007500 <consolewrite>:
    80007500:	fb010113          	addi	sp,sp,-80
    80007504:	04813023          	sd	s0,64(sp)
    80007508:	04113423          	sd	ra,72(sp)
    8000750c:	02913c23          	sd	s1,56(sp)
    80007510:	03213823          	sd	s2,48(sp)
    80007514:	03313423          	sd	s3,40(sp)
    80007518:	03413023          	sd	s4,32(sp)
    8000751c:	01513c23          	sd	s5,24(sp)
    80007520:	05010413          	addi	s0,sp,80
    80007524:	06c05c63          	blez	a2,8000759c <consolewrite+0x9c>
    80007528:	00060993          	mv	s3,a2
    8000752c:	00050a13          	mv	s4,a0
    80007530:	00058493          	mv	s1,a1
    80007534:	00000913          	li	s2,0
    80007538:	fff00a93          	li	s5,-1
    8000753c:	01c0006f          	j	80007558 <consolewrite+0x58>
    80007540:	fbf44503          	lbu	a0,-65(s0)
    80007544:	0019091b          	addiw	s2,s2,1
    80007548:	00148493          	addi	s1,s1,1
    8000754c:	00001097          	auipc	ra,0x1
    80007550:	a9c080e7          	jalr	-1380(ra) # 80007fe8 <uartputc>
    80007554:	03298063          	beq	s3,s2,80007574 <consolewrite+0x74>
    80007558:	00048613          	mv	a2,s1
    8000755c:	00100693          	li	a3,1
    80007560:	000a0593          	mv	a1,s4
    80007564:	fbf40513          	addi	a0,s0,-65
    80007568:	00000097          	auipc	ra,0x0
    8000756c:	9dc080e7          	jalr	-1572(ra) # 80006f44 <either_copyin>
    80007570:	fd5518e3          	bne	a0,s5,80007540 <consolewrite+0x40>
    80007574:	04813083          	ld	ra,72(sp)
    80007578:	04013403          	ld	s0,64(sp)
    8000757c:	03813483          	ld	s1,56(sp)
    80007580:	02813983          	ld	s3,40(sp)
    80007584:	02013a03          	ld	s4,32(sp)
    80007588:	01813a83          	ld	s5,24(sp)
    8000758c:	00090513          	mv	a0,s2
    80007590:	03013903          	ld	s2,48(sp)
    80007594:	05010113          	addi	sp,sp,80
    80007598:	00008067          	ret
    8000759c:	00000913          	li	s2,0
    800075a0:	fd5ff06f          	j	80007574 <consolewrite+0x74>

00000000800075a4 <consoleread>:
    800075a4:	f9010113          	addi	sp,sp,-112
    800075a8:	06813023          	sd	s0,96(sp)
    800075ac:	04913c23          	sd	s1,88(sp)
    800075b0:	05213823          	sd	s2,80(sp)
    800075b4:	05313423          	sd	s3,72(sp)
    800075b8:	05413023          	sd	s4,64(sp)
    800075bc:	03513c23          	sd	s5,56(sp)
    800075c0:	03613823          	sd	s6,48(sp)
    800075c4:	03713423          	sd	s7,40(sp)
    800075c8:	03813023          	sd	s8,32(sp)
    800075cc:	06113423          	sd	ra,104(sp)
    800075d0:	01913c23          	sd	s9,24(sp)
    800075d4:	07010413          	addi	s0,sp,112
    800075d8:	00060b93          	mv	s7,a2
    800075dc:	00050913          	mv	s2,a0
    800075e0:	00058c13          	mv	s8,a1
    800075e4:	00060b1b          	sext.w	s6,a2
    800075e8:	00005497          	auipc	s1,0x5
    800075ec:	74048493          	addi	s1,s1,1856 # 8000cd28 <cons>
    800075f0:	00400993          	li	s3,4
    800075f4:	fff00a13          	li	s4,-1
    800075f8:	00a00a93          	li	s5,10
    800075fc:	05705e63          	blez	s7,80007658 <consoleread+0xb4>
    80007600:	09c4a703          	lw	a4,156(s1)
    80007604:	0984a783          	lw	a5,152(s1)
    80007608:	0007071b          	sext.w	a4,a4
    8000760c:	08e78463          	beq	a5,a4,80007694 <consoleread+0xf0>
    80007610:	07f7f713          	andi	a4,a5,127
    80007614:	00e48733          	add	a4,s1,a4
    80007618:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000761c:	0017869b          	addiw	a3,a5,1
    80007620:	08d4ac23          	sw	a3,152(s1)
    80007624:	00070c9b          	sext.w	s9,a4
    80007628:	0b370663          	beq	a4,s3,800076d4 <consoleread+0x130>
    8000762c:	00100693          	li	a3,1
    80007630:	f9f40613          	addi	a2,s0,-97
    80007634:	000c0593          	mv	a1,s8
    80007638:	00090513          	mv	a0,s2
    8000763c:	f8e40fa3          	sb	a4,-97(s0)
    80007640:	00000097          	auipc	ra,0x0
    80007644:	8b8080e7          	jalr	-1864(ra) # 80006ef8 <either_copyout>
    80007648:	01450863          	beq	a0,s4,80007658 <consoleread+0xb4>
    8000764c:	001c0c13          	addi	s8,s8,1
    80007650:	fffb8b9b          	addiw	s7,s7,-1
    80007654:	fb5c94e3          	bne	s9,s5,800075fc <consoleread+0x58>
    80007658:	000b851b          	sext.w	a0,s7
    8000765c:	06813083          	ld	ra,104(sp)
    80007660:	06013403          	ld	s0,96(sp)
    80007664:	05813483          	ld	s1,88(sp)
    80007668:	05013903          	ld	s2,80(sp)
    8000766c:	04813983          	ld	s3,72(sp)
    80007670:	04013a03          	ld	s4,64(sp)
    80007674:	03813a83          	ld	s5,56(sp)
    80007678:	02813b83          	ld	s7,40(sp)
    8000767c:	02013c03          	ld	s8,32(sp)
    80007680:	01813c83          	ld	s9,24(sp)
    80007684:	40ab053b          	subw	a0,s6,a0
    80007688:	03013b03          	ld	s6,48(sp)
    8000768c:	07010113          	addi	sp,sp,112
    80007690:	00008067          	ret
    80007694:	00001097          	auipc	ra,0x1
    80007698:	1d8080e7          	jalr	472(ra) # 8000886c <push_on>
    8000769c:	0984a703          	lw	a4,152(s1)
    800076a0:	09c4a783          	lw	a5,156(s1)
    800076a4:	0007879b          	sext.w	a5,a5
    800076a8:	fef70ce3          	beq	a4,a5,800076a0 <consoleread+0xfc>
    800076ac:	00001097          	auipc	ra,0x1
    800076b0:	234080e7          	jalr	564(ra) # 800088e0 <pop_on>
    800076b4:	0984a783          	lw	a5,152(s1)
    800076b8:	07f7f713          	andi	a4,a5,127
    800076bc:	00e48733          	add	a4,s1,a4
    800076c0:	01874703          	lbu	a4,24(a4)
    800076c4:	0017869b          	addiw	a3,a5,1
    800076c8:	08d4ac23          	sw	a3,152(s1)
    800076cc:	00070c9b          	sext.w	s9,a4
    800076d0:	f5371ee3          	bne	a4,s3,8000762c <consoleread+0x88>
    800076d4:	000b851b          	sext.w	a0,s7
    800076d8:	f96bf2e3          	bgeu	s7,s6,8000765c <consoleread+0xb8>
    800076dc:	08f4ac23          	sw	a5,152(s1)
    800076e0:	f7dff06f          	j	8000765c <consoleread+0xb8>

00000000800076e4 <consputc>:
    800076e4:	10000793          	li	a5,256
    800076e8:	00f50663          	beq	a0,a5,800076f4 <consputc+0x10>
    800076ec:	00001317          	auipc	t1,0x1
    800076f0:	9f430067          	jr	-1548(t1) # 800080e0 <uartputc_sync>
    800076f4:	ff010113          	addi	sp,sp,-16
    800076f8:	00113423          	sd	ra,8(sp)
    800076fc:	00813023          	sd	s0,0(sp)
    80007700:	01010413          	addi	s0,sp,16
    80007704:	00800513          	li	a0,8
    80007708:	00001097          	auipc	ra,0x1
    8000770c:	9d8080e7          	jalr	-1576(ra) # 800080e0 <uartputc_sync>
    80007710:	02000513          	li	a0,32
    80007714:	00001097          	auipc	ra,0x1
    80007718:	9cc080e7          	jalr	-1588(ra) # 800080e0 <uartputc_sync>
    8000771c:	00013403          	ld	s0,0(sp)
    80007720:	00813083          	ld	ra,8(sp)
    80007724:	00800513          	li	a0,8
    80007728:	01010113          	addi	sp,sp,16
    8000772c:	00001317          	auipc	t1,0x1
    80007730:	9b430067          	jr	-1612(t1) # 800080e0 <uartputc_sync>

0000000080007734 <consoleintr>:
    80007734:	fe010113          	addi	sp,sp,-32
    80007738:	00813823          	sd	s0,16(sp)
    8000773c:	00913423          	sd	s1,8(sp)
    80007740:	01213023          	sd	s2,0(sp)
    80007744:	00113c23          	sd	ra,24(sp)
    80007748:	02010413          	addi	s0,sp,32
    8000774c:	00005917          	auipc	s2,0x5
    80007750:	5dc90913          	addi	s2,s2,1500 # 8000cd28 <cons>
    80007754:	00050493          	mv	s1,a0
    80007758:	00090513          	mv	a0,s2
    8000775c:	00001097          	auipc	ra,0x1
    80007760:	e40080e7          	jalr	-448(ra) # 8000859c <acquire>
    80007764:	02048c63          	beqz	s1,8000779c <consoleintr+0x68>
    80007768:	0a092783          	lw	a5,160(s2)
    8000776c:	09892703          	lw	a4,152(s2)
    80007770:	07f00693          	li	a3,127
    80007774:	40e7873b          	subw	a4,a5,a4
    80007778:	02e6e263          	bltu	a3,a4,8000779c <consoleintr+0x68>
    8000777c:	00d00713          	li	a4,13
    80007780:	04e48063          	beq	s1,a4,800077c0 <consoleintr+0x8c>
    80007784:	07f7f713          	andi	a4,a5,127
    80007788:	00e90733          	add	a4,s2,a4
    8000778c:	0017879b          	addiw	a5,a5,1
    80007790:	0af92023          	sw	a5,160(s2)
    80007794:	00970c23          	sb	s1,24(a4)
    80007798:	08f92e23          	sw	a5,156(s2)
    8000779c:	01013403          	ld	s0,16(sp)
    800077a0:	01813083          	ld	ra,24(sp)
    800077a4:	00813483          	ld	s1,8(sp)
    800077a8:	00013903          	ld	s2,0(sp)
    800077ac:	00005517          	auipc	a0,0x5
    800077b0:	57c50513          	addi	a0,a0,1404 # 8000cd28 <cons>
    800077b4:	02010113          	addi	sp,sp,32
    800077b8:	00001317          	auipc	t1,0x1
    800077bc:	eb030067          	jr	-336(t1) # 80008668 <release>
    800077c0:	00a00493          	li	s1,10
    800077c4:	fc1ff06f          	j	80007784 <consoleintr+0x50>

00000000800077c8 <consoleinit>:
    800077c8:	fe010113          	addi	sp,sp,-32
    800077cc:	00113c23          	sd	ra,24(sp)
    800077d0:	00813823          	sd	s0,16(sp)
    800077d4:	00913423          	sd	s1,8(sp)
    800077d8:	02010413          	addi	s0,sp,32
    800077dc:	00005497          	auipc	s1,0x5
    800077e0:	54c48493          	addi	s1,s1,1356 # 8000cd28 <cons>
    800077e4:	00048513          	mv	a0,s1
    800077e8:	00002597          	auipc	a1,0x2
    800077ec:	df858593          	addi	a1,a1,-520 # 800095e0 <CONSOLE_STATUS+0x5d0>
    800077f0:	00001097          	auipc	ra,0x1
    800077f4:	d88080e7          	jalr	-632(ra) # 80008578 <initlock>
    800077f8:	00000097          	auipc	ra,0x0
    800077fc:	7ac080e7          	jalr	1964(ra) # 80007fa4 <uartinit>
    80007800:	01813083          	ld	ra,24(sp)
    80007804:	01013403          	ld	s0,16(sp)
    80007808:	00000797          	auipc	a5,0x0
    8000780c:	d9c78793          	addi	a5,a5,-612 # 800075a4 <consoleread>
    80007810:	0af4bc23          	sd	a5,184(s1)
    80007814:	00000797          	auipc	a5,0x0
    80007818:	cec78793          	addi	a5,a5,-788 # 80007500 <consolewrite>
    8000781c:	0cf4b023          	sd	a5,192(s1)
    80007820:	00813483          	ld	s1,8(sp)
    80007824:	02010113          	addi	sp,sp,32
    80007828:	00008067          	ret

000000008000782c <console_read>:
    8000782c:	ff010113          	addi	sp,sp,-16
    80007830:	00813423          	sd	s0,8(sp)
    80007834:	01010413          	addi	s0,sp,16
    80007838:	00813403          	ld	s0,8(sp)
    8000783c:	00005317          	auipc	t1,0x5
    80007840:	5a433303          	ld	t1,1444(t1) # 8000cde0 <devsw+0x10>
    80007844:	01010113          	addi	sp,sp,16
    80007848:	00030067          	jr	t1

000000008000784c <console_write>:
    8000784c:	ff010113          	addi	sp,sp,-16
    80007850:	00813423          	sd	s0,8(sp)
    80007854:	01010413          	addi	s0,sp,16
    80007858:	00813403          	ld	s0,8(sp)
    8000785c:	00005317          	auipc	t1,0x5
    80007860:	58c33303          	ld	t1,1420(t1) # 8000cde8 <devsw+0x18>
    80007864:	01010113          	addi	sp,sp,16
    80007868:	00030067          	jr	t1

000000008000786c <panic>:
    8000786c:	fe010113          	addi	sp,sp,-32
    80007870:	00113c23          	sd	ra,24(sp)
    80007874:	00813823          	sd	s0,16(sp)
    80007878:	00913423          	sd	s1,8(sp)
    8000787c:	02010413          	addi	s0,sp,32
    80007880:	00050493          	mv	s1,a0
    80007884:	00002517          	auipc	a0,0x2
    80007888:	d6450513          	addi	a0,a0,-668 # 800095e8 <CONSOLE_STATUS+0x5d8>
    8000788c:	00005797          	auipc	a5,0x5
    80007890:	5e07ae23          	sw	zero,1532(a5) # 8000ce88 <pr+0x18>
    80007894:	00000097          	auipc	ra,0x0
    80007898:	034080e7          	jalr	52(ra) # 800078c8 <__printf>
    8000789c:	00048513          	mv	a0,s1
    800078a0:	00000097          	auipc	ra,0x0
    800078a4:	028080e7          	jalr	40(ra) # 800078c8 <__printf>
    800078a8:	00002517          	auipc	a0,0x2
    800078ac:	ab050513          	addi	a0,a0,-1360 # 80009358 <CONSOLE_STATUS+0x348>
    800078b0:	00000097          	auipc	ra,0x0
    800078b4:	018080e7          	jalr	24(ra) # 800078c8 <__printf>
    800078b8:	00100793          	li	a5,1
    800078bc:	00004717          	auipc	a4,0x4
    800078c0:	24f72e23          	sw	a5,604(a4) # 8000bb18 <panicked>
    800078c4:	0000006f          	j	800078c4 <panic+0x58>

00000000800078c8 <__printf>:
    800078c8:	f3010113          	addi	sp,sp,-208
    800078cc:	08813023          	sd	s0,128(sp)
    800078d0:	07313423          	sd	s3,104(sp)
    800078d4:	09010413          	addi	s0,sp,144
    800078d8:	05813023          	sd	s8,64(sp)
    800078dc:	08113423          	sd	ra,136(sp)
    800078e0:	06913c23          	sd	s1,120(sp)
    800078e4:	07213823          	sd	s2,112(sp)
    800078e8:	07413023          	sd	s4,96(sp)
    800078ec:	05513c23          	sd	s5,88(sp)
    800078f0:	05613823          	sd	s6,80(sp)
    800078f4:	05713423          	sd	s7,72(sp)
    800078f8:	03913c23          	sd	s9,56(sp)
    800078fc:	03a13823          	sd	s10,48(sp)
    80007900:	03b13423          	sd	s11,40(sp)
    80007904:	00005317          	auipc	t1,0x5
    80007908:	56c30313          	addi	t1,t1,1388 # 8000ce70 <pr>
    8000790c:	01832c03          	lw	s8,24(t1)
    80007910:	00b43423          	sd	a1,8(s0)
    80007914:	00c43823          	sd	a2,16(s0)
    80007918:	00d43c23          	sd	a3,24(s0)
    8000791c:	02e43023          	sd	a4,32(s0)
    80007920:	02f43423          	sd	a5,40(s0)
    80007924:	03043823          	sd	a6,48(s0)
    80007928:	03143c23          	sd	a7,56(s0)
    8000792c:	00050993          	mv	s3,a0
    80007930:	4a0c1663          	bnez	s8,80007ddc <__printf+0x514>
    80007934:	60098c63          	beqz	s3,80007f4c <__printf+0x684>
    80007938:	0009c503          	lbu	a0,0(s3)
    8000793c:	00840793          	addi	a5,s0,8
    80007940:	f6f43c23          	sd	a5,-136(s0)
    80007944:	00000493          	li	s1,0
    80007948:	22050063          	beqz	a0,80007b68 <__printf+0x2a0>
    8000794c:	00002a37          	lui	s4,0x2
    80007950:	00018ab7          	lui	s5,0x18
    80007954:	000f4b37          	lui	s6,0xf4
    80007958:	00989bb7          	lui	s7,0x989
    8000795c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80007960:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80007964:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80007968:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000796c:	00148c9b          	addiw	s9,s1,1
    80007970:	02500793          	li	a5,37
    80007974:	01998933          	add	s2,s3,s9
    80007978:	38f51263          	bne	a0,a5,80007cfc <__printf+0x434>
    8000797c:	00094783          	lbu	a5,0(s2)
    80007980:	00078c9b          	sext.w	s9,a5
    80007984:	1e078263          	beqz	a5,80007b68 <__printf+0x2a0>
    80007988:	0024849b          	addiw	s1,s1,2
    8000798c:	07000713          	li	a4,112
    80007990:	00998933          	add	s2,s3,s1
    80007994:	38e78a63          	beq	a5,a4,80007d28 <__printf+0x460>
    80007998:	20f76863          	bltu	a4,a5,80007ba8 <__printf+0x2e0>
    8000799c:	42a78863          	beq	a5,a0,80007dcc <__printf+0x504>
    800079a0:	06400713          	li	a4,100
    800079a4:	40e79663          	bne	a5,a4,80007db0 <__printf+0x4e8>
    800079a8:	f7843783          	ld	a5,-136(s0)
    800079ac:	0007a603          	lw	a2,0(a5)
    800079b0:	00878793          	addi	a5,a5,8
    800079b4:	f6f43c23          	sd	a5,-136(s0)
    800079b8:	42064a63          	bltz	a2,80007dec <__printf+0x524>
    800079bc:	00a00713          	li	a4,10
    800079c0:	02e677bb          	remuw	a5,a2,a4
    800079c4:	00002d97          	auipc	s11,0x2
    800079c8:	c4cd8d93          	addi	s11,s11,-948 # 80009610 <digits>
    800079cc:	00900593          	li	a1,9
    800079d0:	0006051b          	sext.w	a0,a2
    800079d4:	00000c93          	li	s9,0
    800079d8:	02079793          	slli	a5,a5,0x20
    800079dc:	0207d793          	srli	a5,a5,0x20
    800079e0:	00fd87b3          	add	a5,s11,a5
    800079e4:	0007c783          	lbu	a5,0(a5)
    800079e8:	02e656bb          	divuw	a3,a2,a4
    800079ec:	f8f40023          	sb	a5,-128(s0)
    800079f0:	14c5d863          	bge	a1,a2,80007b40 <__printf+0x278>
    800079f4:	06300593          	li	a1,99
    800079f8:	00100c93          	li	s9,1
    800079fc:	02e6f7bb          	remuw	a5,a3,a4
    80007a00:	02079793          	slli	a5,a5,0x20
    80007a04:	0207d793          	srli	a5,a5,0x20
    80007a08:	00fd87b3          	add	a5,s11,a5
    80007a0c:	0007c783          	lbu	a5,0(a5)
    80007a10:	02e6d73b          	divuw	a4,a3,a4
    80007a14:	f8f400a3          	sb	a5,-127(s0)
    80007a18:	12a5f463          	bgeu	a1,a0,80007b40 <__printf+0x278>
    80007a1c:	00a00693          	li	a3,10
    80007a20:	00900593          	li	a1,9
    80007a24:	02d777bb          	remuw	a5,a4,a3
    80007a28:	02079793          	slli	a5,a5,0x20
    80007a2c:	0207d793          	srli	a5,a5,0x20
    80007a30:	00fd87b3          	add	a5,s11,a5
    80007a34:	0007c503          	lbu	a0,0(a5)
    80007a38:	02d757bb          	divuw	a5,a4,a3
    80007a3c:	f8a40123          	sb	a0,-126(s0)
    80007a40:	48e5f263          	bgeu	a1,a4,80007ec4 <__printf+0x5fc>
    80007a44:	06300513          	li	a0,99
    80007a48:	02d7f5bb          	remuw	a1,a5,a3
    80007a4c:	02059593          	slli	a1,a1,0x20
    80007a50:	0205d593          	srli	a1,a1,0x20
    80007a54:	00bd85b3          	add	a1,s11,a1
    80007a58:	0005c583          	lbu	a1,0(a1)
    80007a5c:	02d7d7bb          	divuw	a5,a5,a3
    80007a60:	f8b401a3          	sb	a1,-125(s0)
    80007a64:	48e57263          	bgeu	a0,a4,80007ee8 <__printf+0x620>
    80007a68:	3e700513          	li	a0,999
    80007a6c:	02d7f5bb          	remuw	a1,a5,a3
    80007a70:	02059593          	slli	a1,a1,0x20
    80007a74:	0205d593          	srli	a1,a1,0x20
    80007a78:	00bd85b3          	add	a1,s11,a1
    80007a7c:	0005c583          	lbu	a1,0(a1)
    80007a80:	02d7d7bb          	divuw	a5,a5,a3
    80007a84:	f8b40223          	sb	a1,-124(s0)
    80007a88:	46e57663          	bgeu	a0,a4,80007ef4 <__printf+0x62c>
    80007a8c:	02d7f5bb          	remuw	a1,a5,a3
    80007a90:	02059593          	slli	a1,a1,0x20
    80007a94:	0205d593          	srli	a1,a1,0x20
    80007a98:	00bd85b3          	add	a1,s11,a1
    80007a9c:	0005c583          	lbu	a1,0(a1)
    80007aa0:	02d7d7bb          	divuw	a5,a5,a3
    80007aa4:	f8b402a3          	sb	a1,-123(s0)
    80007aa8:	46ea7863          	bgeu	s4,a4,80007f18 <__printf+0x650>
    80007aac:	02d7f5bb          	remuw	a1,a5,a3
    80007ab0:	02059593          	slli	a1,a1,0x20
    80007ab4:	0205d593          	srli	a1,a1,0x20
    80007ab8:	00bd85b3          	add	a1,s11,a1
    80007abc:	0005c583          	lbu	a1,0(a1)
    80007ac0:	02d7d7bb          	divuw	a5,a5,a3
    80007ac4:	f8b40323          	sb	a1,-122(s0)
    80007ac8:	3eeaf863          	bgeu	s5,a4,80007eb8 <__printf+0x5f0>
    80007acc:	02d7f5bb          	remuw	a1,a5,a3
    80007ad0:	02059593          	slli	a1,a1,0x20
    80007ad4:	0205d593          	srli	a1,a1,0x20
    80007ad8:	00bd85b3          	add	a1,s11,a1
    80007adc:	0005c583          	lbu	a1,0(a1)
    80007ae0:	02d7d7bb          	divuw	a5,a5,a3
    80007ae4:	f8b403a3          	sb	a1,-121(s0)
    80007ae8:	42eb7e63          	bgeu	s6,a4,80007f24 <__printf+0x65c>
    80007aec:	02d7f5bb          	remuw	a1,a5,a3
    80007af0:	02059593          	slli	a1,a1,0x20
    80007af4:	0205d593          	srli	a1,a1,0x20
    80007af8:	00bd85b3          	add	a1,s11,a1
    80007afc:	0005c583          	lbu	a1,0(a1)
    80007b00:	02d7d7bb          	divuw	a5,a5,a3
    80007b04:	f8b40423          	sb	a1,-120(s0)
    80007b08:	42ebfc63          	bgeu	s7,a4,80007f40 <__printf+0x678>
    80007b0c:	02079793          	slli	a5,a5,0x20
    80007b10:	0207d793          	srli	a5,a5,0x20
    80007b14:	00fd8db3          	add	s11,s11,a5
    80007b18:	000dc703          	lbu	a4,0(s11)
    80007b1c:	00a00793          	li	a5,10
    80007b20:	00900c93          	li	s9,9
    80007b24:	f8e404a3          	sb	a4,-119(s0)
    80007b28:	00065c63          	bgez	a2,80007b40 <__printf+0x278>
    80007b2c:	f9040713          	addi	a4,s0,-112
    80007b30:	00f70733          	add	a4,a4,a5
    80007b34:	02d00693          	li	a3,45
    80007b38:	fed70823          	sb	a3,-16(a4)
    80007b3c:	00078c93          	mv	s9,a5
    80007b40:	f8040793          	addi	a5,s0,-128
    80007b44:	01978cb3          	add	s9,a5,s9
    80007b48:	f7f40d13          	addi	s10,s0,-129
    80007b4c:	000cc503          	lbu	a0,0(s9)
    80007b50:	fffc8c93          	addi	s9,s9,-1
    80007b54:	00000097          	auipc	ra,0x0
    80007b58:	b90080e7          	jalr	-1136(ra) # 800076e4 <consputc>
    80007b5c:	ffac98e3          	bne	s9,s10,80007b4c <__printf+0x284>
    80007b60:	00094503          	lbu	a0,0(s2)
    80007b64:	e00514e3          	bnez	a0,8000796c <__printf+0xa4>
    80007b68:	1a0c1663          	bnez	s8,80007d14 <__printf+0x44c>
    80007b6c:	08813083          	ld	ra,136(sp)
    80007b70:	08013403          	ld	s0,128(sp)
    80007b74:	07813483          	ld	s1,120(sp)
    80007b78:	07013903          	ld	s2,112(sp)
    80007b7c:	06813983          	ld	s3,104(sp)
    80007b80:	06013a03          	ld	s4,96(sp)
    80007b84:	05813a83          	ld	s5,88(sp)
    80007b88:	05013b03          	ld	s6,80(sp)
    80007b8c:	04813b83          	ld	s7,72(sp)
    80007b90:	04013c03          	ld	s8,64(sp)
    80007b94:	03813c83          	ld	s9,56(sp)
    80007b98:	03013d03          	ld	s10,48(sp)
    80007b9c:	02813d83          	ld	s11,40(sp)
    80007ba0:	0d010113          	addi	sp,sp,208
    80007ba4:	00008067          	ret
    80007ba8:	07300713          	li	a4,115
    80007bac:	1ce78a63          	beq	a5,a4,80007d80 <__printf+0x4b8>
    80007bb0:	07800713          	li	a4,120
    80007bb4:	1ee79e63          	bne	a5,a4,80007db0 <__printf+0x4e8>
    80007bb8:	f7843783          	ld	a5,-136(s0)
    80007bbc:	0007a703          	lw	a4,0(a5)
    80007bc0:	00878793          	addi	a5,a5,8
    80007bc4:	f6f43c23          	sd	a5,-136(s0)
    80007bc8:	28074263          	bltz	a4,80007e4c <__printf+0x584>
    80007bcc:	00002d97          	auipc	s11,0x2
    80007bd0:	a44d8d93          	addi	s11,s11,-1468 # 80009610 <digits>
    80007bd4:	00f77793          	andi	a5,a4,15
    80007bd8:	00fd87b3          	add	a5,s11,a5
    80007bdc:	0007c683          	lbu	a3,0(a5)
    80007be0:	00f00613          	li	a2,15
    80007be4:	0007079b          	sext.w	a5,a4
    80007be8:	f8d40023          	sb	a3,-128(s0)
    80007bec:	0047559b          	srliw	a1,a4,0x4
    80007bf0:	0047569b          	srliw	a3,a4,0x4
    80007bf4:	00000c93          	li	s9,0
    80007bf8:	0ee65063          	bge	a2,a4,80007cd8 <__printf+0x410>
    80007bfc:	00f6f693          	andi	a3,a3,15
    80007c00:	00dd86b3          	add	a3,s11,a3
    80007c04:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80007c08:	0087d79b          	srliw	a5,a5,0x8
    80007c0c:	00100c93          	li	s9,1
    80007c10:	f8d400a3          	sb	a3,-127(s0)
    80007c14:	0cb67263          	bgeu	a2,a1,80007cd8 <__printf+0x410>
    80007c18:	00f7f693          	andi	a3,a5,15
    80007c1c:	00dd86b3          	add	a3,s11,a3
    80007c20:	0006c583          	lbu	a1,0(a3)
    80007c24:	00f00613          	li	a2,15
    80007c28:	0047d69b          	srliw	a3,a5,0x4
    80007c2c:	f8b40123          	sb	a1,-126(s0)
    80007c30:	0047d593          	srli	a1,a5,0x4
    80007c34:	28f67e63          	bgeu	a2,a5,80007ed0 <__printf+0x608>
    80007c38:	00f6f693          	andi	a3,a3,15
    80007c3c:	00dd86b3          	add	a3,s11,a3
    80007c40:	0006c503          	lbu	a0,0(a3)
    80007c44:	0087d813          	srli	a6,a5,0x8
    80007c48:	0087d69b          	srliw	a3,a5,0x8
    80007c4c:	f8a401a3          	sb	a0,-125(s0)
    80007c50:	28b67663          	bgeu	a2,a1,80007edc <__printf+0x614>
    80007c54:	00f6f693          	andi	a3,a3,15
    80007c58:	00dd86b3          	add	a3,s11,a3
    80007c5c:	0006c583          	lbu	a1,0(a3)
    80007c60:	00c7d513          	srli	a0,a5,0xc
    80007c64:	00c7d69b          	srliw	a3,a5,0xc
    80007c68:	f8b40223          	sb	a1,-124(s0)
    80007c6c:	29067a63          	bgeu	a2,a6,80007f00 <__printf+0x638>
    80007c70:	00f6f693          	andi	a3,a3,15
    80007c74:	00dd86b3          	add	a3,s11,a3
    80007c78:	0006c583          	lbu	a1,0(a3)
    80007c7c:	0107d813          	srli	a6,a5,0x10
    80007c80:	0107d69b          	srliw	a3,a5,0x10
    80007c84:	f8b402a3          	sb	a1,-123(s0)
    80007c88:	28a67263          	bgeu	a2,a0,80007f0c <__printf+0x644>
    80007c8c:	00f6f693          	andi	a3,a3,15
    80007c90:	00dd86b3          	add	a3,s11,a3
    80007c94:	0006c683          	lbu	a3,0(a3)
    80007c98:	0147d79b          	srliw	a5,a5,0x14
    80007c9c:	f8d40323          	sb	a3,-122(s0)
    80007ca0:	21067663          	bgeu	a2,a6,80007eac <__printf+0x5e4>
    80007ca4:	02079793          	slli	a5,a5,0x20
    80007ca8:	0207d793          	srli	a5,a5,0x20
    80007cac:	00fd8db3          	add	s11,s11,a5
    80007cb0:	000dc683          	lbu	a3,0(s11)
    80007cb4:	00800793          	li	a5,8
    80007cb8:	00700c93          	li	s9,7
    80007cbc:	f8d403a3          	sb	a3,-121(s0)
    80007cc0:	00075c63          	bgez	a4,80007cd8 <__printf+0x410>
    80007cc4:	f9040713          	addi	a4,s0,-112
    80007cc8:	00f70733          	add	a4,a4,a5
    80007ccc:	02d00693          	li	a3,45
    80007cd0:	fed70823          	sb	a3,-16(a4)
    80007cd4:	00078c93          	mv	s9,a5
    80007cd8:	f8040793          	addi	a5,s0,-128
    80007cdc:	01978cb3          	add	s9,a5,s9
    80007ce0:	f7f40d13          	addi	s10,s0,-129
    80007ce4:	000cc503          	lbu	a0,0(s9)
    80007ce8:	fffc8c93          	addi	s9,s9,-1
    80007cec:	00000097          	auipc	ra,0x0
    80007cf0:	9f8080e7          	jalr	-1544(ra) # 800076e4 <consputc>
    80007cf4:	ff9d18e3          	bne	s10,s9,80007ce4 <__printf+0x41c>
    80007cf8:	0100006f          	j	80007d08 <__printf+0x440>
    80007cfc:	00000097          	auipc	ra,0x0
    80007d00:	9e8080e7          	jalr	-1560(ra) # 800076e4 <consputc>
    80007d04:	000c8493          	mv	s1,s9
    80007d08:	00094503          	lbu	a0,0(s2)
    80007d0c:	c60510e3          	bnez	a0,8000796c <__printf+0xa4>
    80007d10:	e40c0ee3          	beqz	s8,80007b6c <__printf+0x2a4>
    80007d14:	00005517          	auipc	a0,0x5
    80007d18:	15c50513          	addi	a0,a0,348 # 8000ce70 <pr>
    80007d1c:	00001097          	auipc	ra,0x1
    80007d20:	94c080e7          	jalr	-1716(ra) # 80008668 <release>
    80007d24:	e49ff06f          	j	80007b6c <__printf+0x2a4>
    80007d28:	f7843783          	ld	a5,-136(s0)
    80007d2c:	03000513          	li	a0,48
    80007d30:	01000d13          	li	s10,16
    80007d34:	00878713          	addi	a4,a5,8
    80007d38:	0007bc83          	ld	s9,0(a5)
    80007d3c:	f6e43c23          	sd	a4,-136(s0)
    80007d40:	00000097          	auipc	ra,0x0
    80007d44:	9a4080e7          	jalr	-1628(ra) # 800076e4 <consputc>
    80007d48:	07800513          	li	a0,120
    80007d4c:	00000097          	auipc	ra,0x0
    80007d50:	998080e7          	jalr	-1640(ra) # 800076e4 <consputc>
    80007d54:	00002d97          	auipc	s11,0x2
    80007d58:	8bcd8d93          	addi	s11,s11,-1860 # 80009610 <digits>
    80007d5c:	03ccd793          	srli	a5,s9,0x3c
    80007d60:	00fd87b3          	add	a5,s11,a5
    80007d64:	0007c503          	lbu	a0,0(a5)
    80007d68:	fffd0d1b          	addiw	s10,s10,-1
    80007d6c:	004c9c93          	slli	s9,s9,0x4
    80007d70:	00000097          	auipc	ra,0x0
    80007d74:	974080e7          	jalr	-1676(ra) # 800076e4 <consputc>
    80007d78:	fe0d12e3          	bnez	s10,80007d5c <__printf+0x494>
    80007d7c:	f8dff06f          	j	80007d08 <__printf+0x440>
    80007d80:	f7843783          	ld	a5,-136(s0)
    80007d84:	0007bc83          	ld	s9,0(a5)
    80007d88:	00878793          	addi	a5,a5,8
    80007d8c:	f6f43c23          	sd	a5,-136(s0)
    80007d90:	000c9a63          	bnez	s9,80007da4 <__printf+0x4dc>
    80007d94:	1080006f          	j	80007e9c <__printf+0x5d4>
    80007d98:	001c8c93          	addi	s9,s9,1
    80007d9c:	00000097          	auipc	ra,0x0
    80007da0:	948080e7          	jalr	-1720(ra) # 800076e4 <consputc>
    80007da4:	000cc503          	lbu	a0,0(s9)
    80007da8:	fe0518e3          	bnez	a0,80007d98 <__printf+0x4d0>
    80007dac:	f5dff06f          	j	80007d08 <__printf+0x440>
    80007db0:	02500513          	li	a0,37
    80007db4:	00000097          	auipc	ra,0x0
    80007db8:	930080e7          	jalr	-1744(ra) # 800076e4 <consputc>
    80007dbc:	000c8513          	mv	a0,s9
    80007dc0:	00000097          	auipc	ra,0x0
    80007dc4:	924080e7          	jalr	-1756(ra) # 800076e4 <consputc>
    80007dc8:	f41ff06f          	j	80007d08 <__printf+0x440>
    80007dcc:	02500513          	li	a0,37
    80007dd0:	00000097          	auipc	ra,0x0
    80007dd4:	914080e7          	jalr	-1772(ra) # 800076e4 <consputc>
    80007dd8:	f31ff06f          	j	80007d08 <__printf+0x440>
    80007ddc:	00030513          	mv	a0,t1
    80007de0:	00000097          	auipc	ra,0x0
    80007de4:	7bc080e7          	jalr	1980(ra) # 8000859c <acquire>
    80007de8:	b4dff06f          	j	80007934 <__printf+0x6c>
    80007dec:	40c0053b          	negw	a0,a2
    80007df0:	00a00713          	li	a4,10
    80007df4:	02e576bb          	remuw	a3,a0,a4
    80007df8:	00002d97          	auipc	s11,0x2
    80007dfc:	818d8d93          	addi	s11,s11,-2024 # 80009610 <digits>
    80007e00:	ff700593          	li	a1,-9
    80007e04:	02069693          	slli	a3,a3,0x20
    80007e08:	0206d693          	srli	a3,a3,0x20
    80007e0c:	00dd86b3          	add	a3,s11,a3
    80007e10:	0006c683          	lbu	a3,0(a3)
    80007e14:	02e557bb          	divuw	a5,a0,a4
    80007e18:	f8d40023          	sb	a3,-128(s0)
    80007e1c:	10b65e63          	bge	a2,a1,80007f38 <__printf+0x670>
    80007e20:	06300593          	li	a1,99
    80007e24:	02e7f6bb          	remuw	a3,a5,a4
    80007e28:	02069693          	slli	a3,a3,0x20
    80007e2c:	0206d693          	srli	a3,a3,0x20
    80007e30:	00dd86b3          	add	a3,s11,a3
    80007e34:	0006c683          	lbu	a3,0(a3)
    80007e38:	02e7d73b          	divuw	a4,a5,a4
    80007e3c:	00200793          	li	a5,2
    80007e40:	f8d400a3          	sb	a3,-127(s0)
    80007e44:	bca5ece3          	bltu	a1,a0,80007a1c <__printf+0x154>
    80007e48:	ce5ff06f          	j	80007b2c <__printf+0x264>
    80007e4c:	40e007bb          	negw	a5,a4
    80007e50:	00001d97          	auipc	s11,0x1
    80007e54:	7c0d8d93          	addi	s11,s11,1984 # 80009610 <digits>
    80007e58:	00f7f693          	andi	a3,a5,15
    80007e5c:	00dd86b3          	add	a3,s11,a3
    80007e60:	0006c583          	lbu	a1,0(a3)
    80007e64:	ff100613          	li	a2,-15
    80007e68:	0047d69b          	srliw	a3,a5,0x4
    80007e6c:	f8b40023          	sb	a1,-128(s0)
    80007e70:	0047d59b          	srliw	a1,a5,0x4
    80007e74:	0ac75e63          	bge	a4,a2,80007f30 <__printf+0x668>
    80007e78:	00f6f693          	andi	a3,a3,15
    80007e7c:	00dd86b3          	add	a3,s11,a3
    80007e80:	0006c603          	lbu	a2,0(a3)
    80007e84:	00f00693          	li	a3,15
    80007e88:	0087d79b          	srliw	a5,a5,0x8
    80007e8c:	f8c400a3          	sb	a2,-127(s0)
    80007e90:	d8b6e4e3          	bltu	a3,a1,80007c18 <__printf+0x350>
    80007e94:	00200793          	li	a5,2
    80007e98:	e2dff06f          	j	80007cc4 <__printf+0x3fc>
    80007e9c:	00001c97          	auipc	s9,0x1
    80007ea0:	754c8c93          	addi	s9,s9,1876 # 800095f0 <CONSOLE_STATUS+0x5e0>
    80007ea4:	02800513          	li	a0,40
    80007ea8:	ef1ff06f          	j	80007d98 <__printf+0x4d0>
    80007eac:	00700793          	li	a5,7
    80007eb0:	00600c93          	li	s9,6
    80007eb4:	e0dff06f          	j	80007cc0 <__printf+0x3f8>
    80007eb8:	00700793          	li	a5,7
    80007ebc:	00600c93          	li	s9,6
    80007ec0:	c69ff06f          	j	80007b28 <__printf+0x260>
    80007ec4:	00300793          	li	a5,3
    80007ec8:	00200c93          	li	s9,2
    80007ecc:	c5dff06f          	j	80007b28 <__printf+0x260>
    80007ed0:	00300793          	li	a5,3
    80007ed4:	00200c93          	li	s9,2
    80007ed8:	de9ff06f          	j	80007cc0 <__printf+0x3f8>
    80007edc:	00400793          	li	a5,4
    80007ee0:	00300c93          	li	s9,3
    80007ee4:	dddff06f          	j	80007cc0 <__printf+0x3f8>
    80007ee8:	00400793          	li	a5,4
    80007eec:	00300c93          	li	s9,3
    80007ef0:	c39ff06f          	j	80007b28 <__printf+0x260>
    80007ef4:	00500793          	li	a5,5
    80007ef8:	00400c93          	li	s9,4
    80007efc:	c2dff06f          	j	80007b28 <__printf+0x260>
    80007f00:	00500793          	li	a5,5
    80007f04:	00400c93          	li	s9,4
    80007f08:	db9ff06f          	j	80007cc0 <__printf+0x3f8>
    80007f0c:	00600793          	li	a5,6
    80007f10:	00500c93          	li	s9,5
    80007f14:	dadff06f          	j	80007cc0 <__printf+0x3f8>
    80007f18:	00600793          	li	a5,6
    80007f1c:	00500c93          	li	s9,5
    80007f20:	c09ff06f          	j	80007b28 <__printf+0x260>
    80007f24:	00800793          	li	a5,8
    80007f28:	00700c93          	li	s9,7
    80007f2c:	bfdff06f          	j	80007b28 <__printf+0x260>
    80007f30:	00100793          	li	a5,1
    80007f34:	d91ff06f          	j	80007cc4 <__printf+0x3fc>
    80007f38:	00100793          	li	a5,1
    80007f3c:	bf1ff06f          	j	80007b2c <__printf+0x264>
    80007f40:	00900793          	li	a5,9
    80007f44:	00800c93          	li	s9,8
    80007f48:	be1ff06f          	j	80007b28 <__printf+0x260>
    80007f4c:	00001517          	auipc	a0,0x1
    80007f50:	6ac50513          	addi	a0,a0,1708 # 800095f8 <CONSOLE_STATUS+0x5e8>
    80007f54:	00000097          	auipc	ra,0x0
    80007f58:	918080e7          	jalr	-1768(ra) # 8000786c <panic>

0000000080007f5c <printfinit>:
    80007f5c:	fe010113          	addi	sp,sp,-32
    80007f60:	00813823          	sd	s0,16(sp)
    80007f64:	00913423          	sd	s1,8(sp)
    80007f68:	00113c23          	sd	ra,24(sp)
    80007f6c:	02010413          	addi	s0,sp,32
    80007f70:	00005497          	auipc	s1,0x5
    80007f74:	f0048493          	addi	s1,s1,-256 # 8000ce70 <pr>
    80007f78:	00048513          	mv	a0,s1
    80007f7c:	00001597          	auipc	a1,0x1
    80007f80:	68c58593          	addi	a1,a1,1676 # 80009608 <CONSOLE_STATUS+0x5f8>
    80007f84:	00000097          	auipc	ra,0x0
    80007f88:	5f4080e7          	jalr	1524(ra) # 80008578 <initlock>
    80007f8c:	01813083          	ld	ra,24(sp)
    80007f90:	01013403          	ld	s0,16(sp)
    80007f94:	0004ac23          	sw	zero,24(s1)
    80007f98:	00813483          	ld	s1,8(sp)
    80007f9c:	02010113          	addi	sp,sp,32
    80007fa0:	00008067          	ret

0000000080007fa4 <uartinit>:
    80007fa4:	ff010113          	addi	sp,sp,-16
    80007fa8:	00813423          	sd	s0,8(sp)
    80007fac:	01010413          	addi	s0,sp,16
    80007fb0:	100007b7          	lui	a5,0x10000
    80007fb4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80007fb8:	f8000713          	li	a4,-128
    80007fbc:	00e781a3          	sb	a4,3(a5)
    80007fc0:	00300713          	li	a4,3
    80007fc4:	00e78023          	sb	a4,0(a5)
    80007fc8:	000780a3          	sb	zero,1(a5)
    80007fcc:	00e781a3          	sb	a4,3(a5)
    80007fd0:	00700693          	li	a3,7
    80007fd4:	00d78123          	sb	a3,2(a5)
    80007fd8:	00e780a3          	sb	a4,1(a5)
    80007fdc:	00813403          	ld	s0,8(sp)
    80007fe0:	01010113          	addi	sp,sp,16
    80007fe4:	00008067          	ret

0000000080007fe8 <uartputc>:
    80007fe8:	00004797          	auipc	a5,0x4
    80007fec:	b307a783          	lw	a5,-1232(a5) # 8000bb18 <panicked>
    80007ff0:	00078463          	beqz	a5,80007ff8 <uartputc+0x10>
    80007ff4:	0000006f          	j	80007ff4 <uartputc+0xc>
    80007ff8:	fd010113          	addi	sp,sp,-48
    80007ffc:	02813023          	sd	s0,32(sp)
    80008000:	00913c23          	sd	s1,24(sp)
    80008004:	01213823          	sd	s2,16(sp)
    80008008:	01313423          	sd	s3,8(sp)
    8000800c:	02113423          	sd	ra,40(sp)
    80008010:	03010413          	addi	s0,sp,48
    80008014:	00004917          	auipc	s2,0x4
    80008018:	b0c90913          	addi	s2,s2,-1268 # 8000bb20 <uart_tx_r>
    8000801c:	00093783          	ld	a5,0(s2)
    80008020:	00004497          	auipc	s1,0x4
    80008024:	b0848493          	addi	s1,s1,-1272 # 8000bb28 <uart_tx_w>
    80008028:	0004b703          	ld	a4,0(s1)
    8000802c:	02078693          	addi	a3,a5,32
    80008030:	00050993          	mv	s3,a0
    80008034:	02e69c63          	bne	a3,a4,8000806c <uartputc+0x84>
    80008038:	00001097          	auipc	ra,0x1
    8000803c:	834080e7          	jalr	-1996(ra) # 8000886c <push_on>
    80008040:	00093783          	ld	a5,0(s2)
    80008044:	0004b703          	ld	a4,0(s1)
    80008048:	02078793          	addi	a5,a5,32
    8000804c:	00e79463          	bne	a5,a4,80008054 <uartputc+0x6c>
    80008050:	0000006f          	j	80008050 <uartputc+0x68>
    80008054:	00001097          	auipc	ra,0x1
    80008058:	88c080e7          	jalr	-1908(ra) # 800088e0 <pop_on>
    8000805c:	00093783          	ld	a5,0(s2)
    80008060:	0004b703          	ld	a4,0(s1)
    80008064:	02078693          	addi	a3,a5,32
    80008068:	fce688e3          	beq	a3,a4,80008038 <uartputc+0x50>
    8000806c:	01f77693          	andi	a3,a4,31
    80008070:	00005597          	auipc	a1,0x5
    80008074:	e2058593          	addi	a1,a1,-480 # 8000ce90 <uart_tx_buf>
    80008078:	00d586b3          	add	a3,a1,a3
    8000807c:	00170713          	addi	a4,a4,1
    80008080:	01368023          	sb	s3,0(a3)
    80008084:	00e4b023          	sd	a4,0(s1)
    80008088:	10000637          	lui	a2,0x10000
    8000808c:	02f71063          	bne	a4,a5,800080ac <uartputc+0xc4>
    80008090:	0340006f          	j	800080c4 <uartputc+0xdc>
    80008094:	00074703          	lbu	a4,0(a4)
    80008098:	00f93023          	sd	a5,0(s2)
    8000809c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800080a0:	00093783          	ld	a5,0(s2)
    800080a4:	0004b703          	ld	a4,0(s1)
    800080a8:	00f70e63          	beq	a4,a5,800080c4 <uartputc+0xdc>
    800080ac:	00564683          	lbu	a3,5(a2)
    800080b0:	01f7f713          	andi	a4,a5,31
    800080b4:	00e58733          	add	a4,a1,a4
    800080b8:	0206f693          	andi	a3,a3,32
    800080bc:	00178793          	addi	a5,a5,1
    800080c0:	fc069ae3          	bnez	a3,80008094 <uartputc+0xac>
    800080c4:	02813083          	ld	ra,40(sp)
    800080c8:	02013403          	ld	s0,32(sp)
    800080cc:	01813483          	ld	s1,24(sp)
    800080d0:	01013903          	ld	s2,16(sp)
    800080d4:	00813983          	ld	s3,8(sp)
    800080d8:	03010113          	addi	sp,sp,48
    800080dc:	00008067          	ret

00000000800080e0 <uartputc_sync>:
    800080e0:	ff010113          	addi	sp,sp,-16
    800080e4:	00813423          	sd	s0,8(sp)
    800080e8:	01010413          	addi	s0,sp,16
    800080ec:	00004717          	auipc	a4,0x4
    800080f0:	a2c72703          	lw	a4,-1492(a4) # 8000bb18 <panicked>
    800080f4:	02071663          	bnez	a4,80008120 <uartputc_sync+0x40>
    800080f8:	00050793          	mv	a5,a0
    800080fc:	100006b7          	lui	a3,0x10000
    80008100:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80008104:	02077713          	andi	a4,a4,32
    80008108:	fe070ce3          	beqz	a4,80008100 <uartputc_sync+0x20>
    8000810c:	0ff7f793          	andi	a5,a5,255
    80008110:	00f68023          	sb	a5,0(a3)
    80008114:	00813403          	ld	s0,8(sp)
    80008118:	01010113          	addi	sp,sp,16
    8000811c:	00008067          	ret
    80008120:	0000006f          	j	80008120 <uartputc_sync+0x40>

0000000080008124 <uartstart>:
    80008124:	ff010113          	addi	sp,sp,-16
    80008128:	00813423          	sd	s0,8(sp)
    8000812c:	01010413          	addi	s0,sp,16
    80008130:	00004617          	auipc	a2,0x4
    80008134:	9f060613          	addi	a2,a2,-1552 # 8000bb20 <uart_tx_r>
    80008138:	00004517          	auipc	a0,0x4
    8000813c:	9f050513          	addi	a0,a0,-1552 # 8000bb28 <uart_tx_w>
    80008140:	00063783          	ld	a5,0(a2)
    80008144:	00053703          	ld	a4,0(a0)
    80008148:	04f70263          	beq	a4,a5,8000818c <uartstart+0x68>
    8000814c:	100005b7          	lui	a1,0x10000
    80008150:	00005817          	auipc	a6,0x5
    80008154:	d4080813          	addi	a6,a6,-704 # 8000ce90 <uart_tx_buf>
    80008158:	01c0006f          	j	80008174 <uartstart+0x50>
    8000815c:	0006c703          	lbu	a4,0(a3)
    80008160:	00f63023          	sd	a5,0(a2)
    80008164:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80008168:	00063783          	ld	a5,0(a2)
    8000816c:	00053703          	ld	a4,0(a0)
    80008170:	00f70e63          	beq	a4,a5,8000818c <uartstart+0x68>
    80008174:	01f7f713          	andi	a4,a5,31
    80008178:	00e806b3          	add	a3,a6,a4
    8000817c:	0055c703          	lbu	a4,5(a1)
    80008180:	00178793          	addi	a5,a5,1
    80008184:	02077713          	andi	a4,a4,32
    80008188:	fc071ae3          	bnez	a4,8000815c <uartstart+0x38>
    8000818c:	00813403          	ld	s0,8(sp)
    80008190:	01010113          	addi	sp,sp,16
    80008194:	00008067          	ret

0000000080008198 <uartgetc>:
    80008198:	ff010113          	addi	sp,sp,-16
    8000819c:	00813423          	sd	s0,8(sp)
    800081a0:	01010413          	addi	s0,sp,16
    800081a4:	10000737          	lui	a4,0x10000
    800081a8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800081ac:	0017f793          	andi	a5,a5,1
    800081b0:	00078c63          	beqz	a5,800081c8 <uartgetc+0x30>
    800081b4:	00074503          	lbu	a0,0(a4)
    800081b8:	0ff57513          	andi	a0,a0,255
    800081bc:	00813403          	ld	s0,8(sp)
    800081c0:	01010113          	addi	sp,sp,16
    800081c4:	00008067          	ret
    800081c8:	fff00513          	li	a0,-1
    800081cc:	ff1ff06f          	j	800081bc <uartgetc+0x24>

00000000800081d0 <uartintr>:
    800081d0:	100007b7          	lui	a5,0x10000
    800081d4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800081d8:	0017f793          	andi	a5,a5,1
    800081dc:	0a078463          	beqz	a5,80008284 <uartintr+0xb4>
    800081e0:	fe010113          	addi	sp,sp,-32
    800081e4:	00813823          	sd	s0,16(sp)
    800081e8:	00913423          	sd	s1,8(sp)
    800081ec:	00113c23          	sd	ra,24(sp)
    800081f0:	02010413          	addi	s0,sp,32
    800081f4:	100004b7          	lui	s1,0x10000
    800081f8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800081fc:	0ff57513          	andi	a0,a0,255
    80008200:	fffff097          	auipc	ra,0xfffff
    80008204:	534080e7          	jalr	1332(ra) # 80007734 <consoleintr>
    80008208:	0054c783          	lbu	a5,5(s1)
    8000820c:	0017f793          	andi	a5,a5,1
    80008210:	fe0794e3          	bnez	a5,800081f8 <uartintr+0x28>
    80008214:	00004617          	auipc	a2,0x4
    80008218:	90c60613          	addi	a2,a2,-1780 # 8000bb20 <uart_tx_r>
    8000821c:	00004517          	auipc	a0,0x4
    80008220:	90c50513          	addi	a0,a0,-1780 # 8000bb28 <uart_tx_w>
    80008224:	00063783          	ld	a5,0(a2)
    80008228:	00053703          	ld	a4,0(a0)
    8000822c:	04f70263          	beq	a4,a5,80008270 <uartintr+0xa0>
    80008230:	100005b7          	lui	a1,0x10000
    80008234:	00005817          	auipc	a6,0x5
    80008238:	c5c80813          	addi	a6,a6,-932 # 8000ce90 <uart_tx_buf>
    8000823c:	01c0006f          	j	80008258 <uartintr+0x88>
    80008240:	0006c703          	lbu	a4,0(a3)
    80008244:	00f63023          	sd	a5,0(a2)
    80008248:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000824c:	00063783          	ld	a5,0(a2)
    80008250:	00053703          	ld	a4,0(a0)
    80008254:	00f70e63          	beq	a4,a5,80008270 <uartintr+0xa0>
    80008258:	01f7f713          	andi	a4,a5,31
    8000825c:	00e806b3          	add	a3,a6,a4
    80008260:	0055c703          	lbu	a4,5(a1)
    80008264:	00178793          	addi	a5,a5,1
    80008268:	02077713          	andi	a4,a4,32
    8000826c:	fc071ae3          	bnez	a4,80008240 <uartintr+0x70>
    80008270:	01813083          	ld	ra,24(sp)
    80008274:	01013403          	ld	s0,16(sp)
    80008278:	00813483          	ld	s1,8(sp)
    8000827c:	02010113          	addi	sp,sp,32
    80008280:	00008067          	ret
    80008284:	00004617          	auipc	a2,0x4
    80008288:	89c60613          	addi	a2,a2,-1892 # 8000bb20 <uart_tx_r>
    8000828c:	00004517          	auipc	a0,0x4
    80008290:	89c50513          	addi	a0,a0,-1892 # 8000bb28 <uart_tx_w>
    80008294:	00063783          	ld	a5,0(a2)
    80008298:	00053703          	ld	a4,0(a0)
    8000829c:	04f70263          	beq	a4,a5,800082e0 <uartintr+0x110>
    800082a0:	100005b7          	lui	a1,0x10000
    800082a4:	00005817          	auipc	a6,0x5
    800082a8:	bec80813          	addi	a6,a6,-1044 # 8000ce90 <uart_tx_buf>
    800082ac:	01c0006f          	j	800082c8 <uartintr+0xf8>
    800082b0:	0006c703          	lbu	a4,0(a3)
    800082b4:	00f63023          	sd	a5,0(a2)
    800082b8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800082bc:	00063783          	ld	a5,0(a2)
    800082c0:	00053703          	ld	a4,0(a0)
    800082c4:	02f70063          	beq	a4,a5,800082e4 <uartintr+0x114>
    800082c8:	01f7f713          	andi	a4,a5,31
    800082cc:	00e806b3          	add	a3,a6,a4
    800082d0:	0055c703          	lbu	a4,5(a1)
    800082d4:	00178793          	addi	a5,a5,1
    800082d8:	02077713          	andi	a4,a4,32
    800082dc:	fc071ae3          	bnez	a4,800082b0 <uartintr+0xe0>
    800082e0:	00008067          	ret
    800082e4:	00008067          	ret

00000000800082e8 <kinit>:
    800082e8:	fc010113          	addi	sp,sp,-64
    800082ec:	02913423          	sd	s1,40(sp)
    800082f0:	fffff7b7          	lui	a5,0xfffff
    800082f4:	00006497          	auipc	s1,0x6
    800082f8:	bbb48493          	addi	s1,s1,-1093 # 8000deaf <end+0xfff>
    800082fc:	02813823          	sd	s0,48(sp)
    80008300:	01313c23          	sd	s3,24(sp)
    80008304:	00f4f4b3          	and	s1,s1,a5
    80008308:	02113c23          	sd	ra,56(sp)
    8000830c:	03213023          	sd	s2,32(sp)
    80008310:	01413823          	sd	s4,16(sp)
    80008314:	01513423          	sd	s5,8(sp)
    80008318:	04010413          	addi	s0,sp,64
    8000831c:	000017b7          	lui	a5,0x1
    80008320:	01100993          	li	s3,17
    80008324:	00f487b3          	add	a5,s1,a5
    80008328:	01b99993          	slli	s3,s3,0x1b
    8000832c:	06f9e063          	bltu	s3,a5,8000838c <kinit+0xa4>
    80008330:	00005a97          	auipc	s5,0x5
    80008334:	b80a8a93          	addi	s5,s5,-1152 # 8000ceb0 <end>
    80008338:	0754ec63          	bltu	s1,s5,800083b0 <kinit+0xc8>
    8000833c:	0734fa63          	bgeu	s1,s3,800083b0 <kinit+0xc8>
    80008340:	00088a37          	lui	s4,0x88
    80008344:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80008348:	00003917          	auipc	s2,0x3
    8000834c:	7e890913          	addi	s2,s2,2024 # 8000bb30 <kmem>
    80008350:	00ca1a13          	slli	s4,s4,0xc
    80008354:	0140006f          	j	80008368 <kinit+0x80>
    80008358:	000017b7          	lui	a5,0x1
    8000835c:	00f484b3          	add	s1,s1,a5
    80008360:	0554e863          	bltu	s1,s5,800083b0 <kinit+0xc8>
    80008364:	0534f663          	bgeu	s1,s3,800083b0 <kinit+0xc8>
    80008368:	00001637          	lui	a2,0x1
    8000836c:	00100593          	li	a1,1
    80008370:	00048513          	mv	a0,s1
    80008374:	00000097          	auipc	ra,0x0
    80008378:	5e4080e7          	jalr	1508(ra) # 80008958 <__memset>
    8000837c:	00093783          	ld	a5,0(s2)
    80008380:	00f4b023          	sd	a5,0(s1)
    80008384:	00993023          	sd	s1,0(s2)
    80008388:	fd4498e3          	bne	s1,s4,80008358 <kinit+0x70>
    8000838c:	03813083          	ld	ra,56(sp)
    80008390:	03013403          	ld	s0,48(sp)
    80008394:	02813483          	ld	s1,40(sp)
    80008398:	02013903          	ld	s2,32(sp)
    8000839c:	01813983          	ld	s3,24(sp)
    800083a0:	01013a03          	ld	s4,16(sp)
    800083a4:	00813a83          	ld	s5,8(sp)
    800083a8:	04010113          	addi	sp,sp,64
    800083ac:	00008067          	ret
    800083b0:	00001517          	auipc	a0,0x1
    800083b4:	27850513          	addi	a0,a0,632 # 80009628 <digits+0x18>
    800083b8:	fffff097          	auipc	ra,0xfffff
    800083bc:	4b4080e7          	jalr	1204(ra) # 8000786c <panic>

00000000800083c0 <freerange>:
    800083c0:	fc010113          	addi	sp,sp,-64
    800083c4:	000017b7          	lui	a5,0x1
    800083c8:	02913423          	sd	s1,40(sp)
    800083cc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800083d0:	009504b3          	add	s1,a0,s1
    800083d4:	fffff537          	lui	a0,0xfffff
    800083d8:	02813823          	sd	s0,48(sp)
    800083dc:	02113c23          	sd	ra,56(sp)
    800083e0:	03213023          	sd	s2,32(sp)
    800083e4:	01313c23          	sd	s3,24(sp)
    800083e8:	01413823          	sd	s4,16(sp)
    800083ec:	01513423          	sd	s5,8(sp)
    800083f0:	01613023          	sd	s6,0(sp)
    800083f4:	04010413          	addi	s0,sp,64
    800083f8:	00a4f4b3          	and	s1,s1,a0
    800083fc:	00f487b3          	add	a5,s1,a5
    80008400:	06f5e463          	bltu	a1,a5,80008468 <freerange+0xa8>
    80008404:	00005a97          	auipc	s5,0x5
    80008408:	aaca8a93          	addi	s5,s5,-1364 # 8000ceb0 <end>
    8000840c:	0954e263          	bltu	s1,s5,80008490 <freerange+0xd0>
    80008410:	01100993          	li	s3,17
    80008414:	01b99993          	slli	s3,s3,0x1b
    80008418:	0734fc63          	bgeu	s1,s3,80008490 <freerange+0xd0>
    8000841c:	00058a13          	mv	s4,a1
    80008420:	00003917          	auipc	s2,0x3
    80008424:	71090913          	addi	s2,s2,1808 # 8000bb30 <kmem>
    80008428:	00002b37          	lui	s6,0x2
    8000842c:	0140006f          	j	80008440 <freerange+0x80>
    80008430:	000017b7          	lui	a5,0x1
    80008434:	00f484b3          	add	s1,s1,a5
    80008438:	0554ec63          	bltu	s1,s5,80008490 <freerange+0xd0>
    8000843c:	0534fa63          	bgeu	s1,s3,80008490 <freerange+0xd0>
    80008440:	00001637          	lui	a2,0x1
    80008444:	00100593          	li	a1,1
    80008448:	00048513          	mv	a0,s1
    8000844c:	00000097          	auipc	ra,0x0
    80008450:	50c080e7          	jalr	1292(ra) # 80008958 <__memset>
    80008454:	00093703          	ld	a4,0(s2)
    80008458:	016487b3          	add	a5,s1,s6
    8000845c:	00e4b023          	sd	a4,0(s1)
    80008460:	00993023          	sd	s1,0(s2)
    80008464:	fcfa76e3          	bgeu	s4,a5,80008430 <freerange+0x70>
    80008468:	03813083          	ld	ra,56(sp)
    8000846c:	03013403          	ld	s0,48(sp)
    80008470:	02813483          	ld	s1,40(sp)
    80008474:	02013903          	ld	s2,32(sp)
    80008478:	01813983          	ld	s3,24(sp)
    8000847c:	01013a03          	ld	s4,16(sp)
    80008480:	00813a83          	ld	s5,8(sp)
    80008484:	00013b03          	ld	s6,0(sp)
    80008488:	04010113          	addi	sp,sp,64
    8000848c:	00008067          	ret
    80008490:	00001517          	auipc	a0,0x1
    80008494:	19850513          	addi	a0,a0,408 # 80009628 <digits+0x18>
    80008498:	fffff097          	auipc	ra,0xfffff
    8000849c:	3d4080e7          	jalr	980(ra) # 8000786c <panic>

00000000800084a0 <kfree>:
    800084a0:	fe010113          	addi	sp,sp,-32
    800084a4:	00813823          	sd	s0,16(sp)
    800084a8:	00113c23          	sd	ra,24(sp)
    800084ac:	00913423          	sd	s1,8(sp)
    800084b0:	02010413          	addi	s0,sp,32
    800084b4:	03451793          	slli	a5,a0,0x34
    800084b8:	04079c63          	bnez	a5,80008510 <kfree+0x70>
    800084bc:	00005797          	auipc	a5,0x5
    800084c0:	9f478793          	addi	a5,a5,-1548 # 8000ceb0 <end>
    800084c4:	00050493          	mv	s1,a0
    800084c8:	04f56463          	bltu	a0,a5,80008510 <kfree+0x70>
    800084cc:	01100793          	li	a5,17
    800084d0:	01b79793          	slli	a5,a5,0x1b
    800084d4:	02f57e63          	bgeu	a0,a5,80008510 <kfree+0x70>
    800084d8:	00001637          	lui	a2,0x1
    800084dc:	00100593          	li	a1,1
    800084e0:	00000097          	auipc	ra,0x0
    800084e4:	478080e7          	jalr	1144(ra) # 80008958 <__memset>
    800084e8:	00003797          	auipc	a5,0x3
    800084ec:	64878793          	addi	a5,a5,1608 # 8000bb30 <kmem>
    800084f0:	0007b703          	ld	a4,0(a5)
    800084f4:	01813083          	ld	ra,24(sp)
    800084f8:	01013403          	ld	s0,16(sp)
    800084fc:	00e4b023          	sd	a4,0(s1)
    80008500:	0097b023          	sd	s1,0(a5)
    80008504:	00813483          	ld	s1,8(sp)
    80008508:	02010113          	addi	sp,sp,32
    8000850c:	00008067          	ret
    80008510:	00001517          	auipc	a0,0x1
    80008514:	11850513          	addi	a0,a0,280 # 80009628 <digits+0x18>
    80008518:	fffff097          	auipc	ra,0xfffff
    8000851c:	354080e7          	jalr	852(ra) # 8000786c <panic>

0000000080008520 <kalloc>:
    80008520:	fe010113          	addi	sp,sp,-32
    80008524:	00813823          	sd	s0,16(sp)
    80008528:	00913423          	sd	s1,8(sp)
    8000852c:	00113c23          	sd	ra,24(sp)
    80008530:	02010413          	addi	s0,sp,32
    80008534:	00003797          	auipc	a5,0x3
    80008538:	5fc78793          	addi	a5,a5,1532 # 8000bb30 <kmem>
    8000853c:	0007b483          	ld	s1,0(a5)
    80008540:	02048063          	beqz	s1,80008560 <kalloc+0x40>
    80008544:	0004b703          	ld	a4,0(s1)
    80008548:	00001637          	lui	a2,0x1
    8000854c:	00500593          	li	a1,5
    80008550:	00048513          	mv	a0,s1
    80008554:	00e7b023          	sd	a4,0(a5)
    80008558:	00000097          	auipc	ra,0x0
    8000855c:	400080e7          	jalr	1024(ra) # 80008958 <__memset>
    80008560:	01813083          	ld	ra,24(sp)
    80008564:	01013403          	ld	s0,16(sp)
    80008568:	00048513          	mv	a0,s1
    8000856c:	00813483          	ld	s1,8(sp)
    80008570:	02010113          	addi	sp,sp,32
    80008574:	00008067          	ret

0000000080008578 <initlock>:
    80008578:	ff010113          	addi	sp,sp,-16
    8000857c:	00813423          	sd	s0,8(sp)
    80008580:	01010413          	addi	s0,sp,16
    80008584:	00813403          	ld	s0,8(sp)
    80008588:	00b53423          	sd	a1,8(a0)
    8000858c:	00052023          	sw	zero,0(a0)
    80008590:	00053823          	sd	zero,16(a0)
    80008594:	01010113          	addi	sp,sp,16
    80008598:	00008067          	ret

000000008000859c <acquire>:
    8000859c:	fe010113          	addi	sp,sp,-32
    800085a0:	00813823          	sd	s0,16(sp)
    800085a4:	00913423          	sd	s1,8(sp)
    800085a8:	00113c23          	sd	ra,24(sp)
    800085ac:	01213023          	sd	s2,0(sp)
    800085b0:	02010413          	addi	s0,sp,32
    800085b4:	00050493          	mv	s1,a0
    800085b8:	10002973          	csrr	s2,sstatus
    800085bc:	100027f3          	csrr	a5,sstatus
    800085c0:	ffd7f793          	andi	a5,a5,-3
    800085c4:	10079073          	csrw	sstatus,a5
    800085c8:	fffff097          	auipc	ra,0xfffff
    800085cc:	8e4080e7          	jalr	-1820(ra) # 80006eac <mycpu>
    800085d0:	07852783          	lw	a5,120(a0)
    800085d4:	06078e63          	beqz	a5,80008650 <acquire+0xb4>
    800085d8:	fffff097          	auipc	ra,0xfffff
    800085dc:	8d4080e7          	jalr	-1836(ra) # 80006eac <mycpu>
    800085e0:	07852783          	lw	a5,120(a0)
    800085e4:	0004a703          	lw	a4,0(s1)
    800085e8:	0017879b          	addiw	a5,a5,1
    800085ec:	06f52c23          	sw	a5,120(a0)
    800085f0:	04071063          	bnez	a4,80008630 <acquire+0x94>
    800085f4:	00100713          	li	a4,1
    800085f8:	00070793          	mv	a5,a4
    800085fc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80008600:	0007879b          	sext.w	a5,a5
    80008604:	fe079ae3          	bnez	a5,800085f8 <acquire+0x5c>
    80008608:	0ff0000f          	fence
    8000860c:	fffff097          	auipc	ra,0xfffff
    80008610:	8a0080e7          	jalr	-1888(ra) # 80006eac <mycpu>
    80008614:	01813083          	ld	ra,24(sp)
    80008618:	01013403          	ld	s0,16(sp)
    8000861c:	00a4b823          	sd	a0,16(s1)
    80008620:	00013903          	ld	s2,0(sp)
    80008624:	00813483          	ld	s1,8(sp)
    80008628:	02010113          	addi	sp,sp,32
    8000862c:	00008067          	ret
    80008630:	0104b903          	ld	s2,16(s1)
    80008634:	fffff097          	auipc	ra,0xfffff
    80008638:	878080e7          	jalr	-1928(ra) # 80006eac <mycpu>
    8000863c:	faa91ce3          	bne	s2,a0,800085f4 <acquire+0x58>
    80008640:	00001517          	auipc	a0,0x1
    80008644:	ff050513          	addi	a0,a0,-16 # 80009630 <digits+0x20>
    80008648:	fffff097          	auipc	ra,0xfffff
    8000864c:	224080e7          	jalr	548(ra) # 8000786c <panic>
    80008650:	00195913          	srli	s2,s2,0x1
    80008654:	fffff097          	auipc	ra,0xfffff
    80008658:	858080e7          	jalr	-1960(ra) # 80006eac <mycpu>
    8000865c:	00197913          	andi	s2,s2,1
    80008660:	07252e23          	sw	s2,124(a0)
    80008664:	f75ff06f          	j	800085d8 <acquire+0x3c>

0000000080008668 <release>:
    80008668:	fe010113          	addi	sp,sp,-32
    8000866c:	00813823          	sd	s0,16(sp)
    80008670:	00113c23          	sd	ra,24(sp)
    80008674:	00913423          	sd	s1,8(sp)
    80008678:	01213023          	sd	s2,0(sp)
    8000867c:	02010413          	addi	s0,sp,32
    80008680:	00052783          	lw	a5,0(a0)
    80008684:	00079a63          	bnez	a5,80008698 <release+0x30>
    80008688:	00001517          	auipc	a0,0x1
    8000868c:	fb050513          	addi	a0,a0,-80 # 80009638 <digits+0x28>
    80008690:	fffff097          	auipc	ra,0xfffff
    80008694:	1dc080e7          	jalr	476(ra) # 8000786c <panic>
    80008698:	01053903          	ld	s2,16(a0)
    8000869c:	00050493          	mv	s1,a0
    800086a0:	fffff097          	auipc	ra,0xfffff
    800086a4:	80c080e7          	jalr	-2036(ra) # 80006eac <mycpu>
    800086a8:	fea910e3          	bne	s2,a0,80008688 <release+0x20>
    800086ac:	0004b823          	sd	zero,16(s1)
    800086b0:	0ff0000f          	fence
    800086b4:	0f50000f          	fence	iorw,ow
    800086b8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800086bc:	ffffe097          	auipc	ra,0xffffe
    800086c0:	7f0080e7          	jalr	2032(ra) # 80006eac <mycpu>
    800086c4:	100027f3          	csrr	a5,sstatus
    800086c8:	0027f793          	andi	a5,a5,2
    800086cc:	04079a63          	bnez	a5,80008720 <release+0xb8>
    800086d0:	07852783          	lw	a5,120(a0)
    800086d4:	02f05e63          	blez	a5,80008710 <release+0xa8>
    800086d8:	fff7871b          	addiw	a4,a5,-1
    800086dc:	06e52c23          	sw	a4,120(a0)
    800086e0:	00071c63          	bnez	a4,800086f8 <release+0x90>
    800086e4:	07c52783          	lw	a5,124(a0)
    800086e8:	00078863          	beqz	a5,800086f8 <release+0x90>
    800086ec:	100027f3          	csrr	a5,sstatus
    800086f0:	0027e793          	ori	a5,a5,2
    800086f4:	10079073          	csrw	sstatus,a5
    800086f8:	01813083          	ld	ra,24(sp)
    800086fc:	01013403          	ld	s0,16(sp)
    80008700:	00813483          	ld	s1,8(sp)
    80008704:	00013903          	ld	s2,0(sp)
    80008708:	02010113          	addi	sp,sp,32
    8000870c:	00008067          	ret
    80008710:	00001517          	auipc	a0,0x1
    80008714:	f4850513          	addi	a0,a0,-184 # 80009658 <digits+0x48>
    80008718:	fffff097          	auipc	ra,0xfffff
    8000871c:	154080e7          	jalr	340(ra) # 8000786c <panic>
    80008720:	00001517          	auipc	a0,0x1
    80008724:	f2050513          	addi	a0,a0,-224 # 80009640 <digits+0x30>
    80008728:	fffff097          	auipc	ra,0xfffff
    8000872c:	144080e7          	jalr	324(ra) # 8000786c <panic>

0000000080008730 <holding>:
    80008730:	00052783          	lw	a5,0(a0)
    80008734:	00079663          	bnez	a5,80008740 <holding+0x10>
    80008738:	00000513          	li	a0,0
    8000873c:	00008067          	ret
    80008740:	fe010113          	addi	sp,sp,-32
    80008744:	00813823          	sd	s0,16(sp)
    80008748:	00913423          	sd	s1,8(sp)
    8000874c:	00113c23          	sd	ra,24(sp)
    80008750:	02010413          	addi	s0,sp,32
    80008754:	01053483          	ld	s1,16(a0)
    80008758:	ffffe097          	auipc	ra,0xffffe
    8000875c:	754080e7          	jalr	1876(ra) # 80006eac <mycpu>
    80008760:	01813083          	ld	ra,24(sp)
    80008764:	01013403          	ld	s0,16(sp)
    80008768:	40a48533          	sub	a0,s1,a0
    8000876c:	00153513          	seqz	a0,a0
    80008770:	00813483          	ld	s1,8(sp)
    80008774:	02010113          	addi	sp,sp,32
    80008778:	00008067          	ret

000000008000877c <push_off>:
    8000877c:	fe010113          	addi	sp,sp,-32
    80008780:	00813823          	sd	s0,16(sp)
    80008784:	00113c23          	sd	ra,24(sp)
    80008788:	00913423          	sd	s1,8(sp)
    8000878c:	02010413          	addi	s0,sp,32
    80008790:	100024f3          	csrr	s1,sstatus
    80008794:	100027f3          	csrr	a5,sstatus
    80008798:	ffd7f793          	andi	a5,a5,-3
    8000879c:	10079073          	csrw	sstatus,a5
    800087a0:	ffffe097          	auipc	ra,0xffffe
    800087a4:	70c080e7          	jalr	1804(ra) # 80006eac <mycpu>
    800087a8:	07852783          	lw	a5,120(a0)
    800087ac:	02078663          	beqz	a5,800087d8 <push_off+0x5c>
    800087b0:	ffffe097          	auipc	ra,0xffffe
    800087b4:	6fc080e7          	jalr	1788(ra) # 80006eac <mycpu>
    800087b8:	07852783          	lw	a5,120(a0)
    800087bc:	01813083          	ld	ra,24(sp)
    800087c0:	01013403          	ld	s0,16(sp)
    800087c4:	0017879b          	addiw	a5,a5,1
    800087c8:	06f52c23          	sw	a5,120(a0)
    800087cc:	00813483          	ld	s1,8(sp)
    800087d0:	02010113          	addi	sp,sp,32
    800087d4:	00008067          	ret
    800087d8:	0014d493          	srli	s1,s1,0x1
    800087dc:	ffffe097          	auipc	ra,0xffffe
    800087e0:	6d0080e7          	jalr	1744(ra) # 80006eac <mycpu>
    800087e4:	0014f493          	andi	s1,s1,1
    800087e8:	06952e23          	sw	s1,124(a0)
    800087ec:	fc5ff06f          	j	800087b0 <push_off+0x34>

00000000800087f0 <pop_off>:
    800087f0:	ff010113          	addi	sp,sp,-16
    800087f4:	00813023          	sd	s0,0(sp)
    800087f8:	00113423          	sd	ra,8(sp)
    800087fc:	01010413          	addi	s0,sp,16
    80008800:	ffffe097          	auipc	ra,0xffffe
    80008804:	6ac080e7          	jalr	1708(ra) # 80006eac <mycpu>
    80008808:	100027f3          	csrr	a5,sstatus
    8000880c:	0027f793          	andi	a5,a5,2
    80008810:	04079663          	bnez	a5,8000885c <pop_off+0x6c>
    80008814:	07852783          	lw	a5,120(a0)
    80008818:	02f05a63          	blez	a5,8000884c <pop_off+0x5c>
    8000881c:	fff7871b          	addiw	a4,a5,-1
    80008820:	06e52c23          	sw	a4,120(a0)
    80008824:	00071c63          	bnez	a4,8000883c <pop_off+0x4c>
    80008828:	07c52783          	lw	a5,124(a0)
    8000882c:	00078863          	beqz	a5,8000883c <pop_off+0x4c>
    80008830:	100027f3          	csrr	a5,sstatus
    80008834:	0027e793          	ori	a5,a5,2
    80008838:	10079073          	csrw	sstatus,a5
    8000883c:	00813083          	ld	ra,8(sp)
    80008840:	00013403          	ld	s0,0(sp)
    80008844:	01010113          	addi	sp,sp,16
    80008848:	00008067          	ret
    8000884c:	00001517          	auipc	a0,0x1
    80008850:	e0c50513          	addi	a0,a0,-500 # 80009658 <digits+0x48>
    80008854:	fffff097          	auipc	ra,0xfffff
    80008858:	018080e7          	jalr	24(ra) # 8000786c <panic>
    8000885c:	00001517          	auipc	a0,0x1
    80008860:	de450513          	addi	a0,a0,-540 # 80009640 <digits+0x30>
    80008864:	fffff097          	auipc	ra,0xfffff
    80008868:	008080e7          	jalr	8(ra) # 8000786c <panic>

000000008000886c <push_on>:
    8000886c:	fe010113          	addi	sp,sp,-32
    80008870:	00813823          	sd	s0,16(sp)
    80008874:	00113c23          	sd	ra,24(sp)
    80008878:	00913423          	sd	s1,8(sp)
    8000887c:	02010413          	addi	s0,sp,32
    80008880:	100024f3          	csrr	s1,sstatus
    80008884:	100027f3          	csrr	a5,sstatus
    80008888:	0027e793          	ori	a5,a5,2
    8000888c:	10079073          	csrw	sstatus,a5
    80008890:	ffffe097          	auipc	ra,0xffffe
    80008894:	61c080e7          	jalr	1564(ra) # 80006eac <mycpu>
    80008898:	07852783          	lw	a5,120(a0)
    8000889c:	02078663          	beqz	a5,800088c8 <push_on+0x5c>
    800088a0:	ffffe097          	auipc	ra,0xffffe
    800088a4:	60c080e7          	jalr	1548(ra) # 80006eac <mycpu>
    800088a8:	07852783          	lw	a5,120(a0)
    800088ac:	01813083          	ld	ra,24(sp)
    800088b0:	01013403          	ld	s0,16(sp)
    800088b4:	0017879b          	addiw	a5,a5,1
    800088b8:	06f52c23          	sw	a5,120(a0)
    800088bc:	00813483          	ld	s1,8(sp)
    800088c0:	02010113          	addi	sp,sp,32
    800088c4:	00008067          	ret
    800088c8:	0014d493          	srli	s1,s1,0x1
    800088cc:	ffffe097          	auipc	ra,0xffffe
    800088d0:	5e0080e7          	jalr	1504(ra) # 80006eac <mycpu>
    800088d4:	0014f493          	andi	s1,s1,1
    800088d8:	06952e23          	sw	s1,124(a0)
    800088dc:	fc5ff06f          	j	800088a0 <push_on+0x34>

00000000800088e0 <pop_on>:
    800088e0:	ff010113          	addi	sp,sp,-16
    800088e4:	00813023          	sd	s0,0(sp)
    800088e8:	00113423          	sd	ra,8(sp)
    800088ec:	01010413          	addi	s0,sp,16
    800088f0:	ffffe097          	auipc	ra,0xffffe
    800088f4:	5bc080e7          	jalr	1468(ra) # 80006eac <mycpu>
    800088f8:	100027f3          	csrr	a5,sstatus
    800088fc:	0027f793          	andi	a5,a5,2
    80008900:	04078463          	beqz	a5,80008948 <pop_on+0x68>
    80008904:	07852783          	lw	a5,120(a0)
    80008908:	02f05863          	blez	a5,80008938 <pop_on+0x58>
    8000890c:	fff7879b          	addiw	a5,a5,-1
    80008910:	06f52c23          	sw	a5,120(a0)
    80008914:	07853783          	ld	a5,120(a0)
    80008918:	00079863          	bnez	a5,80008928 <pop_on+0x48>
    8000891c:	100027f3          	csrr	a5,sstatus
    80008920:	ffd7f793          	andi	a5,a5,-3
    80008924:	10079073          	csrw	sstatus,a5
    80008928:	00813083          	ld	ra,8(sp)
    8000892c:	00013403          	ld	s0,0(sp)
    80008930:	01010113          	addi	sp,sp,16
    80008934:	00008067          	ret
    80008938:	00001517          	auipc	a0,0x1
    8000893c:	d4850513          	addi	a0,a0,-696 # 80009680 <digits+0x70>
    80008940:	fffff097          	auipc	ra,0xfffff
    80008944:	f2c080e7          	jalr	-212(ra) # 8000786c <panic>
    80008948:	00001517          	auipc	a0,0x1
    8000894c:	d1850513          	addi	a0,a0,-744 # 80009660 <digits+0x50>
    80008950:	fffff097          	auipc	ra,0xfffff
    80008954:	f1c080e7          	jalr	-228(ra) # 8000786c <panic>

0000000080008958 <__memset>:
    80008958:	ff010113          	addi	sp,sp,-16
    8000895c:	00813423          	sd	s0,8(sp)
    80008960:	01010413          	addi	s0,sp,16
    80008964:	1a060e63          	beqz	a2,80008b20 <__memset+0x1c8>
    80008968:	40a007b3          	neg	a5,a0
    8000896c:	0077f793          	andi	a5,a5,7
    80008970:	00778693          	addi	a3,a5,7
    80008974:	00b00813          	li	a6,11
    80008978:	0ff5f593          	andi	a1,a1,255
    8000897c:	fff6071b          	addiw	a4,a2,-1
    80008980:	1b06e663          	bltu	a3,a6,80008b2c <__memset+0x1d4>
    80008984:	1cd76463          	bltu	a4,a3,80008b4c <__memset+0x1f4>
    80008988:	1a078e63          	beqz	a5,80008b44 <__memset+0x1ec>
    8000898c:	00b50023          	sb	a1,0(a0)
    80008990:	00100713          	li	a4,1
    80008994:	1ae78463          	beq	a5,a4,80008b3c <__memset+0x1e4>
    80008998:	00b500a3          	sb	a1,1(a0)
    8000899c:	00200713          	li	a4,2
    800089a0:	1ae78a63          	beq	a5,a4,80008b54 <__memset+0x1fc>
    800089a4:	00b50123          	sb	a1,2(a0)
    800089a8:	00300713          	li	a4,3
    800089ac:	18e78463          	beq	a5,a4,80008b34 <__memset+0x1dc>
    800089b0:	00b501a3          	sb	a1,3(a0)
    800089b4:	00400713          	li	a4,4
    800089b8:	1ae78263          	beq	a5,a4,80008b5c <__memset+0x204>
    800089bc:	00b50223          	sb	a1,4(a0)
    800089c0:	00500713          	li	a4,5
    800089c4:	1ae78063          	beq	a5,a4,80008b64 <__memset+0x20c>
    800089c8:	00b502a3          	sb	a1,5(a0)
    800089cc:	00700713          	li	a4,7
    800089d0:	18e79e63          	bne	a5,a4,80008b6c <__memset+0x214>
    800089d4:	00b50323          	sb	a1,6(a0)
    800089d8:	00700e93          	li	t4,7
    800089dc:	00859713          	slli	a4,a1,0x8
    800089e0:	00e5e733          	or	a4,a1,a4
    800089e4:	01059e13          	slli	t3,a1,0x10
    800089e8:	01c76e33          	or	t3,a4,t3
    800089ec:	01859313          	slli	t1,a1,0x18
    800089f0:	006e6333          	or	t1,t3,t1
    800089f4:	02059893          	slli	a7,a1,0x20
    800089f8:	40f60e3b          	subw	t3,a2,a5
    800089fc:	011368b3          	or	a7,t1,a7
    80008a00:	02859813          	slli	a6,a1,0x28
    80008a04:	0108e833          	or	a6,a7,a6
    80008a08:	03059693          	slli	a3,a1,0x30
    80008a0c:	003e589b          	srliw	a7,t3,0x3
    80008a10:	00d866b3          	or	a3,a6,a3
    80008a14:	03859713          	slli	a4,a1,0x38
    80008a18:	00389813          	slli	a6,a7,0x3
    80008a1c:	00f507b3          	add	a5,a0,a5
    80008a20:	00e6e733          	or	a4,a3,a4
    80008a24:	000e089b          	sext.w	a7,t3
    80008a28:	00f806b3          	add	a3,a6,a5
    80008a2c:	00e7b023          	sd	a4,0(a5)
    80008a30:	00878793          	addi	a5,a5,8
    80008a34:	fed79ce3          	bne	a5,a3,80008a2c <__memset+0xd4>
    80008a38:	ff8e7793          	andi	a5,t3,-8
    80008a3c:	0007871b          	sext.w	a4,a5
    80008a40:	01d787bb          	addw	a5,a5,t4
    80008a44:	0ce88e63          	beq	a7,a4,80008b20 <__memset+0x1c8>
    80008a48:	00f50733          	add	a4,a0,a5
    80008a4c:	00b70023          	sb	a1,0(a4)
    80008a50:	0017871b          	addiw	a4,a5,1
    80008a54:	0cc77663          	bgeu	a4,a2,80008b20 <__memset+0x1c8>
    80008a58:	00e50733          	add	a4,a0,a4
    80008a5c:	00b70023          	sb	a1,0(a4)
    80008a60:	0027871b          	addiw	a4,a5,2
    80008a64:	0ac77e63          	bgeu	a4,a2,80008b20 <__memset+0x1c8>
    80008a68:	00e50733          	add	a4,a0,a4
    80008a6c:	00b70023          	sb	a1,0(a4)
    80008a70:	0037871b          	addiw	a4,a5,3
    80008a74:	0ac77663          	bgeu	a4,a2,80008b20 <__memset+0x1c8>
    80008a78:	00e50733          	add	a4,a0,a4
    80008a7c:	00b70023          	sb	a1,0(a4)
    80008a80:	0047871b          	addiw	a4,a5,4
    80008a84:	08c77e63          	bgeu	a4,a2,80008b20 <__memset+0x1c8>
    80008a88:	00e50733          	add	a4,a0,a4
    80008a8c:	00b70023          	sb	a1,0(a4)
    80008a90:	0057871b          	addiw	a4,a5,5
    80008a94:	08c77663          	bgeu	a4,a2,80008b20 <__memset+0x1c8>
    80008a98:	00e50733          	add	a4,a0,a4
    80008a9c:	00b70023          	sb	a1,0(a4)
    80008aa0:	0067871b          	addiw	a4,a5,6
    80008aa4:	06c77e63          	bgeu	a4,a2,80008b20 <__memset+0x1c8>
    80008aa8:	00e50733          	add	a4,a0,a4
    80008aac:	00b70023          	sb	a1,0(a4)
    80008ab0:	0077871b          	addiw	a4,a5,7
    80008ab4:	06c77663          	bgeu	a4,a2,80008b20 <__memset+0x1c8>
    80008ab8:	00e50733          	add	a4,a0,a4
    80008abc:	00b70023          	sb	a1,0(a4)
    80008ac0:	0087871b          	addiw	a4,a5,8
    80008ac4:	04c77e63          	bgeu	a4,a2,80008b20 <__memset+0x1c8>
    80008ac8:	00e50733          	add	a4,a0,a4
    80008acc:	00b70023          	sb	a1,0(a4)
    80008ad0:	0097871b          	addiw	a4,a5,9
    80008ad4:	04c77663          	bgeu	a4,a2,80008b20 <__memset+0x1c8>
    80008ad8:	00e50733          	add	a4,a0,a4
    80008adc:	00b70023          	sb	a1,0(a4)
    80008ae0:	00a7871b          	addiw	a4,a5,10
    80008ae4:	02c77e63          	bgeu	a4,a2,80008b20 <__memset+0x1c8>
    80008ae8:	00e50733          	add	a4,a0,a4
    80008aec:	00b70023          	sb	a1,0(a4)
    80008af0:	00b7871b          	addiw	a4,a5,11
    80008af4:	02c77663          	bgeu	a4,a2,80008b20 <__memset+0x1c8>
    80008af8:	00e50733          	add	a4,a0,a4
    80008afc:	00b70023          	sb	a1,0(a4)
    80008b00:	00c7871b          	addiw	a4,a5,12
    80008b04:	00c77e63          	bgeu	a4,a2,80008b20 <__memset+0x1c8>
    80008b08:	00e50733          	add	a4,a0,a4
    80008b0c:	00b70023          	sb	a1,0(a4)
    80008b10:	00d7879b          	addiw	a5,a5,13
    80008b14:	00c7f663          	bgeu	a5,a2,80008b20 <__memset+0x1c8>
    80008b18:	00f507b3          	add	a5,a0,a5
    80008b1c:	00b78023          	sb	a1,0(a5)
    80008b20:	00813403          	ld	s0,8(sp)
    80008b24:	01010113          	addi	sp,sp,16
    80008b28:	00008067          	ret
    80008b2c:	00b00693          	li	a3,11
    80008b30:	e55ff06f          	j	80008984 <__memset+0x2c>
    80008b34:	00300e93          	li	t4,3
    80008b38:	ea5ff06f          	j	800089dc <__memset+0x84>
    80008b3c:	00100e93          	li	t4,1
    80008b40:	e9dff06f          	j	800089dc <__memset+0x84>
    80008b44:	00000e93          	li	t4,0
    80008b48:	e95ff06f          	j	800089dc <__memset+0x84>
    80008b4c:	00000793          	li	a5,0
    80008b50:	ef9ff06f          	j	80008a48 <__memset+0xf0>
    80008b54:	00200e93          	li	t4,2
    80008b58:	e85ff06f          	j	800089dc <__memset+0x84>
    80008b5c:	00400e93          	li	t4,4
    80008b60:	e7dff06f          	j	800089dc <__memset+0x84>
    80008b64:	00500e93          	li	t4,5
    80008b68:	e75ff06f          	j	800089dc <__memset+0x84>
    80008b6c:	00600e93          	li	t4,6
    80008b70:	e6dff06f          	j	800089dc <__memset+0x84>

0000000080008b74 <__memmove>:
    80008b74:	ff010113          	addi	sp,sp,-16
    80008b78:	00813423          	sd	s0,8(sp)
    80008b7c:	01010413          	addi	s0,sp,16
    80008b80:	0e060863          	beqz	a2,80008c70 <__memmove+0xfc>
    80008b84:	fff6069b          	addiw	a3,a2,-1
    80008b88:	0006881b          	sext.w	a6,a3
    80008b8c:	0ea5e863          	bltu	a1,a0,80008c7c <__memmove+0x108>
    80008b90:	00758713          	addi	a4,a1,7
    80008b94:	00a5e7b3          	or	a5,a1,a0
    80008b98:	40a70733          	sub	a4,a4,a0
    80008b9c:	0077f793          	andi	a5,a5,7
    80008ba0:	00f73713          	sltiu	a4,a4,15
    80008ba4:	00174713          	xori	a4,a4,1
    80008ba8:	0017b793          	seqz	a5,a5
    80008bac:	00e7f7b3          	and	a5,a5,a4
    80008bb0:	10078863          	beqz	a5,80008cc0 <__memmove+0x14c>
    80008bb4:	00900793          	li	a5,9
    80008bb8:	1107f463          	bgeu	a5,a6,80008cc0 <__memmove+0x14c>
    80008bbc:	0036581b          	srliw	a6,a2,0x3
    80008bc0:	fff8081b          	addiw	a6,a6,-1
    80008bc4:	02081813          	slli	a6,a6,0x20
    80008bc8:	01d85893          	srli	a7,a6,0x1d
    80008bcc:	00858813          	addi	a6,a1,8
    80008bd0:	00058793          	mv	a5,a1
    80008bd4:	00050713          	mv	a4,a0
    80008bd8:	01088833          	add	a6,a7,a6
    80008bdc:	0007b883          	ld	a7,0(a5)
    80008be0:	00878793          	addi	a5,a5,8
    80008be4:	00870713          	addi	a4,a4,8
    80008be8:	ff173c23          	sd	a7,-8(a4)
    80008bec:	ff0798e3          	bne	a5,a6,80008bdc <__memmove+0x68>
    80008bf0:	ff867713          	andi	a4,a2,-8
    80008bf4:	02071793          	slli	a5,a4,0x20
    80008bf8:	0207d793          	srli	a5,a5,0x20
    80008bfc:	00f585b3          	add	a1,a1,a5
    80008c00:	40e686bb          	subw	a3,a3,a4
    80008c04:	00f507b3          	add	a5,a0,a5
    80008c08:	06e60463          	beq	a2,a4,80008c70 <__memmove+0xfc>
    80008c0c:	0005c703          	lbu	a4,0(a1)
    80008c10:	00e78023          	sb	a4,0(a5)
    80008c14:	04068e63          	beqz	a3,80008c70 <__memmove+0xfc>
    80008c18:	0015c603          	lbu	a2,1(a1)
    80008c1c:	00100713          	li	a4,1
    80008c20:	00c780a3          	sb	a2,1(a5)
    80008c24:	04e68663          	beq	a3,a4,80008c70 <__memmove+0xfc>
    80008c28:	0025c603          	lbu	a2,2(a1)
    80008c2c:	00200713          	li	a4,2
    80008c30:	00c78123          	sb	a2,2(a5)
    80008c34:	02e68e63          	beq	a3,a4,80008c70 <__memmove+0xfc>
    80008c38:	0035c603          	lbu	a2,3(a1)
    80008c3c:	00300713          	li	a4,3
    80008c40:	00c781a3          	sb	a2,3(a5)
    80008c44:	02e68663          	beq	a3,a4,80008c70 <__memmove+0xfc>
    80008c48:	0045c603          	lbu	a2,4(a1)
    80008c4c:	00400713          	li	a4,4
    80008c50:	00c78223          	sb	a2,4(a5)
    80008c54:	00e68e63          	beq	a3,a4,80008c70 <__memmove+0xfc>
    80008c58:	0055c603          	lbu	a2,5(a1)
    80008c5c:	00500713          	li	a4,5
    80008c60:	00c782a3          	sb	a2,5(a5)
    80008c64:	00e68663          	beq	a3,a4,80008c70 <__memmove+0xfc>
    80008c68:	0065c703          	lbu	a4,6(a1)
    80008c6c:	00e78323          	sb	a4,6(a5)
    80008c70:	00813403          	ld	s0,8(sp)
    80008c74:	01010113          	addi	sp,sp,16
    80008c78:	00008067          	ret
    80008c7c:	02061713          	slli	a4,a2,0x20
    80008c80:	02075713          	srli	a4,a4,0x20
    80008c84:	00e587b3          	add	a5,a1,a4
    80008c88:	f0f574e3          	bgeu	a0,a5,80008b90 <__memmove+0x1c>
    80008c8c:	02069613          	slli	a2,a3,0x20
    80008c90:	02065613          	srli	a2,a2,0x20
    80008c94:	fff64613          	not	a2,a2
    80008c98:	00e50733          	add	a4,a0,a4
    80008c9c:	00c78633          	add	a2,a5,a2
    80008ca0:	fff7c683          	lbu	a3,-1(a5)
    80008ca4:	fff78793          	addi	a5,a5,-1
    80008ca8:	fff70713          	addi	a4,a4,-1
    80008cac:	00d70023          	sb	a3,0(a4)
    80008cb0:	fec798e3          	bne	a5,a2,80008ca0 <__memmove+0x12c>
    80008cb4:	00813403          	ld	s0,8(sp)
    80008cb8:	01010113          	addi	sp,sp,16
    80008cbc:	00008067          	ret
    80008cc0:	02069713          	slli	a4,a3,0x20
    80008cc4:	02075713          	srli	a4,a4,0x20
    80008cc8:	00170713          	addi	a4,a4,1
    80008ccc:	00e50733          	add	a4,a0,a4
    80008cd0:	00050793          	mv	a5,a0
    80008cd4:	0005c683          	lbu	a3,0(a1)
    80008cd8:	00178793          	addi	a5,a5,1
    80008cdc:	00158593          	addi	a1,a1,1
    80008ce0:	fed78fa3          	sb	a3,-1(a5)
    80008ce4:	fee798e3          	bne	a5,a4,80008cd4 <__memmove+0x160>
    80008ce8:	f89ff06f          	j	80008c70 <__memmove+0xfc>

0000000080008cec <__putc>:
    80008cec:	fe010113          	addi	sp,sp,-32
    80008cf0:	00813823          	sd	s0,16(sp)
    80008cf4:	00113c23          	sd	ra,24(sp)
    80008cf8:	02010413          	addi	s0,sp,32
    80008cfc:	00050793          	mv	a5,a0
    80008d00:	fef40593          	addi	a1,s0,-17
    80008d04:	00100613          	li	a2,1
    80008d08:	00000513          	li	a0,0
    80008d0c:	fef407a3          	sb	a5,-17(s0)
    80008d10:	fffff097          	auipc	ra,0xfffff
    80008d14:	b3c080e7          	jalr	-1220(ra) # 8000784c <console_write>
    80008d18:	01813083          	ld	ra,24(sp)
    80008d1c:	01013403          	ld	s0,16(sp)
    80008d20:	02010113          	addi	sp,sp,32
    80008d24:	00008067          	ret

0000000080008d28 <__getc>:
    80008d28:	fe010113          	addi	sp,sp,-32
    80008d2c:	00813823          	sd	s0,16(sp)
    80008d30:	00113c23          	sd	ra,24(sp)
    80008d34:	02010413          	addi	s0,sp,32
    80008d38:	fe840593          	addi	a1,s0,-24
    80008d3c:	00100613          	li	a2,1
    80008d40:	00000513          	li	a0,0
    80008d44:	fffff097          	auipc	ra,0xfffff
    80008d48:	ae8080e7          	jalr	-1304(ra) # 8000782c <console_read>
    80008d4c:	fe844503          	lbu	a0,-24(s0)
    80008d50:	01813083          	ld	ra,24(sp)
    80008d54:	01013403          	ld	s0,16(sp)
    80008d58:	02010113          	addi	sp,sp,32
    80008d5c:	00008067          	ret

0000000080008d60 <console_handler>:
    80008d60:	fe010113          	addi	sp,sp,-32
    80008d64:	00813823          	sd	s0,16(sp)
    80008d68:	00113c23          	sd	ra,24(sp)
    80008d6c:	00913423          	sd	s1,8(sp)
    80008d70:	02010413          	addi	s0,sp,32
    80008d74:	14202773          	csrr	a4,scause
    80008d78:	100027f3          	csrr	a5,sstatus
    80008d7c:	0027f793          	andi	a5,a5,2
    80008d80:	06079e63          	bnez	a5,80008dfc <console_handler+0x9c>
    80008d84:	00074c63          	bltz	a4,80008d9c <console_handler+0x3c>
    80008d88:	01813083          	ld	ra,24(sp)
    80008d8c:	01013403          	ld	s0,16(sp)
    80008d90:	00813483          	ld	s1,8(sp)
    80008d94:	02010113          	addi	sp,sp,32
    80008d98:	00008067          	ret
    80008d9c:	0ff77713          	andi	a4,a4,255
    80008da0:	00900793          	li	a5,9
    80008da4:	fef712e3          	bne	a4,a5,80008d88 <console_handler+0x28>
    80008da8:	ffffe097          	auipc	ra,0xffffe
    80008dac:	6dc080e7          	jalr	1756(ra) # 80007484 <plic_claim>
    80008db0:	00a00793          	li	a5,10
    80008db4:	00050493          	mv	s1,a0
    80008db8:	02f50c63          	beq	a0,a5,80008df0 <console_handler+0x90>
    80008dbc:	fc0506e3          	beqz	a0,80008d88 <console_handler+0x28>
    80008dc0:	00050593          	mv	a1,a0
    80008dc4:	00000517          	auipc	a0,0x0
    80008dc8:	7c450513          	addi	a0,a0,1988 # 80009588 <CONSOLE_STATUS+0x578>
    80008dcc:	fffff097          	auipc	ra,0xfffff
    80008dd0:	afc080e7          	jalr	-1284(ra) # 800078c8 <__printf>
    80008dd4:	01013403          	ld	s0,16(sp)
    80008dd8:	01813083          	ld	ra,24(sp)
    80008ddc:	00048513          	mv	a0,s1
    80008de0:	00813483          	ld	s1,8(sp)
    80008de4:	02010113          	addi	sp,sp,32
    80008de8:	ffffe317          	auipc	t1,0xffffe
    80008dec:	6d430067          	jr	1748(t1) # 800074bc <plic_complete>
    80008df0:	fffff097          	auipc	ra,0xfffff
    80008df4:	3e0080e7          	jalr	992(ra) # 800081d0 <uartintr>
    80008df8:	fddff06f          	j	80008dd4 <console_handler+0x74>
    80008dfc:	00001517          	auipc	a0,0x1
    80008e00:	88c50513          	addi	a0,a0,-1908 # 80009688 <digits+0x78>
    80008e04:	fffff097          	auipc	ra,0xfffff
    80008e08:	a68080e7          	jalr	-1432(ra) # 8000786c <panic>
	...
