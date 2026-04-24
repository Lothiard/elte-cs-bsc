%% 1: Gersgorin körök tesztelése
fprintf('--- HFP1: Gersgorin körök kirajzolása ---\n');
n1 = 6;
A1 = rand(n1) * 10; % Nem triviális 6x6-os mátrix
[kp, rs, ro] = gersgorin_plot(A1);
fprintf('Középpontok száma: %d\n', length(kp));
fprintf('Sugarak kiszámítva. (Grafikon megnyitva)\n\n');

%% 2: Householder Hessenberg-alak tesztelése
fprintf('--- HFP2: Householder Hessenberg-alak ---\n');
n2 = 6;
A2 = rand(n2);
H_sajat = hessenberg(A2);
H_matlab = hess(A2);
% Ellenőrzés: a sajátértékeknek egyezniük kell
hiba_hess = norm(sort(eig(H_sajat)) - sort(eig(H_matlab)));
fprintf('Hessenberg-alak sajátérték hiba a beépítetthez képest: %e\n\n', hiba_hess);

%% 3 & 4: Tridiagonális rekurzió és Newton sajátérték kereső
fprintf('--- HFP3 & HFP4: Tridiagonális karakterisztikus polinom és Newton ---\n');
n3 = 5;
alfa = rand(n3, 1) * 5;
beta = rand(n3-1, 1);
gamma = rand(n3-1, 1);
% ellenőrzése egy pontban
x_pont = 2.5;
pol_ert = tridiag_poly(beta, alfa, gamma, x_pont);

% Tridiagonális mátrix felépítése az ellenőrzéshez
T = diag(alfa) + diag(beta, -1) + diag(gamma, 1);
pol_matlab = polyval(poly(T), x_pont);
fprintf('Polinom érték különbsége a poly() függvényhez képest: %e\n', abs(pol_ert - pol_matlab));

% Newton-módszer indítása a legnagyobb eig közeléből
lambda_pontos = max(eig(T));
lambda_newton = tridiag_newton(beta, alfa, gamma, lambda_pontos + 0.1, 20);
fprintf('Newton-módszerrel talált sajátérték hiba: %e\n\n', abs(lambda_newton - lambda_pontos));

%% 6: Klasszikus Jacobi-módszer tesztelése
fprintf('--- HFP6: Klasszikus Jacobi-módszer ---\n');
n6 = 5;
% Szimmetrikus tesztmátrix előállítása ismert sajátértékekkel [3]
D_sajat = diag([4-8]);
[Q_rand, ~] = qr(rand(n6));
A6 = Q_rand * D_sajat * Q_rand';

[D_jac, Q_jac, hiba_jac] = jacobi_classic(A6, 50);
sajatert_hiba = norm(sort(diag(D_jac)) - [1; 2; 3; 4; 5]);
fprintf('Jacobi sajátérték hiba: %e\n', sajatert_hiba);
fprintf('Gersgorin alapú maradék hiba (off-diagonal): %e\n\n', hiba_jac);

%% 8: Természetes köbös spline tesztelése
fprintf('--- HFP8: Természetes köbös spline ---\n');
x8 = [0, 1, 2.5, 4, 5]';
y8 = sin(x8);
xx8 = linspace(0, 5, 100);
yy8 = natural_spline(x8, y8, xx8);

figure;
plot(x8, y8, 'ro', xx8, yy8, 'b-', 'LineWidth', 1.5);
title('HFP8: Természetes köbös spline');
legend('Adatpontok', 'Spline');
fprintf('Spline interpoláció kész. (Grafikon megnyitva)\n\n');

%% 10: Köbös B-spline elemek tesztelése
fprintf('--- HFP10: Köbös B-spline bázisok ---\n');
x10 = [4-7]'; % 5 alappont
xx10 = linspace(0, 4, 100);
B_matrix = bspline_basis(x10, xx10);

% Ellenőrzés: az egység felosztása (a bázisok összege minden pontban 1) [9, 10]
sum_B = sum(B_matrix, 1);
fprintf('B-spline egység-felosztás hiba (sum-1): %e\n', norm(sum_B - 1));

figure;
plot(xx10, B_matrix');
title('HFP10: Köbös B-spline bázisfüggvények');
fprintf('B-spline bázisok kirajzolva. (Grafikon megnyitva)\n');