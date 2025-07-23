#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "lab.h"

static void free_board(Lab* lab) {
    if(!lab->board) return;
    for(int i = 0; i < lab->rows; i++) {
        free(lab->board[i]);
    }
    free(lab->board);
    lab->board = NULL;
}

void create_labyrinth(Lab* lab) {
    free_board(lab);
    int r, c;
    do {
        printf("Kerem a labirintus sorainak szamat (5..10): ");
        scanf("%d", &r);
    } while(r < 5 || r > 10);

    do {
        printf("Kerem a labirintus oszlopainak szamat (5..10): ");
        scanf("%d", &c);
    } while(c < 5 || c > 10);

    lab->rows = r;
    lab->cols = c;
    lab->board = (char**)malloc(r * sizeof(char*));
    getchar(); // consume leftover newline
    for(int i = 0; i < r; i++) {
        lab->board[i] = (char*)malloc(c + 2); // +1 for '\n' +1 for '\0'
        fgets(lab->board[i], c + 2, stdin);
        // remove trailing newline if any
        for(int j = 0; j < c + 2; j++) {
            if(lab->board[i][j] == '\n') {
                lab->board[i][j] = '\0';
                break;
            }
        }
    }
}

void print_board(const Lab* lab) {
    if(!lab->board) {
        printf("Nincs labirintus!\n");
        return;
    }
    for(int i = 0; i < lab->rows; i++) {
        for(int j = 0; j < lab->cols; j++) {
            putchar(lab->board[i][j]); 
        }
        putchar('\n');
    }
}

void save_labyrinth(const Lab* lab) {
    if(!lab->board) {
        printf("Nincs mentheto labirintus!\n");
        return;
    }
    char fname[100];
    printf("Fajl nev: ");
    scanf("%s", fname);
    FILE* f = fopen(fname, "w");
    if(!f) {
        printf("Nem sikerult megnyitni a fajlt!\n");
        return;
    }
    fprintf(f, "%d %d\n", lab->rows, lab->cols);
    for(int i = 0; i < lab->rows; i++) {
        fprintf(f, "%s\n", lab->board[i]);
    }
    fclose(f);
    printf("Mentes kesz.\n");
}

void load_labyrinth(Lab* lab) {
    free_board(lab);
    char fname[100];
    printf("Olvasando fajl: ");
    scanf("%s", fname);
    FILE* f = fopen(fname, "r");
    if(!f) {
        printf("Nem sikerult megnyitni a fajlt.\n");
        return;
    }
    fscanf(f, "%d %d\n", &lab->rows, &lab->cols);
    lab->board = (char**)malloc(lab->rows * sizeof(char*));
    for(int i = 0; i < lab->rows; i++) {
        lab->board[i] = (char*)malloc(lab->cols + 1);
        for(int j = 0; j < lab->cols; j++) {
            lab->board[i][j] = (char)fgetc(f);
        }
        lab->board[i][lab->cols] = '\0';
        fgetc(f); // newline
    }
    fclose(f);
    printf("Betoltes kesz.\n");
}

void play_labyrinth(Lab* lab) {
    if(!lab->board) {
        printf("Nincs palya a jatekhoz!\n");
        return;
    }
    // Keressunk egy random, belso, szabad mezot a 'P'-nek
    srand((unsigned)time(NULL));
    int pr = 0, pc = 0;
    // Probalkozunk random ponttal
    while(1) {
        pr = rand() % lab->rows;
        pc = rand() % lab->cols;
        // Fal: '#' (vagy barmi), Nyilas: valamilyen, stb. 
        // Csak space-hez rakjuk
        if(lab->board[pr][pc] == ' ') {
            lab->board[pr][pc] = 'P';
            break;
        }
    }

    // Jatek smink
    while(1) {
        print_board(lab);
        printf("Mozgas: w/a/s/d, r=feladas\n");
        char cmd;
        scanf(" %c", &cmd);
        if(cmd == 'r') {
            lab->board[pr][pc] = ' ';
            printf("Jatek feladva.\n");
            return;
        }
        int nr = pr, nc = pc;
        if(cmd == 'w') nr--;
        if(cmd == 's') nr++;
        if(cmd == 'a') nc--;
        if(cmd == 'd') nc++;
        // Mozgas
        if(nr < 0 || nr >= lab->rows || nc < 0 || nc >= lab->cols) continue;
        // Fal nincs engedelyezve, pl. '#'
        if(lab->board[nr][nc] == '#') continue;
        // Ha kijarat (lyuk) -> pl. 'O', nyilas. Feltesszuk a kulso falban van nyilas
        // tetszoleges mas jellel. Itt pl. 'O'
        if(lab->board[nr][nc] == 'O') {
            lab->board[pr][pc] = ' ';
            printf("Gyozelem!\n");
            return;
        }
        // Egyebkent mehetunk
        lab->board[pr][pc] = ' ';
        lab->board[nr][nc] = 'P';
        pr = nr; 
        pc = nc;
    }
}
