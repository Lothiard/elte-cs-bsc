function [kp, r_sor, r_oszl] = gersgorin_plot(A)
    [m, n] = size(A);
    if m ~= n, error('A mátrix nem négyzetes!'); end
    
    kp = diag(A); % Középpontok
    r_sor = sum(abs(A), 2) - abs(kp); % Soronkénti sugarak
    r_oszl = sum(abs(A), 1)' - abs(kp); % Oszloponkénti sugarak
    
    figure; hold on; axis equal; grid on;
    t = linspace(0, 2*pi, 100);
    
    for i = 1:n
        % Sorokhoz tartozó körök (piros)
        fill(kp(i) + r_sor(i)*cos(t), r_sor(i)*sin(t), 'r', 'FaceAlpha', 0.2);
        % Oszlopokhoz tartozó körök (kék)
        fill(kp(i) + r_oszl(i)*cos(t), r_oszl(i)*sin(t), 'b', 'FaceAlpha', 0.2);
    end
    title('Gersgorin körök (piros: sor, kék: oszlop)');
    hold off;
end