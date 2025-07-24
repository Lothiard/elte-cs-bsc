#include <stdio.h>

int main() {
    int foo = 1;

    if (foo > 0) {
        int i = 2;
    } else {
        /* error: use of undeclared identifier 'i'
           'i' is only scoped to the taken branch */
        i = 3;
    }

    /* error: use of undeclared identifier i */
    printf("i = %d\n", i);
    return 0;
}
