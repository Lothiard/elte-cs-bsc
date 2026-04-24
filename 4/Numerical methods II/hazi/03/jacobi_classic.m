function [D, Q, hiba] = jacobi_classic(A, N)
    [n, ~] = size(A);
    D = A; Q = eye(n);
    for k = 1:N
        % Max elem keresése
        off_diag = D - diag(diag(D));
        [~, idx] = max(abs(off_diag(:)));
        [i, j] = ind2sub([n, n], idx);
        
        % Stabil forgatás
        u = 2 * D(i,j); v = D(j,j) - D(i,i); w = sqrt(u^2 + v^2);
        c = sqrt((w + v * sign(u)) / (2 * w));
        s = u * sign(u) / (2 * c * w);
        
        % Frissítés
        G = D([i,j], :);
        D([i,j], :) = [c -s; s c] * G;
        G = D(:, [i,j]);
        D(:, [i,j]) = G * [c s; -s c];
        
        % Sajátvektorok becslése
        Q(:, [i,j]) = Q(:, [i,j]) * [c s; -s c];
    end
    % Hibabecslés Gersgorinnal: sugarak maximuma
    hiba = max(sum(abs(D), 2) - abs(diag(D)));
end