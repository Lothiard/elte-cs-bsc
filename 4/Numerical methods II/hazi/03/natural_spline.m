function yy = natural_spline(x, y, xx)
    % Biztosítsuk, hogy oszlopvektorokkal dolgozunk
    x = x(:); y = y(:);
    
    n = length(x) - 1;
    h = diff(x);
    df = diff(y) ./ h;
    
    % LER felírása a2-re (másodrendű együtthatók)
    % A mátrix (n-1)x(n-1) méretű lesz
    diag_main = 2 * (h(1:end-1) + h(2:end));
    A = diag(diag_main);
    
    % Mellékátlók: h(2), h(3), ..., h(n-1)
    if n > 2
        A = A + diag(h(2:end-1), 1) + diag(h(2:end-1), -1);
    end
    
    % Jobb oldal: 3 * (f[x_k, x_{k+1}] - f[x_{k-1}, x_k])
    % Itt NEM kell a transzponálás, hogy oszlopvektor maradjon
    b = 3 * diff(df); 
    
    % Megoldás a belső pontokra + természetes peremfeltétel (a2(1)=0, a2(n+1)=0)
    a2 = [0; A \ b; 0];
    
    % Polinom együtthatók és kiértékelés
    yy = zeros(size(xx));
    for k = 1:n
        a0 = y(k);
        a3 = (a2(k+1) - a2(k)) / (3*h(k));
        a1 = df(k) - h(k)/3 * (2*a2(k) + a2(k+1));
        
        % Csak az aktuális intervallumba eső pontokat értékeljük ki
        if k < n
            idx = xx >= x(k) & xx < x(k+1);
        else
            idx = xx >= x(k) & xx <= x(k+1); % Az utolsó pontot is vegye bele
        end
        
        dx = xx(idx) - x(k);
        yy(idx) = a0 + a1*dx + a2(k)*dx.^2 + a3*dx.^3;
    end
end
