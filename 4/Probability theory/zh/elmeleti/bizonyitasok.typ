#set text(size: 10pt, lang: "hu")
#set page(paper: "a4", margin: 2cm)

= Valószínűségszámítás Elméleti Bizonyítások

= *Lemma:* $P(A union B) = P(A) + P(B) - P(A B)$\
*Bizonyítás:*\ Mivel $ A union B = A union (overline(A) B) $ ezért $ P(A union B) = P(A) + P(overline(A) B) $ Másrészt $ B = (A B) union (overline(A) B) $ amiből $ P(B) = P(A B) + P(overline(A) B) $ tehát $ P(overline(A) B) = P(B) - P(A B) $ Ezt behelyettesítve kapjuk az állítást.\ \

= *Poincaré-formula (Szita formula):*\
*Bizonyítás (Teljes indukcióval):*\ $n=2$-re a fenti lemma.\ Feltesszük $n$-re, majd $n+1$-re felírjuk: $ P(union_(i=1)^(n+1) A_i) = P((union_(i=1)^n A_i) union A_(n+1)) = P(union_(i=1)^n A_i) + P(A_(n+1)) - P((union_(i=1)^n A_i) inter A_(n+1)) $ Az utolsó tagra alkalmazzuk a disztributivitást és az indukciós feltevést.\ \

= *Bayes-formula:*\
*Bizonyítás:*\ $ P(A|B) = P(A B) / P(B) = (P(B|A)P(A)) / (P(B|A)P(A) + P(B|overline(A))P(overline(A))) $ Ez a feltételes valószínűség definíciójából és a teljes valószínűség tételéből következik.\ \

= *Teljes várható érték tétel (diszkrét eset):*\
*Bizonyítás:*\ $ sum_n E(xi | A_n) P(A_n) = sum_n (sum_k x_k P(xi = x_k | A_n)) P(A_n) = sum_k x_k sum_n P(xi = x_k | A_n) P(A_n) = sum_k x_k P(xi = x_k) = E xi $\

= *A szórásnégyzet eltolási formulája:*\
$ D^2 xi = E xi^2 - (E xi)^2 $
*Bizonyítás:*\ $ D^2 xi = E(xi - E xi)^2 = E(xi^2 - 2 xi E xi + (E xi)^2) = E xi^2 - 2 (E xi)(E xi) + (E xi)^2 = E xi^2 - (E xi)^2 $\

= *A korreláció abszolút értéke:*\
$ |R(xi, eta)| <= 1 $
*Bizonyítás:*\
A Cauchy-Schwarz egyenlőtlenséget használjuk: $ (E(X Y))^2 <= E X^2 E Y^2 $ Alkalmazzuk ezt a középpontosított változókra: $ X = xi - E xi " és " Y = eta - E eta $ Ekkor $ ("cov"(xi, eta))^2 <= D^2 xi D^2 eta $ amiből gyökvonás és átrendezés után kapjuk, hogy $ |R| <= 1 $\

= *Markov-egyenlőtlenség (diszkrét eset):*
$ P(xi >= c) <= (E xi) / c $
*Bizonyítás:*\ $ E xi = sum_k x_k P(xi = x_k) >= sum_(x_k >= c) x_k P(xi = x_k) >= sum_(x_k >= c) c P(xi = x_k) = c P(xi >= c) $\

= *Csebisev-egyenlőtlenség:*
$ P(|xi - E xi| >= lambda) <= (D^2 xi) / lambda^2 $
*Bizonyítás:*\ Alkalmazzuk a Markov-egyenlőtlenséget a nemnegatív $eta = (xi - E xi)^2$ változóra $c = lambda^2$ mellett: $ P((xi - E xi)^2 >= lambda^2) <= E(xi - E xi)^2 / lambda^2 = (D^2 xi) / lambda^2 $\

= *A nagy számok gyenge törvénye (független, azonos eloszlású, véges szórású eset):*\
*Bizonyítás:*\ $S_n / n$ várható értéke $m$, szórásnégyzete $D^2 xi_1 / n$. A Csebisev-egyenlőtlenség szerint: $ P(abs(S_n / n - m) >= epsilon) <= (D^2 (S_n / n)) / epsilon^2 = (D^2 xi_1) / (n epsilon^2) $ ami $n -> infinity$ esetén 0-hoz tart.\ \

#pagebreak()
= *Poisson-közelítés a binomiálishoz (levezetés vázlata):*\
*Bizonyítás:*\ Legyen $ lambda = n p, "  " P(U_n = k) = binom(n, k) p^k (1-p)^(n-k) = (n(n-1)...(n-k+1))/k! (lambda/n)^k (1 - lambda/n)^(n-k) $ Ahogy $n -> infinity$, a tört kifejezés $1$-hez, az $(1-lambda/n)^n$ kifejezés $e^(-lambda)$-hoz, az $(1-lambda/n)^(-k)$ pedig $1$-hez tart, így kapjuk a $lambda^k / k! e^(-lambda)$ alakot.

= *Momentumok kiszámítása GF-ből:*
$ E eta = G'(1) $
*Bizonyítás:*\ $ G(z) = sum P(eta = n) z^n $ Deriválva: $ G'(z) = sum n P(eta = n) z^(n-1) $ $z=1$ helyen: $ G'(1) = sum n P(eta = n) = E eta $\

= *Kihalási valószínűség:*
$ x "a legkisebb gyöke a" G(s)=s "egyenletnek" $
*Bizonyítás:*\ Legyen $x_n = P(S_n = 0)$.\ Ekkor $x_1 = G(0)$ és $x_(n+1) = G(x_n)$.\ Mivel $G$ monoton, az $x_n$ sorozat monoton nő és korlátos, így tart egy $x$ határértékhez, amire $x = G(x)$ teljesül.\ \

= *Legkisebb négyzetes hiba:*
$ E(xi - A)^2 "minimális, ha" A = E xi $
*Bizonyítás:*\ $ E(xi - A)^2 = E(xi - E xi + E xi - A)^2 = E(xi - E xi)^2 + 2(E xi - A) E(xi - E xi) + (E xi - A)^2 $ Mivel $ E(xi - E xi) = 0 $ a középső tag kiesik, és a kifejezés akkor minimális, ha $ E xi - A = 0 $
