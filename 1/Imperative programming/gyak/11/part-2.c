#include <stdlib.h>
#include <time.h>
#include <stdio.h>

#define STUD_CNT 17

typedef struct student {
    int id;
    double avg;
    short age;
} Student;

void init_students(Student *students, int count) {
    for (int i = 0; i < count; ++i) {
        students[i].id = rand();

        /* 
         * trick: generate num between 1 and 5
         * with increments of 0.1
         *
         * 1.0, 1.1, ..., 5.0 -> 41 values
         */
        students[i].avg = 1.0 + (rand() % 41) / 10.0;

        /* age[i] \in {16, 17, ..., 100} */
        students[i].age = 16 + (rand() % 85);
    }
}

int main() {
    struct student students[STUD_CNT];

    srand(time(NULL));

    init_students(students, STUD_CNT);
}