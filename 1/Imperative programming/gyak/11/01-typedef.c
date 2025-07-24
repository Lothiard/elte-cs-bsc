#include <stddef.h> /* for NULL */
#include <math.h>   /* for pow */

/* 
 * type alias (hu: szinonima) which does not create
 * a new type, only a name which can be more informative
 * to the programmer
 */

/* aliased type is a primitive */
typedef int length;
typedef float weight;

/* aliased type is a pointer */
typedef int* intptr;

/* aliased type is an array */
typedef char neptun_code[7];

/* aliased type is a function pointer */
typedef double (*math_fn)(double, double);

int main() {
    /* Not a new type - conversion is possible */
    int x = 5;
    length len = x;

    weight wei = 3.14;
    double bar = wei;
    
    /* do these work? */
    weight res1 = len * wei;
    length res2 = len * wei;

    intptr p = NULL;

    neptun_code me = "QO5KUI";

    /*
     * NOTE: if you get undefined reference to 'pow',
     *       add -lm to the gcc command line.
     */
    math_fn fn = pow;

    return 0;
}