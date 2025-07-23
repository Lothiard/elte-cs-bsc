#include <stdio.h>

int main() {
    int input1, input2;
    printf("Adj meg 2 szamot: \n");
    scanf("%d %d", &input1, &input2);

    if(input1 < input2) {
        for(int i = ++input1; i < input2; i++) {
            printf("%d", i);
            printf("\n");
        }
    } else {
        for(int i = ++input2; i < input1; i++) {
            printf("%d", i);
            printf("\n");
        }
    }

    return 0;
}