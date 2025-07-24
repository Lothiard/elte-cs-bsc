#include <stdio.h>

void szorzotabla() {
    for(int i = 1; i <= 10; i++) {
        for (int j = 1; j <= 10; j++) {
            printf("%d\t", i * j);
        }
        printf("\n");
    }
}

int main() {
    szorzotabla();
}
