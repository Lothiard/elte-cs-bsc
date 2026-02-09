function interp_ekvidisztans(n,f)
    x=linspace(-1,1,n+1);    
    y=f(x);
    p=polyfit(x,y,n);
    
    xx=linspace(-1,1,100);
    plot(xx,f(xx),'b-');
    hold on
    plot(xx,polyval(p,xx),'r-');
    plot(x,y,'ro');
    hold off
end