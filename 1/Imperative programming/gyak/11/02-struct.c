/*
 * structs (record types, product types [why?]) group
 * together related data (of possibly different types)
 * into a single composite type.
 *
 * they contain: fields == members
 */

struct rectangle {
    int width;
    int height;
}; /* note the ending semicolon! */

void this_has_no_effect(struct rectangle);

void create_rect() {
    /* the struct keyword is required */
    struct rectangle rect;

    /* member access with the dot (.) operator */
    rect.width = 16;
    rect.height = 9;

    this_has_no_effect(rect);

    struct rectangle *rp = &rect;
    (*rp).width = 21;
    /* equivalent, preferred shorthand form */
    rp->width = 10;

    /* aggregate initialization, in field order */
    struct rectangle rect2 = { 16, 9 };

    /* C99: "designated initializers" */
    struct rectangle rect3 = { .height = 9, .width = 16 };
}

/* structs are passed by value */
void this_has_no_effect(struct rectangle rect) {
    /* we can perform operations on fields just like variables */
    rect.width *= 2;
}

/* structs cannot contain themselves (size?) */
struct person {
    char name[20];
    int age;
    struct person *mom, *dad;
};

/* common idiom: introduce typedef name to avoid 'struct' */
typedef struct payment {
    int sender;
    int recipient;
    double amount;
} payment_t;

void process(payment_t p);

/* like with functions: names are only seen once the
   definition is processed -> forward declaration! */

struct course;

struct student {
    char name[20];
    struct course *classes[10];
};

struct course {
    char name[20];
    struct student *students[20];
};

/* we have seen this before (/usr/include/bits/FILE.h) */
/*
    struct _IO_FILE;
    typedef struct _IO_FILE FILE;
*/

/* C++ classes */