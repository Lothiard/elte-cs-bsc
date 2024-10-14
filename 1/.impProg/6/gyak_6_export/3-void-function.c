#include <stdio.h>

/* procedure vs function */
void print_num(int n) {
    printf("%d\n", n);
    /* no need for return; */
}

void print_num2(int n) {
    /* early return still works (no value!) */
    if (n == 0)
        return;

    printf("%d\n", n);
}

int main() {
    print_num(42);
    print_num2(0);
    print_num2(42);

    return 0;
}
