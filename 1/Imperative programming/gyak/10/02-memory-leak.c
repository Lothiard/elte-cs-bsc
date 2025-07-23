#include <stdio.h>
#include <stdlib.h>

int main() {
    int *ptr = malloc(4 * sizeof(int));

    printf("%p\n", ptr);
    ptr = malloc(4 * sizeof(int));
    printf("%p\n", ptr);

    free(ptr);

    /*
     * Why does this leak?
     * run under Valgrind to check!
     */
    return 0;
}