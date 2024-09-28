#include <stdio.h>
#include <stdbool.h>
#include <time.h>
#include <stdlib.h>

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

int nehezsegKiszamolo(int nehezseg) {
    if(nehezseg == 1) {
        return 10;
    } else if (nehezseg == 2) {
        return 100;
    } else if (nehezseg == 3) {
        return 10000;
    }
    return 0;
}

void o() {
    int guess;
    int probak = 1;
    int nehezseg;
    int nehezsegSzorzo;
    int num;
    // string dicseretek[3] = ["nagyon profi vagy", "nem rossz", "jo bena volt nem rosszbol"]; sajnos egy ilyen elavult fos nyelvben nincs string

    printf("koszontelek a guessing jatekban! Eloszor valaszd ki a nehezseget\n1 - konnyu\n2 - kozepes\n3 - nehez\n\n");

    bool helyesNehezseg = false;
    while(!helyesNehezseg) {
        scanf("%d", &nehezseg);
        nehezsegSzorzo = nehezsegKiszamolo(nehezseg);
        if(!nehezsegSzorzo) {
            printf("nem jo (1-3)\n");
        } else {
            num = rand() % nehezsegSzorzo;
            helyesNehezseg = true;
        }
    }

    printf("Talald ki melyik szamra gondoltam\n");

    bool helyesTipp = false;
    while(!helyesTipp) {
        scanf("%d", &guess);
        
        // igy irja egy normalis ember
        if(guess == num) {
            printf("helyesTipp, %d probalkozasbol sikerult. ", probak);
            helyesTipp = true;

            if(probak < 5) {
                printf("nagyon profi vagy\n\n");
            } else if (probak < 10) {
                printf("nem rossz\n\n");
            } else {
                printf("jo bena volt nem rosszbol\n\n");
            }
        } else {
            printf("helytelen, ");
            ++probak;

            if(guess > num) {
                printf("tul nagy a tipp\n");
            } else {
                printf("tul kicsi a tipp\n");
            }
        }

        // igy irja az akit megvertek kiskoraban minden nap
        /*
        (guess == num) ? (
            (printf("helyesTipp\n\n"), helyesTipp = true)
        ) : (
            printf("helytelen, "),
            (guess > num) ? (
                printf("tul nagy a tipp\n")
            ) : (
                printf("tul kicsi a tipp\n")
            )
        );
        */
    }
}


int main() {
    srand(time(NULL));
    // k();
    // printf("%d\n\n", divisor(43));
    // o();
    return 0;
}
