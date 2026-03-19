#include "bor.h"
#include "menu.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int initial_load(int argc, char* argv[]);

int main(int argc, char* argv[]) {
    int input;

    printf("Oprendszer Hegyvidék - adatbázis kezelő\n");
    if (initial_load(argc, argv)) { return 1; }

    while (1) {
        menu_print();
        input = menu_input();

        if (input == -1) {
            printf("\n");
            continue;
        }

        if (input == 0) { break; }

        menu_handle_input(input);
        printf("\n");
    }

    return 0;
}

int initial_load(int argc, char* argv[]) {
    const char* filename;
    FILE* file;

    if (argc < 2) {
        filename = "data.csv";
        file = fopen(filename, "r");
        if (!file) {
            file = fopen(filename, "w");
            if (!file) {
                perror("Hiba történt data.csv létrehozása során");
                return 1;
            }
            printf("%s létrehozva\n", filename);
        } else {
            printf("%s megnyitva\n", filename);
        }
    } else {
        filename = argv[1];
        file = fopen(filename, "r");
        if (!file) {
            fprintf(stderr, "'%s' nevű fájl nem létezik.\n", filename);
            return 1;
        }
        printf("%s megnyitva\n", filename);
    }

    fclose(file);
    set_data_filename(filename);
    return 0;
}
