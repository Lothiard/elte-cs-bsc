% Lépések száma
N=15;

% Teszt mátrix sajátértékei
D=diag([-3,0,1,5,2]);
% Véletlen szimmetrikus mátrix ezekkel
% a sajátértékekkel
[Q,R]=qr(rand(5));
A=Q*D*Q';

% Teszt
[rho,err]=qrmax(A,N);