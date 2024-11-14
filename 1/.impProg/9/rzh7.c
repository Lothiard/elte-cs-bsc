#include <stdio.h>
#include "header.h"

int main() {
    puts("0 - osszeadas\n1 - szorzas");
    for (;;) {
        int op;
        scanf("%d", &op);

        if (op == 0) {
            int a, b;
            scanf("%d %d", &a, &b);
            printf("%d\n", add(a, b)); /* implement this function */
        } else if (op == 1) {
            int a, b;
            scanf("%d %d", &a, &b);
            printf("%d\n", mul(a, b)); /* implement this function */
        } else {
            break;
        }
    }
    return 0;
}