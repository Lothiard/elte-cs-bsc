#include <stdio.h>
#include <stdlib.h>

int main() {
    int *ptr = malloc(sizeof(int));
    *ptr = 42;

    /* pointer aliasing */
    int *ptr2 = ptr;

    free(ptr2);

    printf("*ptr = %d\n", *ptr);

    /* Special case: double free */
    free(ptr);

    return 0;
}
