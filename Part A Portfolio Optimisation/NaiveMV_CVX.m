function [PRisk, PRoR, PWts] = NaiveMV_CVX(ERet, ECov, NPts)
ERet = ERet(:);      % makes sure it is a column vector
NAssets = length(ERet);  % get number of assets
% vector of lower bounds on weights
V0 = zeros(NAssets, 1);
% row vector of ones
V1 = ones(1, NAssets);
%A = chol(ECov);
% set medium scale option
options = optimset('LargeScale', 'off');
% Find the maximum expected return
%Regression using the CVX Tool:
cvx_begin quiet
    variable MaxReturnWeights(NAssets,1)
    minimize (-ERet'*MaxReturnWeights)
    subject to 
            V1*MaxReturnWeights == 1;
            MaxReturnWeights >= V0;
cvx_end
%MaxReturnWeights = linprog(-ERet, [], [], V1, 1, V0);
MaxReturn = MaxReturnWeights' * ERet;

% Find the minimum variance return
cvx_begin quiet
    variable MinVarWeights(NAssets,1)
    minimize (MinVarWeights'*ECov*MinVarWeights)
    subject to 
            V1*MinVarWeights == 1; 
            MinVarWeights >= V0;
cvx_end

%MinVarWeights = quadprog(ECov,V0,[],[],V1,1,V0,[],[],options);
MinVarReturn = MinVarWeights' * ERet;
MinVarStd = sqrt(MinVarWeights' * ECov * MinVarWeights);
% check if there is only one efficient portfolio
if MaxReturn > MinVarReturn
   RTarget = linspace(MinVarReturn, MaxReturn, NPts);
   NumFrontPoints = NPts;
else
      RTarget = MaxReturn;
      NumFrontPoints = 1;
end
% Store first portfolio
PRoR = zeros(NumFrontPoints, 1);
PRisk = zeros(NumFrontPoints, 1);
PWts = zeros(NumFrontPoints, NAssets);
PRoR(1) = MinVarReturn;
PRisk(1) = MinVarStd;
PWts(1,:) = MinVarWeights(:)';
% trace frontier by changing target return
VConstr = ERet';
A = [V1 ; VConstr ];
B = [1 ; 0];
for point = 2:NumFrontPoints
    %RTarget is a vector of Npts points in [Min,Max] Return
B(2) = RTarget(point);
cvx_begin quiet
    variable Weights(NAssets,1)
    minimize(Weights'*ECov*Weights)
    subject to
        A*Weights == B;
        Weights >= V0;
cvx_end
%Weights = quadprog(ECov,V0,[],[],A,B,V0,[],[],options);
PRoR(point) = dot(Weights, ERet);
PRisk(point) = sqrt(Weights'*ECov*Weights);
PWts(point, :) = Weights(:)';
end
end