/*
 * optional demo: how we can work around
 * the lack of reflection on enum members
 *
 * https://en.wikipedia.org/wiki/X_macro
 */

/* run with -E to see what this ends up generating */

#define WEEKDAY_NAMES \
    X(Monday)         \
    X(Tuesday)        \
    X(Wednesday)      \
    X(Thursday)       \
    X(Friday)         \
    X(Saturday)       \
    X(Sunday)

typedef enum {
    #define X(name) name,
    WEEKDAY_NAMES
    #undef X
} weekday;

char const *name_of_day(weekday day) {
    #define X(name) if (day == name) return #name;
    WEEKDAY_NAMES
    #undef X

    return "?";
}