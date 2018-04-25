%get the name of all files in the folder
clear all, clc
d='C:\Users\home\Documents\Computational Finance\Assignment1\ftse100 data';  % folder
f=dir([d '\*.xlsx']);
%758 days ,30 assets
FTSE=zeros(758,30);
for j=1:numel(f)
    FTSE(:,j) = xlsread(f(j).name,'G3:G760');
    % read the data from 23 Feb 2018 to 26 Feb 2015
end
%{
N=length(FTSE);
FTSE100 = xlsread('FTSE 100 Historical Data.xlsx','G2:G759');
XTrain = FTSE(ceil(N/2)+1:N,:);
XTest = FTSE(1:ceil(N/2),:);
YTrain = FTSE100(ceil(N/2)+1:N,:);
YTest = FTSE100(1:ceil(N/2),:);
%}