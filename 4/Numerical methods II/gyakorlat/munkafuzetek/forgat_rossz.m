function B = forgat_rossz(A,i,j)
    n=size(A,1);
    Q=eye(n);
    p=(A(j,j)-A(i,i))/2/A(i,j);
    c2=p/sqrt(1+p^2);
    c=sqrt((1+c2)/2);
    s=sqrt((1-c2)/2);
    Q(i,i)=c;
    Q(i,j)=s;
    Q(j,i)=-s;
    Q(j,j)=c;
    B=Q'*A*Q;
    B(i,j)=0;
    B(j,i)=0;
end