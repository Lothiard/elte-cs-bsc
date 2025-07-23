#include <stdio.h>

/*
 * 'i' and 'j' from main's body are not visible to 'foo'
void foo() {
    printf("i = %d\tj=%d\n", i, j);
}
*/

int main() {
    int i = 1;
    int j = 2;

    printf("i = %d\tj=%d\n", i, j);

    {
        /* new scope for variable definitions */

        i = 11;     /* modifies 'i' from the outer scope */
        int j = 12; /* defines new variable 'j', shadows outer */

        printf("i = %d\tj=%d\n", i, j);
    }

    /* back to the outer scope */
    printf("i = %d\tj=%d\n", i, j);

    return 0;
}
