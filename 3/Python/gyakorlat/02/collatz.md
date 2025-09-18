1937-ben Lothar Collatz német matematikus egy érdekes hipotézist fogalmazott meg (amely még mindig nem bizonyított), amelyet a következőképpen lehet leírni:
1. Vegyünk egy tetszőleges nem negatív és nem nulla egész számot, és nevezzük el c0-nak.
2. -ha páros, akkor az új c0 értéke c0 / 2;
    -ha páratlan, akkor az új c0 értéke 3 * c0 + 1;
3. ha c0 != 1, akkor ugorjon a 2. pontra.
A hipotézis szerint a c0 kezdeti értékétől függetlenül az érték mindig 1-re fog változni.

Írj programot, ami beolvas egy természetes számot és végrehajtja a fenti lépéseket, amíg c0 nem 1. Írd ki c0 értékét minden lépés után, valamint azt is, hogy mennyi lépésben jutottunk el 1-ig.

Példák:
input: 16
output:
8
4
2
1
steps=4

input: 15
output:
46
23
70
35
106
53
160
80
40
20
10
5
16
8
4
2
1
steps=17