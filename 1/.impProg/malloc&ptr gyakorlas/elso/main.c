// elso feladat: stringek beolvasasa filebol es tarolasa dinamikusan (1 sor = 1 string)
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if(argc < 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
    }

    FILE *f = fopen(argv[1], "r");
    if(!f) return 1;

    char **arr = NULL;
    char buf[1024];
    int count = 0;

    while(fgets(buf, sizeof(buf), f)) {
        arr = realloc(arr, (count + 1) * sizeof(char*));
        arr[count] = malloc(strlen(buf));
        strcpy(arr[count], buf);
        ++count;
    }

    fclose(f);

    for(int i = 0; i < count; ++i) {
        printf("%s", arr[i]);
        free(arr[i]);
    }
    printf("\n");
    free(arr);
}
