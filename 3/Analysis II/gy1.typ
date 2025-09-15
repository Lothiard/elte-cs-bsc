hf megnezni miert $(sin x)/x = 1$
bizonyitani nem kell de majd hasznalni igen

$ limits(lim)_(x arrow 0)(1-cos x)/x^2 $
ez az $1/a$ csak negyzettel
erdemes megjegyezni

$cos$ hatvanysora az az exponencialis csak a paros tagoknak mas az elojele

\
= megjegyzesek:
- 1
$ limits(lim)_(x arrow 0)(sin x)/x = 1 $
ha $x approx 0 $ akkor $sin/x approx 1$

de ha atszorzok $x$-el, ($sin approx x$) akkor $sin x$ kozelit $x$-hez
\ sot, ez felirhato ugy hogy $limits(lim)_(x arrow 0)(sin x - sin 0) / (x - 0)$. ezzel ugyanaz van leirva, ez pedig $sin'(x)$. azt pedig tudjuk hogy $sin'(0) = cos(0) = 1$

ahol ez az $1$ az erintonek a meredekseget a nulla pontban
ha felrajzoljuk a $sin$-t akkor latszik hogy nullaban $y = x$ egyenes az erinto

ez azt fejezi ki hogy az origo koruli $x$-ek majdnem olyan mint egy egyenes, origo kivul ez nem igaz.

mi az $x$? $sin$ hatvanysora ($x - x^3/3! + x^5/5! - dots$) ugy indul hogy $x$. az az elso tag, tehat ha linearisan kozelitek elso fokon akkor csak az van ott

\
- 2
$ limits(lim)_(x arrow 0) (e^x - 1)/x = 1 $
ha $x approx 0 => (e^x - 1)/x approx 1$

ha atrendezem akkor $e^x approx x + 1$

masreszt mi a $lim$?

$ limits(lim)_(x arrow 0)(e^x + e^0)/(x - 0) $

ez pedig nem mas mint $exp'(0)$, amirol pedig tudjuk hogy a derivaltja onmaga $ exp'(0) = exp(0) = 1 $

az erintojenek az egyenlete itt $y = e^x$

null pontban ez $1$. Az egyenete $ y = F(a) + f'(a) dot (x - a) #h(1cm) "ha" f in D{a} $
$ y = e^0 + 1(x - 0) $
$ y = 1 + x $

ez pedig pont a kozelitesbol adodott egyenes
tehat az megint az adott pontban a legjobban kozelito linearis fuggveny
tehat ha $x$ kozel van az origohoz akkor pontos, ha nem nem

ennek a hatvanysora
$ 1 + x + x^2/2! + dots $
megint latszik hogy az elso tagok $1+x$, tehat innen is latszik a kozelites

= feladatok
== 2/a
$
limits(lim)_(x arrow a)(f(x) - f(a))/(x - a) =
limits(lim)_(x arrow a)(c-c)/(x-a)=
limits(lim)_(x arrow a)0=0
$

ha a kapott $lim$ egy veges szam akkor a fuggveny differencialhato tehat $f in D{a} "es" f'(a) = 0$

egyezmenyes jeloles: $ (c)' = 0 #h(1cm) (forall c in bb(R)) $

== 2/b
$
limits(lim)_(x arrow 0)(f(x) - f(0))/(x - 0) =
limits(lim)_(x arrow 0)(|x| - |0|)/(x - 0) =
limits(lim)_(x arrow 0)(|x|)/x =
cases(
    limits(lim)_(x arrow 0-0)(-1) = -1\
    limits(lim)_(x arrow 0+0)(1) = 1
)
$

esetrebontom bal es jobb oldali hatarertekre
- balrol $x->0-0$ akkor $-x$ lesz a szamlaloban es igy az eredmeny $lim -1 = -1 = f'_b (0)$ (ahol a b bal oldali derivaltat jelol)
- jobbrol $x ->0+0$ akkor $x/x$ igy $lim(1) = 1= f'_j (0)$
lehetne + es - jelolni b es j helyett

az kovetkezik hogy abs fugveny nem differerncialhato a nulla pontban mert a ketto hatarertek nem egyezik meg. nem tudunk huzni erintot. van baloldali felerinto $-1$ meredekseggel, jobbrol $1$, de nullaban nincs. erre mondjuk hogy hegyes, nem sima.
innen intuicioban latszik hogy olyan fuggveny ahol eles torespontok vannak akkor ordibal hogy abban a pontban nem lehet derivalni mert mindig ket erintoje lesz

