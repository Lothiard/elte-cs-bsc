#include <stdio.h>

void process_matrix(unsigned (*mat)[3], int nrows) {
    for (int i = 0; i < nrows; ++i)
    {
        for (int j = 0; j < sizeof(mat[i])/sizeof(int); ++j)
            printf("%d ", mat[i][j]);
        puts("");
    }
}

int main() {
    unsigned mat[3][3] = {
        { 0, 1, 2 },
        { 3, 4, 5 },
        { 6, 7, 8 }
    };

    process_matrix(mat, 3);
    /* what would have been the other option? */

    /* can only switch primitive types -> try what happens on strings! */
    char letter = 'a';
    switch (letter) {
        case 'a':
            puts("alma");
            break;
        case 'c':
        case 'd':
            puts("banan");
            break;
        
        default:
            puts("ismeretlen");
    }
}