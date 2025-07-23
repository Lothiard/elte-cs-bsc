#include <stdlib.h>
#include <stdio.h>

/* pointer must be freed after use */
char *read_str() {
    char buf[21];
    char *ptr = fgets(buf, 21, stdin);

    if (ptr == NULL) {
        return ptr;
    }

    char *copy = malloc(strlen(buf) + 1);
    strcpy(copy, buf);
    return copy;
}

/* NOTE: here, the pointer must not be freed (global) */
char *dont_free_me() {
    static char x;
    return &x;
}

int main() {
    char *copy = read_str();
    free(copy);

    return 0;
}