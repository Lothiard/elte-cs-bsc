#include <stdio.h>

char substitute(char c, int shift) {
    // TODO: implementáld!

    return c + shift;
}

int main() {
    int shift;
    printf("Eltolas merteke: ");
    scanf("%d", &shift);

    // TODO: implementáld!
    char input;
    int i = 0;
    char jelszo[100]; 
    while((input = getchar()) != EOF && !(input == '.')) {
        jelszo[i] = substitute(input, shift);
        i++;
    }

    printf(jelszo);

    return 0;
}