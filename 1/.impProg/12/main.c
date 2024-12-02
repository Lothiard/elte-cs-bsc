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

    int age = 59;
    Person p1 = {"Lajos", &age};
    Person p2 = p1;

    printf("%s %d\n", p2.name, *p2.age);

    return 0;
}