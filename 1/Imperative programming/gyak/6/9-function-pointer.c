
#include <stdio.h>

/* What does this signature mean? */
void fun(int a) {
    printf("Value of a is %d\n", a);
}

int main() {
    /* Defines fun_ptr as a function pointer
       pointing to fun(). */
    void (*fun_ptr)(int) = &fun;

    /*
     * How would you write a pointer to this?
     *    double foo(int, void*);
     */

    /* Useful tool: https://cdecl.org/ */

    /* Invoke a function through a pointer */
    (*fun_ptr)(10);

    return 0;
}

/* https://cdecl.org/?q=void+%28*fun_ptr%29%28int%29 */
