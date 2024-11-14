#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

void elso();
void masodik();
void harmadik();
void negyedik();

int main(int argc, const char *argv[]) {
    if(argc == 1) {
        puts("Argument expected");
        return 1;
    }

    if(strcmp(argv[1], "1")) {
        elso();
    } else if (strcmp(argv[1], "2")) {
        masodik();
    } else if(strcmp(argv[1], "3")) {
        harmadik();
    } else if(strcmp(argv[1], "4")) {
        negyedik();
    }
    return 0;
}

void elso() {
    char buf[100];
    if(!fgets(buf, sizeof(buf), stdin)) {
        puts("Error reading input");
        exit(1);
    }

    int words = 0, chars = 0;

    while(buf[chars]) {
        if(buf[chars] == ' ') {
            ++words;
        }
        ++chars;    
    }

    printf("%d words, %d characters\n", words + 1, chars);
}

void masodik() {
    char buf1[100];
    if(!fgets(buf1, sizeof(buf1), stdin)) {
        puts("Error reading input");
        exit(1);
    }

    char buf2[100];
    if(!fgets(buf2, sizeof(buf2), stdin)) {
        puts("Error reading input");
        exit(1);
    }

    int res = strcmp(buf1, buf2);

    if(res < 0) {
        puts("First string is less than the second");
    } else if (!res) {
        puts("equal");
    } else {
        puts("Second string is less than the first");
    }
}

void harmadik() {
    char buf1[100];
    if(!fgets(buf1, sizeof(buf1), stdin)) {
        puts("Error reading input");
        exit(1);
    }

    char dst[100];
    strcpy(dst, buf1);
}

void negyedik() {
    FILE *fp = fopen("file.txt", "r");
    if(fp == NULL) {
        puts("can't open");
        exit(1);
    }

    char buf[1024];
    while(fgets(buf, sizeof(buf), fp) != NULL) {
        char *s = buf;
        while(*s != 0) {
            putc(toupper(*s), stdout);
            ++s;
        }
    }

    

    fclose(fp);
}
