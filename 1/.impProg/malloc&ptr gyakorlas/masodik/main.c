// masodik: dinamikus beolvasas filebol structba
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char name[50];
    int age;
} Person;

int main(int argc, char *argv[]) {
    if(argc < 2) {
        fprintf(stderr, "Usage: %s <filename>", argv[0]);
        return 1;
    }

    FILE *fp = fopen(argv[1], "r");
    
    Person *people = NULL;
    char buf[1024];
    int count = 0;

    while(fgets(buf, sizeof(buf), fp)) {
        people = realloc(people, (count + 1) * sizeof(Person));

        char currName[50];
        int currAge;
        sscanf(buf, "%s %d", currName, &currAge);

        strcpy(people[count].name, currName);
        people[count].age = currAge;

        ++count;
    }

    for(int i = 0; i < count; ++i) {
        printf("Name: %s, age: %d\n", people[i].name, people[i].age);
    }
    free(people);

    fclose(fp);
}