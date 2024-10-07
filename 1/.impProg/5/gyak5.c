#include <stdio.h>
#include <string.h>

void f1() {
    int nullak[5] = {0,0,0,0,};
    
    for(int i = 0; i < 5; ++i) {
        printf("%d\n", nullak[i]);

    }
}

void f2() {
    int arr[5] = {1,2,3,4,5};

    int osszeg = 0;
    for(int i = 0; i < 5; ++i) {
        osszeg += arr[i];
    }

    printf("%d\n", osszeg);
}

void f3() {
    int arr[5] = {1,2,3,4,5};
 
    int max = 0;
    for(int i = 0; i < 5; ++i) {
        if(max < arr[i]) {
            max = arr[i];
        }
    }

    printf("%d\n", max);
}

void f4() {
    int arr[5] = {1,2,3,4,5};
    int min1, min2;
    
    if(arr[0] < arr[1]) {
        min1 = arr[0];
        min2 = arr[1];
    } else {
        min1 = arr[1];
        min2 = arr[0];
    }

    for(int i = 2; i < 5; ++i) {
        if(arr[i] < min1) {
            min2 = min1;
            min1 = arr[i];
        } else if (arr[i] > min1 && arr[i] < min2) {
            min2 = arr[i];
        }
    }

    printf("%d\n", min2);
}

void f5() {
    int arr1[5] = {1,2,3,4,5};
    int arr2[5] = {1,1,2,3,4};

    int osszeg = 0;
    for(int i = 0; i < 5; ++i) {
        osszeg += arr1[i] * arr2[i];
    }

    printf("%d\n", osszeg);
}

void f6() {
    double arr[5] = {1.5,2.5,3.5,4.5,5.5};
    double sum;
    double avg;

    for(int i = 0; i < 5; ++i) {
        sum += arr[i];
    }

    avg = sum / (sizeof(arr)/sizeof(arr[0]));
    printf("%f\n", avg);
}

void f7() {
    char str1[] = "alma";
    char str2[] = "banan";

    int result = strcmp(str1, str2);

    if (result < 0) {
        printf("%s\n", str1);
    } else if (result > 0) {
        printf("%s\n", str2);
    } else {
        printf("A két string megegyezik.\n");
    }
}

void f8() {
    char input[100];
    fgets(input, 100, stdin);

    printf("%ld\n", strlen(input) - 1);
}

int main() {
    // f1();
    // f2();
    // f3();
    // f4();
    // f5();
    // f6();
    // f7();
    f8();

    return 0;
}
