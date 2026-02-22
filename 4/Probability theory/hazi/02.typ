/ 1.): A $32$ lapos kártyacsomagból kihúzunk $7$ lapot. Mennyi annak a valószínűsége, hogy a lapok között mind a négy szín előfordul? (1 pont)
- *4-1-1-1 eloszlás:* 1 színből 4 lapot, a többi 3 színből 1-1 lapot húzunk.
  $ E_1 = binom(4, 1) binom(8, 4) binom(8, 1)^3 = 4 dot 70 dot 512 = 143 360 $
- *3-2-1-1 eloszlás:*
  $ E_2 = binom(4, 1) binom(3, 1) binom(8, 3) binom(8, 2) binom(8, 1)^2 = 4 dot 3 dot 56 dot 28 dot 64 = 1 204 224 $
- *2-2-2-1 eloszlás:*
  $ E_3 = binom(4, 1) binom(8, 1) binom(8, 2)^3 = 4 dot 8 dot 28^3 = 32 dot 21 952 = 702 464 $

$
  P = (binom(4, 1) binom(8, 4) binom(8, 1)^3 + binom(4, 1) binom(3, 1) binom(8, 3) binom(8, 2) binom(8, 1)^2 + binom(4, 1) binom(8, 1) binom(8, 2)^3)/ binom(32, 7) approx 0,6091
$

\ \ \
/ 2.): Egy urnában $K$ fehér és $M$ fekete golyó van. Visszatevés nélkül kihúztunk $n$ golyót, s ebből $k$ lett fehér és $n−k$ fekete. Mi a valószínűsége, hogy az első húzás eredménye fehér golyó volt, ha a golyók számozottak? (2 pont)

Mivel a golyók sorszámozottak (megkülönböztethetőek), és a húzás teljesen véletlenszerű, a kihúzott $k$ fehér golyó egyforma eséllyel helyezkedhet el a húzási sorrend bármelyik pozíciójában.
$ P = k / n $

#pagebreak()
/ 3.): Aladár és Béla pingpongoznak. Minden labdamenetet, egymástól függetlenül, $1/3$ valószínűséggel Aladár, $2/3$ valószínűséggel Béla nyer meg. A jelenlegi állás 20:19 Béla javára. Mennyi annak a valószínűsége, hogy a meccset mégis Aladár nyeri meg? (Az nyer, akinek sikerül legalább két pontos előny mellett legalább $21$ pontot szerezni.) (3 pont)

Két dolognak kell teljesülnie ahhoz, hogy Aladár nyerjen:

+ *Játékban kell maradnia:* Meg kell nyernie a következő labdamenetet, különben Béla 21:19-re győz. Ennek valószínűsége $p = 1/3$. Ha ez sikerül, az állás *20:20*.
+ *Meg kell nyernie a meccset egyenlő állásról:* 20:20-ról 2 pont különbséggel kell nyerni. Jelöljük $x$-szel annak a valószínűségét, hogy Aladár nyer egyenlő állásról.

A következő két labdamenetben 3 dolog történhet:
- Aladár megnyeri mindkettőt (nyer): $p^2$
- Béla megnyeri mindkettőt (veszít): $q^2$
- Mindketten nyernek 1-1 pontot, és újra egyenlő (az esély újra $x$ lesz): $2 p q$

Ebből felírhatunk egy egyenletet $x$-re:
$ x = p^2 + 2 p q dot x $
$ x(1 - 2 p q) = p^2 => x = p^2 / (1 - 2 p q) $

Helyettesítsük be a számokat ($p=1/3$, $q=2/3$):
$ x = (1/3)^2 / (1 - 2 dot 1/3 dot 2/3) = (1/9) / (1 - 4/9) = (1/9) / (5/9) = 1/5 $

Tehát egyenlőről 20% esélye van nyerni. De ne feledjük, előbb ki kellett egyenlítenie! A teljes valószínűség:
$ P("Aladár nyer") = p dot x = 1/3 dot 1/5 = 1/15 $

\ \ \
/ 4.): $2N$ darab molekula mindegyike egymástól függetlenül, véletlenszerűen kerül $N$ darab térrész valamelyikébe. Mennyi a valószínűsége, hogy mindegyik térrészben lesz legalább egy molekula?
A kedvező eset az, amikor *egyik térrész sem üres*.
$ P = (sum_(i=0)^N (-1)^i binom(N, i) (N-i)^(2N)) / N^(2N) $
