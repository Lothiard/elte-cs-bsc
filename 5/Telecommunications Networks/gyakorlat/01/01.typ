== Alapfogalmak
- *Sávszélesség (Bandwidth, $C$):* legnagyobb adatsebesség (b/s). Példa: 1 Gbit/s.
- *Késleltetés (Latency, $L$):* egy csomag egyirányú ideje (s). *RTT:* oda-vissza idő.
- *Jitter:* késleltetés ingadozása (szórás vagy max-min).
- *Kihasználtság (Utilization, $rho$):* terhelés/kapacitás arány.

== Prefixek & átváltások
*Gyakori átváltások:*
- $1 "B" = 8 "b"$
- $1 "MB/s" ("decimális") = 8 "Mb/s"$
- $1 "Gbit/s" = 1000 "Mbit/s" = 10^9 "b/s"$

*Példa:* $125 "MB/s" = 1000 "Mb/s" = 1 "Gb/s"$.

== Késleltetés
- *Terjedési késleltetés (Propagation, $L_p$):*
  - Képlet: $L_p = "Távolság" / "terjedési sebesség"$
  - Vákum = $3 times 10^8 "m/s"$; vezeték = $2 times 10^8 "m/s"$ ($approx 5 mu "s/km"$)
- *Egyéb késleltetési összetevők:*
  - $L_s$: Sorbaállítási késleltetés (Serialization)
  - $L_("proc")$: Feldolgozási késleltetés (Processing)
  - $L_q$: Sorbanállási késleltetés (Queuing)
- *RTT képlet:* $"RTT" = 2 dot L_p + "egyéb"$

*Gyakorlati példák (egyirányú terjedés):*
- 100 km szál: $L_p = 100 "km" dot 5 mu "s/km" = 0.5 "ms"$.
- 1000 km szál: $L_p = 1000 "km" dot 5 mu "s/km" = 5 "ms"$.

#figure(
  image("kesleltetesek.gif", width: 80%),
)

== Alap képletek (sebesség, idő, méret)
- *Bitidő:* $t_b = 1 / C$
- *Idő egy keretre:* $t = "méret_bitben" / C$
- *Átvitt adat adott idő alatt:* $"adat" = C dot t$

*Hasznos hatásfok ($E$):*
- $E = "hasznos_biteket" / "összes_átvitt_bit"$
- $"Goodput" = E dot C$

== Egyszerű feladatok – Kidolgozás és Megoldás

=== 1. Átviteli idő
_Feladat:_ Mennyi idő alatt továbbítunk 60 MB adatot egy 100 Mbit/s linken (overhead nélkül)?

*Megoldás:*
- Adatméret bitben: $D = 60 "MB" = 60 dot 8 "Mbit" = 480 "Mbit" = 480 dot 10^6 "bit"$.
- Link sebessége: $C = 100 "Mbit/s" = 100 dot 10^6 "bit/s"$.
- Átviteli idő: $t = D / C = (480 "Mbit") / (100 "Mbit/s") =$ *4.8 mp*

=== 2. Propagációs késés
_Feladat:_ Mennyi a terjedési késleltetés 200 km hosszú optikai szálon ($5 mu "s/km"$)?

*Megoldás:*
- $L_p = 200 "km" dot 5 mu "s/km" = 1000 mu "s" =$ *1 ms*

=== 3. RTT becslés
_Feladat:_ Egy adatcsomag 1000 km szálon halad ($5 mu "s/km"$). Becsüld meg az RTT-t, úgy hogy a hálózati eszközök feldolgozása további fix 2 ms késleltetést ad irányonként!

*Megoldás:*
- Egyirányú terjedési késleltetés: $L_p = 1000 "km" dot 5 mu "s/km" = 5 "ms"$.
- Egyirányú teljes késleltetés: $L_("egyirányú") = L_p + L_("proc") = 5 "ms" + 2 "ms" = 7 "ms"$.
- Oda-vissza idő (RTT): $"RTT" = 2 dot L_("egyirányú") = 2 dot 7 "ms" =$ *14 ms*

=== 4. Hasznos hatásfok
_Feladat:_ Maximális csomagméret (MTU) = 1500 B, ebből az IP fejléc (min): 20 B, TCP fejléc (min): 20 B. Számoljuk ki a hasznos hatásfokot százalékban. Mennyi a goodput 1 Gbps linken?

*Megoldás:*
- Fejlécek összege: $20 "B" + 20 "B" = 40 "B"$.
- Hasznos teher (payload): $1500 "B" - 40 "B" = 1460 "B"$.
- Hasznos hatásfok: $E = 1460 / 1500 = 73 / 75 approx$ *97.33%*.
- Goodput 1 Gbps linken: $"Goodput" = E dot C = 0.97333 dot 1 "Gbps" =$ *973.33 Mbps*.

== Komplexebb feladatok – Kidolgozás és Megoldás

=== Adatközpont költöztetés – hálózati mentés vs. fizikai szállítás
*Adatok:* $V$ (TB) adat, 3000 km távolság.
- Hálózati költség: $C_("net")(V) = 500 + 20 V$ [€]
- Fizikai költség: $C_("phys")(V) = 2000 + 5 V$ [€]

