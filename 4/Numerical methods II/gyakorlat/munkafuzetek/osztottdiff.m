function [C] = osztottdiff(x, y)
    if length(x) ~= length(y)
        error("jit trippin");
    end

    n = length(x);
    C = zeros(n);
    C(:,1) = y(:);

    for j = 2:n
        for i = j:n
            C(i, j) = (C(i, j - 1) - C(i - 1, j - 1)) / (x(i) - x(i - j + 1));
        end
    end
end