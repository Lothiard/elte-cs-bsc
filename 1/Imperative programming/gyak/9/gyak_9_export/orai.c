#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

void elso(void);
void masodik(void);
void harmadik(void);
void negyedik(void);
void otodik(void);

int main(int argc, char const *argv[]) {
    if (argc == 1)
    {
        printf("Argument expected\n");
        return 1;
    }
    
    /* argv[1] == "1" */
    if (strcmp(argv[1], "1") == 0) {
        elso();
    } else if (strcmp(argv[1], "2") == 0) {
        masodik();
    } else if (strcmp(argv[1], "3") == 0) {
        harmadik();
    } else if (strcmp(argv[1], "4") == 0) {
        negyedik();
    } else if (strcmp(argv[1], "5") == 0) {
        otodik();
    }

    return 0;
}

void elso() {
    char buf[100];
    if (!fgets(buf, sizeof(buf), stdin)) {
        printf("Error reading input\n");
        exit(1);
    }

    int words = 0;
    int idx = 0;
    while (buf[idx] != 0) {
        if (buf[idx] == ' ') ++words;
        ++idx;
    }

    printf("%d words, %d characters\n", words + 1, idx);
}

void masodik() {
    char buf1[100];
    if (!fgets(buf1, sizeof(buf1), stdin)) {
        printf("Error reading input\n");
        exit(1);
    }

    char buf2[100];
    if (!fgets(buf2, sizeof(buf2), stdin)) {
        printf("Error reading input\n");
        exit(1);
    }

    int res = strcmp(buf1, buf2);

    if (res < 0)
        puts("First string is less than the second");
    else if (res == 0)
        puts("equal");
    else
        puts("greater");
}

void harmadik() {
    char buf1[100];
    if (!fgets(buf1, sizeof(buf1), stdin)) {
        printf("Error reading input\n");
        exit(1);
    }

    char dst[100];
    strcpy(dst, buf1);
}

void negyedik() {
    FILE *fp = fopen("input.txt", "r");
    if (fp == NULL) {
        perror("open(input.txt)");
        exit(1);
    }

    char buf[1024];
    while (fgets(buf, sizeof(buf), fp) != NULL) {
        char *s = buf;
        while (*s != 0) {
           putc(toupper(*s), stdout);
           ++s;
        } 
    }

    /* !!! */
    fclose(fp);
}

void otodik() {
    FILE *fp = fopen("input.txt", "r");
    if (fp == NULL) {
        perror("open(input.txt)");
        exit(1);
    }

    FILE *dst = fopen("output.txt", "w");

    char buf[1024];
    while (fgets(buf, sizeof(buf), fp) != NULL) {
        char *s = buf;
        while (*s != 0) {
           putc(toupper(*s), dst);
           ++s;
        } 
    }

    /* !!! */
    fclose(fp);
    /* !!! !!! !!! */
    fclose(dst);
}