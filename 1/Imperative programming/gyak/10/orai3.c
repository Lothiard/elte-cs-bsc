#include <stdio.h>
#include <stdlib.h>

int main() {
    int tmp;
    int cnt = 0;
    int* arr = NULL;

    while (scanf("%d", &tmp) != EOF) {
        /*
         * real implementations of dynamic arrays (C# List, C++ std::vector)
         * don't grow elements one by one; instead multiply
         * => amortized constant complexity
         *  for proof: https://people.engr.tamu.edu/andreas-klappenecker/csce411-f13/csce411-amortized2.pdf
         */

        /* http://gsd.web.elte.hu/lectures/imper/imper-lecture-10/ */
        arr = realloc(arr, sizeof(int) * cnt++);
        arr[cnt - 1] = tmp;
    }

    puts("A beolvasott szamok:");
    for (int i = cnt - 1; i >= 0; --i)
        printf("%d ", arr[i]);
    puts("");

    return 0;
}
