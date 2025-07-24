#include <stdio.h>

/*
 * union a.k.a. sum type
 */
typedef union {
    int i;
    float f;
} IntOrFloat;

/* 
 * common use case: tagged union
 *
 * the language does not keep track of the active member
 * (c.f. Rust enums), so we need to add a 'tag' enum ourselves
 */
typedef struct {
    enum { Number, Text } kind;
    union {
        long long num;
        char const* text;
    }; /* unnamed -> directly access members */
} NumberOrText;

int main() {
    IntOrFloat x;

    /* 
     * i and f occupy the same memory,
     * setting one overwrites the other
     *
     * not type conversion, it's *reinterpreting*
     * the bytes as a different type
    */

    x.i = 42;
    printf("i = %d\tf = %f\n", x.i, x.f);

    x.f = 1.0;
    printf("i = %d\tf = %f\n", x.i, x.f);

    /* C99 designated initializers */
    NumberOrText v = { .kind = Text, .text = "Hello World" };

    /* setting values the classic style */
    v.kind = Number;
    v.num = 1337;

    return 0;
}