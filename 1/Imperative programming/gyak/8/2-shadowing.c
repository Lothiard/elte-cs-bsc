#include <stdio.h>

int main() {
    int i = 1;
    int j = 2;

    printf("i = %d\tj=%d\n", i, j);

    {
        /* new scope for variable definitions */

        i = 11;     /* modifies 'i' from the outer scope */
        int j = 12; /* defines new variable 'j', shadows outer */

        /* Q: Which variable do these modify? */
        ++i;
        ++j;

        printf("i = %d\tj=%d\n", i, j);
    }

    /* back to the outer scope */
    printf("i = %d\tj=%d\n", i, j);

    /* error: redefinition of 'i'
     * this is in the same scope as the "outer" 'i'; shadowing not possible
     */
    int i = 22;

    return 0;
}
