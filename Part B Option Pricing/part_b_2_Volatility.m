Dates = quatT+1:quatT+30;

figure(11),clf
[Volatility_Call,x1,err1,N_d2_1,sig1,Delta1,C_True1,C1,K1,StockPrice1] = BS(1);
plot(sig1(Dates),Volatility_Call(Dates),'o')
title('Volatility,Call Option,K = 2925','FontSize',14)
xlabel('Estimated Volatility','FontSize',14)
ylabel('Implied Volatility','FontSize',14)

figure(12),clf
[Volatility_Put,x6,err6,N_d2_6,sig6,Delta6,C_True6,C6,K6,StockPrice6] = BS(6);
plot(sig6(Dates),Volatility_Put(Dates),'o')
title('Volatility, Put Option,K = 2925','FontSize',14)
xlabel('Estimated Volatility','FontSize',14)
ylabel('Implied Volatility','FontSize',14)

