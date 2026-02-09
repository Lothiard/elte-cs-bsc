function [lambda,v]=hatvanymodszer(A,x0,N)   
    x0=x0(:);
    x1=x0;
    for k=1:N
        x0=x1;
        x1=A*x0;
    end
    % Ha A szimmetrikus, a sajátérték közelítést
    % a Rayleigh-hányadosból számoljuk!
    if(issymmetric(A))
        lambda=dot(x1,x0)/dot(x0,x0);
    else
        [~,i]=max(abs(x0));
        lambda=x1(i)/x0(i);
    end
    v=x1/norm(x1);
end