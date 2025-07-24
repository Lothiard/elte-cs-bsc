#include <stdio.h>

/*
 * enums introduce named constants
 * underlying type is some unspecified integer type
 *
 * not type safe, just as with typedef
 * free to convert to/from int
 */

enum color {
    Red,
    Green,
    Blue, /* trailing comma optional */
};

enum serial {
    TxReady = (1 << 0),
    RxReady = (1 << 1),
    RxBufOverflow = (1 << 2)
};

void color_test() {
    /* by default, values start at 0, increase by 1 */
    printf("red=%d\tgreen=%d\tblue=%d\n", Red, Green, Blue);

    /* similarly to struct, 'enum' keyword is required */
    enum color c = Blue;

    c = 42; /* not an error */
    c++;    /* similarly */

    printf("c = %d\n", c);
}

enum weekday { Mon = 1, Tue, Wed, Thur, Fri,
               Sat = 100, Sun };

void weekday_test() {
    /*
     * if explicit value given, numbering starts there
     *
     * multiple names can belong to the same value
     */

    printf("Sat=%d\tSun=%d\n", Sat, Sun); /*100 101 */
}

enum role {
    Student,
    Teacher,
    Professor = Teacher, /* alias */
    Admin,
    Blue,
    roleCount
};

void role_test() {
    char const* roles[] = { "student", "teacher", "admin" };

    /*
     * idiom: add extra "count" member for iterating values
     * no reflection in C :(
     * does not handle "holes" correctly
     */
    for (int i = 0; i < roleCount; ++i)
        printf("%d = %s\n", i, roles[i]);
}

int main() {
    color_test();
    weekday_test();
    role_test();

    enum weekday day = Professor;

    return 0;
}