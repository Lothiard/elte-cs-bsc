n = 100;
A = (rand(n, n) - 0.5) * 100;
A = A * A';

lambda = sort(eig(A))

p = poly(A)
r = sort(roots(p))

norm(lambda - r, 1)