#ifndef PEOPLE_H
#define PEOPLE_H

#include <stdio.h>

typedef struct {
    char name[50];
    int age;
} Person;

void init(FILE *fp, Person **people, int *count);

#endif
