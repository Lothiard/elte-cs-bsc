#ifndef EXAM_H
#define EXAM_H

enum type {
    Written,
    Oral
};

struct Exam {
    char subject[20];
    int duration;
    enum type type;
};

struct Exam* create_exam(char *subject, int duration, enum type exam_type);

#endif