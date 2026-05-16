#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

struct fuggveny_msg {
    long mtype;
    int mennyiseg;
};

int keszen_allnak = 0;
void handler(int sig) { ++keszen_allnak; }

int main(int argc, char* argv[]) {
    srand(time(NULL));
    key_t kulcs = ftok(*argv, 65);
    int msgQ = msgget(kulcs, 0600 | IPC_CREAT);

    int p_tutajos[2];
    int p_butyok[2];

    if (pipe(p_tutajos) == -1 || pipe(p_butyok) == -1) {
        perror("Cső hiba");
        return 1;
    }

    signal(SIGUSR1, handler);

    // Tutajos
    if (fork() == 0) {
        close(p_tutajos[0]);
        close(p_butyok[0]);
        close(p_butyok[1]);

        sleep(1);
        kill(getppid(), SIGUSR1);

        struct fuggveny_msg bejovo;
        msgrcv(msgQ, &bejovo, sizeof(int), 2, 0);
        printf("Tutajos: %d halat kell fognom!\n", bejovo.mennyiseg);

        int fogott = rand() % 2 + 1;
        printf("Tutajos: %d halat fogtam!\n", fogott);

        char valasz[1024] = "A csuka megfogott stop, segítség stop!";
        write(p_tutajos[1], valasz, strlen(valasz) + 1);

        close(p_tutajos[1]);
        exit(0);
    }

    // Butyok
    if (fork() == 0) {
        close(p_butyok[0]);
        close(p_tutajos[0]);
        close(p_tutajos[1]);

        sleep(1);
        kill(getppid(), SIGUSR1);

        struct fuggveny_msg bejovo;
        msgrcv(msgQ, &bejovo, sizeof(int), 1, 0);
        printf("Bütyök: %d koteg fat kell gyujtenem!\n", bejovo.mennyiseg);

        char valasz[1024] = "Vizes a fa!";
        write(p_butyok[1], valasz, strlen(valasz) + 1);

        close(p_butyok[1]);
        exit(0);
    }

    // Matula bacsi
    printf("Matula bacsi elkeszul\n");
    while (keszen_allnak < 2) { sleep(1); }

    printf("Matula bacsi kuldi a feladatokat\n");
    struct fuggveny_msg msg_butyok = {.mtype = 1, .mennyiseg = 2};
    struct fuggveny_msg msg_tutajos = {.mtype = 2, .mennyiseg = 3};
    msgsnd(msgQ, &msg_butyok, sizeof(int), 0);
    msgsnd(msgQ, &msg_tutajos, sizeof(int), 0);

    close(p_tutajos[1]);
    close(p_butyok[1]);

    char buf[1024];
    ssize_t n;
    if ((n = read(p_butyok[0], buf, sizeof(buf))) > 0) {
        printf("Matula bacsi kapta: %s\n", buf);
    }
    if ((n = read(p_tutajos[0], buf, sizeof(buf))) > 0) {
        printf("Matula bacsi kapta: %s\n", buf);
    }

    close(p_tutajos[0]);
    close(p_butyok[0]);

    wait(NULL);
    wait(NULL);
    msgctl(msgQ, IPC_RMID, NULL);
    printf("Matula bacsi: vegeztunk.\n");

    return 0;
}
