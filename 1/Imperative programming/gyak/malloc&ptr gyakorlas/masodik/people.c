#include "people.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void init(FILE *fp, Person **people, int *count) {
    char buf[1024];

    while(fgets(buf, sizeof(buf), fp)) {
        *people = realloc(*people, ((*count) + 1) * sizeof(Person));

        char currName[50];
        int currAge;
        sscanf(buf, "%s %d", currName, &currAge);

        strcpy((*people)[*count].name, currName);
        (*people)[*count].age = currAge;

        ++(*count);
    }
}
