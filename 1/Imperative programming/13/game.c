#include "game.h"
// #include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void init_field(char *fields, int rows, int cols) {
    // memset(fields, ' ', rows * cols);
    for(int i = 0; i < rows * cols; ++i) {
        fields[i] = ' ';
    }

    int placed = 0;
    while (placed < APPLE_COUNT) {
        int index = rand() % (rows * cols);
        if(fields[index] == ' ') {
            fields[index] = 'A';
            ++placed;
        }
    }
}

void init_snake(Point snake[INITIAL_SNAKE_LENGTH]) {
    for(int i = 0; i < INITIAL_SNAKE_LENGTH; ++i) {
        snake[i].x = 0;
        snake[i].y = INITIAL_SNAKE_LENGTH - i - 1;
    }
}

State init_game(int rows, int cols) {
    State state;

    state.rows = rows;
    state.cols = cols;
    char *fields = malloc(rows * cols);
    state.fields = fields;
    init_field(fields, rows, cols);

    Point *snake = malloc(INITIAL_SNAKE_LENGTH * sizeof(Point));
    state.snake = snake;
    init_snake(snake);

    state.snake_length = INITIAL_SNAKE_LENGTH;

    return state;
}

void print_border(int cnt) {
    for(int i = 0; i < State->cols + 2; ++i) {
        putchar('#');
    }

    for(int i = 0; i < State->rows; ++i) {
        putchar('#');
        for(int j = 0; j < State->cols; ++j) {
            putchar(display[i * State->cols + j]);
        }
        putchar('#');
        putchar('\n');
    }
}

void print_game(Point *state) {
    char *display = malloc(state->rows * state->cols);

    for(int i = 0; i < state->rows * state->cols; ++i) {
        display[i] = state->fields[i];
    }

    Point head = state->snake[0];
    display->fields[head.x * state->cols + head.y] = '8';

    for(int i = 0; i < state->snake_length; ++i) {
        Point segment = state->snake[i];
        display->fields[segment.x * state->cols + segment.y] = '0';
    }

    print_border(state->cols + 2)

    free(display);
}

int update_snake(State *state, char direction) {
    Point head = state->snake[0];

    switch(direction) {
        case 'w':
            --head.x;
            break;
        case 's':
            ++head.x;
            break;
        case 'a':
            --head.y;
            break;
        case 'd':
            ++head.y;
            break;

        if(head.x < 0 || head.y < 0) {
            return -1;
        } else if(head.x >= state->rows || head.y >= state->cols) {
            return -1;
        } 
        for(int i = 1; i < state->snake_length; ++i) {
            if(head.x == state->snake[i].x && head.y == state->snake[i].y) {
                return -2;
            }
        }
        if(/*state->fields[head.x * state->cols + head.y] == ' '*/) {
            for(int i = state->snake_length - 1; i > 1; --i) {
                state->snake[i] = state->snake[i - 1];
            }

            state->snake[0] = head;

            return 0;
        } else {
            Point *snake = malloc((state->snake_length + 1) * sizeof(Point));
            snake[0] = head;
            for(int i = 0; i < state->snake_length; ++i) {
                snake[i + 1] = state->snake[i];
            }

            state->snake_length++;
            free(state->snake);
            state->snake = snake;

            return 1;
        }
    }

    if(state->fields[new_head.x * state->cols + new_head.y] == 'A') {
        state->snake_length++;
    }

    for(int i = state->snake_length - 1; i > 0; --i) {
        state->snake[i] = state->snake[i - 1];
    }

    state->snake[0] = new_head;
}
