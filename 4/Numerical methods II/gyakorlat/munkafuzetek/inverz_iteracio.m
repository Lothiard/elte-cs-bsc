function [lambda,v]=inverz_iteracio(A,x0,N,p)
    if ~exist('p','var')
        p=0;
    end

    A=A-p*eye(size(A));
    x0=x0(:);
    x1=x0;
    for k=1:N
        x0=x1;
        x1=A\x0;
    end
    % Ha A szimmetrikus, a sajátérték közelítést
    % a Rayleigh-hányadosból számoljuk!
    if(issymmetric(A))
        lambda_p=dot(x0,x0)/dot(x1,x0);
    else
        [~,i]=max(abs(x0));
        lambda_p=x0(i)/x1(i);
    end
    lambda=lambda_p + p;
    v=x1/norm(x1);
end