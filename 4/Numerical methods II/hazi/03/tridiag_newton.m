function lambda = tridiag_newton(beta, alfa, gamma, x0, N)
    lambda = x0;
    n = length(alfa);
    for i = 1:N
        p = 1; p_der = 0; p_old = 0; p_der_old = 0;
        for k = 1:n
            p_new = (alfa(k) - lambda) * p;
            p_der_new = -p + (alfa(k) - lambda) * p_der;
            if k > 1
                p_new = p_new - beta(k-1)*gamma(k-1)*p_old;
                p_der_new = p_der_new - beta(k-1)*gamma(k-1)*p_der_old;
            end
            p_old = p; p_der_old = p_der;
            p = p_new; p_der = p_der_new;
        end
        lambda = lambda - p / p_der; % Newton-lépés
    end
end