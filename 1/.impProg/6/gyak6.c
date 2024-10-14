#include <stdio.h>

void f1() {
    int egy = 1;
    int* ptr = &egy;
    *ptr = 2;

    printf("%d\n", egy);
}

void f2() {
    int i = 1;
    int j = 2;

    int *ptr = &i;
    int **pptr = &ptr;
    int ***ppptr = &pptr;
    
    ptr = &j;

    printf("%d\n", ***ppptr);
}

void f3() {
    int *ptr = &ptr;
}

int osszeg(int *array, int size) {
    int sum = 0;
    int *end = array + size;  // A tömb végére mutató mutató

    // Végigmegyünk a tömbön pointer aritmetikával
    for (int *ptr = array; ptr < end; ++ptr) {
        sum += *ptr;  // A ptr által mutatott elem hozzáadása az összeghez
    }

    return sum;
}

void f4() {
    int i = 1;
    int *ptr = &i;
    int hossz = 5;


}

int main() {
    //f1();
    //f2();
    //f3();
    f4();
}