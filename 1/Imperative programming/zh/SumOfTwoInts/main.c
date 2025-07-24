#include <stdio.h>
#include <stdlib.h>

int sumOfTwoInts(int *arr, int sum) {
    for(int i = 0; i < 5; ++i) {
        for(int j = i + 1; j < 5; ++j) {
            if(arr[i] + arr[j] == sum) {
                return 1;
            }
        }
    }

    return 0;
}

int main(int argc, char *argv[]) {
    if(argc < 2) return 0;
    int arr[5] = {2, 5, -7, 6, 9};

    if(sumOfTwoInts(arr, atoi(argv[1]))) {
        printf("van ket ilyen szam aminek az osszege egyenlo ezzel\n");
    } else {
        printf("nincs ket ilyen szam aminek az osszege egyenlo ezzel\n");
    }
    
    return 1;
}
