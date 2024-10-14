#include <stdio.h>

int main() {
    int a[] = { 1, 3, 3, 7 };
    int b[] = { 9, 8, 7, 6 };

    // TODO
    int s = 0;
    int size = sizeof(a) / sizeof(a[0]);

    for(int i = 0; i < size; ++i) {
        s += a[i] * b[i];
    }

    // printf("%d", s);

    for(int i = 0; i < size; ++i) {
        b[i] *= s;
        // printf("%d ", b[i]);
    }


    return 0;
}