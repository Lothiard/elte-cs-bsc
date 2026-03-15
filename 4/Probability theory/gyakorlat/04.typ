/ 1): Célbalövéskor háromszor próbálkozhatunk. Az első lövésnél $60%$, a másodiknál $70%$, a harmadiknál $80%$ eséllyel találjuk el a célt, az egyes lövéseknél egymástól függetlenül. Mennyi a valószínűsége, hogy
/ (a): egyszer sem találjuk el a célt?

A lövések találati valószínűségei: $p_1 = 0,6$, $p_2 = 0,7$, $p_3 = 0,8$.\ A hibázások esélyei (komplementerek): $q_1 = 0,4$, $q_2 = 0,3$, $q_3 = 0,2$.
$ P(T=0) = q_1 dot q_2 dot q_3 = 0,4 dot 0,3 dot 0,2 $
/ (b): csak a harmadik lövésnél találunk célba?
$ P = q_1 dot q_2 dot p_3 = 0,4 dot 0,3 dot 0,8 $
/ (c): egyszer sem találjuk el a célt, feltéve, hogy az első lövést elhibáztuk?
$ P = q_2 dot q_3 = 0,3 dot 0,2 $
(Ugyanez Bayes-tétellel: $P(T=0 | "1. hiba") = (0,024)/(0,4) = 0,06$)
/ (d): feltéve, hogy összesen kétszer találtunk célba, az első lövés sikeres volt?
$ P(T=2) = p_1 p_2 q_3 + p_1 q_2 p_3 + q_1 p_2 p_3 = 0,084 + 0,144 + 0,224 = 0,452 $
Ebből azok az esetek, ahol az első sikeres volt (az első két tag): $0,084 + 0,144 = 0,228$.
$ P = (0,228)/(0,452) = 57/113 $
/ (e): Adjuk meg az első sikeres találat sorszámának és az összes találat számának az együttes eloszlását (ha nincs találat, az első sikeres találat sorszáma helyett írjunk $0$-t).
#align(center)[
  #table(
    columns: 5,
    align: center,
    stroke: 0.5pt,
    [$F$ \/ $T$], [*0*], [*1*], [*2*], [*3*],
    [*0*], [0,024], [0], [0], [0],
    [*1*], [0], [0,036], [0,228], [0,336],
    [*2*], [0], [0,056], [0,224], [0],
    [*3*], [0], [0,096], [0], [0],
  )
]

($F$: első sikeres találat sorszáma, $T$: összes találat): (A táblázat elemeinek összege pontosan 1.)

/ 2): Két kockával dobunk. Egy ilyen dobást sikeresnek nevezünk, ha van $6$-os a kapott számok között. Várhatóan hány sikeres dobásunk lesz $n$ próbálkozásból?

Egy dobás során a siker esélye (azaz legalább egy $6$-os van a két kockán) komplementerrel:
$ p = 1 - (5/6)^2 = 1 - 25/36 = 11/36 $
A sikeres dobások száma binomiális eloszlást követ, melynek várható értéke:
$ EE = n dot p = 11/36 n $

#pagebreak()
/ 3): Egy tízemeletes ház földszintjén 15 ember száll be a liftbe. Egymástól függetlenül mindenki választ a 10 emelet közül egyet (mindegyiket azonos valószínűséggel), ahol kiszáll. Várhatóan hány emeleten áll meg a lift?
Vezessünk be $I_i$ indikátorváltozókat minden $i$. emeletre (1, ha megáll ott a lift, 0, ha nem). Annak esélye, hogy egy adott emeleten megáll, egyenlő annak komplementerével, hogy senki sem választja azt az emeletet:
$ P(I_i = 1) = 1 - (9/10)^15 $
A várható értékek linearitása miatt a megállások várható száma a 10 emelet indikátorainak összege:
$ EE[X] = sum_(i=1)^10 EE[I_i] = 10 dot (1 - 0,9^15) $

/ 4): Mennyi az ötöslottón kihúzott
/ (a): számok összegének várható értéke?
Egyetlen véletlenszerűen húzott szám várható értéke $(1+90)/2 = 45,5$. Az 5 szám összegének várható értéke a linearitás miatt: $EE = 5 dot 45,5 = 227,5$.

/ (b): Páros számok számának várható értéke?
$45$ páros és $45$ páratlan szám van. Minden húzásnál $1/2$ eséllyel húzunk párost. $EE = 5 dot 1/2 = 2,5$.

