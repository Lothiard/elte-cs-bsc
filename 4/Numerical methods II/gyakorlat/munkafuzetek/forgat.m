function B = forgat(A,i,j)
    u=2*A(i,j);
    v=A(j,j)-A(i,i);
    w=sqrt(u^2+v^2);
    c=sqrt((w+v*sign(u))/(2*w));
    s=(u*sign(u))/(2*c*w);    
    G=A;
    G(i,:)=c*A(i,:)-s*A(j,:);
    G(j,:)=s*A(i,:)+c*A(j,:);
    B=G;
    B(:,i)=c*G(:,i)-s*G(:,j);
    B(:,j)=s*G(:,i)+c*G(:,j);        
    B(i,j)=0;
    B(j,i)=0;
end