#include <inttypes.h>
#include <stdio.h>

int main() {
    int arr[] = { 0, 1, 2, 3 };

    int *p = (arr + 0), *q = (arr + 3);

    printf("p: %p, q: %p\n", p, q);
    printf("q - p: %zu\n", q - p);

    /* uintptr_t => 64-bit unsigned integer
                    that addresses fit in */

    printf("(uintptr_t)p: 0x%zx, (uintptr_t)q: 0x%zx\n",
        (uintptr_t)p, (uintptr_t)q);
    printf("(uintptr_t)q - (uintptr_t)p: %zu\n",
        (uintptr_t)q - (uintptr_t)p);

    printf("hint: sizeof(int)=%zu", sizeof(int));

    return 0;
}