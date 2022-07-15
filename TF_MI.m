clear all
sub=[3,4,5:13,15:16,32:37,39:43,50]; %1064
%sub=[]
con={'_A','_S'};
for i=1:length(sub)
    for o=1:2
% define the filenames, parameters and other information that is subject specific
  subname=['sub',num2str(sub(i)),con{o}];
  filename=[subname,'_pre_ICA_clean_V_TF'];
  filepath=['J:\\Zhaochenguang\\Data\\TIBS\\Filedtrip_TF\\'];
  savepath=['J:\\Zhaochenguang\\Data\\TIBS\\Filedtrip_TF\\'];
  subjectdata.subjectdir        = filepath;
  subjectdata.datadir           = [filename,'.mat'];
  subjectdata.subjectnr         = filename;
  outputdir = savepath;
  load([subjectdata.subjectdir filesep subjectdata.datadir]);
%%% load EEGLAB type data
%   EEG = pop_loadset('filename',[filename,'.set'],'filepath',filepath);
%   data = eeglab2fieldtrip( EEG,'preprocessing','none');
  data_TF.powspctrm;     % trial*channel*frequency*time
  %% struct2mat
  for i=1:length(data_TF.cfg.previous.event)
  value(i,:) = getfield(data_TF.cfg.previous.event,{i}, 'value');
  end
  index=find(value==11|value==21|value==111|value==121);
  reactionindex=value(index+2); % reaction index
  data_TF.trialinfo(:,2)=reactionindex;
%%% define trials
  condition={'11' '21' '111' '121'};  % 后期被试
  %condition=[11 21 111 121];  % 前期被试

  %%% make directory, if needed, to save all analysis data
%   if exist(outputdir) == 0
%      mkdir(ouputdir)
%   end
  %%% Preprocess and SAVE
  data_pre = ft_preprocessing(cfg);
  %plot(dataM.time{1}, dataM.trial{89}(60,:));
  %% T-f analysis 
        %end
   end
end