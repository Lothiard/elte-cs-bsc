#include <stdio.h>

int is_prime(int num) {
    for (int i = 2; i != num; ++i)
        if ((num % i) == 0)
            return 0;
    return 1;
}

int main() {
    int num;
    scanf("%d", &num);

    if (is_prime(num))
        printf("%d prim\n", num);
    else
        printf("nem prim\n");
    return 0;
}