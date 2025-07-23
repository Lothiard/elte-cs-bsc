#include "exam.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Exam* create_exam(char *subject, int duration, enum type exam_type) {
    struct Exam *exam = (struct Exam *)malloc(sizeof(struct Exam));

    exam->duration = duration;
    exam->type = exam_type;
    strcpy(exam->subject, subject);
    return exam;
}