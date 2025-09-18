1.
M = M(5, -6, 6)
fl(0,12) = ?

fl(0,24) = ?

fl(0,12) - fl(0,24) = ?

$1/2$ szorzo van az elso ketto kozott

$ #table(
  columns: (auto, auto),
  [0], [12],
  [0], [24],
  [0], [48],
  [0], [96],
  [1], [92],
  [1], [84],
  [1], [68],
  [1], [36],
  [0], [72],
  [1], [44],
) $

felso szomszed: $[11111 | -3] = (1 - 1/(2^5)) dot 2^(-3) = 31/256$

also szomszed: $[11110 | -3] = 30/256$

ellenorzes (mindig meg kell tenni attol hogy mindig elfelejtem):
$ 30/256 < 0,12 < 31/256 "  " \/ dot 100 \/ dot 256 $
$ 3000 < 3072 < 3100 $

felso szomszedhoz van kozelebb

fl(0,12) = $31/256$ = [11111 | -3]

fl(0,24) = $31/256$ = [11111 | -2]

\
most sajnos ki kene vonni

azonos karakterisztikara kell hozni es mindig a nagyobbikat valtoztatom

karakterisztika emeles kerekitessel

ha csokken a karaktersztika csokkenie kell a mantisszanak is. az egyes elcsuszik es az utolso lesz a kerekitojegy

$[11111 | -2]$

$[10000 | -2]$

ez kivonva

$[01111 | -2] -> "normalizaljuk kerekitessel" -> [11110 | -3] = "(also szomszed)" = 30/256$

itt mar van elteres

#pagebreak()
= hibaszamolas
"nagyon fontos hogy $a, A$ mindig rogztisuk magunkban, hiaba egyszeru a feladat. jol kell kezelni ezeket mert a fogalmuk es szamolasuk kicsit elter a megszokottol."

$ Delta"fl(0,12)" = 1/2 dot 1/2^5 dot 2^(-3) = 1/2^3 $

$ Delta"fl(0.24)" = 1/2 dot 1/2^5 dot 2^(-2) = 1/2^8 $

$ Delta"vegeredmeny" = 1/2 dot 1/2^5 dot 2^(-3) = 1/9 $

"ez egyszeru volt de nem lesz mindig egyszeru" xd

1. lehetsoeg
$ delta"fl(0,12)" = emptyset = (Delta"fl(0.12)")/(0.12) = ((1)/(2^9))/(0,1) = 10/2^9 < 16/2^9 = 1/2^5 $

vagy
2. lehetoseg

$ (Delta"fl(0,12)")/"fl"(0.12) = (1/2^9)/(31/256) = 1/312 = 1/62 < 1/60 = 1/6 dot 10^(-1) = delta"fl(0,12)" $

#pagebreak()
= muveletek hibakorlatjai

mindig el kell kerulni hogy a nevezoben kicsi szam legyen mert akkor nagy lesz a baj

== 1.a
hazi?

== 2 (helyett)
$ sqrt(2014) - sqrt(2013) = 1/(sqrt(2014) + sqrt(2013)) $

$ a = 44,88 approx sqrt(2014) $
$ a = 44,87 approx sqrt(2013) $
$ c = a - b = 0.01 $
$ d = 1/(a + b) = 0.011142061 $

arrol szol az egesz hogy meg kell mutatuni hogy $d$ az mennyivel jobb mint $c$

$ Delta_a = Delta_b = 1/2 dot 10^(-2) $

nem irom le hogy $Delta_c$ mert nem tudom mennyi, azt viszont tudom hogy kivonasra ossze kell adjam a kettot

$ Delta_a + Delta_b = 10^(-2) = Delta_c $

szoval jk mert megis tudom mennyi a $Delta_c$

most kene a $Delta_d$ de abban ket muvelet van es azt kulon kell vegyem

$ Delta_a + Delta_b = 10^(-2) = Delta_(a + b) $

$ (1 dot Delta_(a + b) + (a + b) dot Delta_1)/(a+b)^2 $

na de a $Delta_1 = 0$

$ (10^(-2))/(89,75)^2 < (10^(-2))/(8000) = 1/8 dot 10^(-5) = Delta_d $

ahol a 8000 netto hasrautes volt (?)
ig lehet barmennyit mondani mert becsulunk

kesz az egyik fele

#pagebreak()
== relativ hiba

$ (Delta_a)/(a) = (1/2 dot 10^(-2))/(44,88) < (1/2 dot 10^(-2))/(40) = 1/8 dot 10^(-3) = delta_a = delta_b $

TODO: hazi feladat

$ Delta_c/c = (10^-2)/(0,01) = 1 = delta_c $

a hiba nagysegrendje megegyezik a szameval, ertekelhetetlen hiba (100%-os) (semmitmondo)

$ Delta_d/d = (1/8 dot 10^-3)/(0,011142061) = (1/8 dot 10^-5)/(10^(-2)) = 1/8 dot 10^(-3) = delta_d $

#pagebreak()
= megjegyzes

ZH-n nem lesz fuggvenyertek hibaja es nem is kell foglalkozni vele amig nincs kozel a vizsga mert nem fogjuk erteni siman

== 6 (helyett)
$ A = pi $
$ a = 3 "(egeszre kerekitett ertek)" $

$ Delta_a = 1/2 $

ha nem mond semmit akkor barmi lehet pl $0,15$ az abszolut korlat

$ f(x) = 2^x ==> f(pi) = 2^pi, f(3) = 2^3 $

megoldas:

$ f'(x) = ln 2 dot 2^x $

$ x in [3 - Delta_a; 3 + Delta_a] = [2,5; 3,5] $

szigoru monoton no

$ M_1 = f'(3,5) = ln 2 dot 2^(3,5) $

$ Delta_(f(a)) = M_1 dot Delta_a = ln 2 dot 2^(3,5) dot 1/2 $
