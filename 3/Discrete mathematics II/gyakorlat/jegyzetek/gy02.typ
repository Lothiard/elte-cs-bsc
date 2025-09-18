1.
gcm es lcm kell, de primtenyezokre bontani lassu ezert be kell ujitani: euklideszi algoritmus

a)
$ a = 13, b = 14 $

a ket szam kozul kivalasztjuk a nagyobbikat, es modoljuk

$ 14 mod 13 = 1 $

a vegeredmennyel megcsinaljuk ugyanezt

$ 13 mod 1 = 0 $

a legutolos nem 0 ertek lesz a legnagyobb kozos oszto

$ "gcm"(14, 13) = 1 $

lcm pedig

$ "lcm"(a, b) = (a dot b)/("gcm(14, 13)") $

$ "lcm"(14, 13) = (14 dot 13)/(1) = 182 $

== b)
$ a = 16, b = 37 $

$ 37 mod 16 = 5 $
$ 16 mod 5 = 1 $
$ 5 mod 1 = 0 $

$ "gcm"(16, 37) = 1 $
$ "lcm"(16, 37) = (16 dot 37)/1 = 592 $

celszerubb tablazatban dolgozni (elso ket sorban nincs semmi) a bal oszlop a mod es a jobb az hogy hanyszor van meg

== c)
$ a=90, b=111 $
$ #table(
  columns: (auto, auto),
  [111], [],
  [90], [],
  [21], [1],
  [6], [4],
  [2], [3],
  [0], [2],
) $

a nulla feletti szam lesz a gcm

$ "gcm"(111, 90) = 3 $
$ "lcm"(111, 90) = (111 dot 90)/3 = 3330 $

== d)
$ #table(
  columns: (auto, auto),
  [219], [],
  [168], [],
  [51], [1],
  [15], [3],
  [6], [3],
  [3], [2],
  [0], [2],
) $

$ "gcm"(219, 168) = 3 $
$ "lcm"(219, 168) = (219 dot 168)/3 = 12264 $

== f)
$ a=756, b=795 $

$ #table(
  columns: (auto, auto),
  [795], [],
  [756], [],
  [39], [1],
  [15], [19],
  [9], [2],
  [6], [1],
  [3], [1],
  [0], [2],
) $

$ "gcm"(795, 756) = 3 $
$ "lcm"(795, 756) = (795 dot 756)/3 = 20034 $

#pagebreak()
= kongruencia
kongruencia ugy mukodik hogy $a, b in bb(Z): a equiv b (mod n) "  ha" n | a - b$

ekvivalenciarelaciot jelol a $equiv$ (reflexiv, szimmetrikus, tranzitiv)

- Reflexiv: $a equiv a (mod n)$
- Tranzitiv: $a equiv b, b equiv c => a equiv c (mod n)$
- Szimmetrikus: $a equiv b <==> b equiv a (mod n)$

ez azert jo mert ezzel egyenletszeruen meg tuduk oldani problemakat

$ a,b,c,m in bb(Z) "  " m != 0 $
$ a b equiv a dot c "  " (mod m) <==> b equiv c "  " (mod m/((a, m))) $

== 1. pelda
$ 2 equiv 6 "  " (mod 6) ==> 1 equiv 4 "  " (mod 6/2 = 3) $

== 2. pelda
$ a x equiv b "  " (mod m) $

ennek tobb megoldasa is lehet, ehhez valamiert eleg $n$ proba (ennyi probalkozasbol garantaltam megtalaljuk a megoldast, de nem mindig van szuksegunk mindre)

$ a x equiv b "  " (mod m) "megoldhato" <==> (a, m) | b "es" (a, m) "db inkongurens megoldas van" $

= 2
Milyen $x in bb(Z)$ egeszek elegitik ki a kovetkezo kongurenciakat?
== 2/a
$ x equiv 1 mod 3 $
probalgassuk vegig nullatol $n$-szer
$ "ha" x = 0 ==> 0 equiv.not 1 $
$ "ha" x = 1 ==> 1 equiv 1 $
$ "ha" x = 2 ==> 2 equiv.not 1 $

$1$ az egyetlen helyes megoladas $==> x equiv 1 mod 3$

== 2/b
$ 2x equiv 1 mod 3 $
$ 2 dot 0 equiv.not 1 $
$ 2 dot 1 equiv.not 1 $
$ 2 dot 2 = 4 equiv 1 $
$ x = 2 mod 3 $

== 2/c
$ 2x equiv 1 mod 4 $
$ 2 dot 0 equiv.not 1 $
$ 2 dot 1 equiv.not 1 $
$ 2 dot 2 equiv.not 1 $
$ 2 dot 3 equiv.not 1 $
$ 2 dot 4 equiv.not 1 $

nincs megoldas azert mert a 2 meg a 4 relativ primek de ezt ki lehet deriteni mashogy is ilyen tiltott technikaval

$ (2, 4) = 2 "es" 2 divides.not.rev 1 "tehat nincs megolas" $

== 2/d
$ 2x equiv 2 mod 4 $

ketfele modon lehet csinalni

1. ugy ahogy eddig
nezzuk meg hogy van-e egyaltalan megoldas
$ (2, 4) = 2 "  " 2|2 $
ketto megolas van, nezzuk meg mik azok

