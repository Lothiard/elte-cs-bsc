#include <stdlib.h>
#include <time.h>
#include <stdio.h>

#define STUD_CNT 17

void init_students(int *id, double *avg, int count) {
    for (int i = 0; i < count; ++i) {
        id[i] = rand();

        /* 
         * trick: generate num between 1 and 5
         * with increments of 0.1
         *
         * 1.0, 1.1, ..., 5.0 -> 41 values
         */
        avg[i] = 1.0 + (rand() % 41) / 10.0;
    }
}

int main() {
    int id[STUD_CNT];
    double avg[STUD_CNT];

    srand(time(NULL));

    init_students(id, avg, STUD_CNT);

    for (int i = 0; i < STUD_CNT; ++i) {
        printf("{ %d : %f }\n", id[i], avg[i]);
    }
}