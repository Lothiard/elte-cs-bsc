#include <stdio.h>

/*
 * So far: functions were always defined _above_ main
 * reason: declarations must come before first use
 *         mutual recursion
 */

int is_even(int);
int is_odd(int);

/* return_type name(parameter_type [name], ...) */

int main() {
    printf("is_even(123) = %d\n", is_even(123));
    printf("is_even(42) = %d\n", is_even(42));

    return 0;
}

int is_odd(int n) {
    if (n == 0)
        return 0;

    return is_even(n - 1);
}

int is_even(int n) {
    if (n == 0)
        return 1;

    return is_odd(n - 1);
}
