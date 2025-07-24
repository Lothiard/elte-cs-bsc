#include <stdio.h>

int main() {
    /* printf("%d\n", sizeof(int)); */
    int a = 10;
    long long b = 20;
    /*
    printf("sizeof(float) = %d\n", sizeof(float));
    printf("sizeof(double) = %d\n", sizeof(double));
    printf("sizeof(long double) = %d\n", sizeof(long double));
    */
    double d /* 8 */; int i /* 4 */;
    printf("%d\n", sizeof(d + i));
    return 0;
}