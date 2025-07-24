#include <stdio.h>
#include <stdlib.h> /* for exit() */

int main() {
    /* FILE - an opaque type, we only access sit through a pointer */
    FILE *fp;
    int x;

    /* 
     * FILE *fopen(char const *path, char const *mode)
     *
     * modes:
     *  - "r": read; fail if the file doesn't exist
     *  - "w": write; create file if it doesn't exist
     *  - "a": append; seek to end of file and write
     *  - "r+"/"w+"/"a+": read and write
     */
    fp = fopen("out.txt", "w+"); /* change this to r to see what happens */
    if (!fp) {
        perror("opening file failed");
        exit(0);
    }

    /* int fprinf(FILE *fp, char const *fmt, ...) */
    fprintf(fp, "%d\n", 42);

    /* int fputs(char const *str, FILE *fp) (and puts!) */
    fputs("alma", fp); /* adds newline! */

    /*
     * 42
     * alma
     * <- cursor
     */

    /* seek back in file to read tthe just printed number */
    /* int fseek(FILE *fp, long offset, int whence {SEEK_SET, SEEK_END, SEEK_CUR}) */
    fseek(fp, 0, SEEK_SET);

    /* fgets, of course */

    /* int fscanf(FILE *fp, char const *fmt, ...) */
    if (fscanf(fp, "%d", &x) == EOF) {
        if (feof(fp))
            puts("Reaced end of file");
        else if (ferror(fp))
            puts("Error while reading file");
    }
    printf("Read back number: %d\n", x);

    /* int fclose(FILE *fp) */
    fclose(fp);

    /* Afterwards FP will be a dangling pointer (the underlying FILE object is freed) */
}