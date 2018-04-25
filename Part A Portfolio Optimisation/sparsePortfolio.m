function w = sparsePortfolio( X,Y,p, tau )

    N = size(X, 2);
    T = length(Y);
    mu = (sum(X)/T)';
    R = X;
    
    cvx_begin quiet
    variable w(N);
        minimise( sum( (ones(T,1)*p - R*w).^2 ) + (tau*norm(w,1)) );
        subject to
            w'*mu==p;
            w'*ones(N,1)==1;
    cvx_end


end