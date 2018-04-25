%part_a_2
%plot the efficient frontier of three portfolio
m=[0.10,0.20,0.15]';%expected return
C=[0.005,-0.010,0.004;-0.010,0.040,-0.002;0.004,-0.002,0.023];%cov martrix

E=zeros(1,100);%expected return
V=zeros(1,100);%variance

%generate 100 portfolio vectors, the entries in each vector should sum up
%to one
for i=1:100
    weights = rand(3,1);%generate 3 random numbers
    s =  sum(weights);%sum of the numbers
    weights = weights/s;%normalise the weights
    E(i)=weights'*m; %calculate the expected return
    V(i)=sqrt(weights'*C*weights); %calculate the risk(Standard deviation)
end

% use the matlab financial toolbox to plot the efficient frontier
ExpReturn = m';
ExpCovariance = C;
NumPorts = 100;
p = Portfolio;
p = setAssetMoments(p, ExpReturn, ExpCovariance);
p = setDefaultConstraints(p);

figure(2), clf,
plotFrontier(p, NumPorts)
hold on
plot(V,E,'.')
title('Efficient Frontier(3 porfolios)','FontSize',14)
legend('Efficient frontier','E-V conbinations','Location','northwest')