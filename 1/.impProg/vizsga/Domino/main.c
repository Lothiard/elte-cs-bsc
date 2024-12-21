#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int left, right;
} Domino;

void init(Domino *initial, int *setAmount, FILE *fp) {
    int a, b;
    fscanf(fp, "%d %d", &a, &b);

    initial->left = a;
    initial->right = b;
    // printf("%d %d\n", initial->left, initial->right);

    fscanf(fp, "%d", setAmount);
}

void initArr(Domino *arr, int setAmount, FILE *fp) {
    for(int i = 0; i < setAmount; ++i) {
        int leftTemp, rightTemp;

        fscanf(fp, "%d", &leftTemp);
        fscanf(fp, "%d", &rightTemp);

        arr[i].left = leftTemp;
        arr[i].right = rightTemp;

        // printf("%d %d ", arr[i].left, arr[i].right);
    }
}

void place(Domino initial, Domino arr, int setAmount) {
    Domino current;
    current.left = initial.left;
    current.right = initial.right;
    printf("Initial domino: %d|%d\n", current.left, current.right)

    for(int i = 0; i < setAmount; ++i) {
        if(current.right == arr[i].left) {
            printf("Added to the right end: %d|%d\n", arr[i].left, arr[i].right);
            current.right = arr[i].right;
        } else if (current.right == arr[i].right) {
            printf("Added to the right end: %d|%d\n", arr[i].left, arr[i].right);
            current.right = arr[i].left;
        } else if (current.left == arr[i].right) {
            printf("Added to the left end: %d|%d\n", arr[i].left, arr[i].right);
            current.left = arr[i].left
        } else if (current.left == arr[i].left) {
            printf("Added to the left end: %d|%d\n", arr[i].left, arr[i].right);
            current.left = arr[i].right
        }
    }
}

int main() {
    Domino initial;
    int setAmount;

    FILE *fp = fopen("input01.txt", "r");
    init(&initial, &setAmount, fp);
    
    Domino *arr = malloc(setAmount * sizeof(Domino));
    initArr(arr, setAmount, fp);
    
    fclose(fp);

    place(initial, arr, setAmount);

    free(arr);


    return 0;
}