#include "game.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

int main(int argc, char *argv[]) {
    /* Véletlen számokat fogunk használni, inicializáljuk a random generátort! */
    srand(time(NULL));

    if (argc <= 2) {
        fprintf(stderr, "Usage: %s <height> <width>\n", argv[0]);
        return 1;
    }

    puts("Udvozollek a kigyo jatekban");
    puts("A jatek celja a 10 alma (melyeket az \'a\' karakter jelol) begyujtese.");
    puts("A kigyo fejet a \'8\' karakter, a testet \'0\' jeloli. Mozgatashoz hasznald az alabbi karaktereket:");
    puts("- a: balra");
    puts("- s: le");
    puts("- d: jobbra");
    puts("- w: fel");
    puts("Egyszerre tobb lepest is megadhatsz, de csak az <ENTER> leutese utan hajtodnak vegre.");
    puts("Vigyazz! Ha a kigyo onmagaba vagy a falba (\'#\') utkozik, a jatek veget er.");


    int height = atoi(argv[1]);
    int width = atoi(argv[2]);

    /* 
     * Ezt csak azért tettem ide, mert az init_snake() függvényem az első sorba
     * próbálja az egész kígyót lehelyezni. Lehetne más megoldás is (pl. csigavonal
     * rajzolása vagy a kígyó rövidítése) túl keskeny pálya esetéén, ZH-n le lesz írva,
     * mit kell tenni, ha ilyen lesz.
     */
    if (width < 9) {
        fprintf(stderr, "Width must be at least 9\n");
        return 1;
    }

    State state = init_game(height, width);
    print_game(&state);

    /* 
     * Egyesével megyünk végig a beolvasott karaktereken, de attól még csak enter
     * lenyomására olvasódik be.
     */
    int command;
    int apples_remaining = APPLE_COUNT;
    while ((command = getchar()) != EOF) {
        if (command != 'w' && command != 'a' && command != 's' && command != 'd') continue;

        UpdateResult res = update_snake(&state, command);
        if (res < 0) {
            /* A "hiba" állapotok negatív értéket kaptak */
            printf("Utkoztel %s. A jatek leall.", (res == UPDATE_COLLIDED_WITH_SELF) ? "onmagaddal" : "a fallal");
            break; /* return 0 nem jó itt, mert a free_game() ekkor nem hívódna meg */
        }

        print_game(&state);
        if (res == UPDATE_COLLECTED_APPLE) {
            apples_remaining--;
            if (apples_remaining == 0) {
                puts("Gratulalok, osszes almát begyujtotted!");
                break;
            }
        }
    }

    free_game(&state);

    return 0;
}
