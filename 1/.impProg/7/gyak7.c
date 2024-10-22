#include <stdio.h>

// 6. gyakrol
int a[5] = {1, 2, 3, 4, 5};

double avg(int *begin, int *end) {
    int n = end - begin;

    double sum = 0;
    while(begin < end) {
        sum += *begin;
        ++begin;
    }

    return sum / n;
}

int *max_element(int *begin, int *end) {
    int *maxp = begin;

    while (begin < end) {
        if(*begin > *maxp) {
            maxp = begin;
        }
        ++begin;
    }

    return maxp;
}

// 7
int convert()

int main() {
    printf("%f\n", avg(&a[0], &a[5]));


    return 0;
}
