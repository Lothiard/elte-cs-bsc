#include "exam.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    struct Exam *exam = create_exam("Imperativ", 180, Written);

    printf("Subject: %s\tduration: %d\ttype: %s\n", exam->subject, exam->duration, exam->type == Written ? "written" : "oral");

    free(exam);
    return 0;
}