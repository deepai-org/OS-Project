//
// Created by os on 7/10/26.
//
#include "../h/MemoryAllocator.hpp"
#include "../lib/hw.h"

// radimo sa zaglavljem jer moramo da znamo koliko nam je segment veliki

MemoryAllocator::FreeMem* MemoryAllocator::freeMemHead = nullptr;

void MemoryAllocator::initialize() {
    freeMemHead = (FreeMem*) HEAP_START_ADDR;
    freeMemHead->next = nullptr;
    freeMemHead->size = ((char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR)/MEM_BLOCK_SIZE;
    // prva zagrada je broj bajtova u heap-u, deljenjem sa velicinom dobija se broj blokova
}

void* MemoryAllocator::mem_alloc(size_t size) {
    if (size == 0 || freeMemHead == nullptr) {
        return nullptr;
    }

    const size_t blocks = (size + MEM_BLOCK_SIZE - 1) / MEM_BLOCK_SIZE;
    const size_t requiredBlocks = blocks + 1;
    FreeMem* prev = nullptr;

    for (FreeMem* curr = freeMemHead; curr != nullptr; prev = curr, curr = curr->next) {
        if (curr->size < requiredBlocks) continue;
        FreeMem* allocated = curr;
        if (curr->size == requiredBlocks) {
            if (prev != nullptr) {
                prev->next = curr->next;
            } else {
                freeMemHead = curr->next;
            }
        } else {
            FreeMem* newFragment = (FreeMem*)(
                        (char*)(curr) + requiredBlocks * MEM_BLOCK_SIZE
                    );

            newFragment->size = curr->size - requiredBlocks;
            newFragment->next = curr->next;

            if (prev) {
                prev->next = newFragment;
            } else {
                freeMemHead = newFragment;
            }
        }
        allocated->size = requiredBlocks;
        allocated->next = nullptr;

        return (char*) (allocated) + MEM_BLOCK_SIZE;
    }
    return nullptr;
}

int MemoryAllocator::mem_free(void *addr) {
    if (addr == nullptr) return -1;
    // Zbog zaglavlja ovako dobijamo tacno jedan blok koji nam treba
    FreeMem* block = (FreeMem*) ((char*)addr - MEM_BLOCK_SIZE);

    FreeMem* prev = nullptr;
    FreeMem* curr = freeMemHead;
    while (curr != nullptr && (char*) curr < (char*) block) {
        prev = curr;
        curr = curr->next;
    }

    block->next = curr;
    if (prev) prev->next = block;
    else freeMemHead = block;

    //Spajanje bloka sa sledecim slobodnim segmentom
    if (block->next && (char*)block + block->size * MEM_BLOCK_SIZE
        == (char*) block->next
    ) {
        block->size += block->next->size;
        block->next = block->next->next;
    }

    //Spajanje sa prethodnim
    if (prev && (char*)prev + prev->size * MEM_BLOCK_SIZE == (char*)block) {
        prev->size += block->size;
        prev->next = block->next;
    }

    return 0;

}