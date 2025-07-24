#include <stdio.h>

void print(int b, int a) {
    printf("a = %d\tb = %d\n", a, b);

    /* 
       redefinition -- think of formal parameters
       as variables defined inside the function body
    */
}

int main() {
    int a = 1;
    int b = 2;

    /* NOT pass by name - in 'print':
       b == 2 && a == 1 */
    print(a, b);

    return 0;
}