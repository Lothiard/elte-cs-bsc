#ifndef UNIQ_H
#define UNIQ_H

#include <stdio.h>

typedef struct {
    char word[1024];
    int count;
} Words;

void counter(FILE *f, Words **words, int *size);

#endif
