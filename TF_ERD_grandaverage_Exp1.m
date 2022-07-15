%% grand average A1 ERD
        clear all
        cd 'G:\Zhaochenguang\Data\TIBS\Filedtrip_TF\ERD\Exp1\'
        Path='G:\Zhaochenguang\Data\TIBS\Filedtrip_TF\ERD\Exp1\*A_pre_ICA_clean_V_TF_ERD1.mat';
        File=dir(Path);
        nsubj = length(File);
        for i=1:nsubj   
        load(File(i).name);
        Data_ERD1{i} = data_ERD1;
        end   
        cfg=[];
        cfg.keepindividual ='yes';
        Grandavg1A = ft_freqgrandaverage(cfg,Data_ERD1{:});
        
        
 %% grand average A2 ERD
        Path='G:\Zhaochenguang\Data\TIBS\Filedtrip_TF\ERD\Exp1\*A_pre_ICA_clean_V_TF_ERD2.mat';
        File=dir(Path);
        nsubj = length(File);
        for i=1:nsubj   
        load(File(i).name);
        Data_ERD2{i} = data_ERD2;
        end   
        cfg=[];
        cfg.keepindividual ='yes';
        Grandavg2A = ft_freqgrandaverage(cfg,Data_ERD2{:});

 %% grand average S1 ERD
        Path='G:\Zhaochenguang\Data\TIBS\Filedtrip_TF\ERD\Exp1\*S_pre_ICA_clean_V_TF_ERD1.mat';
        File=dir(Path);
        nsubj = length(File);
        for i=1:nsubj   
        load(File(i).name);
        Data_ERD1{i} = data_ERD1;
        end   
        cfg=[];
        cfg.keepindividual ='yes';
        Grandavg1S = ft_freqgrandaverage(cfg,Data_ERD1{:});

        
 %% grand average S2 ERD
        Path='G:\Zhaochenguang\Data\TIBS\Filedtrip_TF\ERD\Exp1\*S_pre_ICA_clean_V_TF_ERD2.mat';
        File=dir(Path);
        nsubj = length(File);
        for i=1:nsubj   
        load(File(i).name);
        Data_ERD2{i} = data_ERD2;
        end   
        cfg=[];
        cfg.keepindividual ='yes';
        Grandavg2S = ft_freqgrandaverage(cfg,Data_ERD2{:});    
        

%% ERD
ROI_electrode=[44,43,42,53,52,51,48,49,50,55,56,57,54];
ERD_1A=squeeze(mean(mean(Grandavg1A.powspctrm(:,ROI_electrode,3:5,:),2),3));
ERD_1A_avg=mean(ERD_1A);
ERD_2A=squeeze(mean(mean(Grandavg2A.powspctrm(:,ROI_electrode,3:5,:),2),3));
ERD_2A_avg=mean(ERD_2A);
ERD_1S=squeeze(mean(mean(Grandavg1S.powspctrm(:,ROI_electrode,3:5,:),2),3));
ERD_1S_avg=mean(ERD_1S);
ERD_2S=squeeze(mean(mean(Grandavg2S.powspctrm(:,ROI_electrode,3:5,:),2),3));
ERD_2S_avg=mean(ERD_2S);

% figure
% plot(Grandavg1A.time,ERD_1A_avg,'r--')
% hold on
% plot(Grandavg1A.time,ERD_2A_avg,'r-')
% hold on
% plot(Grandavg1A.time,ERD_1S_avg,'b--')
% hold on
% plot(Grandavg1A.time,ERD_2S_avg,'b-')
% legend('2T active','4T active','2T sham','4T sham')
% axis([-0.2 1.2 -0.5 0.2]);
%%
% figure
% stat1=ttest(ERD_1A,ERD_1S);
% stat2=ttest(ERD_2A,ERD_2S);
% for ii=1:2
% y1=ERD_1S;
% shadedErrorBar(Grandavg1A.time,mean(y1,1),std(y1)/sqrt(i),'lineprops','b');
% hold on
% y1=ERD_1A;
% shadedErrorBar(Grandavg1A.time,mean(y1,1),std(y1)/sqrt(i),'lineprops','r');
% plot(Grandavg1A.time,0.15*stat1,'k--');
% axis([-0.2 1.2 -0.6 0.2]);
% end
% 
% figure
% for ii=1:2
% y1=ERD_2S;
% shadedErrorBar(Grandavg1A.time,mean(y1,1),std(y1)/sqrt(i),'lineprops','b');
% hold on
% y1=ERD_2A;
% shadedErrorBar(Grandavg1A.time,mean(y1,1),std(y1)/sqrt(i),'lineprops','r');
% plot(Grandavg1A.time,0.15*stat2,'k--');
% axis([-0.2 1.2 -0.6 0.2]);
% % plot(ones(8),-0.1:0.05:0.25,'k--');%*100则是在100ms处产生
% end

figure
statA=ttest(ERD_1A,ERD_2A);
statS=ttest(ERD_1S,ERD_2S);
for ii=1:2
y1=ERD_1A;
% shadedErrorBar(Grandavg1A.time,mean(y1,1),std(y1)/sqrt(i),'lineprops','b');
plot(Grandavg1A.time,mean(y1,1),'r')
hold on
y1=ERD_2A;
% shadedErrorBar(Grandavg1A.time,mean(y1,1),std(y1)/sqrt(i),'lineprops','r');
plot(Grandavg1A.time,mean(y1,1),'r--')
plot(Grandavg1A.time,0.15*statA,'k--');
axis([-0.2 1.2 -0.6 0.2]);
end
% 
figure
for ii=1:2
y1=ERD_1S;
% shadedErrorBar(Grandavg1A.time,mean(y1,1),std(y1)/sqrt(i),'lineprops','b');
plot(Grandavg1A.time,mean(y1,1),'b')
hold on
y1=ERD_2S;
% shadedErrorBar(Grandavg1A.time,mean(y1,1),std(y1)/sqrt(i),'lineprops','r');
plot(Grandavg1A.time,mean(y1,1),'b--')
plot(Grandavg1A.time,0.15*statS,'k--');
axis([-0.2 1.2 -0.6 0.2]);
% plot(ones(8),-0.1:0.05:0.25,'k--');%*100则是在100ms处产生
end

[stat,p]=ttest(ERD_2S-ERD_1S,ERD_2A-ERD_1A);
figure
y1=ERD_2S-ERD_1S;
y2=ERD_2A-ERD_1A;
plot(Grandavg1A.time,mean(y1,1),'b')
plot(Grandavg1A.time,mean(y2,1),'r')
plot(Grandavg1A.time,0.1*stat,'k--');
axis([-0.2 1.2 -0.2 0.2]);