/ (c): Kihúzott páros számok összegének várható értéke?
A lottón szereplő páros számok $(2, 4, ..., 90)$ átlaga $46$. Mivel várhatóan $2,5$ darab páros számot húzunk, az összegük várható értéke: $EE = 2,5 dot 46 = 115$.

/ 5): Tegyük fel, hogy egy dobozban van $2N$ kártyalap, melyek közül kettõn $1$-es, kettõn $2$-es szám van és így tovább. Válasszunk ki véletlenszerűen $m$ lapot. Várhatóan hány pár marad a dobozban?
Van $N$ darab párunk (összesen $2N$ kártya). Húzunk $m$ lapot. Egy konkrét pár pontosan akkor marad a dobozban, ha mindkét lapját elkerültük a húzásnál.
Összes húzási lehetőség: $binom(2N, m)$. Kedvező eset (egy adott pár elkerülése): $binom(2N-2, m)$.
Egy pár bent maradásának valószínűsége:
$ p = binom(2N-2, m) / binom(2N, m) = ((2N-m)(2N-m-1)) / (2N(2N-1)) $
Mivel összesen $N$ pár van, az indikátorváltozók linearitása alapján megszorozzuk $N$-nel:
$ EE = N dot ((2N-m)(2N-m-1)) / (2N(2N-1)) = ((2N-m)(2N-m-1)) / (2(2N-1)) $

#pagebreak()
/ 6): Egy bányász a bánya egyik termében rekedt, ahonnan három út nyílik. Az első egy három perces út végén a szabadba vezet. A második út öt, a harmadik hét percnyi séta után visszatér ugyanebbe a terembe. A bányász minden alkalommal a többi választástól függetlenül egyenlő valószínűséggel választ egyet az utak közül. Legyen $X$ a szabadba jutáshoz szükséges idő Mennyi $X$ várható értéke?
Jelölje $EE[X]$ a kijutáshoz szükséges várható időt. A teljes várható érték tétele alapján felírható egy egyenlet:
$ EE[X] = 1/3(3) + 1/3(5 + EE[X]) + 1/3(7 + EE[X]) $
$ EE[X] = 1 + 5/3 + 1/3 EE[X] + 7/3 + 1/3 EE[X] $
$ EE[X] = 15/3 + 2/3 EE[X] = 5 + 2/3 EE[X] $
Ebből $1/3 EE[X] = 5$, vagyis $EE[X] = 15 "perc".$

/ 7): Szerencsejátékot játszunk, amely során minden fordulóban a feltett tétet $1/2$ valószínűséggel megduplázzuk, $1/2$ valószínűséggel pedig elveszítjük. Kezdetben $1$ petákunk van. Addig folytatjuk, amíg $5$ petákunk nem lesz vagy el nem fogy az összes pénzünk. Várhatóan hány játszmát fogunk játszani, ha a mohó stratégiát követjük, azaz mindig akkora tétet választunk, amennyi az öthöz hiányzik, vagy ha ez nem lehetséges, akkor az összes pénzünket feltesszük? Várhatóan hány játszmát fogunk játszani, ha az óvatos stratégiát követjük, és minden lépésben egy petákot teszünk fel?
*1. Mohó stratégia:* Mindig $min(5 - S, S)$ petákot teszünk fel.
Jelölje $E_k$ a hátralévő játszmák várható számát, ha $k$ petákunk van.
- $E_1 = 1 + 1/2 E_2$ (1-et teszünk fel, nyerünk: 2 lesz, veszítünk: 0)
- $E_2 = 1 + 1/2 E_4$ (2-t teszünk fel)
- $E_3 = 1 + 1/2 E_1$ (2-t teszünk fel, mert az 5-höz ennyi hiányzik)
- $E_4 = 1 + 1/2 E_3$ (1-et teszünk fel)
Ezt az egyenletrendszert visszahelyettesítéssel megoldva kapjuk, hogy *$E_1 = 2$*. Tehát várhatóan 2 játszmát játszunk.

*2. Óvatos stratégia:* Mindig $1$ petákot teszünk fel.
Ez a klasszikus "bolyongás abszorpciós falakkal" probléma. Az $E_k = 1 + 1/2 E_(k-1) + 1/2 E_(k+1)$ egyenlet megoldása az $N=5$ végpontú pályán $E_k = k(N-k)$.
$E_1 = 1(5-1) = 4$. Tehát várhatóan 4 játszmát fogunk játszani.
