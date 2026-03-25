/ 5): Tegyük fel, hogy egy dobozban van $2N$ kártyalap, melyek közül kettõn $1$-es, kettõn $2$-es szám van és így tovább. Válasszunk ki véletlenszerűen $m$ lapot. Várhatóan hány pár marad a dobozban?
Van $N$ darab párunk (összesen $2N$ kártya). Húzunk $m$ lapot. Egy konkrét pár pontosan akkor marad a dobozban, ha mindkét lapját elkerültük a húzásnál.
Összes húzási lehetőség: $binom(2N, m)$. Kedvező eset (egy adott pár elkerülése): $binom(2N-2, m)$.
Egy pár bent maradásának valószínűsége:
$ p = binom(2N-2, m) / binom(2N, m) = ((2N-m)(2N-m-1)) / (2N(2N-1)) $
Mivel összesen $N$ pár van, az indikátorváltozók linearitása alapján megszorozzuk $N$-nel:
$ EE = N dot ((2N-m)(2N-m-1)) / (2N(2N-1)) = ((2N-m)(2N-m-1)) / (2(2N-1)) $
