#include "box.h"
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

static struct Box *top;

void initialize(void) {
    top = NULL;
}

int is_empty(void) {
    return top == NULL;
}

int peek(void) {
    if (is_empty()) {
        fprintf(stderr, "anyad picsajat\n");
        return -1;
    }
    return top->weight;
}

void push(int weight) {
    struct Box *new_box = malloc(sizeof(struct Box));
    new_box->weight = weight;
    new_box->next = top;
    top = new_box;
}

void pop(void) {
    if (is_empty()) {
        fprintf(stderr, "anyad picsajat\n");
        return;
    }
    struct Box *temp = top;
    top = top->next;
    free(temp);
}

void copy_top(void) {
    if (is_empty()) {
        fprintf(stderr, "anyad picsajat\n");
        return;
    }
    struct Box *new_box = malloc(sizeof(struct Box));
    new_box->weight = top->weight;
    new_box->next = top->next;
    top->next = new_box;
}
