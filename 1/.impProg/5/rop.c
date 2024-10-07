#include <stdio.h>

char substitute(char c, int shift) {
    // TODO: implementáld!
    if(c >= 'a' && c <= 'z') {
        return 'a' + ((c - 'a' + shift) % 26);
    }
    if(c >= 'A' && c <= 'Z') {
        return 'A' + ((c - 'A' + shift) % 26);
    }
    return c;
}

int main() {
    int shift;
    printf("Eltolas merteke: ");
    scanf("%d", &shift);

    // TODO: implementáld! 
    char input;
    while((input = getchar()) != EOF && !(input == '.')) {
        printf("%c", substitute(input, shift));
    }

    return 0;
}