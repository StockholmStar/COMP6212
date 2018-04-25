% Split data into training and test sets (60% of data used as training)


trainN = 0.6*length(X);
ii = randperm(length(X));
trainX = X(ii(1:trainN), :);
trainY = y(ii(1:trainN));
testX = X(ii(trainN+1:end),:);
testY = y(ii(trainN+1:end));
testNormS = normS(ii(trainN+1:end));
testActY = normActC(ii(trainN+1:end));
testDeltas = deltas(ii(trainN+1:end));
dm = constructDM(trainX);
lambda =dm\ trainY;
% Reproduce figure 4
dmTest = constructDM(testX);
%pred = sim(lambda, dmTest');
pred = dmTest*lambda;

figure(15),clf
[xq,yq] = meshgrid(0:.01:2, 0:.01:2);
vq = griddata(testX(:,1), testX(:,2), pred, xq, yq);
surf(xq, yq, vq),
hold on
plot3(testX(:,1), testX(:,2), pred, 'k.');

title('Network Call Price','FontSize',14)
xlabel('Normalizd stock price S/K','FontSize',12)
ylabel('Time','FontSize',12)
zlabel('$$\hat{C/K}$$','Interpreter','Latex','FontSize',12)
%}

% Reproduce figure 5
r=0.06;
sig= 0.1656; %sig = mean(sigmas(find(sigmas>0))); % we use the average of sigmas
estimatedDelta = zeros(length(pred), 1);
cpe = zeros(length(pred), 1);
de = zeros(length(pred),1);
for p=1:length(pred)
    %nDeltas(p) = normcdf(  (log(testX(p,1))+ ((r+((sig^2)/2))*testX(p,2)))/(sig*sqrt(testX(p,2))));
    estimatedDelta(p) = (pred(p)+(exp(-r*testX(p,2))*normcdf(blsdelta(testX(p,1),1,r,testX(p,2),sig)-(sig*sqrt(testX(p,2))))))/testX(p,1);
    %estimatedDelta(p) = (pred(p)+(exp(-r*testX(p,2))*N_d2(p)))/testX(p,1);
    cpe(p) = pred(p) - testActY(p);
    %de(p) = deltas(p) - normcdf(  (log(testX(p,1))+ ((r+((sig^2)/2))*testX(p,2)))/(sig*sqrt(testX(p,2))));
    de(p) = estimatedDelta(p) - testDeltas(p);
end

figure(16),clf
[xq,yq] = meshgrid(0:.01:2, 0:.01:2);
vq = griddata(testX(:,1), testX(:,2), estimatedDelta, xq, yq);
surf(xq, yq, vq), hold on

title('Network Delta','FontSize',14)
xlabel('Normalizd stock price S/K','FontSize',12)
ylabel('Time','FontSize',12)
zlabel('Delta','FontSize',12)
%plot3(x(:,1), x(:,2), deltas, 'k.', 'MarkerSize',20);


figure(17),clf
[xq,yq] = meshgrid(0:.01:2, 0:.01:2);
vq = griddata(testX(:,1), testX(:,2), cpe, xq, yq);
surf(xq, yq, vq), hold on
title('Call Price Error','FontSize',14)
xlabel('Normalizd stock price S/K','FontSize',12)
ylabel('Time','FontSize',12)
zlabel('$$\hat{C/K} - C/K $$','Interpreter','Latex','FontSize',12)

figure(18),clf
[xq,yq] = meshgrid(0:.01:2, 0:.01:2);
vq = griddata(testX(:,1), testX(:,2), de, xq, yq);
surf(xq, yq, vq), hold on
title('Delta Error','FontSize',12)
xlabel('Normalizd stock price S/K','FontSize',12)
ylabel('Time','FontSize',12)
zlabel('Delta error','FontSize',12)
%}