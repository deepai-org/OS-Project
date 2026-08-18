#include "../lib/hw.h"
extern const size_t MEM_BLOCK_SIZE;
extern const void* HEAP_START_ADDR;
extern const void* HEAP_END_ADDR;

class MemoryAllocator {
public:
    static void initialize();
    static void* mem_alloc(size_t size);
    static int mem_free(void* addr);

private:
    MemoryAllocator() = delete;
    struct FreeMem {
        FreeMem* next;
        size_t size; // broj blokova u fragmentu
    };

    static FreeMem* freeMemHead;
};