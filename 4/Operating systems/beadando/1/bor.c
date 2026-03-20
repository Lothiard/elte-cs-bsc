#include "bor.h"
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char g_data_filename[512] = "data.csv";

static char* dup_text(const char* src) {
    size_t len;
    char* out;

    if (!src) { return NULL; }

    len = strlen(src);
    out = malloc(len + 1);
    if (!out) { return NULL; }

    memcpy(out, src, len + 1);
    return out;
}

static char* trim(char* str) {
    char* end;

    while (*str && isspace((unsigned char)*str)) { str++; }
    if (*str == '\0') { return str; }

    end = str + strlen(str) - 1;
    while (end > str && isspace((unsigned char)*end)) {
        *end = '\0';
        end--;
    }

    return str;
}

static int prompt_line(const char* prompt, char* out, size_t out_size) {
    printf("%s", prompt);
    if (!fgets(out, (int)out_size, stdin)) { return 0; }

    out[strcspn(out, "\n")] = '\0';
    return 1;
}

static int prompt_float(const char* prompt, float* value) {
    char buffer[128];
    char* end;

    while (1) {
        if (!prompt_line(prompt, buffer, sizeof(buffer))) { return 0; }

        *value = strtof(buffer, &end);
        while (*end && isspace((unsigned char)*end)) { end++; }

        if (end != buffer && *end == '\0') { return 1; }
        printf("Helytelen számformátum!\n");
    }
}

static int has_comma(const char* text) { return strchr(text, ',') != NULL; }

static int parse_line(const char* line, data* row) {
    char buffer[1024];
    char* token;
    char* termohely;
    char* tabla;
    char* szolo;
    char* terulet;
    char* pusztulas;

    strncpy(buffer, line, sizeof(buffer) - 1);
    buffer[sizeof(buffer) - 1] = '\0';

    token = strtok(buffer, ",");
    if (!token) { return 0; }
    termohely = trim(token);

    token = strtok(NULL, ",");
    if (!token) { return 0; }
    tabla = trim(token);

    token = strtok(NULL, ",");
    if (!token) { return 0; }
    szolo = trim(token);

    token = strtok(NULL, ",");
    if (!token) { return 0; }
    terulet = trim(token);

    token = strtok(NULL, ",");
    if (!token) { return 0; }
    pusztulas = trim(token);

    row->termohely_nev = dup_text(termohely);
    row->tabla_nev = dup_text(tabla);
    row->szolo_tipus = dup_text(szolo);

    if (!row->termohely_nev || !row->tabla_nev || !row->szolo_tipus) {
        free(row->termohely_nev);
        free(row->tabla_nev);
        free(row->szolo_tipus);
        return 0;
    }

    if (sscanf(terulet, "%f", &row->terulet_meret) != 1 ||
        sscanf(pusztulas, "%f", &row->pusztulas_szazalek) != 1) {
        free(row->termohely_nev);
        free(row->tabla_nev);
        free(row->szolo_tipus);
        return 0;
    }

    return 1;
}

static void free_records(data* records, int count) {
    int i;
    for (i = 0; i < count; i++) {
        free(records[i].termohely_nev);
        free(records[i].tabla_nev);
        free(records[i].szolo_tipus);
    }
    free(records);
}

static int load_records(data** records, int* count) {
    FILE* file;
    char line[1024];
    data* loaded = NULL;
    int loaded_count = 0;

    *records = NULL;
    *count = 0;

    file = fopen(g_data_filename, "r");
    if (!file) { return 0; }

    while (fgets(line, sizeof(line), file)) {
        data row;
        data* temp;

        if (!parse_line(line, &row)) { continue; }

        temp = realloc(loaded, (size_t)(loaded_count + 1) * sizeof(data));
        if (!temp) {
            free(row.termohely_nev);
            free(row.tabla_nev);
            free(row.szolo_tipus);
            free_records(loaded, loaded_count);
            fclose(file);
            return 0;
        }

        loaded = temp;
        loaded[loaded_count] = row;
        loaded_count++;
    }

    fclose(file);
    *records = loaded;
    *count = loaded_count;
    return 1;
}

