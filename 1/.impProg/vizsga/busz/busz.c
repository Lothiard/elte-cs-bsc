#include "busz.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void initCity(City *currentCity) {
    currentCity->stops = NULL;
    currentCity->count = 0;
}

static void freeStop(BusStop *stop) {
    free(stop->name);
    stop->name = NULL;
}

void freeCity(City *currentCity) {
    for(int i = 0; i < currentCity->count; ++i) {
        freeStop(&currentCity->stops[i]);
    }
    free(currentCity->stops);
    currentCity->stops = NULL;
    currentCity->count = 0;
}

void show_map(City* currentCity) {
    char map[MAPSIZE][MAPSIZE];

    for(int i = 0; i < MAPSIZE; ++i) {
        for(int j = 0; j < MAPSIZE; ++j) {
            map[i][j] = ' ';
        }
    }

    for(int i = 0; i < currentCity->count; ++i) {
        int rx = currentCity->stops[i].x - 1;
        int ry = currentCity->stops[i].y - 1;
        if(rx >= 0 && rx < MAPSIZE && ry >= 0 && ry < MAPSIZE) {
            map[rx][ry] = 'B';
        }
    }

    printf("   ");
    for(int col = 1; col <= MAPSIZE; ++col) {
        printf("%d ", col % 10);
    }
    printf("\n");
    for(int i = 0; i < MAPSIZE; ++i) {
        printf("%c  ", 'a' + i);
        for(int j = 0; j < MAPSIZE; ++j) {
            printf("%c ", map[i][j]);
        }
        putchar('\n');
    }
}

void print_bus_stop(City* currentCity) {
    for(int i = 0; i < currentCity->count; ++i) {
        printf("%d. %s (%d, %d)\n", (i + 1), currentCity->stops[i].name, currentCity->stops[i].x, currentCity->stops[i].y);
    }
}

void save_list(City* currentCity) {
    if(currentCity->count == 0) {
        printf("A lista ures\n");
        return;
    }
    printf("Add meg a fajl nevet: ");
    char fajlnev[256];
    scanf("%s", fajlnev);

    FILE* f = fopen(fajlnev, "w");
    if(!f) {
        printf("fajl megnyitasa sikertelen\n");
    }

    for(int i = 0; i < currentCity->count; ++i) {
        fprintf(f, "%d. %s (%d, %d)\n", (i + 1), currentCity->stops[i].name, currentCity->stops[i].x, currentCity->stops[i].y);
    }
    puts("lista letrehozasa sikeres");
    fclose(f);
}

void load_list(City *currentCity) {
    printf("\nAdd meg a betolteni kivant fajl nevet: ");
    char fajlnev[50];
    scanf("%s", fajlnev);
    FILE* f = fopen(fajlnev, "r");
    if(!f) {
        printf("helytelen fajlnev!\n");
        return; 
    }
    freeCity(currentCity);
    initCity(currentCity);

    char temp[256];
    while(1) {
        if(!fgets(temp, 256, f)) break;
        char* newline = strchr(temp, '\n');
        if(newline) *newline = '\0';

        char coordLine[256];
        if(!fgets(coordLine, 256, f)) break;
        int x, y;
        if(sscanf(coordLine, "%d %d", &x, &y) != 2) continue;
        if(x < 1 || x > 10 || y < 1 || y > 10) continue;

        currentCity->stops = realloc(currentCity->stops, (currentCity->count + 1) * sizeof(BusStop));
        BusStop* added = &currentCity->stops[currentCity->count];
        added->name = malloc(strlen(temp) + 1);
        strcpy(added->name, temp);
        added->x = x;
        added->y = y;
        currentCity->count++;
    }
    fclose(f);
    printf("betoltes kesz\n");
}
