= Gömbi koordináták -- példa, és görbék/felületek paraméterezése

== Emlékeztető: gömbi koordináták

/ Emlékeztető: Eddig az alapötlet az volt, hogy van egy pontunk a térben, és a szokásos Descartes-koordináta helyett használunk egy sugarat és két szöget -- ezek a földrajzi koordinátákhoz hasonlítanak egy kicsit. Ilyenkor
$
  0 <= r\
  0 <= Theta <= pi
$
Ahhoz, hogy gömbi koordinátákkal fejezzük ki, kell egy függvény:
$
  mat(x; y; z) = g(r, Theta, phi) = mat(r sin Theta cos phi; r sin Theta sin phi; r cos Theta)
$
és ehhez kell
$
  abs("det " g'(r, Theta, phi)) = r^2 sin Theta
$

== Példa

$
  G = {(x, y, z) in RR^3 : x^2 + y^2 + z^2 <= z} " és a sűrűség egyenesen arányos az origótól mért távolsággal"\
  "Mennyi lesz a test tömege?"
$

(Emlékeztető: $m(G) = integral_G rho(x, y, z) dif x dif y dif z = integral_G alpha sqrt(x^2 + y^2 + z^2) dif x dif y dif z, " ahol " alpha in RR$.)

Két módszer adja magát.

=== 1. módszer: síkmetszetek

Rögzítem valamelyik változó értékét, és síkmetszeteket nézek -- előnyös itt $z$-t rögzíteni, mert akkor egy kört kapok.

Ha pl. $z=0$, akkor $x^2+y^2<=0$, ami csak az origó. Negatív $z$-t is megnézhetnénk, de látszik, hogy az nem fog teljesülni. Ha $z=1$, akkor megint $x^2+y^2<=0$, azaz megint egyetlen pont. A $z-z^2$ alak miatt tudjuk, hogy nem lehet $z>1$, tehát $z in [0,1]$-ben mozgunk.

Ha $z=1/2$, akkor $x^2+y^2 <= 1/2 - 1/4 = 1/4 = (1/2)^2$, ami egy $1/2$ sugarú kör.

Tehát $0<=z<=1$-re $x^2+y^2<=z-z^2$, ami egy $sqrt(z-z^2)$ sugarú kör, azaz
$
  G = {(x,y,z) in RR^3 : " " 0 <= z <= 1 " és " x^2+y^2 <= z - z^2}\
  ==> m(G) = integral_0^1 (integral_(K(z)) alpha sqrt(x^2+y^2+z^2) dif x dif y) dif z
$

Áttérek polárkoordinátákra:
$
  0 <= r <= sqrt(z - z^2), " " 0 <= phi <= 2pi
$

Ezen a polártartományon integrálunk:
$
  integral_0^1 integral_0^(2pi) integral_0^(sqrt(z - z^2)) alpha sqrt(r^2+z^2) dot r dif r dif phi dif z = alpha/2 integral_0^1 integral_0^(2pi) integral_0^(sqrt(z-z^2)) sqrt(r^2+z^2) dot 2r dif r dif phi dif z = dots
$
(Innentől a $u=r^2+z^2$ helyettesítéssel folytatódna, de a jegyzet itt a 2. módszerre vált.)

=== 2. módszer: eltolt gömb

Eddig szinte mindig origó középpontú gömbünk volt, viszont általában a gömb egyenlete $(x-x_0)^2+(y-y_0)^2+(z-z_0)^2=r^2$.

A mostani feladatban $x^2+y^2+z^2-z<=0$, tehát egy teljes négyzetet kéne csinálni, hogy illeszkedjen:
$
  x^2 + y^2 + (z - 1/2)^2 <= 1/4
$
tehát ez egy $(0,0,1/2)$ középpontú, $1/2$ sugarú gömb -- így sokkal olvashatóbb és elegánsabb.

Mivel ez egy gömb, adja magát, hogy gömbi koordinátákat használjunk -- csak hát hogy csináljuk? Eddig azok akkor jöttek ki szépen, ha origó középpontúak voltunk.

/ 1. lehetőség: origó szerinti gömbi koordináták.
/ 2. lehetőség: az origót eltoljuk a $(0,0,1/2)$ pontba.

Ha az eltolást választjuk, akkor
$
  G = {(x,y,z) in RR^3 : x^2+y^2+z^2 <= 1/4} " és " rho(x, y, z) = alpha dot sqrt(x^2+y^2+(z+1/2)^2)
$
de ez innentől kezdve elég triviális, szóval csináljuk inkább az első lehetőséggel.

Megtartjuk, hogy $x^2+y^2+z^2=z$, és akkor
$
  x = r sin Theta cos phi, " " y = r sin Theta sin phi, " " z = r cos Theta\
  <==> r^2 <=_(r >= 0) r cos Theta\
  r <= cos Theta " " ("tehát " 0 <= Theta <= pi/2)
$
és minden $Theta$ értékhez tartozik érték, és
$
  0 <= r <= cos Theta " és " 0 <= phi <= 2pi
$
Mostmár lehet integrálni -- ezzel a lehetőséggel nem változik a sűrűségfüggvény:
$
  m(G) = integral_G alpha sqrt(x^2+y^2+z^2) dif x dif y dif z = integral_0^(pi/2) integral_0^(cos Theta) integral_0^(2pi) alpha dot r dot r^2 sin Theta dif phi dif r dif Theta =\
  = 2pi dot alpha dot integral_0^(pi/2) integral_0^(cos Theta) r^3 sin Theta dif r dif Theta = 2pi dot alpha dot integral_0^(pi/2) sin Theta [r^4/4]_0^(cos Theta) dif Theta =\
  = pi/2 dot alpha dot integral_0^(pi/2) [cos Theta]^4 dot sin Theta dif Theta = -pi/2 dot alpha dot integral_0^(pi/2) [cos Theta]^4 dot (-sin Theta) dif Theta =\
  = -pi/2 dot alpha dot [([cos Theta]^5)/5]_0^(pi/2) = underline(underline((pi alpha)/10))
$

Eddig megfigyelhettük, hogy minden egy Descartes-koordinátarendszerből indult, de a gyakorlatban nem csak ilyenekhez rögzítve lehet megadni a feladatot -- lehet paraméteresen is.

== Görbék és felületek paraméterezése

Egy görbe esetén teljesen természetes, hogy van egy folyamat, aminek az eredménye a görbe. Bevezethetek egy változót, ami egy időbeli változáshoz, vagy bármihez, ami nem jelenik meg a grafikonon, tartozik:
$
  t in [a, b] "-re  " f(t) = (x(t), y(t), z(t)), " " f: [a, b] arrow RR^3, " " f in C
$

Legyen például
$
  t in [0, 2pi] " és " f(t) = (cos t, sin t, 0)
$
ez egy kör.

Egy másik példa:
$
  t in [0, 2pi] " és " f(t) = (cos t, sin t, t)
$
ez abban változik, hogy térben $t$-vel megyünk, szóval ahogy megyünk körbe-körbe, jön elő a $t$ -- tehát egy spirált kapok.

Ezzel analóg módon a felületeket is hasonlóan meg lehet adni, mint a görbéket, például
$
  s, t in [a,b] times [c,d] "-re  " f: [a,b] times [c,d] arrow RR^3, " " f in C\
  f(s,t) = (x(s,t), y(s,t), z(s,t))
$
Ezt egy kicsit nehezebb elképzelni. Korábban találkoztunk $f: RR^2 arrow RR, f in C$ függvényekkel -- a most vizsgált síkok grafikonja $(x, y, f(x,y))$, $x, y in [a,b] times [c,d]$:
$
  Gamma(x, y) = (x, y, f(x, y))
$
ez egy paraméteres módon megadott felület.

Nézzünk egy példát: nézzünk egy gömböt. Rögzítsük a sugarat $1$-re. Lehetne a két paraméter a szögek:
$
  s in [0, pi] " és " t in [0, 2pi]\
  f(s,t) = (sin(s)cos(t), sin(s)sin(t), cos(s))
$
Itt gömbi koordinátákat használtunk a paraméterezéshez.

Legyen a felület
$
  Phi(u, v) = (u^2, 2u cos(v), 2u sin(v)), " " (u,v) in [0,1] times [0, pi/2]
$
Próbáljuk meg elképzelni, hogy ez milyen felület. A kulcs az, hogy vegyük észre: $y$-t és $z$-t nézve ez éppen egy kör polárkoordinátás megadása -- így egy körnek egy darabját kapjuk.
