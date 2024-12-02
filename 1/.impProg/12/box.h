#ifndef GYAK12_H
#define GYAK12_H

struct Box {
    int weight;
    struct Box *next;
};

void initialize(void);
int is_empty(void);
int peek(void);
void push(int weight);
void pop(void);
void copy_top(void);

typedef struct Person {
    char name[30];
    int *age;
} Person;

#endif