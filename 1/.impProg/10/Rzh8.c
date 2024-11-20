#include <stdio.h>
#include <string.h>

int main(int argc, const char *argv[]) {
    if(argc < 2) {
        puts("argument expected");
        return 1;
    }


    FILE *fp = fopen(argv[1], "r");

    if(fp == NULL) {
        puts("nem jo");
        return 1;
    }

    char temp[1024];
    int almak = 0;

    while(fgets(temp, sizeof(temp), fp) != NULL) {
        temp[strlen(temp) - 1] = '\0';
        if(strcmp(temp, "alma\n") == 0) {
            ++almak;
        }
    }

    printf("%d\n", almak);

    fclose(fp);
    return 0;
}