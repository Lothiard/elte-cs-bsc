#include <stdio.h>
#include <stdlib.h>

#ifndef BEAD_H
#define BEAD_H

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

#define TERMINAL_CLEAR "\033[2J"
#define TERMINAL_HOME "\033[2H"

typedef enum {
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

typedef struct gif {
    Image *images[10];
} Gif;

void color_print(Color color);
void image_print(Image *img, FILE *f);
void gif_print(Gif *gif);

#endif
