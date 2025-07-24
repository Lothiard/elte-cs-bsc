#include <stdio.h>

int main() {
    int x = 4;
    float y = 5.5;

    /* a void pointer - may point to any type */
    void* ptr;
    ptr = &x;

    /*
     * printf("%d\n", *ptr);
     */

    /*
     * (int*)ptr    : casts to "useful" pointer type
     * *((int*)ptr) : dereferences type casted ptr
     */
    printf("Integer variable is = %d\n", *((int*)ptr));

    /* void pointer is now float */
    ptr = &y;
    printf("Float variable is= %f\n", *((float*)ptr));

    /*
     * uses:
     * - "generic" programming
     * - raw memory manipulation (e.g. memcpy)
     */

    return 0;
}
