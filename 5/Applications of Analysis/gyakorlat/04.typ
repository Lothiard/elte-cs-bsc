= Felszínszámítás paraméteres felületekkel

== Paraméteres felületek

Eddig függvény grafikonjaként adtunk meg felületet:
$
  z = f(x, y), " " (x, y) in cal(D)_f
$
ennek a grafikonja
$
  {(x, y, f(x, y)) : (x, y) in cal(D)_f}, " " (f in C) " felület"
$

Az eddigi módszereinkkel ebben az alakban könnyű volt dolgozni, de például a felszín számolása már nem lenne túl könnyű: ha van ilyen függvény által meghatározott felület, a felszín kiszámolása elég bonyolult lehet. Ezért általánosíthatunk, és ún. *paraméteres felületet* használhatunk. Az alapötlet annyi, hogy a koordinátaharmasokat két változóhoz rendeljük, de három darab koordinátafüggvénnyel adjuk meg. Úgy általánosítottunk, hogy
$
  (u, v) in [a, b] times [c, d]
$
két intervallum direktszorzatának eleme, és erre tekintünk egy
$
  Phi : [a, b] times [c, d] arrow RR^3, " " Phi in C
$
függvényt, aminek a pontjait úgy foghatom fel, hogy három koordinátafüggvényből áll, azaz
$
  {Phi(u, v) = (g_1(u, v), g_2(u, v), g_3(u, v)) : (u, v) in [a, b] times [c, d]}
$
Ez a *paraméterezett felület*.

Például
$
  Phi(u, v) = (u^2, 2u cos(v), 2u sin(v)), " " (u, v) in [0, 1] times [0, pi/2]
$
egy paraméterezéssel megadott felület. Ez azt mondja, hogy egy adott $(u, v)$ értékre olyan pontokat kell vennünk, hogy
$
  x = u^2, " " y = 2u cos(v), " " z = 2u sin(v)
$
ahol
$
  y^2 + z^2 = 4u^2 cos^2(v) + 4u^2 sin^2(v) = 4u^2 = 4x <==> x = (y^2 + z^2)/4
$
tehát ez egy $(y, z)$ feletti forgásparaboloid, ahol
$
  0 <= u <= 1 <==> 0 <= x <= 1 <==> 0 <= y^2 + z^2 <= 4
$
Tehát megint azt akarom csinálni, hogy
$
  x = f(y, z) = (y^2 + z^2)/4
$
Ezek a pontok egy $2$ sugarú körben vannak -- ezzel az egyik feltételt (hogy $0 <= y^2 + z^2 <= 4$) már el is intéztük.

Ha megnézzük, hogy
$
  v in [0, pi/2]
$
akkor látjuk, hogy ez az első síknegyedben van, tehát
$
  y >= 0, " " z >= 0
$
Összességében tehát egy negyedkört kapok ($2$ sugárral).

Itt az észrevétel az, hogy a feladatban el van dugva egy kör polárkoordinátás megadása az $y$-ban és $z$-ben. Lehetett volna úgy is, hogy
$
  mat(y; z) = 2 dot mat(r cos(phi); r sin(phi)), " polárkoordináták: " r in [0, 1], " " phi in [0, pi/2]
$

== Felületi normális

Kulcsszerepe lesz az ún. *felületi normálisnak*, ami egy olyan vektor, ami merőleges a felületre minden pontban. Ezt úgy kell értenünk, hogy ha veszek valamilyen $Phi(u, v) in RR^3$ paraméterezett felületet, akkor a felület minden pontjában van egy olyan vektor, ami merőleges a felületre -- ezt a felület normálvektorának hívjuk.

Ha visszagondolunk az eredeti függvényes alakra, az sokat segít a megértésben. Az eredeti függvény által meghatározott felület esetén
$
  Phi(u, v) = (u, v, f(u, v))
$
a parciális deriváltak
$
  partial_u Phi(u, v) = (1, 0, partial_u f(u, v)),\
  partial_v Phi(u, v) = (0, 1, partial_v f(u, v))
$
Ezek minden pontban megadják az érintő meredekségét -- ez egy *érintővektor* lesz.

Ha elképzelek egy $x z$ szerinti síkmetszetet egy ilyen függvénynek, és egy adott pontban veszem a parciális deriváltat, akkor egy érintővektort úgy tudok csinálni, hogy az $u$ irányába lépek egyet -- ez az $(1, 0, 0)$ vektor --, utána pedig annyit akarok felfelé lépni, amennyi a meredekség, ami $(0, 0, partial_u f)$. Ezek összege $(1, 0, partial_u f)$.

Ezeket a vektorokat a paraméterek szerint is lehet értelmezni; ekkor valamilyen absztrakt halmaz irányával lesznek párhuzamosak.

