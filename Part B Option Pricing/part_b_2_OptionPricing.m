T = 222;%time period
quatT =ceil(T/4);
for file = 1:10
[Volatility,x,err,N_d2,sig,Delta,C_True,C,K,StockPrice] = BS(file);
    fprintf('The mse for %s is %0.2f \n',x,err)
 figure(file)
plot(quatT+1:T,C_True(quatT+1:T))
hold on
plot(quatT+1:T,C(quatT+1:T))
title('Option Price Estimation on Black-Scholes Model','FontSize',14)
legend('True price','Estimation')
xlabel('Time','FontSize',14)
ylabel('Option Price','FontSize',14)
end
%
