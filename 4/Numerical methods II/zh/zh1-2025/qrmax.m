function [rho,err]=qrmax(A,N)
% QRMAX(A,N): Az A mátrixon végrehajtja a QR-algoritmus
% első N lépését, majd ezek alapján becsli az A spektrálsugarát

% Bemenet vizsgálata
if size(A,1)~=size(A,2)
    error('A mátrix nem négyzetes.')
end

if norm(A-A')>1e-4
    error('A mátrix nem szimmetrikus.')
end

% Spektrálsugár becslések
rho=zeros(1,N);
% Spektrálsugár becslés hibakorlátai
err=zeros(1,N);

% QR-algoritmus
for k=1:N
    [Q,R]=qr(A);
    A=R*Q;
    % Spektrálsugár becslés 
    [M,I] = max(abs(diag(A)));
    rho(k)=M;
    % Hibabecslés Gersgorin-tétel alapján
    err(k)=sum(abs(A(I,:)))-M;
end
% Spektrálsugár becslések
plot(1:N,rho,'k.');
hold on 
% Hibakorlát (a közelített sajátértékre 
% vonatkozó, NEM a spektrálsugárra!)
plot(1:N,rho+err,'r.');
plot(1:N,rho-err,'r.')
title('Gergorin-tétel alkalmazása a QR algoritmusra')
hold off