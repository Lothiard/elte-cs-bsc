function H = hessenberg(A)
    [m, n] = size(A);
    if m ~= n, error('Csak négyzetes mátrix!'); end
    H = A;
    for k = 1:n-2
        x = H(k+1:n, k);
        v = x;
        v(1) = v(1) + sign(x(1)) * norm(x);
        v = v / norm(v); % Householder vektor
        
        % Transzformáció mátrix előállítása nélkül
        H(k+1:n, k:n) = H(k+1:n, k:n) - 2 * v * (v' * H(k+1:n, k:n));
        H(1:n, k+1:n) = H(1:n, k+1:n) - 2 * (H(1:n, k+1:n) * v) * v';
    end
end