*a) Költségek 40 TB és 300 TB esetén:*
- *40 TB esetén:*
  - $C_("net")(40) = 500 + 20 dot 40 = 500 + 800 =$ *1300 €*
  - $C_("phys")(40) = 2000 + 5 dot 40 = 2000 + 200 =$ *2200 €*
  - *Eredmény:* 40 TB-nál a *hálózati átvitel olcsóbb* (1300 € < 2200 €).
- *300 TB esetén:*
  - $C_("net")(300) = 500 + 20 dot 300 = 500 + 6000 =$ *6500 €*
  - $C_("phys")(300) = 2000 + 5 dot 300 = 2000 + 1500 =$ *3500 €*
  - *Eredmény:* 300 TB-nál a *fizikai szállítás olcsóbb* (3500 € < 6500 €).

*b) Egyensúlyi adatméret ($V^*$):*
- Feltétel: $C_("net")(V^*) = C_("phys")(V^*)$
- $500 + 20 V^* = 2000 + 5 V^* arrow.r 15 V^* = 1500 arrow.r$ *$V^*$ = 100 TB*
- $V < 100 "TB"$ esetén a hálózat, $V > 100 "TB"$ esetén a fizikai szállítás éri meg jobban.

*c) Átviteli idő 10 Gbit/s linken (80% hatékonyság) 100 TB-ra:*
- Hatékony sávszélesség: $C_("eff") = 0.8 dot 10 "Gbit/s" = 8 "Gbit/s" = 8 dot 10^9 "bit/s"$.
- Adatméret (decimális konvencióval): $100 "TB" = 100 dot 10^12 "B" = 800 dot 10^12 "bit"$.
- Idő: $t = (800 dot 10^12 "bit") / (8 dot 10^9 "bit/s") = 10^5 "s" =$ *27.78 óra* (kb. 1 nap 3 óra 47 perc).
- *(Bináris $1 "TiB" = 2^40 "B"$ esetén: $t approx 30.54 "óra"$.)*
- *Összehasonlítás:* A hálózati átvitel (~27.8 óra) lényegesen gyorsabb a fizikai szállítás *3 napos (72 órás)* átfutási idejénél, miközben $100 "TB"$-nál a költségük azonos (2500 €).

=== Hibrid adatmentési stratégia
Költségmodell: $C_("hybrid")(N) = F + a dot N + b dot (V - N) + c dot (V - N)^2$, ahol $0 <= N <= V$.

*1. Első derivált és lokális szélsőérték ($N^*$):*
- Deriváljunk $N$ szerint (a láncszabályt alkalmazva a $(V-N)^2$ tagra):
  $ (d C_("hybrid")) / (d N) = a - b + c dot 2(V - N) dot (-1) = a - b - 2c(V - N) $
- Szélsőérték feltétele ($(d C) / (d N) = 0$):
  $ a - b - 2c(V - N^*) = 0 arrow.r 2c(V - N^*) = a - b arrow.r V - N^* = (a - b) / (2c) $
  $N^* = V - (a - b) / (2c)$

*2. Második derivált és a szélsőérték jellege:*
- $ (d^2 C_("hybrid")) / (d N^2) = (d) / (d N) [a - b - 2c V + 2c N] = 2c $
- Mivel $c > 0$, így a második derivált szigorúan pozitív ($2c > 0$), tehát az $N^*$ pontban *lokális minimum* van.

*3. Numerikus példa:*
- Paraméterek: $V = 150 "TB", F = 3500 "€", a = 30 "€/TB", b = 20 "€/TB", c = 0.05 "€/TB"^2$.
- *$N^*$ kiszámítása:*
  $N^* = 150 - (30 - 20) / (2 dot 0.05) = 150 - 10 / 0.1 = 150 - 100 =$ *50 TB*
  - *Intervallum ellenőrzése:* $N^* = 50 "TB" in [0, 150]$, tehát az érvényes tartományba esik.
- *Költségek kiszámítása:*
  - $C(N^*) = C(50) = 3500 + 30(50) + 20(100) + 0.05(100)^2 = 3500 + 1500 + 2000 + 500 =$ *7500 €*
  - $C(0) = 3500 + 30(0) + 20(150) + 0.05(150)^2 = 3500 + 3000 + 1125 =$ *7625 €*
  - $C(150) = 3500 + 30(150) + 20(0) + 0.05(0)^2 = 3500 + 4500 + 0 =$ *8000 €*
- *Magyarázat:* Ha $N < 50$ (túl kevés fizikai szállítás), a hálózati kvadratikus torlódási díj túlságosan megdrágítja az átvitelt. Ha $N > 50$ (túl sok fizikai szállítás), a fizikai szállítás magasabb alapdíját ($a = 30$ vs $b = 20$) fizetjük feleslegesen. Az $N^* = 50 "TB"$ biztosítja a minimális összköltséget ($7500 "€"$).

= Keretezés – bit és bájtbeszúrás

