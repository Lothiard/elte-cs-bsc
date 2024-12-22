// harmadik: elore megadott nagysagu dinamikus matrix szamokkal
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if(argc < 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *fp = fopen(argv[1], "r");
    if(!fp) return 1;

    int height, width;
    fscanf(fp, "%d %d", &height, &width);
    // printf("%d %d", height, width);

    int **matrix = malloc(height * sizeof(int*));
    for(int i = 0; i < height; ++i) {
        matrix[i] = malloc(width * sizeof(int));
        for(int j = 0; j < width; ++j) {
            fscanf(fp, "%d", &matrix[i][j]);
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }

    fclose(fp);

    for(int i = 0; i < height; ++i) {
        free(matrix[i]);
    }
    free(matrix);
}