static int save_records(data* records, int count) {
    FILE* file;
    int i;

    file = fopen(g_data_filename, "w");
    if (!file) {
        perror("Hiba mentés közben");
        return 0;
    }

    for (i = 0; i < count; i++) {
        fprintf(file, "%s,%s,%s,%.2f,%.2f\n", records[i].termohely_nev,
                records[i].tabla_nev, records[i].szolo_tipus,
                records[i].terulet_meret, records[i].pusztulas_szazalek);
    }

    fclose(file);
    return 1;
}

static void print_records(data* records, int count) {
    int i;

    if (count == 0) {
        printf("Nincs listázható adat.\n");
        return;
    }

    for (i = 0; i < count; i++) {
        printf("%d. %s, %s, %s, %.2f négyszögöl, %.2f%%\n", i + 1,
               records[i].termohely_nev, records[i].tabla_nev,
               records[i].szolo_tipus, records[i].terulet_meret,
               records[i].pusztulas_szazalek);
    }
}

void set_data_filename(const char* filename) {
    if (!filename || filename[0] == '\0') { return; }

    strncpy(g_data_filename, filename, sizeof(g_data_filename) - 1);
    g_data_filename[sizeof(g_data_filename) - 1] = '\0';
}

void add_row(void) {
    printf("\n");

    char termohely_nev[100];
    char tabla_nev[100];
    char szolo_tipus[100];
    float terulet_meret;
    float pusztulas_szazalek;
    FILE* out;

    if (!prompt_line("Termőhely neve: ", termohely_nev,
                     sizeof(termohely_nev)) ||
        !prompt_line("Tábla neve: ", tabla_nev, sizeof(tabla_nev)) ||
        !prompt_line("Szőlő típusa: ", szolo_tipus, sizeof(szolo_tipus)) ||
        !prompt_float("Terület mérete (négyszögöl): ", &terulet_meret) ||
        !prompt_float("Pusztulás százaléka: ", &pusztulas_szazalek)) {
        printf("Hiba: sikertelen adatbevitel.\n");
        return;
    }

    if (has_comma(termohely_nev) || has_comma(tabla_nev) ||
        has_comma(szolo_tipus)) {
        printf("Hiba: a szöveges mezők nem tartalmazhatnak vesszőt.\n");
        return;
    }

    out = fopen(g_data_filename, "a");
    if (!out) {
        perror("Hiba a fájl megnyitása közben");
        return;
    }

    fprintf(out, "%s,%s,%s,%.2f,%.2f\n", termohely_nev, tabla_nev, szolo_tipus,
            terulet_meret, pusztulas_szazalek);
    fclose(out);

    printf("Sor sikeresen hozzáadva.\n");
}

void read_all(void) {
    printf("\n");

    data* records = NULL;
    int count = 0;

    if (!load_records(&records, &count)) {
        printf("Nem sikerült adatot beolvasni.\n");
        return;
    }

    print_records(records, count);
    free_records(records, count);
}

