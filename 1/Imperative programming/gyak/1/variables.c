#include <stdio.h>

int main() {
	int a = 1, b = 2;
	/* itt 2 egesz tipusu valtozot hozunk letre.
	 * ez ebben az esetben egy nev, mellyel egesz szamokra utalhatunk.
	 * a nevhez egy memoriaterulet tartozik (int eseten 4 byte).
	 * a valtozo erteket kulonfele muveletekkkel megvaltoztathatjuk, pl. erteket adunk neki
	 *
	 * a legtobb olyan helyre ahova egy szamliteralt irtunk, egy valtozo neve is kerulhet
	 * (esetleg valaki kivetel? tombok hossza VLA nelkuli szabvanyban)
	 */


	printf("%d\n", a * b);
	
	/*
	 * Aki korabban hasznalt C-t: a C89-es szabvanyban a valtozok deklaracioja csak utasitasok _elott_ johetnek. 
	 */
	 int foo = 2; /* hibas */
}
