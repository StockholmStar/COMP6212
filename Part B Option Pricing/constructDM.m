function [ dm ] = constructDM( X )

    % Fit GMM and construct design matrix
    options = statset('MaxIter', 1000);
    gmm = fitgmdist(X,4, 'Options', options);
    mu = gmm.mu;
    cov = gmm.Sigma; %(:,:,1) gets the first

    % Construct design matrix
    dm = ones(length(X), 7);%N*7
    for i=1:4
        m = mu(i,:);%1*2
        C = cov(:,:,i);%2*2
        for j=1:length(X)
            dm(j,i) = sqrt((X(j,:)-m)*inv(C)*(X(j,:)-m)');%scalar
            %dm(j,i) = mahal((X(j,:),m);
        end
    end

    dm(:,5:6) = X;

end

