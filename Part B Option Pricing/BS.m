function [Volatility,x,err,N_d2,sig,Delta,C_True,C,K,StockPrice] = BS(filenumber)

d='C:\Users\home\Documents\Computational Finance\Assignment1\data';  % folder
f=dir([d '\*.prn']);% get the file list

x = f(filenumber).name; % get the name of the 1st file in file list.
prn = importdata(x); % import the *.prn files
K = str2double(x(2:5));%strike price
T = length(prn);% time period
r = 0.06; %anual interest rate
StockPrice = prn(:,3);

quatT =ceil(T/4); % 1/4 of the time period
C_True =prn(:,2);% True option price from the 2nd column of file
C = zeros(T,1); % the estimation from Black-Scholes model

Volatility = zeros(T,1);
TD =365; %trading dates per year
sig = zeros(T,1);
Delta = zeros(T,1);
N_d2 = zeros(T,1);
for t= quatT+1:T
sigma = my_sigma(quatT, prn((t-quatT):t,3),TD); % use function my_sigma() to calculate
sig(t) = sigma;
S = prn(t,3);% the stock price at time t (in the 3rd column of *.prn file)
d1= (log(prn(t,3)/K)+(r+sigma^2/2)*(T-t)/TD)/(sigma*sqrt((T-t)/TD)); %calculate d1
d2= d1-sigma*sqrt((T-t)/TD);% calculate d2
Delta(t) = normcdf(d1);
N_d2(t) = normcdf(d2);
if x(1)== 'c' % if the file is for 'call' option
    C(t,1) = S*normcdf(d1)-K*exp(-r*(T-t)/TD)*normcdf(d2); % use the call option equation
    Volatility(t) = blsimpv(prn(t,3),K,r,(T-t)/TD,prn(t,2),0.5,0,[], {'Call'});
else %if not
    C(t,1) = K*exp(-r*(T-t)/TD)*normcdf(-d2)-S*normcdf(-d1);% use the put option equation
    Volatility(t) = blsimpv(prn(t,3),K,r,(T-t)/TD,prn(t,2),0.5,0,[], {'Put'});
end
%[C2(t,1),P2(t,1)] = blsprice(S,K,r,(T-t)/TD,sigma);

end

err = immse(C(quatT+1:T),C_True(quatT+1:T)); %calculate the mean squared error

end