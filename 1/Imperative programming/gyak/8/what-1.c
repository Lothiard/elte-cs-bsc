#include <stdio.h>

int main() {
    int i = 42;
    int *pi = &i;

    {
        i = 1337;
        printf("*pi = %d\n", *pi); /* *pi = ? */
    }

    return 0;
}
