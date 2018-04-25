T = 222;
normPredC = zeros(T*5,1);
normS = zeros(T*5,1);
normActC = zeros(T*5,1);
deltas = zeros(T*5,1);

sigmas=zeros(T*5,1);
N_d2=zeros(T*5,1);
for i = 1:5
[Volatility,x,err,N_d2,sigma,Delta,C_True,C,K,S] = BS(i);
normS((i-1)*T+1:i*T,1) = S/K;
normPredC((i-1)*T+1:i*T) = C/K;
normActC((i-1)*T+1:i*T) = C_True/K;
deltas((i-1)*T+1:i*T) = Delta;
sigmas((i-1)*T+1:i*T) = sigma;
N_d2((i-1)*T+1:i*T) = N_d2;
end
taus = linspace(T/365, 1/365, T);% 222*1
t = [taus taus taus taus taus]';%222*1
X = [normS, t];
y= normPredC;

%plot Call option Price simulated from Black-Scholes model
figure(14),clf
[xq,yq] = meshgrid(0:.01:2, 0:.01:2);
vq = griddata(X(:,1), X(:,2), y, xq, yq);
surf(xq, yq, vq),
hold on
plot3(X(:,1), X(:,2), y, 'k.', 'MarkerSize',10);
title('Call option Price simulated from Black-Scholes model','FontSize',14)
xlabel('Normalizd stock price S/K','FontSize',12)
ylabel('Time','FontSize',12)
zlabel('Normalized call option price prediction C/K','FontSize',12)
