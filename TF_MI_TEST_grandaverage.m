%% Check avg or not avg
%% grand average A1
        clear all
        cd 'E:\Zhaochenguang\Data\TIBS\Filedtrip_TF\MI\1064\'
        Path='E:\Zhaochenguang\Data\TIBS\Filedtrip_TF\MI\1064\*_A_pre_ICA_clean_V_TF_MI1.mat';
        File=dir(Path);
        nsubj = length(File);
        for i=1:nsubj   
        load(File(i).name);
        Data_MI1{i} = data_MI1;
        end   
        cfg=[];
        cfg.keepindividual ='yes';
        Grandavg1A = ft_freqgrandaverage(cfg,Data_MI1{:});

        
 %% grand average A2
        Path='E:\Zhaochenguang\Data\TIBS\Filedtrip_TF\MI\1064\*_A_pre_ICA_clean_V_TF_MI2.mat';
        File=dir(Path);
        nsubj = length(File);
        for i=1:nsubj   
        load(File(i).name);
        Data_MI2{i} = data_MI2;
        end   
        cfg=[];
        cfg.keepindividual ='yes';
        Grandavg2A = ft_freqgrandaverage(cfg,Data_MI2{:});

 %% grand average S1
        Path='E:\Zhaochenguang\Data\TIBS\Filedtrip_TF\MI\1064\*_S_pre_ICA_clean_V_TF_MI1.mat';
        File=dir(Path);
        nsubj = length(File);
        for i=1:nsubj   
        load(File(i).name);
        Data_MI1{i} = data_MI1;
        end   
        cfg=[];
        cfg.keepindividual ='yes';
        Grandavg1S = ft_freqgrandaverage(cfg,Data_MI1{:});

        
 %% grand average S2
        Path='E:\Zhaochenguang\Data\TIBS\Filedtrip_TF\MI\1064\*_S_pre_ICA_clean_V_TF_MI2.mat';
        File=dir(Path);
        nsubj = length(File);
        for i=1:nsubj   
        load(File(i).name);
        Data_MI2{i} = data_MI2;
        end   
        cfg=[];
        cfg.keepindividual ='yes';
        Grandavg2S = ft_freqgrandaverage(cfg,Data_MI2{:});    
        
%         %% multiplotTFR
%         cfg = [];
%         cfg.zlim         = [-0.1 0.1];
%         cfg.xlim         = [-0.2 1.2];
%         cfg.showlabels   = 'yes';
%         cfg.layout       = 'quickcap64.mat';
%         figure
        GrandavgDeltaA=Grandavg2A;
        GrandavgDeltaS=Grandavg2A;
        GrandavgDelta2T=Grandavg2A;
        GrandavgDelta4T=Grandavg2A;
        GrandavgDeltaA.powspctrm=(Grandavg2A.powspctrm-Grandavg1A.powspctrm);
        GrandavgDeltaS.powspctrm=(Grandavg2S.powspctrm-Grandavg1S.powspctrm);
        GrandavgDelta2T.powspctrm=(Grandavg1A.powspctrm-Grandavg1S.powspctrm);
        GrandavgDelta4T.powspctrm=(Grandavg2A.powspctrm-Grandavg2S.powspctrm);
%         ft_multiplotTFR(cfg, GrandavgDelta);
  % multiplotTFR
        cfg = [];
        cfg.zlim         = [-0.1 0.1];
        cfg.xlim         = [-0.2 1.2];
        cfg.showlabels   = 'yes';
        cfg.layout       = 'quickcap64.mat';
        figure
        ft_multiplotTFR(cfg, Grandavg2A);    
%% combinMI
% Lch = [1 4  6  7  8  9 15 16 17 18 24 25 26 27 33 34 35 36 42 43 44 45 51 52 53 58 59];
% Rch = [3 5 14 13 12 11 23 22 21 20 32 31 30 29 41 40 39 38 50 49 48 47 57 56 55 62 61];
% GrandavgDeltaA_comMI=Grandavg2A;
% GrandavgDeltaS_comMI=Grandavg2A;
% GrandavgDeltaA_comMI.powspctrm(:,Lch,:,:)=GrandavgDeltaA.powspctrm(:,Lch,:,:)-GrandavgDeltaA.powspctrm(:,Rch,:,:);
% GrandavgDeltaA_comMI.powspctrm(:,Rch,:,:)=GrandavgDeltaA_comMI.powspctrm(:,Lch,:,:);
% GrandavgDeltaS_comMI.powspctrm(:,Lch,:,:)=GrandavgDeltaS.powspctrm(:,Lch,:,:)-GrandavgDeltaS.powspctrm(:,Rch,:,:);
% GrandavgDeltaS_comMI.powspctrm(:,Rch,:,:)=GrandavgDeltaS_comMI.powspctrm(:,Lch,:,:);

 %% 统计
