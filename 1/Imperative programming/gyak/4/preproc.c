#include <stdio.h>

#define SQUARE(x) ((x) * (x))

int main() {
    int i = 9;
    (++i) / (++i);
    printf("%d\n", SQUARE(++i));
}