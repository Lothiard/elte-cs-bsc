#include "uniq.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
    if(argc <= 1) {
        fprintf(stderr, "Usage: %s <file.txt>\n", argv[0]);
        return 0;
    }

    FILE *f = fopen(argv[1], "r");
    if(f == NULL) {
        printf("anyad");
        return 1;
    }

    Words *words = NULL;
    int size = 0;

    counter(f, &words, &size);

    fclose(f);

    for(int i = 0; i < size; ++i) {
        printf("%d %s", words[i].count, words[i].word);
    }
    printf("\n");

    free(words);

    return 0;
}
