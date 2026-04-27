= Valószínűségszámítás Összefoglaló (6-7. gyakorlat)

== Alapvető momentumok és jellemzők
A valószínűségi változók számszerű jellemzésére a momentumokat használjuk.
- *Várható érték ($E xi$):* A változó "középpontja".
  - Diszkrét esetben: $E xi = sum x_k P(xi = x_k)$.
  - Folytonos esetben: $E xi = integral_(-infinity)^infinity x f(x) dif x$.
- *Második momentum ($E xi^2$):* A változó négyzetének várható értéke, folytonos esetben $integral_(-infinity)^infinity x^2 f(x) dif x$.
- *Szórásnégyzet ($D^2 xi$):* A várható értéktől vett négyzetes eltérés átlaga.
  - Kiszámítása: *$D^2 xi = E xi^2 - (E xi)^2$*.
  - Tulajdonság: $D^2(a xi + b) = a^2 D^2 xi$.
- *Szórás ($D xi$):* A szórásnégyzet négyzetgyöke: *$D xi = sqrt(D^2 xi)$*.

== Kovariancia és Korreláció
Két változó közötti statisztikai kapcsolatot mérik.
- *Kovariancia ($"cov"$):* *$"cov"(X, Y) = E(X Y) - E X dot E Y$*.
  - Ha $X$ és $Y$ függetlenek, akkor $"cov"(X, Y) = 0$.
  - Linearitás: $"cov"(a X + b Y, Z) = a dot "cov"(X, Z) + b dot "cov"(Y, Z)$.
- *Korrelációs együttható ($R$):* *$R(X, Y) = ("cov"(X, Y)) / (D X dot D Y)$*.
  - Értéktartomány: $-1 <= R <= 1$. Ha $|R|=1$, a kapcsolat lineáris.

== Nevezetes eloszlások paraméterei
#table(
  columns: (1fr, 1fr, 1.5fr),
  inset: 5pt,
  align: horizon,
  [*Eloszlás*], [*Várható érték ($E X$)*], [*Szórásnégyzet ($D^2 X$)*],
  [Binomiális $B(n, p)$], [$n p$], [$n p (1-p)$],
  [Poisson $P o i(lambda)$], [$lambda$], [$lambda$],
  [Egyenletes $U(a, b)$], [$(a+b)/2$], [$(b-a)^2/12$],
  [Exponenciális $E x p(lambda)$], [$1/lambda$], [$1/lambda^2$],
  [Normális $N(m, sigma^2)$], [$m$], [$sigma^2$],
  [Gamma $Gamma(lambda, alpha)$], [$alpha/lambda$], [$alpha/lambda^2$],
  [Pareto $(alpha, beta)$], [$beta / (alpha - 1)$], [$(alpha beta^2) / ((alpha-1)^2 (alpha-2))$],
)

== Becslések és Határeloszlás-tételek
- *Markov-egyenlőtlenség:* $P(xi >= c) <= (E xi) / c$.
- *Csebisev-egyenlőtlenség:* $P(|xi - E xi| >= lambda) <= (D^2 xi) / lambda^2$.
- *Nagy Számok Törvénye (NSZT):* Független változók átlaga a várható értékhez tart.
- *Centrális Határeloszlás-tétel (CHT):* Sok független hatás összege normális eloszlást mutat.

== Fontos szabályok a megoldáshoz
- *Transzformált várható értéke:* $E[g(X)] = integral_(-infinity)^infinity g(x) f(x) dif x$.
- *Összeg szórása:* Csak függetleneknél $D^2(X+Y) = D^2 X + D^2 Y$.
- *Várható érték linearitása:* $E(a X + b Y) = a E X + b E Y$.
- *Mintaátlag szórása:* $D overline(X)_n = (D X) / sqrt(n)$.
