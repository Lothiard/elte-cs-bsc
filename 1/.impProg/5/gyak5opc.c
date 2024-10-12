#include <stdio.h>
#include <string.h>
#include <ctype.h>

void f1() {
    int arr[5] = {1, 2, 4, 5, 3};

    printf("eredeti: ");
    for(int i = 0; i < 5; ++i) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    int min = arr[0];
    int max = arr[0];
    int mini, maxi;

    for(int i = 0; i < 5; ++i) {
        if(arr[i] < min) {
            min = arr[i];
            mini = i;
        }

        if(arr[i] > max) {
            max = arr[i];
            maxi = i;
        }
    }

    int temp = arr[mini];
    arr[mini] = arr[maxi];
    arr[maxi] = temp;
    
    printf("cserelt: ");
    for(int i = 0; i < 5; ++i) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

void f2() {
    char str[1000];
    int sorok = 0;

    while (1) {
        fgets(str, sizeof(str), stdin);  // Egy sor beolvasása

        // Ha a felhasználó csak egy Entert üt, azaz üres sor érkezik (csak '\n'), kilép a ciklusból
        if (strcmp(str, "\n") == 0) {
            break;
        }

        // Minden új sor után növeli a sorok számát
        sorok++;
    }

    printf("%d\n", sorok);
}

void f3() {
    char str[100];
    int maganhangzok = 0, massalhangzok = 0;

    printf("Adj meg egy szót: ");
    scanf("%s", str);

    for (int i = 0; str[i] != '\0'; i++) {
        char ch = tolower(str[i]);

        if (isalpha(ch)) {
            if (ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u') {
                maganhangzok++;
            } 
            else {
                massalhangzok++;
            }
        }
    }

    printf("maganhangzok: %d\n", maganhangzok);
    printf("massalhangzok: %d\n", massalhangzok);
}

int main () {
    // f1();
    // f2();
    f3();
}
