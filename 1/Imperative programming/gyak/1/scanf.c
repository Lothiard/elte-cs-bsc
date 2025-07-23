#include <stdio.h>

int main() {
	int a, b;
	/*
	 * valtozo neve: ugyan olyan, mintha az erteket irtuk volna be ide.
	 * fuggvenyhivaskor az ertekek masolodnak
	 * de a beolvasashoz nem az kell most (a nem inicializalt - hibas ertek), hanem arra a memoriara akarunk utalni, amire a valtozo mutat
	 *
	 * ezert van szukseg a '&' cimkepzo operatorra
	 * egyebkent ami letrejon: pointer = mutato, ezek hasznalata kesobbi gyakokon bovebben
	 */
	scanf("%d %d", &a, &b);
	printf("%d\n", a * b);
}
