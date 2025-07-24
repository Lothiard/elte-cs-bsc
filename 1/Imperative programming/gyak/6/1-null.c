#include <stdio.h>

int main() {
    /* guaranteed to not point to a valid object */
    int* ptr = NULL; /* always initialize pointers! */

    if (!ptr) {
        printf("The value of ptr is : %p\n", ptr);
        /* printf("The value of *ptr is : %d\n", *ptr); */
    }

    int c = 123;
    ptr = &c;

    if (ptr) {
        printf("The value of ptr is : %p\n", ptr);
        printf("The value of *ptr is : %d\n", *ptr);
    }

    return 0;
}