function yy = bspline_basis(x, xx)
    % x az alappontok, xx a kiértékelési pontok
    n = length(x);
    N = length(xx);
    % Kiterjesztett csomópontvektor a szélekhez
    t = [x(1)*ones(1,3), x, x(end)*ones(1,3)];
    
    % Nulladfokú bázis [20]
    B = double(repmat(xx, length(t)-1, 1) >= t(1:end-1)' & ...
               repmat(xx, length(t)-1, 1) < t(2:end)');
    
    % Rekurzió 3-as fokig [18]
    for p = 1:3
        B_new = zeros(length(t)-p-1, N);
        for i = 1:length(t)-p-1
            w1 = 0; w2 = 0;
            if t(i+p) ~= t(i), w1 = (xx - t(i)) / (t(i+p) - t(i)); end
            if t(i+p+1) ~= t(i+1), w2 = (t(i+p+1) - xx) / (t(i+p+1) - t(i+1)); end
            B_new(i, :) = w1 .* B(i, :) + w2 .* B(i+1, :);
        end
        B = B_new;
    end
    yy = B;
end