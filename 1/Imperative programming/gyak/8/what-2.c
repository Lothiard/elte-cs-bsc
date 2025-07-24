#include <stdio.h>

void foo(int*);

int main() {
    int i = 42;
    int *pi = &i;

    {
        int i = 1337;
        printf("*pi = %d\n", *pi); /* *pi = ? */
    }

    return 0;
}