Paraméterezés szerinti érintők: ezek magának a $Phi$ függvénynek a parciális deriváltjai lesznek, ismét:
$
  partial_u Phi(u, v) in RR^3\
  partial_v Phi(u, v) in RR^3
$

A normálvektor egy fokkal komplikáltabb. Az érintők meghatároznak egy érintősíkot, és a felületi normális erre a síkra merőleges vektor. Két lehetséges irányú vektor létezik ilyenkor, a két irányba. Ilyen vektort ki lehetne számolni, pl. Gram--Schmidt-ortogonalizációval, de ahelyett van egy zárt képlet: a vektoriális szorzat képlete.

A felületi normális az előző két vektor síkjára merőleges vektor, vektoriális szorzással megadva:
$
  n_Phi (u, v) = partial_u Phi(u, v) times partial_v Phi(u, v) = mat(
    delim: "|",
    bold(i), bold(j), bold(k);
    partial_u g_1, partial_u g_2, partial_u g_3;
    partial_v g_1, partial_v g_2, partial_v g_3
  )
$
ahol $bold(i), bold(j), bold(k)$ a koordinátatengelyekkel párhuzamos vektorok, tehát a kanonikus bázis.

Például
$
  Phi(u, v) = (u^2, 2u cos(v), 2u sin(v))\
  partial_u Phi(u, v) = (2u, 2 cos(v), 2 sin(v))\
  partial_v Phi(u, v) = (0, -2u sin(v), 2u cos(v))
$
ebből
$
  n_Phi (u, v) = mat(
    delim: "|",
    bold(i), bold(j), bold(k);
    2u, 2 cos(v), 2 sin(v);
    0, -2u sin(v), 2u cos(v)
  )
$
Ezt a determinánst az első sor szerint kell kiszámolni: úgy kezdődik, hogy $bold(i)$ szer valami, és abból az aldeterminánsból megkapom az $bold(i)$ szerinti koordinátát.
$
  = bold(i) (4u cos^2(v) - (-4u sin^2(v))) - bold(j) (4u^2 cos(v) - 0) + bold(k) (-4u^2 sin(v) - 0) =\
  = 4u bold(i) - 4u^2 cos(v) bold(j) - 4u^2 sin(v) bold(k) =\
  = (4u, -4u^2 cos(v), -4u^2 sin(v))
$

== A felszín

Ennek az alkalmazása a paraméterezett felület felszínének kiszámolása: itt a felületi normális kettes normáját kell integrálni. Annyi feltétel van, hogy
$
  Phi in C^1 ([a, b] times [c, d]) " esetén"
$
$
  A_Phi = integral_([a, b] times [c, d]) norm(n_Phi (u, v))_2 dif u dif v
$

Speciális eset:
$
  Phi(u, v) = (u, v, f(u, v))\
  A_Phi = integral_([a, b] times [c, d]) sqrt(1 + (partial_u f(u, v))^2 + (partial_v f(u, v))^2) dif u dif v
$
(Ekkor ugyanis $n_Phi = (-partial_u f, -partial_v f, 1)$.)

