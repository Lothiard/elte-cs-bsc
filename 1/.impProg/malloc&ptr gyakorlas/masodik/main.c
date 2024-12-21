// masodik: dinamikus beolvasas filebol structba
#include "people.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    if(argc < 2) {
        fprintf(stderr, "Usage: %s <filename>", argv[0]);
        return 1;
    }

    FILE *fp = fopen(argv[1], "r");
    Person *people = NULL;
    int count = 0;
    
    init(fp, &people, &count);

    for(int i = 0; i < count; ++i) {
        printf("Name: %s, age: %d\n", people[i].name, people[i].age);
    }
    free(people);

    fclose(fp);
}