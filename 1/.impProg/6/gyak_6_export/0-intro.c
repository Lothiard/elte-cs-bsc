#include <stdio.h>

int main() {
    int i = 123;

    printf("value: %d; address: %p\n", i, &i);

    int* j;
    /*
     * int *k, l; != int *k, *l;
     */

    j = &i;

    printf("value: %p, points to: %d\n", j, *j);

    /* dereferencing produces lvalues */
    *j = 5;
    printf("value: %p, points to: %d\n", j, *j);

    int arr[] = { 10, 11, 12, 13 };

    printf("arr: %p\n", arr);
    printf("*arr: %d\n", *arr);
    printf("arr[1] \t (arr+1)[0] \t *(arr+1) \t (arr+2)[-1]\n");
    printf("%d\t%d\t%d\t%d\n", arr[1], (arr+1)[0], *(arr+1), (arr+2)[-1]);

    return 0;
}
