#include <stdio.h>

int main() {
    int arr[2] = { 1, 2 };
    printf("%d %d\n", arr[0], arr[1]);

    /* printf("%d\n", arr[2]); */

    int arr2[] = { 1, 2, 3, 4 };
    printf("%d sz=%zu\n", arr[3], sizeof(arr2));

    int arr3[3] = { 1 };
    printf("%d %d %d\n", arr[0], arr[1], arr[2]);

    /* int arr4[1] = { 1, 2 }; */

    for (int i = 0; i < 4; ++i)
        printf("arr2[%d] = %d\n", i, arr2[i]);

    for (int i = 0; i < sizeof(arr)/sizeof(arr[0]); ++i)
        arr[i] *= 2;

    return 0;
}