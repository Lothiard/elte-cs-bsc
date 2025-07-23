#ifndef GAME_H
#define GAME_H

#define APPLE_COUNT 10
#define INITIAL_SNAKE_LENGTH 9

typedef enum {
    UPDATE_COLLIDED_WITH_SELF = -2,
    UPDATE_COLLIDED_WITH_WALL = -1,
    UPDATE_NONE = 0,
    UPDATE_COLLECTED_APPLE = 1,
} UpdateResult;

typedef struct {
    int x, y;
} Point;

typedef struct {
    int rows, cols;
    char **fields;
    Point *snake;
    int snake_length;
} State;

UpdateResult update_snake(State *state, char direction);

State init_game(int rows, int cols);
void print_game(State *state);
void free_game(State *state);

#endif
