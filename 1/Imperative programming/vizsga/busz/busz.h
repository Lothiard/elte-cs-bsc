#ifndef BUSZ_H
#define BUSZ_H

#include <stdio.h>

#define MAPSIZE 10

typedef struct {
    char* name;
    int x, y;
} BusStop;

typedef struct {
    BusStop* stops;
    int count;
} City;

void initCity(City *currentCity);
void freeCity(City *currentCity);

void show_map(City *currentCity);
void save_list(City* currentCity);
void load_list(City *currentCity);
void print_bus_stop(City *currentCity);

#endif