== 2/c
tetszoleges a pontban a derivaltja
$ f'(a) = limits(lim)_(x arrow a)(x^4 - a^4)/(x - a) = 0/0 $
ha polinomnak veges helye $0$ a hatarerteke, akkor a polinomnak gyoke az a szam, ami azt jelenti hogy oszthato a nevezovel. ezt kihasznalva

$ limits(lim)_(x arrow a)((x - a)(x^3 + x^2a + x a^2 + 3))/(x-a) = $ // kiesik a (x-a)
$x$ nem 0 ezert oszthato
ez $ = a^3 + a^3 + a^3 + a^3 = 4a^3 in bb(R) => f in D{a} "es" f'(a) = 4a^3 (forall a in bb(R)) $
minden $x$-hez ahol a fuggvenyt derivalhato hozzarendelem a derivaltjat

$ bb(R) in.rev x arrow.r.long.bar f'(x) = 4x^3, "roviden" (x^4)' = 4x^3 (forall x in bb(R)) $

== 2/d
mindenhol ertelmes kiveve nullat, terjunk el annyit hogy ne csak pozitivat nezzunk hanem $bb(R) without {0}$,

rovid szabaly:
$ (1/x)' = -1/x^2 #h(1cm) (x in bb(R) without {0}) $

felfoghattam volna hatvanyfuggvenykent is es akkor
$ 1/x = x^(-1) arrow (x^(-1))' = -1 dot x^(-2) = -1/x^2 $

== 2/i
mindig meg kell nezni ki a felelos a nullaert ha $0/0$, es azt kell kiemelni. ha az leegyszerusodik akkor nagy esellyel nyertunk

$
limits(lim)_(x arrow -1)((x + 2)/(x^2 - 9) - (1)/(-8))/(x + 1) =
limits(lim)_(x arrow -1)((8x+16+x^2-9)/(8x^2-72))/(x+1) =
limits(lim)_(x arrow -1)(x^2+8x-7)/((x+1)(8x^2-72)) =
limits(lim)_(x arrow -1)((x+1)(x+7))/((x+1)(8x^2-72)) =
limits(lim)_(x arrow -1)(x+7)/(8x^2-72) = 6/(-64) = 3/(-32)
$

== 2/e
emlkezteto hogy csak akkor nezhetjuk a fuggvenyt ha van kornyezete, nullaban azert nem ertelmes vagyis azert van kikotve mert nullaban nem tudok lejjebb menni a kornyezettel a definicio szerint

$
limits(lim)_(x arrow a)(sqrt(x) - sqrt(a))/(x - a) =
limits(lim)_(x arrow a)(sqrt(x) - sqrt(a))/(x - a)(sqrt(x) + sqrt(a))/(sqrt(x) + sqrt(a)) =
limits(lim)_(x arrow a)(x - a)/((x-a)(sqrt(x) + sqrt(a))) =
limits(lim)_(x arrow a)1/(sqrt(x) + sqrt(a)) = 1/(2sqrt(a))
$

== 2/f
ez az esetet ugy hivjak hogy visszatero pont.
a gyokfuggveny is ilyen

$
limits(lim)_(x arrow 0)(root(3, x^2) - root(3, 0))/(x - 0) =
limits(lim)_(x arrow 0)(1)/(root(3, x)) =
exists.not
$

== 2/g
itt a hatvaysor kiirasa helyett az a trukk hogy $h = x - a -> 0$ es onnan kihozhatjuk az elso feladatban levo nevezetes azonossagot

$
  limits(lim)_(x -> a)(e^x - e^a)/(x - a) = "    " (h = x - a) \
  limits(lim)_(x -> a)(e^a dot e^(x-a) - e^a)/(h) =
  limits(lim)_(x -> a)e^a dot (e^(x-a) - 1)/(h) =
  limits(lim)_(x -> a)e^a dot (e^h - 1)/(h) =
  e^a dot limits(lim)_(h -> 0)(e^h - 1)/(h) =
  e^a dot 1 = e^a
$

== 2/h
hatvanysort megint el lehet kerulni a $h$ trukkel. itt viszont mivel nincs multiplikativ tulajdonsaga a $sin$nek ezert addicios teteleket hasznalni

$
  limits(lim)_(x -> a)(sin x - sin a)/(x - a) = "    " (h = x - a)\
  limits(lim)_(h -> 0)(sin(h + a) - sin a)/(h) =
  limits(lim)_(h -> 0)(sin h cos a + sin a cos h - sin a)/(h) =
  limits(lim)_(h -> 0)(sin h cos a + sin a(cos h - 1))/(h) = \
  limits(lim)_(h -> 0)(cos a dot (sin h)/h - sin a dot (cos h - 1)/h) =
  limits(lim)_(x -> a)(sin x - sin a)/(x - a) = cos a
$
