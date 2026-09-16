= Alapfogalmak

- *Sávszélesség (Bandwidth, $C$):* legnagyobb adatsebesség (b/s). Példa: $1 "Gbit/s"$.
- *Késleltetés (Latency, $L$):* egy csomag egyirányú ideje (s). RTT: oda-vissza idő.
- *Jitter:* késleltetés ingadozása (szórás vagy max–min).
- *Kihasználtság (Utilization, $rho$):* terhelés/kapacitás arány.

== Prefixek & átváltások

Gyakori átváltások:
- $1 "B" = 8 "b"$
- $1 "MB/s" ("decimális") = 8 "Mb/s"$
- $1 "Gbit/s" = 1000 "Mbit/s" = 10^9 "b/s"$

*Példa:* $125 "MB/s" = 1000 "Mb/s" = 1 "Gb/s"$.

== Késleltetés

- *Terjedési késleltetés (Propagation, $L_p$):*
  - *Képlet:* $L_p = "távolság" / "terjedési sebesség"$
  - Vákuum $approx 3 times 10^8 "m/s"$; vezeték $approx 2 times 10^8 "m/s"$ ($approx 5 mu "s/km"$)
- *Egyéb:* pl. Sorosítási késleltetés (Serialization, $L_s$), Feldolgozási késleltetés (Processing, $L_"proc"$), Sorbanállási késleltetés (Queuing, $L_q$)
- $ "RTT" approx 2 L_p [+ "egyéb"] $

*Gyakorlati példák (egyirányú):*
- $100 "km"$ szál: $L_p approx 100 "km" times 5 mu "s/km" = 0.5 "ms"$.
- $1000 "km"$ szál: $approx 5 "ms"$.

#figure(
  image("kesleltetesek.gif", width: 80%),
)

== Alap képletek (sebesség, idő, méret)

- *Bitidő:* $t_b = 1 / C$
- *Idő egy keretre:* $t = "méret_bitben" / C$
- *Átvihető adat adott idő alatt:* $"adat" = C times t$

== Hasznos hatásfok ($E$)

- $E = "hasznos_bitek" / "összes_átvitt_bit"$
- $"Goodput" = E times C$

= 1. Egyszerű feladatok

== 1.1 Átviteli idő
- *Adatállomány:* $50 "MB" = 50 times 8 "Mbit" = 400 "Mbit"$
- *Sávszélesség ($C$):* $100 "Mbit/s"$
- *Számítás:*
$ t = "méret" / "kapacitás" = (400 "Mbit") / (100 "Mbit/s") = 4.0 "másodperc" $

== 1.2 Propagációs késés
- *Távolság:* $200 "km"$
- *Terjedési sebesség optikai szálon:* $5 mu "s/km"$
- *Számítás:*
$ L_p = 200 "km" times 5 mu s"/km" = 1000 mu s = 1.0 "ms" $

== 1.3 RTT becslés
- *Egyirányú terjedési késleltetés:* $1000 "km" times 5 mu "s/km" = 5000 mu s = 5 "ms"$
- *Egyirányú hálózati eszközök feldolgozási ideje:* $+ 2 "ms"$
- *Egyirányú teljes késleltetés:* $5 "ms" + 2 "ms" = 7 "ms"$
- *RTT (Round Trip Time, oda-vissza idő):*
$ "RTT" approx 2 times 7 "ms" = 14 "ms" $

== 1.4 Hasznos hatásfok és Goodput
- *Keretméret (MTU):* $1500 "B"$
- *Fejlécek mérete (Overhead):* "IP fejléc" (20 B) + "TCP fejléc" (20 B) = 40 B
- *Hasznos teher (Payload):* $1500 B - 40 B = 1460 B$
- *Hasznos hatásfok ($E$):*
$ E = "hasznos bitek" / "összes átvitt bit" = (1460 B) / (1500 B) approx 0.97333 ==> 97.33% $
- *Goodput 1 Gbps ($1000 "Mbit/s"$) linken:*
$ "Goodput" = E times C = 0.97333 times 1000 "Mbit/s" = 973.33 "Mbit/s" quad (0.9733 "Gbit/s") $

#v(1em)

#pagebreak()
= 2. Komplexebb feladatok

== 2.1 Adatközpont költöztetés – hálózati mentés vs. fizikai szállítás

Adott költségfüggvények:
- $C_"net"(V) = 500 + 20 V quad ["€"]$
- $C_"phys"(V) = 2000 + 5 V quad ["€"]$

=== a) Költségek 40 TB és 300 TB esetén:
- * $V = 40 "TB"$ esetén:*
  - $C_"net"(40) = 500 + 20 times 40 = 500 + 800 = 1300 "€"$
  - $C_"phys"(40) = 2000 + 5 times 40 = 2000 + 200 = 2200 "€"$
  - *Eredmény:* $40 "TB"$ esetén a *hálózati adatmentés* az olcsóbb.

