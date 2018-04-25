figure(6), clf,
%generate 100 portfolios, calculate E and V
%firstly run part_a_2_1.m
plotFrontier(p, NumPorts)
hold on
%calculate the frontier by using function NaiveMV
[PRisk, PRoR, PWts] = naiveMV(m, C, 10);
%calculate the frontier by using function NaiveMV_CVX
[PRisk2, PRoR2, PWts2] = NaiveMV_CVX(m, C, 10);
%plot the frontier
plot(PRisk,PRoR,'LineWidth',1)
hold on
plot(PRisk2,PRoR2,'LineWidth',1)
%draw the scatter graph
hold on
plot(V,E,'.')
xlabel('Risk(Standard Deviation)','FontSize',14)
ylabel('Expected Return','FontSize',14)
title('Mean-Variance Efficient Frontier','FontSize',14)
legend('Financial toolbox','Linprog and Quadprog','CVX toolbox','E-V conbinations','Location','northwest')

%distance=norm([PRisk-PRisk2;PRoR-PRoR2],2)/20;
%err = immse([PRisk;PRoR],[PRisk2;PRoR2])