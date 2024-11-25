#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define STUD_CNT 10

struct student {
    int id;
    double avg;
    short age;
};

void init(struct student *students) {
    for(int i = 0; i < STUD_CNT; ++i) {
        students[i].id = i + 1;

        double avgtemp = rand() % 41 + 10;
        students[i].avg = avgtemp / STUD_CNT;

        students[i].age = rand() % 85 + 16;

        printf("id: %d,\tavg: %.1f,\tage: %d\n", students[i].id, students[i].avg, students[i].age);
    }
}

int main() {
    srand(time(NULL));
    struct student students[STUD_CNT];

    init(students);
    
    return 0;
}