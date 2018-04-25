 %Sparse Markowitz Portfolio
 tau = 25:25:400;
  numFeatures = zeros(length(tau),1);
  p = mean(YTrain);
 for i=tau
    w= sparsePortfolio(XTrain,YTrain, p, i);
    w= round(w*10000)/sum(round(w*10000));
    numFeatures(i/25) = nnz(w); 
 end
 figure(9),clf
 plot(range,numFeatures,'o');
 ylabel('Number of selected stocks','FontSize',12)
 xlabel('Regularization parameter','FontSize',12)
 title('Number of selected stocks')
 axis([0 500 0 15])
 %set(gca,'ytick',[0:1:15])
%set(gca,'xtick',[0:50:500])
 grid on
 
 tau =275;

w= sparsePortfolio(XTrain, YTrain, p, tau);
w = round(w*10000)/sum(round(w*10000));
noFeatures = nnz(w); 
prediction = (w'*XTest')';
meanSparse = mean(w'*mean(XTest)');
index = find(w >0);
risk =  w(index)'*cov(XTest(:,index))*w(index);
disp(['MSE: ' num2str(immse(YTest, prediction))]);
disp(noFeatures)
disp(mean(prediction))
figure(10),clf
plot(YTest, '-')
hold on
plot(prediction, '--');
xlabel('Time','FontSize',14);
ylabel('Expected Return','FontSize',14);
title('Sparse Portfolio Return','FontSize',14)
legend('Ture','Sparse')