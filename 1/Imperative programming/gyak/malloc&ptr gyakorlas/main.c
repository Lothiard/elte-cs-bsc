#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if(argc < 2) {
        fprintf(stderr, "anyadat");
        return 1;
    }

    FILE *fp = fopen(argv[1], "r");
    if(!fp) {
        fprintf(stderr, "anyadat");
        return 1;
    }

    int *arr = NULL;
    int temp;
    int count = 0;

    while(fscanf(fp, "%d", &temp) == 1) {
        arr = realloc(arr, sizeof(int) * (count + 1));
        arr[count] = temp;
        printf("%d\n", arr[count]);
        ++count;
    }

    free(arr);
    fclose(fp);
    return 0;
}
