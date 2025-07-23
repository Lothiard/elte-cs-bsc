#include <stdio.h>

// 1
int global;
global = 1;

// 2 
void fv() {
    static int local = 2;

    // 3
    if(local == 2) {
        local = 3;
        printf("local = %d\n", local);
    } else {
        printf("local = %d\n", local);
    }
}

int main() {
    printf("global = %d\n", global);
    fv();

    return 0;
}