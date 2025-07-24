#include <stdlib.h> /* for malloc, calloc, realloc, free */
#include <stdio.h>

int main() {
    /*
     * role of dynamic allocation:
     * - number of elements only known at runtime
     * - flexible management of lifetime
     */

    /*
     * VLA - let's not use this (not in C++, stack overflow)
    int n = some_runtime_function();
    int vla[n];
     */

    /*
     * void *malloc(size_t size)
     *
     * C: void* -> T* cast allowed; but not in C++
     * malloc(0) - don't do that
     */
    int *ip = malloc(2 * sizeof(int));

    /* malloc() is specified to return NULL if out of memory */
    if (ip == NULL) {
        /*
         * Modern operating systems: virtual memory, paging.
         * RAM is only allocated when it's first read/written to
         *
         * https://arxiv.org/pdf/2208.08484
         */
        fputs("Out of memory", stderr);
        return 1;
    }

    /* why use sizeof? */

    /* 
     * memory is returned uninitialized from malloc
     * (if you try it; it might be zeroed if no previous
     *  allocation was present at that address)
     */
    ip[0] = 1;
    ip[1] = 2;

    /* magic: ensure that ip's block cannot grow */
    void *other = malloc(100);

    /*
     * void *realloc(void*, size_t)
     *
     * pointer must be from malloc()/calloc()
     *
     * Ability to grow existing allocation:
     * - extends allocation size if possible
     * - allocates, copies and frees otherwise
     *   - accessing the old pointer is invalid
     *
     * Shrinking - implementation defined
     */
    int *old_ip = ip;
    ip = realloc(ip, 10000 * sizeof(int));

    /* Don't use the previous pointer, it might have been freed */

    if (ip == NULL) {
        fputs("Out of memory", stderr);
    }

    printf("ip = %p\told_ip = %p\n", ip, old_ip);

    {
        /* This might get back the previous allocation */
        int *prev = malloc(2 * sizeof(int));
        printf("prev = %p\n", prev);
        free(prev);
    }

    /*
     * void* calloc(size_t n, size_t m)
     *
     * Allocates n * m bytes; avoiding overflow
     * memory is guaranteed to be zeroed
     */

    /*
     * void free(void*)
     *
     * Always free memory when it becomes unreachable!
     * (there are no pointers to it - we "forget" it
     *  => *memory leak*)
     *
     * Pointer needs to be exactly the same as
     * returned by malloc().
     */

    free(ip);
    free(other);

    /*
     * After free(), pointers become dangling,
     * dereferencing them is UB.
     */

    return 0;
}
