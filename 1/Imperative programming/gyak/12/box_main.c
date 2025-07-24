#include <stdio.h>
#include "box.h"

int main() {
    initialize();

    push(1);
    push(2);
    push(3);
    copy_top();
    pop();
    copy_top();

    while (!is_empty()) {
        printf("%d\n", peek());
        pop();
    }
}