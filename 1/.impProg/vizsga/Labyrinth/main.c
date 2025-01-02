#include <stdio.h>
#include <stdlib.h>
#include "lab.h"

int main() {
    Lab currentLab;
    currentLab.rows = 0;
    currentLab.cols = 0;
    currentLab.board = NULL;

    int running = 1;
    printf("Udvozollek a Labirintus jatekban!\n");
    while(running) {
        printf("\nMenu:\n");
        printf("1) Kirajzolas\n");
        printf("2) Keszites\n");
        printf("3) Mentes\n");
        printf("4) Betoltes\n");
        printf("5) Jatek\n");
        printf("6) Kilepes\n");
        printf("Valasztas: ");
        int choice;
        scanf("%d", &choice);

        switch(choice) {
            case 1:
                print_board(&currentLab);
                break;
            case 2:
                create_labyrinth(&currentLab);
                break;
            case 3:
                save_labyrinth(&currentLab);
                break;
            case 4:
                load_labyrinth(&currentLab);
                break;
            case 5:
                play_labyrinth(&currentLab);
                break;
            case 6:
                running = 0;
                break;
            default:
                printf("Ismeretlen valasztas!\n");
        }
    }
    return 0;
}
