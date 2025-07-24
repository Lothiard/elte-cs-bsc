#include "strings.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void init(FILE *f, char ***arr, int *count) {
    char buf[1024];

    while(fgets(buf, sizeof(buf), f)) {
        *arr = realloc(*arr, ((*count) + 1) * sizeof(char*));
        (*arr)[*count] = malloc(strlen(buf));
        strcpy((*arr)[*count], buf);
        ++(*count);
    }
}
