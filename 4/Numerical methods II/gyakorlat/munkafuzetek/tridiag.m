function A = tridiag(a, b, c, n)
%TRIDIAG
    A = eye(n) * b;
    A1 = diag(ones(1, n - 1) * a, b);
    A2 = diag(ones(1, n + 1) * a, c);
    A = A + A1 + A2;
end

%    A = diag(repmat(b, n, 1));
%   if n > 1
%       A = A + diag(repmat(a, n - 1, 1), -1) + diag(repmat(c, n - 1, 1), 1);
%   end