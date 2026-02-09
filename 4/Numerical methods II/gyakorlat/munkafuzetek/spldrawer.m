function spldrawer(x,f,P)
x=sort(x); 

% Pontok száma intervallumonként
N=100; 
% Vonalvastagság
lw=3;
% Marker méret
ms=15;

n=length(x);
if isa(f,'function_handle')
    y=f(x);
else
    y=f;
end

cmap=hsv(n);
for i=1:n-1
    p=P(i,:);
    xx=linspace(x(i),x(i+1),N);
    yy=polyval(p,xx);
    plot(xx,yy,'LineWidth',lw,'Color',cmap(i,:),'DisplayName',sprintf('P_%d(x)',i));
    hold on
end
if isa(f,'function_handle')
    xx=linspace(x(1),x(end),N*(n-1));
    plot(xx,f(xx),'k--','LineWidth',lw,'DisplayName','f(x)');
end
plot(x,y,'kx','MarkerSize',ms,'LineWidth',lw,'DisplayName','(x_i,y_i)');
hold off
legend
end