
figure(13),clf
T = 222;
quatT =ceil(T/4); 
day = quatT+1:quatT+30;
NoDay = length(day);
 Yvol  = zeros(NoDay*5,1);
 for i = 1:5
     [Vol,x,err,N_d2,sig,Delta,C_True,C,K,StockPrice] = BS(i);
 Yvol ((i-1)*NoDay+1:i*NoDay) = Vol(day);
 end
Xstrike = [2925*ones(30,1);
    3025*ones(30,1);
    3125*ones(30,1);
    3225*ones(30,1);
    3325*ones(30,1);];
time = [1:30 1:30 1:30 1:30 1:30]';

[xq,yq] = meshgrid(0:10:3500, 0:0.5:30);
vq = griddata(Xstrike,  time, Yvol, xq, yq);
surf(xq, yq, vq),
hold on
plot3(Xstrike, time,  Yvol, 'k.', 'MarkerSize',10);
title('Implied Volatility','FontSize',14)
xlabel('Strike Price','FontSize',14)
ylabel('Time','FontSize',14)
zlabel('Implied Volatility','FontSize',14)