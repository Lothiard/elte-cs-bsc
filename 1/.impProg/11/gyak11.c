#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define STUD_CNT 10

typedef struct student{
    int id;
    double avg;
    short age;
} Student;

void init(Student *students) {
    for(int i = 0; i < STUD_CNT; ++i) {
        students[i].id = i + 1;

        double avgtemp = rand() % 41 + 10;
        students[i].avg = avgtemp / STUD_CNT;

        students[i].age = rand() % 85 + 16;

        printf("id: %d,\tavg: %.1f,\tage: %d\n", students[i].id, students[i].avg, students[i].age);
    }
}

Student *student_init(int *id, double *avg, short *age) {
    Student *s = malloc(sizeof(Student));

    s->id = *id;
    s->avg = *avg;
    s->age = *age;

    return s;
}

void student_print(int *id, double *avg, short *age) {
    printf("id: %d,\tavg: %.1f,\tage: %d\n", *id, *avg, *age);   
}

double student_search(Student *students) {
    double max = students[0].avg;
    for(int i = 1; i < STUD_CNT; ++i) {
        if(students[i].avg > max) {
            max = students[i].avg;
        }
    }

    return max;
}

int main() {
    srand(time(NULL));

    Student students[STUD_CNT];
    init(students);

    int s_id = 11; double s_avg = 20.5; short s_age = 20;
    Student *s = student_init(&s_id, &s_avg, &s_age);
    free(s);

    student_print(&s_id, &s_avg, &s_age);

    printf("%f.1", student_search(students));

    return 0;
}