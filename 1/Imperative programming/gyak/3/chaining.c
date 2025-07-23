#include <stdio.h>

int main() {
    int a = 1, b = 2, c = 3;

    /*
     * Pythonban: a < b < c is mukodik; itt igy van ertelmezve:
     * (a < b) < c
     * ahol (a < b) az osszehasonlitas eredmenye; 0 vagy 1
     */
    if (c > b && b > a)
        printf("nagyon jo");
}
