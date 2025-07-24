#include <stdlib.h>
#include <stdio.h>

int main()
{
    struct id {
        int i;
        double d;
    } lehet_itt_is_var1, lehet_itt_is_var2;
    /* ^ important */

    struct id *s = malloc(sizeof(struct id));
    (*s).i = 40;
    s->i += 10;
    printf("%d, %d\n", s->i, (*s).i);
    free(s); 

    return 0;
}