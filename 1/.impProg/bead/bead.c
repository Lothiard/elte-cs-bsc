#include <stdio.h>
#include <stdlib.h>

#define RESET       "\033[0m"
#define BG_BLACK    "\033[40m"
#define BG_RED      "\033[41m"
#define BG_GREEN    "\033[42m"
#define BG_YELLOW   "\033[43m"
#define BG_BLUE     "\033[44m"
#define BG_MAGENTA  "\033[45m"
#define BG_CYAN     "\033[46m"
#define BG_WHITE    "\033[47m"

#define MAX_WIDTH 30
#define MAX_HEIGHT 30

typedef enum color {
    black,
    red,
    green,
    yellow,
    blue,
    magenta,
    cyan,
    white
} Color;

typedef struct image {
    int width, height;
    Color **pixels;
} Image;

void color_print(int szin) {
    switch(szin) {
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

void image_print() {
    FILE *f = fopen("input.txt", "r");

    Image img;
    fscanf(f, "%d %d", &img.width, &img.height); // printf("width: %d, height: %d\n", img.width, img.height);
    if(img.width > MAX_WIDTH || img.height > MAX_HEIGHT || img.width < 1 || img.height < 1) {
        printf("invalid kepmeret\n");
        return;
    }
    
    img.pixels = malloc(img.height * sizeof(Color *));
    for (int i = 0; i < img.height; ++i) {
        img.pixels[i] = malloc(img.width * sizeof(Color));
        for (int j = 0; j < img.width; ++j) {
            int color;
            fscanf(f, "%d", &color);
            img.pixels[i][j] = color;
            color_print(img.pixels[i][j]);
        }
        printf("\n");
    }

    free(img.pixels);
    fclose(f);
}

int main() {
    image_print();
    
    return 0;
}
