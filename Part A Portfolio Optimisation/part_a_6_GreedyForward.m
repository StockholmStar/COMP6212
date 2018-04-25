% Greedy feedfoward selection
%import 30 assets price change data, run read30files.m
N=length(FTSE);
FTSE100 = xlsread('FTSE 100 Historical Data.xlsx','G2:G759');

XTrain = FTSE(ceil(N/2)+1:N,:);
XTest = FTSE(1:ceil(N/2),:);
YTrain = FTSE100(ceil(N/2)+1:N,:);
YTest = FTSE100(1:ceil(N/2),:);
[b, se, pval, inmodel, stats, nextstep, history] = stepwisefit(XTrain, YTrain, 'maxiter', 6);


prediction = (b(find(inmodel))'*XTest(:, find(inmodel))')';
RiskGFS = b(find(inmodel))'*cov(XTest(:, find(inmodel)))*b(find(inmodel));
RiskGFS = sqrt(RiskGFS);
MeanGFS = mean(prediction);
disp(['Greedy Forward Selection MSE test: ' num2str(immse(YTest, prediction))]);


figure(8),clf
plot(YTest,'-')
hold on
plot(prediction,'--');
xlabel('Time','FontSize',14);
ylabel('Return','FontSize',14);
title('Greedy Forward Selection Return','FontSize',14)
legend('True', 'GFS')
