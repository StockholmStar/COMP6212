
%part_a_2_2
%Efficent frontier of 2 assests
m12=[0.10,0.20]';%expected return
C12=[0.005,-0.010;-0.010,0.040];%cov martrix
m13=[0.10,0.15]';
C13=[0.005,0.004; 0.004,0.023];
m23=[0.20,0.15]';
C23=[0.040,-0.002;-0.002,0.023];
E=zeros(1,100);%expectation
V=zeros(1,100);%variance

m=m12;
C=C12;
%{
m = m23;
C = C23;

m = m13;
C = C13;
%}

for i=1:100
    weights = rand(2,1);
    s =  sum(weights);
    weights = weights/s;
    E(i)=weights'*m;
    V(i)=sqrt(weights'*C*weights);
end
%frontcon has been removed so use plotFrontier instead

ExpReturn = m';
ExpCovariance = C;
NumPorts = 100;
p = Portfolio;
p = setAssetMoments(p, ExpReturn, ExpCovariance);
p = setDefaultConstraints(p);
figure(3), clf,
plotFrontier(p, NumPorts)
hold on
plot(V,E,'.')
legend('Efficient frontier','E-V conbinations')
title('Efficient Frontier(porfolios 1 & 2)','FontSize',14)
%{
title('Efficient Frontier(porfolios 2 & 3)','FontSize',14)
title('Efficient Frontier(porfolios 1 &3)','FontSize',14)
%}
