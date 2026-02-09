function p=trace_modszer(A)
    n=size(A,1);
    s=zeros(1,n);
    p=zeros(1,n);
    
    Ak=A;
    for k=1:n
        s(k)=trace(Ak);
        p(k)=-sum([1,p(1:k-1)].*s(k:-1:1))/k;
        Ak=Ak*A;
    end
    p=[1,p];
end