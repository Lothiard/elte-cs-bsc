#include "uniq.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void counter(FILE *f, Words **words, int *size) {
    char buf[1024];
    while(fgets(buf, sizeof(buf), f)) {
        
        int found = 0;
        for(int i = 0; i < *size; ++i) {
            if(!strcmp((*words)[i].word, buf)) {
                ++((*words)[i].count);
                found = 1;
                break;
            }
        }

        if(!found) {
            *words = realloc(*words, (*size + 1) * sizeof(Words));
            strcpy((*words)[*size].word, buf);
            (*words)[*size].count = 1;
            ++(*size);
        }
    }
}