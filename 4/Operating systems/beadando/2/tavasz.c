#include "bor.h"
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

int ready_count = 0;
int done_count = 0;

void handler_kesz(int signumber) {
    printf("%i. biztos keszenall!\n", ready_count + 1);
    ready_count++;
}
void handler_vegzett(int signumber) {
    printf("%i. biztos vegzett!\n", done_count + 1);
    done_count++;
}

void tavaszi_munkak(BorData* db) {
    int pipe_destroy[2];
    int pipe_defend[2];

    if (pipe(pipe_destroy) == -1 || pipe(pipe_defend) == -1) {
        perror("Cső hiba");
        return;
    }

    signal(SIGUSR1, handler_kesz);
    signal(SIGUSR2, handler_vegzett);

    ready_count = 0;
    done_count = 0;

    pid_t child1 = fork();
    if (child1 == 0) {
        close(pipe_destroy[1]);
        close(pipe_defend[0]);
        close(pipe_defend[1]);

        kill(getppid(), SIGUSR1);

        BorRow row;
        int amount;
        while (read(pipe_destroy[0], &row, sizeof(BorRow)) > 0) {
            printf("Tisztelt %s hegyközség, %s, %s tábla főmérnöke! Az "
                   "országos "
                   "hegybíró utasítására azonnal kérem megsemmisíteni a "
                   "táblát.\n",
                   row.winery_name, row.field_name, row.grape_type);
        }
        close(pipe_destroy[0]);
        kill(getppid(), SIGUSR2);
        exit(0);
    }

    pid_t child2 = fork();
    if (child2 == 0) {
        close(pipe_defend[1]);
        close(pipe_destroy[0]);
        close(pipe_destroy[1]);

        kill(getppid(), SIGUSR1);

        BorRow row;
        int amount;
        while (read(pipe_defend[0], &row, sizeof(BorRow)) > 0) {
            printf("Tisztelt %s, %s tábla főmérnöke! Indul a tavaszi nagy "
                   "országos védekezés, ne indítsanak permetezést.\n",
                   row.winery_name, row.field_name);
        }
        close(pipe_defend[0]);
        kill(getppid(), SIGUSR2);
        exit(0);
    }

    // parent
    close(pipe_destroy[0]);
    close(pipe_defend[0]);

    while (ready_count < 2) { sleep(1); }

    for (int i = 0; i < db->count; i++) {
        if (db->rows[i].loss >= 30) {
            write(pipe_destroy[1], &db->rows[i], sizeof(BorRow));
        } else {
            write(pipe_defend[1], &db->rows[i], sizeof(BorRow));
        }
    }

    close(pipe_destroy[1]);
    close(pipe_defend[1]);

    while (done_count < 2) { sleep(1); }

    printf("\nJelentés a miniszternek: A munkálatok befejeződtek.\n");
    wait(NULL);
    wait(NULL);

    int count = 0;
    for (int i = 0; i < db->count; i++) {
        if (db->rows[i].loss < 30) {
            db->rows[count] = db->rows[i];
            count++;
        }
    }

    if (count < db->count) {
        db->count = count;
        bor_save(db);
    }
}
