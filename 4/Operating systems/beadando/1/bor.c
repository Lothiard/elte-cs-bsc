#include "bor.h"
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char* trim(char* str) {
    char* end;
    while (*str && isspace((unsigned char)*str)) str++;
    if (*str == '\0') return str;
    end = str + strlen(str) - 1;
    while (end > str && isspace((unsigned char)*end)) {
        *end = '\0';
        end--;
    }
    return str;
}

static int prompt_line(const char* prompt, char* out, size_t out_size) {
    printf("%s", prompt);
    if (!fgets(out, (int)out_size, stdin)) return 0;
    out[strcspn(out, "\n")] = '\0';
    return 1;
}

static int prompt_float(const char* prompt, float* value) {
    char buffer[128], *end;
    while (1) {
        if (!prompt_line(prompt, buffer, sizeof(buffer))) return 0;
        *value = strtof(buffer, &end);
        while (*end && isspace((unsigned char)*end)) end++;
        if (end != buffer && *end == '\0') return 1;
        printf("Invalid number format!\n");
    }
}

static int has_comma(const char* text) { return strchr(text, ',') != NULL; }

void bor_init(BorData* db, const char* filename) {
    db->rows = NULL;
    db->count = 0;
    db->capacity = 0;
    strncpy(db->filename, filename, sizeof(db->filename) - 1);
    db->filename[sizeof(db->filename) - 1] = '\0';
}

void bor_free(BorData* db) {
    for (int i = 0; i < db->count; ++i) {
        free(db->rows[i].winery_name);
        free(db->rows[i].tabla_nev);
        free(db->rows[i].szolo_tipus);
    }
    free(db->rows);
    db->rows = NULL;
    db->count = 0;
    db->capacity = 0;
}

static int parse_line(const char* line, BorData* db) {
    char buffer[1024];
    char* token;
    char* fields[5];
    strncpy(buffer, line, sizeof(buffer) - 1);
    buffer[sizeof(buffer) - 1] = '\0';

    int i = 0;
    token = strtok(buffer, ",");
    while (token && i < 5) {
        fields[i++] = trim(token);
        token = strtok(NULL, ",");
    }
    if (i != 5) return 0;

    if (db->count == db->capacity) {
        int newcap = db->capacity ? db->capacity * 2 : 8;
        void* tmp = realloc(db->rows, newcap * sizeof(*db->rows));
        if (!tmp) return 0;
        db->rows = tmp;
        db->capacity = newcap;
    }

    snprintf(db->rows[db->count].winery_name, 1024, "%s", fields[0]);
    snprintf(db->rows[db->count].tabla_nev, 1024, "%s", fields[1]);
    snprintf(db->rows[db->count].szolo_tipus, 1024, "%s", fields[2]);
    if (sscanf(fields[3], "%f", &db->rows[db->count].terulet_meret) != 1 ||
        sscanf(fields[4], "%f", &db->rows[db->count].pusztulas_szazalek) != 1)
        return 0;
    db->count++;
    return 1;
}

int bor_load(BorData* db) {
    bor_free(db);
    FILE* file = fopen(db->filename, "r");
    if (!file) return 0;
    char line[1024];
    while (fgets(line, sizeof(line), file)) { parse_line(line, db); }
    fclose(file);
    return 1;
}

int bor_save(const BorData* db) {
    FILE* file = fopen(db->filename, "w");
    if (!file) return 0;
    for (int i = 0; i < db->count; ++i) {
        fprintf(file, "%s,%s,%s,%.2f,%.2f\n", db->rows[i].winery_name,
                db->rows[i].tabla_nev, db->rows[i].szolo_tipus,
                db->rows[i].terulet_meret, db->rows[i].pusztulas_szazalek);
    }
    fclose(file);
    return 1;
}

void bor_print(const BorData* db) {
    if (db->count == 0) {
        printf("No data to list.\n");
        return;
    }
    for (int i = 0; i < db->count; ++i) {
        printf("%d. %s, %s, %s, %.2f négyszögöl, %.2f%%\n", i + 1,
               db->rows[i].winery_name, db->rows[i].tabla_nev,
               db->rows[i].szolo_tipus, db->rows[i].terulet_meret,
               db->rows[i].pusztulas_szazalek);
    }
}

