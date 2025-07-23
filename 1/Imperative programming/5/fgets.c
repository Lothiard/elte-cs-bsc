#include <stdio.h>

int main() {
    char name[5];
    char *s = fgets(name, 5, stdin);
    printf("%s", s);

    return 0;
}
