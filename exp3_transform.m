S_POOL=[2,4];
for ii=1:2
for i=1:41
S=S_POOL(ii);
MCMC_I(i,1)= 2;
MCMC_M(i,ii)= S;
MCMC_H(i,ii)= H(i,ii).*Nc(i,ii);
MCMC_FA(i,ii) = FA(i,ii).*Ns(i,ii);
MCMC_Nc(i,ii) =Nc(i,ii);
MCMC_Ns(i,ii) = Ns(i,ii);
end
end
MCMC_dat =[MCMC_I,MCMC_M,MCMC_H,MCMC_FA,MCMC_Nc,MCMC_Ns];
save('I:\Zhaochenguang\Data\TIBS\MCMC_dat_exp3_all.txt','MCMC_dat','-ascii')