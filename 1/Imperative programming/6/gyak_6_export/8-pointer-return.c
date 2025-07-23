/*
 * This example contains UB: stack use-after-return
 *
 * This example segfaults with GCC 12, use
 * Clang 14 to see the desired strange behavior.
 */
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int* get_random() {
    int x;
    x = rand();
    return &x;
}

int main() {
    srand(time(NULL)); /* we now know what NULL is! */

    int *p, *q;
    p = get_random();
    printf("*p=%d\n", *p);

    q = get_random();
    printf("*p=%d\t*q=%d\n", *p, *q);

    return 0;
}