int bor_add(BorData* db) {
    char winery_name[100], tabla_nev[100], szolo_tipus[100];
    float terulet_meret, pusztulas_szazalek;
    printf("\n");
    if (!prompt_line("Termőhely neve: ", winery_name, sizeof(winery_name)) ||
        !prompt_line("Tábla neve: ", tabla_nev, sizeof(tabla_nev)) ||
        !prompt_line("Szőlő típusa: ", szolo_tipus, sizeof(szolo_tipus)) ||
        !prompt_float("Terület mérete (négyszögöl): ", &terulet_meret) ||
        !prompt_float("Pusztulás százaléka: ", &pusztulas_szazalek)) {
        printf("Input error.\n");
        return 0;
    }
    if (has_comma(winery_name) || has_comma(tabla_nev) ||
        has_comma(szolo_tipus)) {
        printf("Error: text fields cannot contain commas.\n");
        return 0;
    }
    if (db->count == db->capacity) {
        int newcap = db->capacity ? db->capacity * 2 : 8;
        void* tmp = realloc(db->rows, newcap * sizeof(*db->rows));
        if (!tmp) return 0;
        db->rows = tmp;
        db->capacity = newcap;
    }
    snprintf(db->rows[db->count].winery_name, 1024, "%s", winery_name);
    snprintf(db->rows[db->count].tabla_nev, 1024, "%s", tabla_nev);
    snprintf(db->rows[db->count].szolo_tipus, 1024, "%s", szolo_tipus);
    db->rows[db->count].terulet_meret = terulet_meret;
    db->rows[db->count].pusztulas_szazalek = pusztulas_szazalek;
    db->count++;
    printf("Row successfully added.\n");
    return bor_save(db);
}

int bor_modify(BorData* db) {
    char input[32];
    char winery_name[100], tabla_nev[100], szolo_tipus[100];
    float terulet_meret, pusztulas_szazalek;
    printf("\n");
    if (db->count == 0) {
        printf("No data to modify.\n");
        return 0;
    }
    bor_print(db);
    if (!prompt_line("Which row to modify? (number): ", input, sizeof(input)))
        return 0;
    int index = atoi(input) - 1;
    if (index < 0 || index >= db->count) {
        printf("Invalid row number.\n");
        return 0;
    }
    if (!prompt_line("New termőhely neve: ", winery_name,
                     sizeof(winery_name)) ||
        !prompt_line("New tábla neve: ", tabla_nev, sizeof(tabla_nev)) ||
        !prompt_line("New szőlő típusa: ", szolo_tipus, sizeof(szolo_tipus)) ||
        !prompt_float("New terület mérete (négyszögöl): ", &terulet_meret) ||
        !prompt_float("New pusztulás százaléka: ", &pusztulas_szazalek)) {
        printf("Input error.\n");
        return 0;
    }
    if (has_comma(winery_name) || has_comma(tabla_nev) ||
        has_comma(szolo_tipus)) {
        printf("Error: text fields cannot contain commas.\n");
        return 0;
    }
    free(db->rows[index].winery_name);
    free(db->rows[index].tabla_nev);
    free(db->rows[index].szolo_tipus);
    snprintf(db->rows[db->count].winery_name, 1024, "%s", winery_name);
    snprintf(db->rows[db->count].tabla_nev, 1024, "%s", tabla_nev);
    snprintf(db->rows[db->count].szolo_tipus, 1024, "%s", szolo_tipus);
    db->rows[index].terulet_meret = terulet_meret;
    db->rows[index].pusztulas_szazalek = pusztulas_szazalek;
    printf("Row successfully modified.\n");
    return bor_save(db);
}

int bor_delete(BorData* db) {
    char input[32];
    printf("\n");
    if (db->count == 0) {
        printf("No data to delete.\n");
        return 0;
    }
    bor_print(db);
    if (!prompt_line("Which row to delete? (number): ", input, sizeof(input)))
        return 0;
    int index = atoi(input) - 1;
    if (index < 0 || index >= db->count) {
        printf("Invalid row number.\n");
        return 0;
    }
    free(db->rows[index].winery_name);
    free(db->rows[index].tabla_nev);
    free(db->rows[index].szolo_tipus);
    for (int i = index; i < db->count - 1; ++i) {
        db->rows[i] = db->rows[i + 1];
    }
    db->count--;
    printf("Row successfully deleted.\n");
    return bor_save(db);
}

void bor_list_by_filter(const BorData* db) {
    char mode[32], needle[100];
    int found = 0;
    printf("\n");
    if (db->count == 0) {
        printf("No data to list.\n");
        return;
    }
    printf("1 - by termőhely\n");
    printf("2 - by szőlő típus\n");
    if (!prompt_line("Choose: ", mode, sizeof(mode))) return;
    if (strcmp(mode, "1") != 0 && strcmp(mode, "2") != 0) {
        printf("Invalid choice.\n");
        return;
    }
    if (!prompt_line("Filter text: ", needle, sizeof(needle))) return;
    for (int i = 0; i < db->count; ++i) {
        const char* field = (strcmp(mode, "1") == 0) ? db->rows[i].winery_name
                                                     : db->rows[i].szolo_tipus;
        if (strstr(field, needle)) {
            printf("%d. %s, %s, %s, %.2f négyszögöl, %.2f%%\n", i + 1,
                   db->rows[i].winery_name, db->rows[i].tabla_nev,
                   db->rows[i].szolo_tipus, db->rows[i].terulet_meret,
                   db->rows[i].pusztulas_szazalek);
            found = 1;
        }
    }
    if (!found) printf("No matches for the given filter.\n");
}
