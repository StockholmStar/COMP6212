%part_a_1
%the efficient frontier of the two assets
%m = [0.1,0.1]';
%C = [0.005,0;0,0.005];
%compute the efficient frontier by hand and this should be a line
figure(1),clf
plot([0.0025,0.005], [0.1,0.1] ,'LineWidth', 2)
axis([0 0.006 0 0.2]); 
title('Efficient Frontier','FontSize',14)
legend('Efficient frontier','E-V conbinations')
xlabel('Variance', 'FontSize',16)
ylabel('Expected return','FontSize',16);
