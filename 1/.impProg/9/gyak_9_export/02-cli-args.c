#include <stdio.h>

int main(int argc, const char *argv[]) {
    /* argv: array of strings (char pointers) */

    printf("Number of arguments: %d\n", argc);

    /* argv[0]: the name of the program (why is that useful?)*/
    for (int i = 0; i < argc; ++i)
        printf("argv[%d] = %s\n", i, argv[i]);

#ifdef __unix__
    /* argv[argc] = NULL; on Unix, the environment variables are located afterwards */
    for (int i = argc + 1; argv[i] != NULL; ++i)
        printf("env[%d]: %s\n", i - argc, argv[i]);
#endif

    return 0;
}
