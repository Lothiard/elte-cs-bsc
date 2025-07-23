#include <stdio.h>
#include <stdlib.h>

void hex_to_dec() {
    char hex[100];
    while (scanf("%s", hex) != EOF) {
        long decimal = strtol(hex, NULL, 16);
        printf("%ld\n", decimal);
    }
}

void fill_multiplication_table(int n, int matrix[n][n]) {
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            matrix[i-1][j-1] = i * j;
        }
    }
}

int main() {
    hex_to_dec();
    fill_multiplication_table;
    return 0;
}