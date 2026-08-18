//
// Created by os on 7/11/26.
//

#include "../h/MemoryAllocator.hpp"
#include "../lib/hw.h"

void* operator new(size_t size) {
    return MemoryAllocator::mem_alloc(size);
}

void* operator new[](size_t size) {
    return MemoryAllocator::mem_alloc(size);
}

void operator delete(void* ptr) noexcept {
    MemoryAllocator::mem_free(ptr);
}

void operator delete[](void* ptr) noexcept {
    MemoryAllocator::mem_free(ptr);
}

void operator delete(void* ptr, size_t) noexcept {
    MemoryAllocator::mem_free(ptr);
}

void operator delete[](void* ptr, size_t) noexcept {
    MemoryAllocator::mem_free(ptr);
}