== Bitbeszúrás (bit stuffing)
- *Használata:* pl. HDLC és CAN protokollokban.
- *Működése:* minden 5 egymást követő 1-es bit után a küldő automatikusan 0-át szúr be.
- *Cél:* biztosítani, hogy a kerethatároló speciális bitmintája (pl. `01111110`) ne jelenjen meg a hasznos adatban.
- A vevő oldalon a dekódoló eltávolítja ezeket a beszúrt 0-kat.

*Példa:*
- Adat: `01111110` (megegyezik a kerethatárt jelző flag-gel)
- Küldő bit stuffing után: `011111010`
- Vevő: felismeri és eltávolítja a beszúrt 0-t, így visszakapja az eredeti bitmintát.

== Bájtbeszúrás (byte stuffing, karakterbeszúrás)
- *Használata:* pl. PPP és más byte-orientált protokollokban.
- *Működése:* ha a hasznos adat tartalmazza a vezérlő karaktert (pl. `0x7E` = keretflag), akkor előtte beszúrnak egy escape karaktert (pl. `0x7D`).
- Ha az adat maga escape karaktert (`0x7D`) tartalmaz, akkor azt is kiegészítik (pl. `0x7D` $arrow.r$ `0x7D7D`).
- A vevő oldalon az escape szekvenciákat visszaalakítják az eredeti adatra.

*Példa:*
- Keret flag: `0x7E`, Escape: `0x7D`
- Adat: `0xAA` $arrow.r$ nincs átalakítás: `0xAA`
- Adat: `0x7E` $arrow.r$ átalakítva: `0x7D7E`
- Adat: `0x7D` $arrow.r$ átalakítva: `0x7D7D`

== Összehasonlítás
- *Bit stuffing:* bitenként működik, bitorientált protokollokban.
- *Byte stuffing:* bájtonként működik, karakterorientált protokollokban.
Mindkét módszer biztosítja, hogy a vezérlő szimbólumok ne keveredjenek az adattal, de egyben növelik a tényleges adat méretét (overhead).

== Feladatok – Kidolgozás és Megoldás

=== 1. Bitbeszúrás feladat
_Feladat:_ Az `11111110011111` üzenet hogy fog kinézni a bitbeszúrásos módszer (5 egymást követő 1-es után 0 beszúrása) alkalmazása után?

*Megoldás:*
- Bontsuk elemeire az eredeti bitfolyamot az 1-esek számlálásával:
  - `1 1 1 1 1` (5 db 1-es) $arrow.r$ *beszúrás:* `0`
  - `1 1 0 0` (folytatás, a számláló törlődik a nulláknál)
  - `1 1 1 1 1` (újabb 5 db 1-es) $arrow.r$ *beszúrás:* `0`
- Eredeti: `11111` `1` `100` `11111`
- Beszúrt bitekkel: `11111`*0*`1100``11111`*0*
- *Végeredmény:* *1111101100111110*

=== 2. Bájtbeszúrás feladat
_Feladat:_ Hogy kerül átvitelre a következő adat:
#figure(
  image("byte.png", width: 80%),
)

*Megoldás:*
- Minden `FLAG` elé egy `ESC` karaktert szúrunk be.
- Minden `ESC` elé egy `ESC` karaktert szúrunk be.
- Átalakítás lépésről lépésre:
  - `FLAG` $arrow.r$ `ESC FLAG`
  - `ESC` $arrow.r$ `ESC ESC`
- *Végeredmény (adatmező):*
  *[ A ] [ B ] [ C ] [ ESC ] [ FLAG ] [ D ] [ ESC ] [ ESC ] [ ESC ] [ FLAG ] [ E ] [ F ] [ ESC ] [ FLAG ] [ ESC ] [ FLAG ] [ G ]*
_(A teljes keretnél a keret elejére és végére egy-egy nyitó/záró `[ FLAG ]` is kerül.)_


=== 3. Kerethossz és eredeti adatméret feladat
_Feladat:_ Bájt-alapú protokoll, keretek nyitó és záró `FLAG` bájttal. 8 keret küldése, összhossz a médiumon: 2048 Byte. Az eredeti adatban 16 `ESC` és 8 `FLAG` bájt volt. Hány bájtból állt az eredeti adat?

*Megoldás:*
- Jelölje $D_("orig")$ az eredeti adat bájtszámát.
- *1. Kerethatárolók:* 8 keret $times 2$ (`FLAG` keretenként) = 16 Byte overhead.
- *2. Bájtbeszúrás overhead:*
  - 8 eredeti `FLAG` miatt $+8$ `ESC` bájt beszúrása.
  - 16 eredeti `ESC` miatt $+16$ `ESC` bájt beszúrása.
  - Összes beszúrt bájt (overhead) = $8 + 16 = 24$ Byte.
- *Egyenlet:*
  $ "Teljes méret" = D_("orig") + "Kerethatárolók" + "Beszúrt ESC bájtok" $
  $ 2048 = D_("orig") + 16 + 24 $
  $ 2048 = D_("orig") + 40 $
  $D_("orig") = 2048 - 40 =$ *2008 Byte*
