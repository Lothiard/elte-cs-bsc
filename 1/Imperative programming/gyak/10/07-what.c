#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
    int cnt = atoi(argv[1]); /* error checking, ... */

    double *p = malloc(cnt * sizeof(double));

    printf("%zu\n", sizeof(p));
    printf("%zu\n", sizeof(*p));
    printf("%zu\n", sizeof(&p));

    free(p);

    return 0;
}