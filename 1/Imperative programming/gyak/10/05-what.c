#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/* What's wrong here? */

int *max_element(int *p, int *q) {
    int *maxp = p;
    while (p != q) {
        if (*p > *maxp)
            maxp = p;
        ++p;
    }
    return maxp;
}

int main() {
    srand(time(NULL));

    int *ptr = malloc(10 * sizeof(int));

    for (int i = 0; i < 10; ++i)
        ptr[i] = rand();

    int *max = max_element(ptr, ptr + 10);
    free(ptr);
    printf("*max = %d\n", *max);

    return 0;
}