void modify_row(void) {
    printf("\n");

    data* records = NULL;
    int count = 0;
    char input[32];
    int index;
    char termohely_nev[100];
    char tabla_nev[100];
    char szolo_tipus[100];
    float terulet_meret;
    float pusztulas_szazalek;

    if (!load_records(&records, &count)) {
        printf("Nem sikerült adatot beolvasni.\n");
        return;
    }

    if (count == 0) {
        printf("Nincs módosítható adat.\n");
        free_records(records, count);
        return;
    }

    print_records(records, count);
    if (!prompt_line("Melyik sor módosuljon? (sorszám): ", input,
                     sizeof(input))) {
        free_records(records, count);
        return;
    }

    index = atoi(input) - 1;
    if (index < 0 || index >= count) {
        printf("Érvénytelen sorszám.\n");
        free_records(records, count);
        return;
    }

    if (!prompt_line("Új termőhely neve: ", termohely_nev,
                     sizeof(termohely_nev)) ||
        !prompt_line("Új tábla neve: ", tabla_nev, sizeof(tabla_nev)) ||
        !prompt_line("Új szőlő típusa: ", szolo_tipus, sizeof(szolo_tipus)) ||
        !prompt_float("Új terület mérete (négyszögöl): ", &terulet_meret) ||
        !prompt_float("Új pusztulás százaléka: ", &pusztulas_szazalek)) {
        printf("Hiba: sikertelen adatbevitel.\n");
        free_records(records, count);
        return;
    }

    if (has_comma(termohely_nev) || has_comma(tabla_nev) ||
        has_comma(szolo_tipus)) {
        printf("Hiba: a szöveges mezők nem tartalmazhatnak vesszőt.\n");
        free_records(records, count);
        return;
    }

    free(records[index].termohely_nev);
    free(records[index].tabla_nev);
    free(records[index].szolo_tipus);

    records[index].termohely_nev = dup_text(termohely_nev);
    records[index].tabla_nev = dup_text(tabla_nev);
    records[index].szolo_tipus = dup_text(szolo_tipus);
    records[index].terulet_meret = terulet_meret;
    records[index].pusztulas_szazalek = pusztulas_szazalek;

    if (!records[index].termohely_nev || !records[index].tabla_nev ||
        !records[index].szolo_tipus) {
        printf("Memóriafoglalási hiba.\n");
        free_records(records, count);
        return;
    }

    if (save_records(records, count)) { printf("Sor sikeresen módosítva.\n"); }

    free_records(records, count);
}

void delete_row(void) {
    printf("\n");

    data* records = NULL;
    int count = 0;
    char input[32];
    int index;
    int i;

    if (!load_records(&records, &count)) {
        printf("Nem sikerült adatot beolvasni.\n");
        return;
    }

    if (count == 0) {
        printf("Nincs törölhető adat.\n");
        free_records(records, count);
        return;
    }

    print_records(records, count);
    if (!prompt_line("Melyik sor törlődjön? (sorszám): ", input,
                     sizeof(input))) {
        free_records(records, count);
        return;
    }

    index = atoi(input) - 1;
    if (index < 0 || index >= count) {
        printf("Érvénytelen sorszám.\n");
        free_records(records, count);
        return;
    }

    free(records[index].termohely_nev);
    free(records[index].tabla_nev);
    free(records[index].szolo_tipus);

    for (i = index; i < count - 1; i++) { records[i] = records[i + 1]; }
    count--;

    if (save_records(records, count)) { printf("Sor sikeresen törölve.\n"); }

    free_records(records, count);
}

void list_by_filter(void) {
    printf("\n");

    data* records = NULL;
    int count = 0;
    char mode[32];
    char needle[100];
    int i;
    int found = 0;

    if (!load_records(&records, &count)) {
        printf("Nem sikerült adatot beolvasni.\n");
        return;
    }

    if (count == 0) {
        printf("Nincs listázható adat.\n");
        free_records(records, count);
        return;
    }

    printf("1 - termőhely szerint\n");
    printf("2 - szőlő típus szerint\n");
    if (!prompt_line("Választás: ", mode, sizeof(mode))) {
        free_records(records, count);
        return;
    }

    if (strcmp(mode, "1") != 0 && strcmp(mode, "2") != 0) {
        printf("Érvénytelen választás.\n");
        free_records(records, count);
        return;
    }

    if (!prompt_line("Szűrő szöveg: ", needle, sizeof(needle))) {
        free_records(records, count);
        return;
    }

    for (i = 0; i < count; i++) {
        const char* field = (strcmp(mode, "1") == 0) ? records[i].termohely_nev
                                                     : records[i].szolo_tipus;

        if (strstr(field, needle)) {
            printf("%d. %s, %s, %s, %.2f négyszögöl, %.2f%%\n", i + 1,
                   records[i].termohely_nev, records[i].tabla_nev,
                   records[i].szolo_tipus, records[i].terulet_meret,
                   records[i].pusztulas_szazalek);
            found = 1;
        }
    }

    if (!found) { printf("Nincs találat a megadott szűrésre.\n"); }

    free_records(records, count);
}
