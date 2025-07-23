#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Ne mar!");
        return 1;
    }

    FILE *fp = fopen(argv[1], "r");

    if (fp == NULL) {
        return 1;
    }

    int cnt = 0;

    char buf[1024];
    while (fgets(buf, sizeof(buf), fp) != NULL) {
        /*
        buf[strlen(buf) - 1] = '\0';
        if (strcmp(buf, "alma") == 0) {
            ++cnt;
        }
        */

        if (strcmp(buf, "alma\n") == 0) {
            ++cnt;
        }
    }

    printf("alma db: %d\n", cnt);

    fclose(fp);
    return 0;
}
