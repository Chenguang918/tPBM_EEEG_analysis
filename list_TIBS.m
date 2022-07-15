% clear
% eeglab;
% sub=[65];
% for c=1%:2;
% con={'_S','_A'};
% for i=1:length(sub)
% nsub=sub(i);
% fileame=['sub',num2str(nsub),con{c}];
% filepath='D:\Zhaochenguang\Data\TIBS\Oridata\';
% file=[filepath,fileame,'.cdt'];
% savename=[fileame,'.set'];
% savepath=['D:\Zhaochenguang\Data\TIBS\CDT2set\',fileame];
% if ~exist([savepath],'dir')
%     mkdir(savepath);
% end
% EEG = loadcurry(file, 'CurryLocations', 'False');
% EEG = eeg_checkset( EEG );
% EEG = pop_select( EEG,'nochannel',{'M1' 'M2' 'EKG' 'EMG'});
% EEG = pop_resample( EEG, 500);
% EEG = pop_eegfiltnew(EEG, 0.1, 40, 33000, 0, [], 0);
% EEG = pop_saveset( EEG, 'filename',savename,'filepath',savepath);
% end
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ICA之后的数据进行1.去错误trail 2.epoch 3.基线矫正 4.祛伪迹 5.取平均
%  clear all
%  %sub=[1:19,21,23:29,31:37,39:43,45:50];
%  FilePath='I:\Zhaochenguang\Data\TIBS\CDT2set\';
%  Path_out='I:\Zhaochenguang\Data\TIBS\CDT2set\';
%  type={ '11'  '21' '111' '121'};
%  eeglab; 
%  for i=1:length(sub)
%      nsub=sub(i);
%      OutName=['sub',num2str(nsub),'_A'];
%      if ~exist([Path_out,OutName],'dir')
%          mkdir(Path_out,OutName);
%      end
%      for j=1:4
%        FileName=[OutName];
%        EEG = pop_loadset('filename',[FileName '.set'],'filepath',[Path_out,OutName]);
%        EEG = pop_reref( EEG, []);
%        EEG = eeg_checkset( EEG );
%        EEGEPC = pop_epoch( EEG, type(j), [-0.5  1.2], 'newname', [FileName '_epoch_cue.set'], 'epochinfo', 'yes');
%        %EEGBC = pop_rmbase( EEGEPC, [-200    0]);
%        EEGCL = pop_eegthresh(EEGEPC,1,[1:60] ,-100,100,-0.1,0.4,0,1);
%        %EEGOUT = pop_Aelectevent( EEGCL, 'event',100,'select','inverse','deleteevents','off','deleteepochs','on','invertepochs','off');
%        fname=['epoc_clear_',type{j}];
%        Path_Aave=[Path_out,OutName];
%        EEGOUT = pop_Aaveset( EEGCL, 'filename',[fname,'.set'],'filepath',Path_Aave); 
%      end
%  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%TF-TANSFER%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  close all;
%  clear all;
%  sub=[1:19,21,23:29,31:37,39:43,45:50];
%  Path_out='I:\Zhaochenguang\Data\TIBS\CDT2set\';
%  cond={'11','21','111','121'};%刺激在左的condition
%  typeindex={'1','2'};
%  eeglab; 
%  for i=1:length(sub)
%        nsub=sub(i); 
%         OutName=['sub',num2str(nsub),'_S'];
%           for con=1:4
%           path_input=[Path_out,OutName,'\'];
%           path_Save=[Path_out,OutName,'\'];
%           inname=['epoc_clear_',cond{con},'.set'];
%           EEG = pop_loadset('filename',inname,'filepath',path_input);
%           EEG = eeg_checkset( EEG );
%          % time frequency
%          Ersp=[];        
%          M=mean(EEG.data,3);
%          MM=repmat( M,1,1,EEG.trials);
%          EEG.Data=EEG.data-MM;
%          EEG.data=EEG.Data;
%          channelinfo=[42,59,44,48,61,50];
%         for ch=1:62
% % %        [ersp,itc,powbase,times,freqs,erspboot,itcboot]=pop_newtimef( EEG,1,channelinfo(ch), [-500  2000], [0] ,...
% % %        'baseline',NaN,'freqs',[4 40],'plotersp','off','plotitc','off' ,'plotphase', 'off','scale', 'abs','ntimesout', 200, 'padratio', 4);
% %             [ersp,itc,powbase,times,freqs,erspboot,itcboot]=pop_newtimef( EEG,1,channelinfo(ch), [-500  1200], [0] ,...
% %          'baseline',NaN,'freqs',[4 40],'plotersp','off','plotitc','off' ,'plotphase', 'off','scale', 'abs','ntimesout', 200, 'padratio', 4);
% %         close;
%           [ersp,itc,powbase,times,freqs,erspboot,itcboot]=pop_newtimef( EEG,1,ch, [-500  1200], [0] ,...
%          'baseline',NaN,'freqs',[4 40],'plotersp','off','plotitc','off' ,'plotphase', 'off','scale', 'abs','ntimesout', 200, 'padratio', 4);
%         close;
%         Ersp(ch,:,:)=ersp;
%         end
%      savefile=['Con_',cond{con},'_'];
%      save([path_Save,savefile,'ersp_topo_clear_topo','.mat'],'Ersp');
%       end
%      save([path_Save,'times_topo_clear_topo','.mat'],'times');
%      save([path_Save,'freqs_topo_clear_topo','.mat'],'freqs');
%  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%% SAVE alpha modulation
%  close all;
%  clear all;
%  sub=[3:13,14,15:16,17:19,21,23:29,31,32:37,39:43,45:49,50]; %all
%  treat=1;
% condition={'_A','_S'};
%  for s=1:length(sub)
%      OutName=['sub',num2str(sub(s)),condition{treat}];
%        for con=1:4
%        nsub=sub(s); 
%        path_A='I:\Zhaochenguang\Data\TIBS\CDT2set\';
%        cond={'11','21','111','121'};
%        path_out='I:\Zhaochenguang\Data\TIBS\CDT2set\';
%        path_input=[path_A,OutName,'\'];
%        path_Aave=[path_out,OutName,'\'];
%        inname=['Con_',cond{con}];
% %       %% 1step
% %        %load ERSP
%         load_path_Ersp=[path_input,inname,'_ersp_topo_clear_topo.mat'];
%         load(load_path_Ersp);
%         eval([inname,'=Ersp;']);
%        end 
%        MI1data=(Con_11-Con_21)./(Con_11+Con_21);
%        MI2data=(Con_111-Con_121)./(Con_111+Con_121);
%        MI1allsub(s,:,:,:)=MI1data;
%        MI2allsub(s,:,:,:)=MI2data;
%  end
%  save('MIalldata_A','MI1allsub','MI2allsub')

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eeglab;
%sub=[3,5:21,23:29,31:50]; %1064
sub=[51:71];
con={'_A','_S'};
for i=1:length(sub)
    for o=1:2
subname=['sub',num2str(sub(i)),con{o}];
filename=[subname,'_pre_clean_V'];
filepath=['D:\\Zhaochenguang\\Data\\TIBS\\CDT2set\\','sub',num2str(sub(i)),con{o},'\\'];
filepath1=['D:\\Zhaochenguang\\Data\\TIBS\\CDT2set\\'];
eventname=[filename,'.txt'];
binname='WM_bin_correct.txt';
trialleft_name=[filename,'_trialleft.txt'];
%savename='subname_ICA.set';
savepath=['I:\\Zhaochenguang\\Data\\TIBS\\CDT2set\\'];
savename=[filename,'_bin.set'];
erpname=[filename,'_erp'];
erpname_1=[filename,'_conips'];
erpname_2=[filename,'_diff'];
erpname_3=[filename,'_ch_avg'];
%save=[savepath,savename];
EEG = pop_loadset('filename',[filename,'.set'],'filepath',filepath);
EEG = pop_reref( EEG, []);
EEG = eeg_checkset( EEG );
EEG  = pop_creabasiceventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' }, 'Eventlist',...
 [filepath,eventname] );
EEG  = pop_binlister( EEG , 'BDF', [filepath1,'TXT\\',binname], 'IndexEL',  1, 'SendEL2', 'EEG', 'Voutput', 'EEG' );
EEG = pop_epochbin( EEG , [0  3000.0],  [ 0 200]);
EEG  = pop_artextval( EEG , 'Channel',  5:62, 'Flag',  1, 'Threshold', [ -100 100], 'Twindow', [ 0 600] );
%EEG  = pop_artextval( EEG , 'Channel',  63, 'Flag', 1 , 'Threshold', [ -50 50], 'Twindow', [ 200 400] );
 EEG = pop_summary_AR_eeg_detection(EEG,[filepath,trialleft_name]);
%EEG = pop_saveset( EEG, 'filename',savename,'filepath',savepath);
ERP = pop_averager( EEG , 'Criterion', 'good', 'ExcludeBoundary', 'on', 'SEM', 'on' );
%ERP = pop_savemyerp(ERP, 'erpname', erpname, 'filename',[erpname,'.erp'], 'filepath',filepath, 'Warning', 'on');

%%%%%%%%%%%con/ips
ERP = pop_binoperator( ERP, {  'prepareContraIpsi',  'Lch = [1 4 6 7 8 9 15 16 17 18 24 25 26 27 33 34 35 36 42 43 44 45 51 52 53 59]',  'Rch = [3 5 14 13 12 11 23 22 21 20 32 31 30 29 41 40 39 38 50 49 48 47 57 56 55 61]',...
  'nbin1 = 0.5*bin1@Rch + 0.5*bin2@Lch label Condition_1 Contra',  'nbin2 = 0.5*bin1@Lch + 0.5*bin2@Rch label Condition_1 Ipsi',...
  'nbin3 = 0.5*bin3@Rch + 0.5*bin4@Lch label Condition_2 Contra',  'nbin4 = 0.5*bin3@Lch + 0.5*bin4@Rch label Condition_2 Ipsi'});
%ERP = pop_savemyerp(ERP, 'erpname', erpname_1, 'filename',[erpname_1,'.erp'], 'filepath',filepath, 'Warning', 'on');

%%%%%%%%% con-ips
ERP = pop_binoperator( ERP, {  'bin5 = bin1 - bin2 label Condition_1 Contra-Ipsi_2T',  'bin6 = bin3 - bin4 label Condition_2 Contra-Ipsi_4T'});

%%%%%%%%  Delta 4T-2T
ERP = pop_binoperator( ERP, {  'bin7 = bin6 - bin5 label deltaT'});
ERP = pop_savemyerp(ERP, 'erpname', erpname_2, 'filename',[erpname_2,'.erp'], 'filepath',filepath, 'Warning', 'on');
%%%%%%%%

%%%%%%%% channel avg
ERP = pop_erpchanoperator( ERP, {  'nch1 = 0.25*(ch42+ch44+ch51+ch59) Label P7+P3+O1+TP7',  'nch2 = 0.33*(ch42+ch44+ch51) Label P7+P3',  'nch3 = 1*(ch51) Label PO7'} ,...
 'ErrorMsg', 'popup', 'Warning', 'on' );
ERP = pop_savemyerp(ERP, 'erpname', erpname_3, 'filename',[erpname_3,'.erp'], 'filepath',filepath, 'Warning', 'on');
%%%%%%%%% plot
ERP = pop_ploterps( ERP,  5:6,  1:3 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'no', 'Box', [ 2 2], 'ChLabel', 'on',...
 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'k-' , 'r-' , 'b-' }, 'LineWidth',  1,...
 'Maximize', 'on', 'Position', [ 103.6 28.2353 107 32], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale', [ -199.0 900.0   -100 0:200:800 ],...
 'YDir', 'normal' );

%%%%%%%% save fig
saveas(gcf,[filepath,'CDA_',filename,'.jpg']);
    end
end
% 
