#include <stdio.h>
#include <stdbool.h>

void k() {
    // 1
    printf("%d\n", sizeof(int));
    printf("%d\n", sizeof(long int));
    printf("%d\n", sizeof(unsigned int));
    printf("%d\n", sizeof(unsigned long int));
    printf("%d\n", sizeof(char));
    printf("%d\n", sizeof(_Bool));
    printf("%d\n", sizeof(float));
    printf("%d\n", sizeof(double));
    printf("%d\n\n", sizeof(long double));

    int a = 10;
    long long b = 20;
    printf("%d\n", sizeof(a + b)); // mindig a nagyobb lesz

    // 2
    int c = 1;
    int d = 2;
    int e = 3;

    if(c < d < e) {
        printf("Igaz\n\n");
    }

    // 3
    for(int i = 10; i > 0; i--) {
        printf("%d ", i);
    } 
    printf("\n");

    
    for(unsigned int j = 10; j > 0; j--) {
        printf("%u ", j);
    }
    printf("\n\n");

    // 4.1
    int input;
    scanf("%d", &input);

    if(input % 4 == 0 && input % 100 != 0) {
        printf("szokoev\n\n");
    } else {
        printf("nem szokoev\n");
    }

    // 4.2 (if nelkul)
    int input2;
    scanf("%d", &input2);

    bool van = false;
    while(input2 % 4 == 0 && input2 % 100 != 0) {
        printf("szokoev\n\n");
        van = true;
        break;
    }

    while(!van) {
        printf("nem szokoev\n\n");
        break;
    }

    // nem while kellett volna hanem
    // res = ((input2 % 4 == 0) && (input2 % 100 != 0)) || (input2 % 400 == 0)
    // vagy
    // input2 == ((input2 % 4 == 0) && (input2 % 100 != 0)) || (input2 % 400 == 0) ? "szokoev\n\n" : "nem szokoev\n\n"
}

// elso legkisebb valodi oszto
int divisor(int num) {
    for(int i = 2; i < num; i++) {
        if(!(num % i)) {

            return i;
        }
    }

    return num;
}

int main() {
    k();
    // printf("%d\n\n", divisor(43));
    return 0;
}
