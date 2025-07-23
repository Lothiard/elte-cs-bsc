#include "bead.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdbool.h>

void color_print(Color color) {
    switch(color) {
        case 0:
            printf("%s %s", BG_BLACK, RESET);
            break;
        case 1:
            printf("%s %s", BG_RED, RESET);
            break;
        case 2:
            printf("%s %s", BG_GREEN, RESET);
            break;
        case 3:
            printf("%s %s", BG_YELLOW, RESET);
            break;
        case 4:
            printf("%s %s", BG_BLUE, RESET);
            break;
        case 5:
            printf("%s %s", BG_MAGENTA, RESET);
            break;
        case 6:
            printf("%s %s", BG_CYAN, RESET);
            break;
        case 7:
            printf("%s %s", BG_WHITE, RESET);
            break;
        default:
            printf("helytelen input (0 - 7)\n");
            break;
    }
}

void image_print(Image *img, FILE *f) {
    fscanf(f, "%d %d", &img->width, &img->height); // printf("width: %d, height: %d\n", img->width, img->height);
    if(img->width > MAX_WIDTH || img->height > MAX_HEIGHT || img->width < 1 || img->height < 1) {
        printf("invalid kepmeret\n");
        return;
    }
    
    img->pixels = malloc(img->height * sizeof(Color *));
    for (int i = 0; i < img->height; ++i) {
        img->pixels[i] = malloc(img->width * sizeof(Color));
        for (int j = 0; j < img->width; ++j) {
            int color;
            fscanf(f, "%d", &color);
            img->pixels[i][j] = color;
            color_print(img->pixels[i][j]);
        }
        printf("\n");
    }

    for (int i = 0; i < img->height; ++i) {
        free(img->pixels[i]);
    }

    free(img->pixels);
}

void gif_print(Gif *gif) {
    char input[100];
    printf("kerlek add meg a gif fajl nevet\n");
    scanf("%s", input);

    int index = strlen(input);
    while(true) { // mert satisfying
        for(int i = 0; i < 10; ++i) {
            gif->images[i] = malloc(sizeof(Image));

            input[index] = '.';
            input[index + 1] = 'b';
            input[index + 2] = 'g';
            input[index + 3] = '0' + i;
            input[index + 4] = '\0';

            FILE *f = fopen(input, "r");
            if(f == NULL) {
                printf("nem sikerult megnyitni a fajlt\n");
                return;
            }

            printf("%s%s", TERMINAL_CLEAR, TERMINAL_HOME);
            image_print(gif->images[i], f);
            usleep(250000);
            printf("%s%s", TERMINAL_CLEAR, TERMINAL_HOME);

            free(gif->images[i]);
        }
    }
}
