#include <stdio.h>
#include <ctype.h>

char to_lower(char ch) {
    if('A' <= ch && ch <= 'Z') {
        return ch + ('a' - 'A');
    }
    return ch;
}

char to_upper(char ch) {
    if('a' <= ch && ch <= 'z') {
        return ch + ('A' - 'a');
    }
    return ch;
}

void caseconvert() {
    int input;

    while((input = getchar()) != EOF) {
        if(isupper(input))
            printf("%c", to_lower(input));
        else if(islower(input))
            printf("%c", to_upper(input));
        else 
            printf("%c", input);
    }
}

int main() {
    int x1, y1, x2, y2, x3, y3, x4, y4;

    printf("%d %d %d %d %d %d %d %d", x1, y1, x2, y2, x3, y3, x4, y4);
    int a1[2] = [x1, y1];
    int a2[2] = [x2, y2];    

    return 0;
}
