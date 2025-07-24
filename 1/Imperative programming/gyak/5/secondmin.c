#include <stdio.h>

int main() {
    int arr[5] = { 5, 2, 1, 4, 3 };

    for (int n = 5; n > 1; n--) {
        int maxind = 0;
        for (int i = 0; i < n; ++i)
            if (arr[i] > arr[maxind])
                maxind = i;
        
        int tmp = arr[n - 1];
        arr[n - 1] = arr[maxind];
        arr[maxind] = tmp;
    }

    for (int i = 0; i < 5; ++i)
        printf("%d", arr[i]);
    printf("\n");

    return 0;
}