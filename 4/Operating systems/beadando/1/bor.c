#include "bor.h"
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int request_line(const char* request, char* out, size_t out_size) {
    printf("%s", request);

    if (!fgets(out, (int)out_size, stdin)) { return 0; }
    out[strcspn(out, "\n")] = '\0';

    return 1;
}

static int request_int(const char* request, int* value) {
    char buffer[1024];

    if (!request_line(request, buffer, sizeof(buffer))) { return 0; }

    if (sscanf(buffer, " %d", value) != 1) {
        printf("Érvénytelen szám formátum!\n");
        return 0;
    }

    return 1;
}

static int has_comma(const char* text) { return strchr(text, ',') != NULL; }

void bor_init(BorData* db, const char* filename) {
    db->rows = NULL;
    db->count = 0;
    strncpy(db->filename, filename, sizeof(db->filename) - 1);
    db->filename[sizeof(db->filename) - 1] = '\0';
}

void bor_free(BorData* db) {
    free(db->rows);
    db->rows = NULL;
    db->count = 0;
}

int bor_load(BorData* db) {
    bor_free(db);

    FILE* file = fopen(db->filename, "r");
    if (!file) { return 0; }

    char line[1024];
    while (fgets(line, sizeof(line), file)) {
        char buffer[1024];
        char* token;
        char* fields[5];
        int i = 0;

        strncpy(buffer, line, sizeof(buffer) - 1);
        buffer[sizeof(buffer) - 1] = '\0';

        token = strtok(buffer, ",");
        while (token && i < 5) {
            char* start = token;
            char* end;

            while (*start && isspace((unsigned char)*start)) { ++start; }

            if (*start != '\0') {
                end = start + strlen(start) - 1;
                while (end > start && isspace((unsigned char)*end)) {
                    *end = '\0';
                    --end;
                }
            }

            fields[i++] = start;
            token = strtok(NULL, ",");
        }

        if (i != 5) { continue; }

        void* tmp =
            realloc(db->rows, (size_t)(db->count + 1) * sizeof(*db->rows));
        if (!tmp) {
            fclose(file);
            return 0;
        }
        db->rows = tmp;

        snprintf(db->rows[db->count].winery_name, 1024, "%s", fields[0]);
        snprintf(db->rows[db->count].field_name, 1024, "%s", fields[1]);
        snprintf(db->rows[db->count].grape_type, 1024, "%s", fields[2]);

        if (sscanf(fields[3], "%d", &db->rows[db->count].field_size) != 1 ||
            sscanf(fields[4], "%d", &db->rows[db->count].loss) != 1) {
            continue;
        }

        db->count++;
    }
    fclose(file);
    return 1;
}

int bor_save(const BorData* db) {
    FILE* file = fopen(db->filename, "w");
    if (!file) { return 0; }

    for (int i = 0; i < db->count; ++i) {
        fprintf(file, "%s,%s,%s,%d,%d\n", db->rows[i].winery_name,
                db->rows[i].field_name, db->rows[i].grape_type,
                db->rows[i].field_size, db->rows[i].loss);
    }
    fclose(file);
    return 1;
}

void bor_print(const BorData* db) {
    if (db->count == 0) {
        printf("Az adatbázis üres.");
        return;
    }
    for (int i = 0; i < db->count; ++i) {
        printf("%d. %s, %s, %s, %d négyszögöl, %d%%\n", i + 1,
               db->rows[i].winery_name, db->rows[i].field_name,
               db->rows[i].grape_type, db->rows[i].field_size,
               db->rows[i].loss);
    }
}

