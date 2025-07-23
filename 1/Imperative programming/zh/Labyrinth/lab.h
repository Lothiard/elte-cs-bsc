#ifndef LAB_H
#define LAB_H

typedef struct {
    int rows;
    int cols;
    char** board; 
} Lab;

void create_labyrinth(Lab* lab);
void print_board(const Lab* lab);
void save_labyrinth(const Lab* lab);
void load_labyrinth(Lab* lab);
void play_labyrinth(Lab* lab);

#endif
