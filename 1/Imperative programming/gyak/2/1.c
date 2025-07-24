#include <stdio.h>

void k1_2() {
    int szam;
    szam = 42;
    
    if(szam % 2) {
        printf("a %d szam ", szam);
        printf("paratlan\n");
    } else {
        printf("a %d szam ", szam);
        printf("paros\n");
    }
}

void k3() {
    int input;
    do {
        scanf("%d", &input);
    } while (input % 2 == 0);
}

void k5() {
    int x, y;
    scanf("%d %d", &x, &y);
    float avg = ((float)x + (float)y) / 2.0;
    printf("%f", avg);
}

void o1() {
    int i;
    scanf("%d", &i);

    if(i > 0) {
        printf("A szam pozitiv\n");        
    } else if (i < 0) {
        printf("A szam negativ\n");        
    } else {
        printf("A szam nulla\n");        
    }
}

void o2() {
    for(int i = -20; i <= 200; i += 10) {
        printf("Farenheit: %f\n", (i - 32) / 1.8);
        printf("Celsius: %d\n\n", i);
    }
}

void o3() {
    printf("Hello\nworld\n");
}

void o5() {
    int input;
    scanf("%d", &input);

    int i = input;
    while(i > 0) {
        if(input % i == 0) {
            printf("%d, ", i);
        }
        i--;
    } 
}

int main() {
    /*
    k1_2();
    k3();
    
    k5();

    o1();
    o2();
    o3();

    o5();
    */

    o2();

    return 0;
}
