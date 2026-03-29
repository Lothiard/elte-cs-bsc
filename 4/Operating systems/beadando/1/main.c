#include "bor.h"
#include "menu.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

BorData g_db;

int initial_load(int argc, char* argv[]);

int main(int argc, char* argv[]) {
    int input;
    printf("Oprendszer Hegyvidék - adatbázis kezelő\n");
    if (initial_load(argc, argv)) { return 1; }
    if (!bor_load(&g_db)) {
        printf("Nem sikerült adatot beolvasni, új adatbázis indul.\n");
    }
    while (1) {
        menu_print();
        input = menu_input();
        if (input == -1) {
            printf("\n");
            continue;
        }
        if (input == 0) { break; }
        menu_handle_input(input, &g_db);
        printf("\n");
    }
    bor_free(&g_db);
    return 0;
}

int initial_load(int argc, char* argv[]) {
    const char* filename;
    FILE* file;
    if (argc < 2) {
        filename = "data.csv";
        file = fopen(filename, "a+");
        if (!file) {
            perror("Hiba történt data.csv létrehozása során");
            return 1;
        }
        printf("%s megnyitva/létrehozva\n", filename);
    } else {
        filename = argv[1];
        file = fopen(filename, "a+");
        if (!file) {
            fprintf(stderr,
                    "'%s' nevű fájl nem létezik és nem hozható létre.\n",
                    filename);
            return 1;
        }
        printf("%s megnyitva/létrehozva\n", filename);
    }
    fclose(file);
    bor_init(&g_db, filename);
    return 0;
}