int bor_add(BorData* db) {
    char winery_name[1024], field_name[1024], grape_type[1024];
    int field_size, loss;
    printf("\n");

    if (!request_line("Termőhely neve: ", winery_name, sizeof(winery_name)) ||
        !request_line("Tábla neve: ", field_name, sizeof(field_name)) ||
        !request_line("Szőlő típusa: ", grape_type, sizeof(grape_type)) ||
        !request_int("Terület mérete (négyszögöl): ", &field_size) ||
        !request_int("Pusztulás százaléka: ", &loss)) {
        printf("Input hiba.\n");
        return 0;
    }

    if (has_comma(winery_name) || has_comma(field_name) ||
        has_comma(grape_type)) {
        printf("Hiba: Szövegben nem szerepelhet vessző.\n");
        return 0;
    }

    void* tmp = realloc(db->rows, (size_t)(db->count + 1) * sizeof(*db->rows));
    if (!tmp) {
        printf("Memóriafoglalási hiba.\n");
        return 0;
    }
    db->rows = tmp;

    snprintf(db->rows[db->count].winery_name, 1024, "%s", winery_name);
    snprintf(db->rows[db->count].field_name, 1024, "%s", field_name);
    snprintf(db->rows[db->count].grape_type, 1024, "%s", grape_type);
    db->rows[db->count].field_size = field_size;
    db->rows[db->count].loss = loss;
    db->count++;

    printf("Sor sikeresen hozzáadva.");
    return bor_save(db);
}

int bor_modify(BorData* db) {
    int index = 0;
    char winery_name[1024], field_name[1024], grape_type[1024];
    int field_size, loss;
    printf("\n");

    if (db->count == 0) {
        printf("Az adatbázis üres.\n");
        return 0;
    }

    bor_print(db);

    if (!request_int("Hanyas sorszámú sort szeretné módosítani?: ", &index)) {
        return 0;
    }

    --index;
    if (index < 0 || index >= db->count) {
        printf("Érvénytelen sorszám.\n");
        return 0;
    }

    if (!request_line("Új termőhely neve: ", winery_name,
                      sizeof(winery_name)) ||
        !request_line("Új tábla neve: ", field_name, sizeof(field_name)) ||
        !request_line("Új szőlő típusa: ", grape_type, sizeof(grape_type)) ||
        !request_int("Új terület mérete (négyszögöl): ", &field_size) ||
        !request_int("Új pusztulás százaléka: ", &loss)) {
        printf("Input hiba.\n");
        return 0;
    }

    if (has_comma(winery_name) || has_comma(field_name) ||
        has_comma(grape_type)) {
        printf("Hiba: Szövegben nem szerepelhet vessző.\n");
        return 0;
    }

    snprintf(db->rows[index].winery_name, 1024, "%s", winery_name);
    snprintf(db->rows[index].field_name, 1024, "%s", field_name);
    snprintf(db->rows[index].grape_type, 1024, "%s", grape_type);
    db->rows[index].field_size = field_size;
    db->rows[index].loss = loss;

    printf("Sor sikeresen módosítva.\n");
    return bor_save(db);
}

int bor_delete(BorData* db) {
    int index;
    printf("\n");

    if (db->count == 0) {
        printf("Az adatbázis üres.\n");
        return 0;
    }

    bor_print(db);

    if (!request_int("Hanyas sorszámú sort szeretné törölni?: ", &index)) {
        return 0;
    }

    --index;
    if (index < 0 || index >= db->count) {
        printf("Érvénytelen sorszám.\n");
        return 0;
    }

    for (int i = index; i < db->count - 1; ++i) {
        db->rows[i] = db->rows[i + 1];
    }

    db->count--;

    printf("Sor sikeresen törölve.\n");
    return bor_save(db);
}

void bor_list_by_filter(const BorData* db) {
    char mode, needle[1024];
    int found = 0;
    printf("\n");

    if (db->count == 0) {
        printf("Az adatbázis üres.\n");
        return;
    }

    printf("1 - termőhely szerint\n");
    printf("2 - szőlő típus szerint\n");

    printf("Válasz: ");
    if (scanf(" %c", &mode) != 1) { return; }

    while (getchar() != '\n') {};

    if (mode != '1' && mode != '2') {
        printf("Érvénytelen választás.\n");
        return;
    }

    if (!request_line("Szűrő szöveg: ", needle, sizeof(needle))) return;
    for (int i = 0; i < db->count; ++i) {
        const char* field =
            (mode == '1') ? db->rows[i].winery_name : db->rows[i].grape_type;
        if (strstr(field, needle)) {
            printf("%d. %s, %s, %s, %d négyszögöl, %d%%\n", i + 1,
                   db->rows[i].winery_name, db->rows[i].field_name,
                   db->rows[i].grape_type, db->rows[i].field_size,
                   db->rows[i].loss);
            found = 1;
        }
    }
    if (!found) printf("Nincs találat.\n");
}
