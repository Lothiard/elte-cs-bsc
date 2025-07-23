#include <stdio.h>

char substitute(char c, int shift) {
    /*
     * c - 'a'                : hányadik betű
     * (c - 'a' + shift) % 26 : eltolás után hányadik?
     *     [modulo azért, hogy 'z' + 1 az 'a' legyen]
     * 'a' + (...)            : sorszám vissza karakterré
     */
    if ('a' <= c && c <= 'z')
        return 'a' + (c - 'a' + shift) % 26;

    if ('A' <= c && c <= 'Z')
        return 'A' + (c - 'A' + shift) % 26;

    return c;
}

int main() {
    int shift;
    printf("Eltolas merteke: ");
    scanf("%d", &shift);

    /* 
     * a getchar() visszatérési értéke egy int,
     * hogy az EOF (End Of File) speciális értéket
     * is tudja reprezentálni.
     */
    int ch;
         /* értékül ad, majd összehasonlít */
    while ((ch = getchar()) != EOF) {
        printf("%c", substitute(ch, shift));
        /*
         * kicsit szebb megoldás (de még nem tanultuk):
         * putchar(substitute(ch, shift));
         */
    }

    return 0;
}