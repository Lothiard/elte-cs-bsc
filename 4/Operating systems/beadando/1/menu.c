#include "menu.h"
#include "bor.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void menu_print(void) {
    printf("1 - felvetel\n");
    printf("2 - modositas\n");
    printf("3 - torles\n");
    printf("4 - teljes listazas\n");
    printf("5 - termohely/szolo szerinti listazas\n");
    printf("x - kilépés\n");
}

int menu_input(void) {
    char input[100];
    int num;

    if (!fgets(input, sizeof(input), stdin)) { return 0; }

    input[strcspn(input, "\n")] = 0;
    if (strcmp(input, "x") == 0) {
        return 0;
    } else {
        num = atoi(input);
        if (num >= 1 && num <= 5 && strlen(input) == 1) { return num; }
    }

    printf("Helytelen bemenet!\n");
    return -1;
}

void menu_handle_input(int input, BorData* db) {
    switch (input) {
    case 1: bor_add(db); break;
    case 2: bor_modify(db); break;
    case 3: bor_delete(db); break;
    case 4: bor_print(db); break;
    case 5: bor_list_by_filter(db); break;
    }
}
