function P = spl3(x,y,m1,m2)
% Harmadfokú interpolációs spline-t állít elő, ahol x(1)-ben
% az 1. és 2. derivált értéke adott (m1, m2).

n = length(x);  
ms1 = m1; 
ms2 = m2;
if length(y) ~= n
    error('Az x és y vektor hossza nem egyezik!');
end
xx=x(1);
yy=y(1);
P = zeros(n-1,4);
for i = 1:n-1
    h = x(i+1)-x(i);
    P(i,4) = y(i); 
    P(i,3) = ms1; 
    P(i,2) = ms2/2;
    P(i,1) = (y(i+1)-y(i)-ms1*h-h^2*ms2/2)/h^3;
    ms1 = P(i,3)+2*h*P(i,2)+3*h^2*P(i,1);
    ms2 = 2*P(i,2)+6*h*P(i,1);
    
    xs = linspace(x(i),x(i+1),100);
    p = P(i,:); 
    ys = polyval(p,xs-x(i)); 
   
    % Találós kérdés: 
    % Hogy lehetne módosítani, a lenti kódot, 
    % hogy ne kapjunk figyelmeztetést?
    xx = [xx,xs];
    yy = [yy,ys];
end

plot(x,y,'o',xx,yy,'b')
end
