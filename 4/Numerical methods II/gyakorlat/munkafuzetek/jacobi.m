function D = jacobi(A,c,q)
n=size(A,1);
for k=1:c
    kuszob=q^k;
    for i=1:n
        for j=i+1:n
            if abs(A(i,j))>kuszob
                A=forgat(A,i,j);
            end
        end
    end
end
D=A;
end