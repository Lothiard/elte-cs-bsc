#include <stdio.h>

const int MAX = 3;

int main() {
    int var[] = { 10, 100, 0xcafebabe };
    int i, *ptr;

    /* points to the first element */
    ptr = var;

    i = 0;
    while (ptr <= &var[MAX - 1]) {
        printf("Address of var[%d] = %p\n", i, ptr);
        printf("Value of var[%d] = %d\n", i, *ptr);

        ptr++;
        i++;
    }

    short *ptr2, *end2;
    ptr2 = (short*)var;
    end2 = (short*)(var + MAX - 1);

    printf("Difference of pointers: %d\n", end2 - ptr2);
    printf("ptr2: %p, end2: %p\n", ptr2, end2);

    i = 0;
    while (ptr2 <= end2) {
        printf("Address of var[%d] = %p\n", i, ptr2);
        printf("Value of var[%d] = %d\n", i, *ptr2);

        ptr2++;
        i++;
    }
}