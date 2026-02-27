#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h> //waitpid
#include <unistd.h>   //fork

int main() {
    int status;
    int notacommonvalue = 1;
    printf("The value is %i before forking \n", notacommonvalue);

    pid_t child1 = fork();
    if (child1 < 0) {
        perror("First fork failed");
        exit(1);
    }
    if (child1 == 0) {
        notacommonvalue = 5;
        printf("The value is %i in first child process (PID: %d)\n",
               notacommonvalue, getpid());
        exit(0);
    } else {
        pid_t child2 = fork();
        if (child2 < 0) {
            perror("Second fork failed");
            exit(1);
        }
        if (child2 == 0) {
            notacommonvalue = 10;
            printf("The value is %i in second child process (PID: %d)\n",
                   notacommonvalue, getpid());
            exit(0);
        } else {
            waitpid(child1, &status, 0);
            waitpid(child2, &status, 0);
            printf("The value is %i in parent process (PID: %d)\n",
                   notacommonvalue, getpid());
        }
    }
    return 0;
}
