#ifndef CALC_H
#define CALC_H

typedef enum {
    left,
    left_plus,
    left_times,
    plus_right,
    times_right
} STATE;

STATE state = left;
unsigned int memory;
unsigned int input;

void digit(int n);
void plus();
void times();

#endif 