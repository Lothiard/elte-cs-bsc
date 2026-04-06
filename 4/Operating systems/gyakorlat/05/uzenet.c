#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <sys/types.h>
#include <unistd.h>

struct uzenet {
    long mtype; // ez egy szabadon hasznalhato ertek, pl uzenetek osztalyozasara
    char mtext[1024];
};

// sendig a message
int kuld(int uzenetsor, long mtype, char* mtext) {
    struct uzenet uz = {mtype};
    strcpy(uz.mtext, mtext);

    int status;

    status = msgsnd(uzenetsor, &uz, strlen(uz.mtext) + 1, 0);
    // a 3. param ilyen is lehet: sizeof(uz.mtext)
    // a 4. parameter gyakran IPC_NOWAIT, ez a 0-val azonos
    if (status < 0) perror("msgsnd");
    return 0;
}

// receiving a message.
int fogad(int uzenetsor, long mtype) {
    struct uzenet uz;
    int status;
    // az utolso parameter(0) az uzenet azonositoszama
    // ha az 0, akkor a sor elso uzenetet vesszuk ki
    // ha >0 (5), akkor az 5-os uzenetekbol a kovetkezot
    // vesszuk ki a sorbol
    status = msgrcv(uzenetsor, &uz, 1024, mtype, 0);

    if (status < 0) perror("msgsnd");
    else
        printf("A kapott uzenet kodja: %ld, szovege:  %s\n", uz.mtype,
               uz.mtext);
    return 0;
}

int main(int argc, char* argv[]) {
    pid_t child;
    int uzenetsor, status;
    key_t kulcs;

    // msgget needs a key, amelyet az ftok generál
    //.
    kulcs = ftok(argv[0], 1);
    printf("A kulcs: %d\n", kulcs);
    uzenetsor = msgget(kulcs, 0600 | IPC_CREAT);
    if (uzenetsor < 0) {
        perror("msgget");
        return 1;
    }

    child = fork();
    if (child > 0) {
        kuld(uzenetsor, 10, "Hajra Ujpest!"); // Parent sends a message.
        wait(NULL);
        // After terminating child process, the message queue is deleted.
        fogad(uzenetsor, 12);
        status = msgctl(uzenetsor, IPC_RMID, NULL);
        if (status < 0) perror("msgctl");

        return 0;
    } else if (child == 0) {
        fogad(uzenetsor, 10);
        kuld(uzenetsor, 12, "Hajra Fradi!");
        // The child process receives a message.
    } else {
        perror("fork");
        return 1;
    }

    return 0;
}
