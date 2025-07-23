#include "game.h"
#include <stdlib.h>
#include <stdio.h>

/* 
 * SEGÉDFÜGGVÉNYEK
 *
 * (opcionális)
 * Mivel csak ebben a fájlban használjuk, a static kulcsszóval elrejthetjük őket.
 */

static void init_field(char **fields, int rows, int cols) {
    for (int i = 0; i < rows; ++i)
        for (int j = 0; j < cols; ++j)
            fields[i][j] = ' ';

    int placed = 0;
    while (placed < APPLE_COUNT) {
        int index = rand() % (rows * cols);
        int x = index / cols;
        int y = index % cols;

        /* Ha már van ott alma, ne próbáljunk még egyet letenni */
        if (fields[x][y] != 'a') {
            fields[x][y] = 'a';
            ++placed;
        }
    }
}

static void init_snake(Point snake[INITIAL_SNAKE_LENGTH]) {
    for (int i = 0; i < INITIAL_SNAKE_LENGTH; ++i) {
        snake[i].x = 0;
        snake[i].y = INITIAL_SNAKE_LENGTH - i - 1;
    }
}

static void print_border(int cnt) {
    for (int i = 0; i < cnt; ++i)
        putchar('#');
    putchar('\n');
}

State init_game(int rows, int cols) {
    State state;
    state.rows = rows;
    state.cols = cols;

    /*
     * Mátrix kétfajta tárolása:
     * - tömb, amiben sorokra (amik maguk is tömbök) mutató pointerek vannak
     *   ha ilyet csinálunk, fontos: felszabadításnál a "belső" tömböket is free()-eljük!
     * - egyetlen tömb, sorfolytonosan; ekkor az indexelés bonyolultabb (órán néztük)
     */
    char **fields = malloc(rows * sizeof(char*));
    for (int i = 0; i < cols; ++i)
        fields[i] = malloc(cols * sizeof(char));
    state.fields = fields;
    init_field(fields, rows, cols);

    Point *snake = malloc(INITIAL_SNAKE_LENGTH * sizeof(Point));
    state.snake = snake;
    init_snake(snake);

    state.snake_length = INITIAL_SNAKE_LENGTH;

    return state;
}

void print_game(State *state) {
    /* 
     * Másolat készítése a játékmátrixról a kirajzoláshoz.
     * Nem elég csak a sorokra mutató pointereket átmásolni,
     * hanem a sorokról is másolatot kell készíteni.
     */
    char **display = malloc(state->rows * sizeof(char*));
    for (int i = 0; i < state->rows; ++i) {
        display[i] = malloc(state->cols * sizeof(char));
        for (int j = 0; j < state->cols; ++j)
            display[i][j] = state->fields[i][j];
    }
    
    Point head = state->snake[0];
    display[head.x][head.y] = '8';
    for (int i = 1; i < state->snake_length; ++i) {
        Point segment = state->snake[i];
        display[segment.x][segment.y] = '0';
    }

    print_border(state->cols + 2);
    
    for (int i = 0; i < state->rows; ++i) {
        putchar('#');

        for (int j = 0; j < state->cols; ++j) {
            putchar(display[i][j]);
        }

        putchar('#');
        putchar('\n');
    }

    print_border(state->cols + 2);

    /* Ne felejtsük el a sorokat is felszabadítani! */
    for (int i = 0; i < state->rows; ++i)
        free(display[i]);
    free(display);
}

int update_snake(State *state, char direction) {
    Point head = state->snake[0];
    switch (direction) {
        case 'w': head.x--; break;
        case 's': head.x++; break;
        case 'a': head.y--; break;
        case 'd': head.y++; break;
    }

    /* Ha a mozgással a pályán kívül esne a feje */
    if (head.x < 0 || head.y < 0)
        return UPDATE_COLLIDED_WITH_WALL;
    if (head.x >= state->rows || head.y >= state->cols)
        return UPDATE_COLLIDED_WITH_WALL;
    
    /* Ha a feje olyan pozícióra került, ahol a teste van */
    for (int i = 1; i < state->snake_length; ++i)
        if (head.x == state->snake[i].x && head.y == state->snake[i].y)
            return UPDATE_COLLIDED_WITH_SELF;
    
    if (state->fields[head.x][head.y] == ' ') {
        /*
         * Nem volt ott alma -> a szegmenseket eltoljuk
         * Ahol eddig a feje volt, most a második szegmens lesz az, stb.
         */
        for (int i = state->snake_length - 1; i >= 1; --i)
            state->snake[i] = state->snake[i - 1];

        state->snake[0] = head;

        return UPDATE_NONE;
    } else {
        /* Volt alma - megnöveljük a kígyót */
        Point *snake = malloc(sizeof(Point) * (state->snake_length + 1));
        snake[0] = head;
        for (int i = 1; i < state->snake_length + 1; ++i)
            snake[i] = state->snake[i - 1];

        state->snake_length++;
        free(state->snake);
        state->snake = snake;

        /* Töröljük az almát, hogy ne gyűjtsünk be még egyet, ha újra ideérünk  */
        state->fields[head.x][head.y] = ' ';

        return UPDATE_COLLECTED_APPLE;
    }
}

void free_game(State *state) {
    for (int i = 0; i < state->rows; ++i)
        free(state->fields[i]);
    free(state->fields);
    free(state->snake);
}
