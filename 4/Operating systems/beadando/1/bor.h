#ifndef BOR_H
#define BOR_H

#include <stdio.h>

typedef struct {
    struct {
        char winery_name[1024];
        char tabla_nev[1024];
        char szolo_tipus[1024];
        float terulet_meret;
        float pusztulas_szazalek;
    }* rows;
    int count;
    int capacity;
    char filename[512];
} BorData;

void bor_init(BorData* db, const char* filename);
void bor_free(BorData* db);
int bor_load(BorData* db);
int bor_save(const BorData* db);
void bor_print(const BorData* db);
int bor_add(BorData* db);
int bor_modify(BorData* db);
int bor_delete(BorData* db);
void bor_list_by_filter(const BorData* db);

#endif
