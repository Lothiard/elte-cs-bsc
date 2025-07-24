#include <stdio.h>

int sum(int nums[], int n) {
    int ret = 0;
    for (int i = 0; i < n; ++i)
        ret += nums[i];
    return ret;
}

int sum_wrong(int *nums, int n) {
    int ret = 0;

    /*
    * warning: division ‘sizeof (int *) / sizeof (int)’
    *          does not compute the number of array elements.
    */
    for (int i = 0; i < sizeof(nums)/sizeof(nums[0]); ++i)
        ret += nums[i];
    return ret;
}

int main() {
    int arr[2];
    scanf("%d %d", &arr[0], &arr[1]);

    printf("%d\n", sum(arr, 2));

    return 0;
}