#include <stdio.h>

int main() {
    for (int i = 0; i-- <= 10; i += 2) {
        printf("%d\n", i);
    }

    // Mi történne, ha --i -t írnánk?

    return 0;
}