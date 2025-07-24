#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int height, width;
    int **matrix;
} Map;

typedef struct {
    char name[50];
    int year;
    float rating;
    Map map;
} Movie;

int main(int argc, char *argv[]) {
    if(argc < 2) {
        fprintf(stderr, "Usage: %s <filename>", argv[0]);
        return 1;
    }

    FILE *fp = fopen(argv[1], "r");
    if(!fp) return 1;

    int movieAmount;
    fscanf(fp, "%d", &movieAmount);
    
    Movie *movies = malloc(movieAmount * sizeof(Movie));
    for(int i = 0; i < movieAmount; ++i) {
        fscanf(fp, "%49s %d %f", movies[i].name,
                               &movies[i].year,
                               &movies[i].rating);
        fscanf(fp, "%d %d", &movies[i].map.height,
                            &movies[i].map.width);

        movies[i].map.matrix = malloc(movies[i].map.height * sizeof(int*));
        for(int j = 0; j < movies[i].map.height; ++j) {
            movies[i].map.matrix[j] = malloc(movies[i].map.width * sizeof(int));
            for(int k = 0; k < movies[i].map.width; ++k) {
                fscanf(fp, "%d", &movies[i].map.matrix[j][k]);
            }
        }
    }

    for(int i = 0; i < movieAmount; ++i) {
        printf("%s %d %.1f\n", movies[i].name, movies[i].year, movies[i].rating);
        for(int j = 0; j < movies[i].map.height; ++j) {
            for(int k = 0; k < movies[i].map.width; ++k) {
                printf("%d ", movies[i].map.matrix[j][k]);
            }
            printf("\n");
        }
    }

    for(int i = 0; i < movieAmount; ++i) {
        for(int j = 0; j < movies[i].map.height; ++j) {
            free(movies[i].map.matrix[j]);
        }
        free(movies[i].map.matrix);
    }
    free(movies);

    fclose(fp);
}