Ez azért nem kell meglepő legyen, mert Analízis 2-n az ívhossz képletét vettük, és ez azzal teljesen analóg:
$
  integral_a^b sqrt(1 + [f'(x)]^2) dif x
$

A példánkban:
$
  A_Phi = integral_([0, 1] times [0, pi/2]) sqrt((4u)^2 + (-4u^2 cos(v))^2 + (-4u^2 sin(v))^2) dif u dif v =\
  = integral_0^(pi/2) integral_0^1 sqrt(16u^2 + 16u^4 cos^2(v) + 16u^4 sin^2(v)) dif u dif v =\
  = integral_0^(pi/2) integral_0^1 4 sqrt(u^2 + u^4) dif u dif v =\
  = integral_0^(pi/2) integral_0^1 4 sqrt(u^2 (1 + u^2)) dif u dif v =_(u >= 0) integral_0^(pi/2) integral_0^1 4u sqrt(1 + u^2) dif u dif v =\
  = 2 integral_0^(pi/2) integral_0^1 2u sqrt(1 + u^2) dif u dif v =\
  = 2 integral_0^(pi/2) [((1 + u^2)^(3/2))/(3/2)]_(u = 0)^1 dif v =\
  = 4/3 (sqrt(8) - 1) integral_0^(pi/2) 1 dif v = underline(underline((2pi)/3 (sqrt(8) - 1)))
$

== Euler--Monge-paraméterezés és implicit felületek

Még egy elnevezés, mert lehet, hogy a ZH-ban is így fognak rá hivatkozni: ezt a paraméterezést ($Phi(u, v) = (u, v, f(u, v))$), amikor valós függvény által definiált felszínről van szó, a környékünkön -- és főleg a volt orosz területeken -- *Euler--Monge-paraméterezésnek* nevezzük.

Nagyon gyakran előfordul, hogy egy felület nem függvénygrafikonként van megadva, és nem is paraméterezéssel, hanem valamilyen egyenlet definiálja. Ilyenkor az a célunk, hogy függvénygrafikonként vagy paraméterezett általános felületként adjuk meg. Az egyenlettel való megadást szebben úgy mondhatjuk, hogy *implicit megadás*.

=== 1. példa

$
  x^2 = 2y z, " " (x in [0, 1], " " y in [1, 2])
$

Ez kicsit gagyi példa, mert nincs is korlát $z$-re; csak annyit kell hozzá felfognunk, hogy ebből akkor lesz felület, ha $z$-re fejezzük ki a többit -- és hát ha $2y$-nal leosztunk, kész is vagyunk:
$
  x^2/(2y) = z
$
tehát
$
  z = f(x, y) = x^2/(2y) " függvény grafikonja"
$

Ha a felszín a kérdés, Euler--Monge-paraméterezéssel:
$
  Phi(u, v) = (u, v, u^2/(2v)), " " (u, v) in cal(D)_f
$
ahol
$
  f in C^1
$
Használjuk azt a képletet, amit levezettünk az elméleti résszel:
$
  A_Phi = integral_1^2 integral_0^1 sqrt(1 + (partial_u f(u, v))^2 + (partial_v f(u, v))^2) dif u dif v\
  partial_u f(u, v) = (2u)/(2v) = u/v\
  partial_v f(u, v) = (u^2)/2 dot (-1)/v^2 = -(u^2)/(2v^2)
$
Visszatérve a felszínre:
$
  A_Phi = integral_1^2 integral_0^1 sqrt(1 + (u/v)^2 + ((-u^2)/(2v^2))^2) dif u dif v =\
  = integral_1^2 integral_0^1 sqrt((4v^4 + 4u^2 v^2 + u^4)/(4v^4)) dif u dif v =\
  = integral_1^2 integral_0^1 sqrt(((2v^2 + u^2)^2)/((2v^2)^2)) dif u dif v =\
  = integral_1^2 integral_0^1 (2v^2 + u^2)/(2v^2) dif u dif v =\
  = integral_1^2 integral_0^1 1 + u^2/(2v^2) dif u dif v =\
  = integral_1^2 [u + u^3/(6v^2)]_(u = 0)^1 dif v = integral_1^2 1 + 1/(6v^2) dif v =\
  = [v - 1/(6v)]_1^2 = underline(underline(1 + 1/12))
$

=== 2. példa

$
  2z = 4 - x^2 - y^2, " " z in [0, 1]
$
Ez a korlát miatt lesz érdekes.
$
  z = (4 - x^2 - y^2)/2, " " cal(D)_f = ?
$
$
  z = 0: " " 0 = (4 - x^2 - y^2)/2 <==> x^2 + y^2 = 4 " (2 sugarú kör)"\
  z = 1: " " 1 = (4 - x^2 - y^2)/2 <==> x^2 + y^2 = 2 " (" sqrt(2) " sugarú kör)"
$
$
  z in [0, 1] " rögzített értékre: " z = (4 - x^2 - y^2)/2 <==> x^2 + y^2 = 4 - 2z " (tehát " sqrt(4 - 2z) " sugarú kör)"
$
Tehát minden egyes magasságban egy egyre kisebb sugarú kör szerepel, de nem ér össze egy pontban, mert le van vágva -- szóval ez egy forgásparaboloid-darab.

Itt az a gond, hogy a felület, amiről beszélünk, nem tartalmazza a felső és az alsó kört, ami fent és lent van "levágva". Tulajdonképpen csak a "palást" kell.

Ebben a felírásban az értelmezési tartomány
$
  cal(D)_f = {(x, y) in RR^2 : 2 <= x^2 + y^2 <= 4} " (a két kör közötti körgyűrű)"
$
Itt az értelmezési tartomány nem egy intervallum(szorzat), ezért az Euler--Monge-paraméterezés itt nem működik közvetlenül.

Az ötlet annyi, hogy az $x, y$ változókat polárkoordinátákkal fejezzük ki:
$
  (x, y) arrow (r, phi)
$
$
  x = r cos(phi)\
  y = r sin(phi)\
  (r, phi) in [sqrt(2), 2] times [0, 2pi]\
  z = (4 - x^2 - y^2)/2 = (4 - (r cos(phi))^2 - (r sin(phi))^2)/2 = (4 - r^2)/2\
  Phi(r, phi) = (r cos(phi), r sin(phi), (4 - r^2)/2), " ahol " (r, phi) in [sqrt(2), 2] times [0, 2pi]
$
