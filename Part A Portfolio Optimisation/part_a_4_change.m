%part a, question 4
%import 30 assets price change data, run read30files.m


%generate all combinations, choose 3 from 30 randomly
comb = nchoosek(1:30,3);% 4060 combinations
NoComb=size(comb,1);% number of combinations
NaiveWeights=(1/3)*ones(3,1);%Weights of 1/N naive portfolio
XTrain=FTSE(ceil(N/2)+1:N,:);%training set
XTest=FTSE(1:ceil(N/2),:);%test set
%{
count = 0;
count_EP = 0;
count_N = 0;
%}
Sharpe_EP_E = zeros(NoComb,1);
Sharpe_EP_V = zeros(NoComb,1);
Sharpe_N_E = zeros(NoComb,1);
Sharpe_N_V = zeros(NoComb,1);

for i = 1:NoComb
Index=comb(i,:);
Train=XTrain(:,Index);
Test=XTest(:,Index);
%calculate mean and cov matrix
m1=mean(Train);
C1=cov(Train);
%calculate the return and risk of test set
%reference: [2]DeMiguelOptimalVersusNaiveDiversification(Equation2)
MaxReturnWeights =C1\m1'/sum(C1\m1');
m2= mean(Test);
C2=cov(Test);

Sharpe_EP_E(i) = (m2*MaxReturnWeights);
Sharpe_EP_V(i) = sqrt(MaxReturnWeights'*C2*MaxReturnWeights);
Sharpe_N_E(i) =(m2*NaiveWeights);
Sharpe_N_V(i)= sqrt(NaiveWeights'*C2*NaiveWeights);
%{
    if (Sharpe_N(i)>=Sharpe_EP(i) &&Sharpe_N(i) >=0 && Sharpe_EP(i) >=0)
        count = count+1;
    end
    if (Sharpe_EP(i)>=0)
        count_EP = count_EP+1;
    end
     if (Sharpe_N(i)>=0)
        count_N = count_N+1;
     end
    
%}
end

figure(7),clf
plot(Sharpe_EP_V,Sharpe_EP_E,'x')
hold on
plot(Sharpe_N_V,Sharpe_N_E,'.')
title('E-V','FontSize',14)
legend('Sample-based M-V','Naive 1/N')

xlabel('Risk','FontSize',14)
ylabel('Return','FontSize',14)
axis([0.5 4 -0.2 0.3])
