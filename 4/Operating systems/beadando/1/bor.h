#ifndef BOR_H
#define BOR_H

#include <stdio.h>

typedef struct {
    char* termohely_nev;
    char* tabla_nev;
    char* szolo_tipus;
    float terulet_meret, pusztulas_szazalek;
} data;

void set_data_filename(const char* filename);
void add_row(void);
void read_all(void);
void modify_row(void);
void delete_row(void);
void list_by_filter(void);

#endif
