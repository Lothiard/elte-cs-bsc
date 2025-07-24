#include <stdio.h>

/* Prefix és postfix növelés */

int main() {
    int i = 42;
    int j;

    j = (i++ + 10);
    printf("i = %d\nj = %d\n", i, j);

    j = (++i + 10);
    printf("i = %d\nj = %d\n", i, j);

    return 0;
}