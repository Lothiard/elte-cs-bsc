#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *read_str() {
    char buf[21];
    fgets(buf, 21, stdin);

    char *copy = malloc(strlen(buf) + 1);
    strcpy(copy, buf);

    return copy;
}

char *read_word() {
    char buf[100];
    if(fgets(buf, 100, stdin) == NULL) {
        return NULL;
    }

    char *word = malloc(strlen(buf) + 1);

    strcpy(word, buf);
    return word;
}

// call
char *reverse(char *str) {
    int n = strlen(str);
    int i = 0;
    int j = n - 1;

    while (i < j) {
        char tmp = str[i];
        str[i] = str[j];
        str[j] = tmp;
        ++i;
        --j;
    }

    return str;
}

int main() {
    // 1
    char *copy = read_str();
    printf("%s", copy);
    free(copy);

    // 2
    char *words[5];

    printf("irj 5 szot:\n");
    for (int i = 0; i < 5; i++) {
        words[i] = read_word();
        if (words[i] == NULL) {
            fprintf(stderr, "anyad\n");
            exit(1);
        }
    }

    printf("forditva:\n");
    for (int i = 4; i >= 0; i--) {
        printf("%s", words[i]);
        free(words[i]);
    }

    return 0;
}
