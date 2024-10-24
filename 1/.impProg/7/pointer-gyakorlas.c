#include <stdio.h>

// 1
void swap(int *a, int *b) {
    
}

// 2
int array[5] = {1, 3, 5, 7, 9};

int sumArr(int *arr, int *end) {
    int sum = 0;
    for(int i = 0; i < *end; ++i) {
        sum += *(arr + i);
    }

    return sum;
}

int main() {
    // 1
    int a = 5; int b = 10;
    swap(&a, &b);

    // 2
    int end = 5;
    printf("Sum: %d\n", sumArr(array, &end));

    return 0;
}