- * $V = 300 "TB"$ esetén:*
  - $C_"net"(300) = 500 + 20 times 300 = 500 + 6000 = 6500 "€"$
  - $C_"phys"(300) = 2000 + 5 times 300 = 2000 + 1500 = 3500 "€"$
  - *Eredmény:* $300 "TB"$ esetén a *fizikai szállítás* az olcsóbb.

=== b) Azonos költségű $V^*$ adatméret (fedezeti pont):
$ C_"net"(V^*) = C_"phys"(V^*) $
$ 500 + 20 V^* = 2000 + 5 V^* $
$ 15 V^* = 1500 ==> V^* = 100 "TB" $
*(Megjegyzés: $100 "TB"$ alatt a hálózati átvitel, $100 "TB"$ felett a fizikai szállítás a gazdaságosabb).*

=== c) Átviteli idő 100 TB hálózati átvitele esetén (10 Gbit/s, 80% hatásfok):
- *Effektív sebesség:* $10 "Gbit/s" times 0.80 = 8 "Gbit/s" = 8 times 10^9 "bit/s"$
- *Átvintendő adat:* $100 "TB" = 100 times 10^(12) "B" = 800 times 10^(12) "bit" = 8 times 10^(14) "bit"$
- *Átviteli idő ($t$):*
$
  t = (8 times 10^(14) "bit") / (8 times 10^(9) "bit/s") = 100 000 "s" approx 27.78 "óra" quad (approx 1 "nap" 3.8 "óra")
$
- *Összehasonlítás:* A hálózati átvitel kb. *27,8 órát* vesz igénybe, ami lényegesen gyorsabb, mint a fizikai szállítás *3 napos (72 órás)* várható átfutási ideje.

#pagebreak()
== 2.2 Hibrid adatmentési stratégia

Költségmodell:
$ C_"hybrid"(N) = F + a N + b(V - N) + c(V - N)^2 quad (0 <= N <= V) $

=== 1. Első derivált és az általános lokális szélsőérték ($N^*$):
Fejtsük ki a deriváltat $N$ szerint:
$ (d C_"hybrid") / (d N) = a - b - 2c(V - N) $

A szélsőérték feltétele $(d C) / (d N) = 0$:
$ a - b - 2c(V - N) = 0 ==> 2c(V - N) = a - b $
$ V - N = (a - b) / (2c) ==> N^* = V - (a - b) / (2c) $

=== 2. Második derivált és a szélsőérték jellege ($c > 0$):
$ (d^2 C_"hybrid") / (d N^2) = d / (d N) [a - b - 2c(V - N)] = 2c $
Mivel $c > 0$, a második derivált értéke *szigorúan pozitív* ($(d^2 C) / (d N^2) = 2c > 0$), így $N^*$-nál *lokális MINIMUM* található.

=== 3. Numerikus példa:
Adatok: $V = 150 "TB"$, $F = 3500 "€"$, $a = 30 "€/TB"$, $b = 20 "€/TB"$, $c = 0.05 "€/TB"^2$.

- * $N^*$ kiszámítása:*
$ N^* = 150 - (30 - 20) / (2 times 0.05) = 150 - 10 / 0.1 = 150 - 100 = 50 "TB" $
- *Ellenőrzés:* $50 in$, tehát az optimum a megengedett intervallumon belülre esik.

- *Költségek kiszámítása ($C(N^*)$, $C(0)$, $C(150)$):*
  - *Optimális pont ($N^* = 50 "TB"$ fizikai, $100 "TB"$ hálózati):*
    $ C(50) = 3500 + 30(50) + 20(100) + 0.05(100)^2 = 3500 + 1500 + 2000 + 500 = 7500 "€" $
  - *Tiszta hálózati átvitel ($N = 0 "TB"$):*
    $ C(0) = 3500 + 30(0) + 20(150) + 0.05(150)^2 = 3500 + 3000 + 1125 = 7625 "€" $
  - *Tiszta fizikai szállítás ($N = 150 "TB"$):*
    $ C(150) = 3500 + 30(150) + 20(0) + 0.05(0)^2 = 3500 + 4500 = 8000 "€" $

- *Miért éri meg az $N^*$ pont? (Magyarázat):*
  - Ha *túl keveset viszünk fizikailag* ($N < 50$), a hálózaton küldött adatmennyiség ($V-N$) nagy lesz. A hálózati díj kvadratikus tagja ($c dot (V-N)^2$) miatt a költségek meredeken elkezdenek növekedni (pl. hálózati torlódás, sávszélességi felárak miatt).
  - Ha *túl sokat viszünk fizikailag* ($N > 50$), a magasabb lineáris fizikai egységár ($a = 30 "€/TB"$ vs. $b = 20 "€/TB"$) növeli meg az összköltséget.
  - Az *$N^"*" = 50 "TB"$* megosztás pontosan kiegyensúlyozza ezt a két hatást, és biztosítja a *lehető legalacsonyabb összköltséget ($7500 "€"$)*.
