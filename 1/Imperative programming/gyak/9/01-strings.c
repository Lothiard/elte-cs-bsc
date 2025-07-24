#include <stdio.h>
#include <string.h>

int main() {
    const char *s1 = "alma";
    /*
     * Not the same as char s2[] = "alma"
     *
     * string literals are in the ".rodata" segment; cannot be modified at runtime
     * (allows interesting features like string merging or common tail)
     */

    char s2[33];
    char s3[10];
    
    /* reading strings */
    /* char *fgets(char *dest, int size, FILE* stream) */

    if (fgets(s2, sizeof(s2), stdin) == NULL)
        printf("Reading failed\n"); /* or EOF */

    /* will include the end-of-line; remove it */
    if (*s2 != 0)
        s2[strlen(s2) - 1] = 0;

    /* length of string */
    /* size_t strlen(char const* s) */
    printf("length of \"alma\": %zu\n", strlen(s1));
    printf("length of \"%s\": %zu\n", s2, strlen(s2));

    /* string copy */
    /* char *strcpy(char *dst, char *src) */
    strcpy(s3, s1);
    printf("s3 = %s\n", s3);

    /* concatenate "src" the end of string at "dst" */
    /* char *strcat(char *dst, char *src) */
    strcat(s2, s1);
    printf("s2 + s1 = %s\n", s2);

    /* strdup - allocates memory for the copy; next lesson */

    printf("s1 = %s\n", s1);
    printf("s3 = %s\n", s3);
    printf("s1 < s3 = %d\ts1 == s3 = %d\ts1 > s3 = %d\n", s1 < s3, s1 == s3, s1 > s3);
    /* why is that? */


    /* strcmp */
    /* 
     * int strcmp(char const *s1, char const *s2)
     *     < 0 if s1 < s2 alphabetically
     *    == 0 if s1 = s2
     *     > 0 if s1 > s2 alphabetically
     *
     * comparing strings using < / == / > is not possible - they compare addresses
    */
    printf("strcmp(\"%s\", \"%s\") = %d\n", s1, s2, strcmp(s1, s2));

    /* many more functions; see man string.h (apt install manpages-posix-dev) */

    return 0;
}