#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/* What's wrong here? */

int main() {
    srand(time(NULL));
    int *ptr = malloc(10 * sizeof(int));

    for (int i = 0; i < 10; ++i) {
        ptr[i] = rand();
    }

    /* Is there an even number in the array? */
    for (int i = 0; i < 10; ++i) {
        if (ptr[i] % 2 == 0) {
            puts("Found an even element");
            return 0;
        }
    }

    puts("No even element");
    free(ptr);
    return 0;
}