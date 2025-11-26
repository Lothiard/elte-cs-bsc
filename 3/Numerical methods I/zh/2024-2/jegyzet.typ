= 1.
== vektornormák
Legyen $n in NN$ rögzített. Az $norm(dot): RR^n arrow RR$ leképezést vektornormának nevezzük, ha\
1. $norm(x) >= 0 "  " (forall x in RR^n)$
2. $norm(x) = 0 <==> x = 0$
3. $norm(lambda dot x) = abs(lambda) dot norm(x) "  " (forall lambda in RR, " " forall x in RR^n)$
4. $norm(x + y) <= norm(x) + norm(y) "  " (forall x, y in RR^n)$

$
    norm(v)_1 = sum^n_(k = 1) abs(v_k)\
    norm(v)_2 = sqrt(sum^n_(k = 1) abs(v_k)^2)\
    norm(v)_infinity = max^n_(k = 1) abs(v_k)\
$
$p >= 1$ esetén
$
    norm(v)_p = (sum^n_(k = 1) abs(x_k)^p)^(1/p)
$

== mátrixnormák
Legyen $n in NN$ rögzített. Az $norm(dot): RR^(n times n) arrow RR$ leképezést mátrixnormának nevezzük, ha\
1. $norm(A) >= 0 "  " (forall A in RR^(n times n))$
2. $norm(A) = 0 <==> A = 0$
3. $norm(lambda dot A) = abs(lambda) dot norm(A) "  " (forall lambda in RR, " " forall A in RR^(n times n))$
4. $norm(A + B) <= norm(A) + norm(B) "  " (forall A, B in RR^(n times n))$
4. $norm(A dot B) <= norm(A) dot norm(B) "  " (forall A, B in RR^(n times n))$

$
    norm(A)_1 = max^n_(j = 1) sum^n_(i = 1) abs(a_(i j))\
    norm(A)_2 = max^n_(i = 1) sum^n_(j = 1) abs(a_(i j))\
    norm(A)_F = sqrt(sum^n_(i = 1) sum^n_(j = 1) abs(a_(i j))^2)\
    norm(A)_2 = sqrt(max^n_(i = 1) lambda_i (A^T A)) = sqrt(rho (A^T A))
$

= 2. kondíciószám, érzékenység
$
    "cond"_1(A) = norm(A) dot norm(A^(-1))\
    "cond"_2(A) = rho(A) dot rho(A^(-1))\
$

#pagebreak()
= 3. iterációk
$
    norm(B) < 1 ==> x^((k + 1)) = B x^((k)) + c " konvergál " forall x^(0)"-ra"\
    rho(B) < 1 <==> x^((k + 1)) = B x^((k)) + c " konvergál " forall x^(0)"-ra"
$

== Jacobi
$
    x^((k + 1)) = underbrace(-D^(-1)(L + U), B_J) x^((k)) + underbrace(D^(-1) b, c_J)
$

=== koordinátás
$
  x_i^((k + 1)) = - 1/(a_(i i)) dot (sum^n_(j = 1 " " j != i) a_(i j) x_j^((k)) - b_i)
$

== csillapított Jacobi
$
    x^((k + 1)) = underbrace([(1 - omega)I - omega D^(-1)(L + U)], B_J(omega)) x^((k)) + underbrace(omega D^(-1) b, c_J(omega))
$

=== koordinátás
$
  x_i^((k + 1)) = (1 - omega)x_i^((k)) - omega/(a_(i i)) dot (sum^n_(j = 1 " " j != i) a_(i j) x_j^((k)) - b_i)
$

== Gauss-Seidel
$
    x^((k + 1)) = underbrace(-(L + D)^(-1)U, B_S) x^((k)) + underbrace((L + D)^(-1) b, c_S)
$

=== paraméteres
$
  x_i^((k + 1)) = - 1/(a_(i i)) (sum^(i - 1)_(j = 1) a_(i j) x_j^((k + 1)) + sum^(n)_(j = i + 1) a_(i j) x_j^((k)) - b_i)
$

== Richardson
$
    x^((k + 1)) = underbrace((I - p A), B_R(p)) x^((k)) + underbrace(p b, c_R(p))
$

=== paraméteres
$
  x_i^((k + 1)) = (1 - omega) x_i^((k)) - omega/(a_(i i)) (sum^(i - 1)_(j = 1) a_(i j) x_j^((k + 1)) + sum^(n)_(j = i + 1) a_(i j) x_j^((k)) - b_i)
$

== $I L U$
$
    x^((k + 1)) = underbrace((P^(-1) Q), B_(I L U)) x^((k)) + underbrace(P^(-1) b, c_(I L U))
$