%         cfg=[];
%         cfg.channel='all';
%         cfg.latency='all';
%         cfg.frequency='all';
%         cfg.method= 'montecarlo';
%         cfg.statistic        = 'ft_statfun_depsamplesT';
%         cfg.numrandomization = 500;
%         cfg.frequency        = 'all';
%         subj = length(File);
%         design = zeros(2,2*subj);
%         for i = 1:subj
%         design(2,i) = i;
%         end
%         for i = 1:subj
%         design(2,subj+i) = i;
%         end
%         design(1,1:subj)        = 1;
%         design(1,subj+1:2*subj) = 2;
%         cfg.design   = design;
%         cfg.ivar     = 1;
%         cfg.uvar     = 2;
%       [stat] = ft_freqstatistics(cfg,   Grandavg2A,  Grandavg1A);

%% multiplotTFR
        cfg = [];
        cfg.zlim         = [-2 2];
        cfg.xlim         = [-0.4 1.4];
        cfg.showlabels   = 'yes';
        cfg.layout       = 'quickcap64.mat';
        figure
%         stat.stat(find(stat.prob>0.1))=0;
%         data_MI1.powspctrm=stat.stat;
       % data_MI1=Grandavg2A;
        ft_multiplotTFR(cfg, data_MI1);
        % elec = ft_read_sens('quickcap64.mat');
        
% %% sigle Plot MI
left_electrode=[44,43,42,53,52,51];
right_electrode=[48,49,50,55,56,57];
combined_MI1A=squeeze(mean(mean(Grandavg1A.powspctrm(:,left_electrode,3:5,:)-Grandavg1A.powspctrm(:,right_electrode,3:5,:),2),3));
combined_MI1A_avg=mean(combined_MI1A);
combined_MI2A=squeeze(mean(mean(Grandavg2A.powspctrm(:,left_electrode,3:5,:)-Grandavg2A.powspctrm(:,right_electrode,3:5,:),2),3));
combined_MI2A_avg=mean(combined_MI2A);
combined_MI1S=squeeze(mean(mean(Grandavg1S.powspctrm(:,left_electrode,3:5,:)-Grandavg1S.powspctrm(:,right_electrode,3:5,:),2),3));
combined_MI1S_avg=mean(combined_MI1S);
combined_MI2S=squeeze(mean(mean(Grandavg2S.powspctrm(:,left_electrode,3:5,:)-Grandavg2S.powspctrm(:,right_electrode,3:5,:),2),3));
combined_MI2S_avg=mean(combined_MI2S);
figure
plot(Grandavg1A.time,combined_MI1A_avg,'r--')
hold on
plot(Grandavg1A.time,combined_MI2A_avg,'r-')
hold on
plot(Grandavg1A.time,combined_MI1S_avg,'b--')
hold on
plot(Grandavg1A.time,combined_MI2S_avg,'b-')
axis([0 1.2 -0.1 0.25]);
legend('2T active','4T active','2T sham','4T sham')

% Plot MI error bar
figure
for ii=1:2
y1=combined_MI1S;
shadedErrorBar(Grandavg1A.time,mean(y1,1),std(y1)/sqrt(i),'lineprops','b');
hold on
y1=combined_MI1A;
shadedErrorBar(Grandavg1A.time,mean(y1,1),std(y1)/sqrt(i),'lineprops','r');
E=zeros(11,1);
plot(0:0.1:1,E,'k--');
axis([0 1 -0.1 0.25]);
% plot(ones(8),-0.1:0.05:0.25,'k--');%*100则是在100ms处产生
end

figure
for ii=1:2
y1=combined_MI2S;
shadedErrorBar(Grandavg1A.time,mean(y1,1),std(y1)/sqrt(i),'lineprops','b');
hold on
y1=combined_MI2A;
shadedErrorBar(Grandavg1A.time,mean(y1,1),std(y1)/sqrt(i),'lineprops','r');
E=zeros(11,1);
plot(0:0.1:1,E,'k--');
axis([0 1 -0.1 0.25]);
% plot(ones(8),-0.1:0.05:0.25,'k--');%*100则是在100ms处产生
end