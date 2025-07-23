#include <stdio.h>
#include <stdlib.h>

int main() {
	int arr[1];
	arr[0] = 9;

    free(arr);
    printf("arr[0] = %d\n", arr[0]);

	return 0;
}