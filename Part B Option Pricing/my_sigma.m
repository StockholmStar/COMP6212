function sigma = my_sigma(N, S,TD)
u =zeros(N,1);
for i = 1:N
u(i) = log( S(i+1)/S(i));
end
sigma = std(u)*sqrt(TD);% trading dates: assume date is 365 per year
end