$ 2 dot 0 = 0 equiv.not 2 $
$ 2 dot 1 = 2 equiv 2 $
$ 2 dot 2 = 4 equiv.not 2 $
$ 2 dot 3 = 6 equiv 2 $

$ x equiv 1, x equiv 3 mod 4 $

2. az elejen keplettel le lehet osztani
$ 2x equiv 2 mod 4 $
$ x equiv 1 mod 4/((4,2)) = 2 $
$ x equiv 1 mod 2 $

a ket megoldas ekvivalens

#pagebreak()
hogy ha van benne valami nem linearis dolog akkor nehez lesz (nem tudjuk megcsinalni az ellenorzest, stb)

meg kell nezni az osszes lehetoseget

$ x^2 equiv 1 mod 5 $
$ 0^2 = 0 equiv.not 1 $
$ 1^2 = 1 equiv 1 $
$ 2^2 = 4 equiv.not 1 $
$ 3^2 = 9 equiv.not 1 $
$ 4^2 = 16 equiv 1 $

$ x equiv 1 "vagy" x equiv 4 mod 5 $

== 3
$ 2 = i "  " w = 1/2 + sqrt(3)/2i $

mely $n in bb(Z) : z^n = w^n = 1?$

$ z^4 = i^4 = 1 ==> z^(4 dot 1) = 1 $
$ w^2 = 1/4 + (2 sqrt(3))/4 + 3/4 dot (-1) = -1/2 + sqrt(3)/2i $
$ w^3 = (-1/2+sqrt(3)/2i)(1/2 + sqrt(3)/2i) = -1/4 - sqrt(3)/4 i + sqrt(3)/4i -3/4 = -1 $

ebbol ki lehet talani hogy

$ w^6 = 1 ==> w^(6 dot k) = 1 $

ezzel a tudassal ki lehet talalni azt is hogy

$ z^4 = 1, w^6 = 1 " lcm"(6,4) = 12 $

ez azt jelenti hogy

$ z^(12 dot k) = w^(12 dot k) = 1 $

#pagebreak()
== 4
ket dolgot kell bebizonyitani, ZH-n nem kell de egyszer latnia kell mindenkinek

=== 1. tetel
$ (c a, c b) = c (a, b) $

bizonyitas:
$ d = (a,b) ==> d|a, "    " d|b ==> c d | c a, "    " c d | c b ==> c d | (c a, c b) $

$ d = (a, b) ==> d = a x + b y "    " x,y in bb(Z) $

$ c d = c a x + c b y ==> (c a, c b) | c d <== d = (a,b) $

tehat valoban

$ (c a, c b) = c(a, b) $

$square.stroked$
\ \

=== 2. tetel
$ (a,b) = (a-b, b) $
biz:

$ d = (a, b) ==> d = a x + b y = a x + b y - b x + b x = (a - b)x + b(x + y) ==> (a - b, b) | d $

$ d = (a,b) ==> d | a, "    " d | b ==> d | (a-b) ==> d | b, "    " d | a-b ==> d | (a-b,b) $

tehat valoban

$ (a,b) = (a-b, b) $

ez a ketto kell hogy meg tudjuk oldani a negyest

#pagebreak()
== 4/a
$ (2^13 - 1, 2^8 - 1) = ? $

elso azonossagot hasznaljuk

$ (2^13 - 1, 2^8 - 1) = (2^13 - 1 - 2^8 + 1, 2^8 - 1) = (2^13 - 2^8, 2^8 - 1) = (2^8(2^8 - 1), 2^8 - 1) = (2^5 - 1, 2^8 - 1) $

ezt akkor lehet leosztani a bal oldallal ha a jobb oldal relativ primje. ha leosztjuk egy olyan szammal a bal oldalt amivel a jobb relativ prim akkor az eredmenyen ez nem fog valtoztatni, ezert ez szabad.

pl $(6, 2) = 2$, itt leoszthatok harommal: $(2, 2) = 2$

$ (2^5 - 1, 2^8 - 1) = (2^5 - 1, 2^8 - 1 - 2^5 - 1) = (2^5 - 1, 2^5(2^3 - 1)) = (2^5 - 1, 2^3 - 1) = $

lehetne tovabb vinni de mar nagyon uncsi

$ = (31, 7) = 1 $

= megjegyzes:

$ (a, b) = 1 <==> "relativ prim" $

== 4/b
hell na i ain doin allat

== 5
eloszor definialjuk a fibonacci sorozatot:

$ F_1 = F_2 = 1, "  " n >= 1 $
$ F_(n + 2) = F_n + F_(n + 1) $

kerdes: bizonyitsd be hogy $(F_(n+1), F_n) = 1$

bizonyitas:

$ F_(n+2) - F_(n+1) = F_n $

az elejen hasznalt tablat hasznalva (a jobb oszlopot ignoralva):
$ #table(
  columns: (auto, auto),
  [$F_(n+1)$], [],
  [$F_(n)$], [],
  [$F_(n-1)$], [],
  [$F_(n-2)$], [],
  [$dots$], [],
  [1], [],
  [0], [],
) $

addig mentunk hogy elertunk a sorozat elejehez

legalja 0, az azelotti tag pedig $F_1 = 1$

ezzel igazoltuk hogy $(F_(n+1), F_n) = 1$

