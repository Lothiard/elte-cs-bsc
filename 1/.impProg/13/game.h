#ifndef GAME_H
#define GAME_H

#define APPLE_COUNT 10
#define INITIAL_SNAKE_LENGTH 9

typedef struct {
    int x, y;
} Point;

typedef struct {
    int rows, cols;
    char *fields;
    Point *snake;
    int snake_length;
} State;

void init_field(char *fields, int rows, int cols);
void init_snake(Point snake[INITIAL_SNAKE_LENGTH]);
void print_game(State *state);
void print_border(int cnt);

State init_game(int rows, int cols);

int updtate_game(State *state, char direction);

#endif 
