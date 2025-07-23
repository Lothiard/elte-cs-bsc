#include <stdio.h>

int i; /* not UB - globals are initialized to 0 by default */

int j = 42; /* initializer can be literal/constant expression (but not fn call, etc.) */

void inc() {
    ++i;
    printf("(inc) i = %d\n", i);
}

/* Function local static - similar, but only accessible within the function */
void inc2() {
    static int val = 123; /* initialized only at program start */
    ++val;
    printf("val = %d\n", val);
}

int main() {
    printf("i = %d\n", i);
    inc();
    inc();
    printf("i = %d\n", i);

    inc2();
    inc2();
    /* 'val' not in scope */
    /* printf("val = %d\n", val); */

    return 0;
}