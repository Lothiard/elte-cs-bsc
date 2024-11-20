#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> /* for perror(); only on Unix */

int main() {
    for (int i = 0; i < 2048; ++i) {
        FILE *fp = fopen("/dev/null", "r");
        if (!fp) {
            perror("open(/dev/null)"); /* print error code from fopen() */
            printf("Failed iteration: %d\n", i);
            exit(1);
        }
        usleep(2500); /* sleep 2500 us = 2.5 ms */
    }

    return 0;
}

/*
* persze ez nem nagyon izgalmas
* de ha webszervert irsz, nem jo, ha megdoglik tul sok megnyitot file miatt
*
* kesobb dinamikus memorianal: eroforrasok felszabadiasa nagyon fontos
* C++ megoldasa erre: RAII
*/
