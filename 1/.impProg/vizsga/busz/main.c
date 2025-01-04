#include "busz.h"
#include <stdio.h>
#include <stdlib.h>

int main() {
    puts("Koszontelek a buszos programban!");
    City currentCity;
    initCity(&currentCity);

    int running = 1;
    while(running) {
        puts("menu:");
        puts("1 - Terkep");
        puts("2 - Lista");
        puts("3 - Uj megallo");
        puts("4 - Megallo torles");
        puts("5 - Mentes");
        puts("6 - Betoltes");
        puts("7 - Utvonal");
        puts("8 - Kilepes");
        printf("valassz: ");

        int anwser;
        scanf("%d", &anwser);
        switch(anwser) {
            case 1: {
                show_map(&currentCity);
                break;
            }
            case 2: {
                print_bus_stop(&currentCity);
                break;
            }
            case 3: {
                // todo
                break;
            }
            case 4: {
                // todo
                break;
            }
            case 5: {
                save_list(&currentCity);
                break;
            }
            case 6: {
                load_list(&currentCity);
                break;
            }
            case 7: {
                // todo
                break;
            }
            case 8: {
                running = 0;
                break;
            }
            default: {
                puts("helytelen menupont");
                break;
            }
        }
    }
}
