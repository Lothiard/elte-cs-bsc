#include "bead.h"
#include <stdio.h>

int main() {
    Image img;
    FILE *f = fopen("input.txt", "r");
    if(f == NULL) {
        printf("nem sikerult megnyitni a fajlt\n");
        return 1;
    }
    
    image_print(&img, f);
    fclose(f);

    Gif gif;
    gif_print(&gif);

    return 0;
}
