#include <stdio.h>

/*
 * function prototype needed:
 * read_num() in main() is referenced before
 * the definition is seen by the compiler.
 */
void read_num(int* p);

int main() {
    int s;
    read_num(&s);

    printf("value of s: %d\n", s);

    return 0;
}

void read_num(int* p) {
    scanf("%d", p);
}
