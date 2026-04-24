function polert = tridiag_poly(beta, alfa, gamma, x)
    n = length(alfa);
    m = length(x);
    polert = zeros(m, 1);
    for j = 1:m
        p_prev2 = 0; p_prev1 = 1; % p0=1, p-1=0
        for k = 1:n
            curr_p = (alfa(k) - x(j)) * p_prev1;
            if k > 1
                curr_p = curr_p - beta(k-1) * gamma(k-1) * p_prev2;
            end
            p_prev2 = p_prev1;
            p_prev1 = curr_p;
        end
        polert(j) = p_prev1;
    end
end