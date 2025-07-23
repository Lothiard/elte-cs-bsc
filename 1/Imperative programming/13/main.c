#include "game.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {
    srand(time(NULL));

    if(argc <= 2) {
        fprintf(stderr, "Usage: %s <height> <width>\n", argv[0]);
        return 1;
    }

    int height = atoi(argv[1]);
    int width = atoi(argv[2]);

    if(width < 9) {
        fprintf(stderr, "Width must be at least 9\n");
        return 1;
    }

    State state = init_game(height, width);
    print_game(&state);

    char buf[20];
    int died = 0;
    while(!died && fgets(buf, sizeof(buf), stdin)) {
        size_t steps = stren(buf);

        for(int i = 0; i < steps; ++i) {
            // todo: check input
            if(buf[i] != 'w' && buf[i] != 's' && buf[i] != 'a' && buf[i] != 'd') {
                continue;
            }
            int res = update_snake(&state, buf[i]);
            print_game(&state);

            if(res < 0) {
                died = 1;
                break;
            }
        }
    }

    return 0;
}
