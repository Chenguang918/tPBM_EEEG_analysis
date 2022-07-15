clear all
sub=[1:4,6:7,9:12,15:21]; % Exp2
% sub=[15];
numsub=[1:21];
con={'A','S'};
% if nargin == 0
%   disp('Not enough input arguments');
%   return;
% end
for i=1:length(sub)
    for o=1:2
      try
% ensure that we don't mix up subjects
clear subjectdata
      if ismember(sub(i),numsub)
          judge=1;                          %NUM
      else
          judge=0;                          %STR
      end
 %judge=1;
% define the filenames, parameters and other information that is subject specific
  subname=['sub',num2str(sub(i)),con{o}];
  filename=[subname,'_filt_int_removeICA'];
  filepath=['I:\Zhaochenguang\Data\TIBS2.0\','sub',num2str(sub(i)),con{o}];
  filepath1=['I:\Zhaochenguang\Data\TIBS2.0\'];
  savepath=['I:\Zhaochenguang\Data\TIBS2.0\Filedtrip_TF'];
  subjectdata.subjectdir        = filepath;
  subjectdata.datadir           = [filename,'.set'];
  subjectdata.subjectnr         = filename;
  outputdir = savepath;
%%% load EEGLAB type data
%   EEG = pop_loadset('filename',[filename,'.set'],'filepath',filepath);
%   data = eeglab2fieldtrip( EEG,'preprocessing','none');
  cfg = [];
%%% define trials
  switch judge
      case 0
  condition={'11' '21' '111' '121'};  % 后期被试
  cfg.trialfun  = 'ft_trialfun_TIBS'; %
      case 1
  condition=[11 21 111 121];  % 前期被试
  cfg.trialfun  = 'ft_trialfun_TIBS_num';
  end
  cfg.trialdef.eventtype      = 'trigger';
  cfg.trialdef.eventvalue     =  condition; % the value of the stimulus trigger. % condition*100 left/right*10
  cfg.dataset = [subjectdata.subjectdir filesep subjectdata.datadir];
  cfg.trialdef.prestim  =  0.8;
  cfg.trialdef.poststim  = 1.5;
  %cfg.trialdef.eventtype  = '?';
  cfg.lpfilter    = 'no';
  cfg.continuous    = 'yes';
  cfg.channel    = 'EEG';
  cfg       = ft_definetrial(cfg);
%   cfg.reref       = 'yes';
%   cfg.channel     = [1:62];        
%   cfg.refchannel  = 'all'; 
  %elec = ft_read_sens('quickcap64.mat');  % for electrodes
  %%% make directory, if needed, to save all analysis data
%   if exist(outputdir) == 0
%      mkdir(outputdir)
%   end
  %%% Preprocess and SAVE
  data_pre = ft_preprocessing(cfg);
  %plot(data_pre.time{1}, data_pre.trial{89}(60,:));
  for i3=1:length(data_pre.trial)
  if (max(max(data_pre.trial{1,i3})))>100||(min(min(data_pre.trial{1,i3}))<-100)
      data_pre.trialinfo(i3,4)=0;
  else
      data_pre.trialinfo(i3,4)=1;
  end
  end
  %%
  
  
  %% T-f analysis 
   cfg=[];
   cfg.method='wavelet';
   cfg.output= 'pow';
   cfg.keeptrials  = 'yes';
   cfg.foi = 4:2:40;
   cfg.toi=-0.5:0.05:1.5;
   cfg.width=5;
   data_TF= ft_freqanalysis(cfg,data_pre);
    save([outputdir filesep subjectdata.subjectnr '_TF'],'data_TF','-V7.3')
       catch
          disp(['Something was wrong with Subject', int2str(i) '! Continuing with next in line']);
       end
   end
end