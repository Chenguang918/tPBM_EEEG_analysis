% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % 将ERP分成4个block
eeglab;
sub=[3,5:21,23:29,31:50]; %1064
% sub=[4];
con={'_A','_S'};
for i=1:length(sub)
    for o=1:2
subname=['sub',num2str(sub(i)),con{o}];
filename=[subname,'_pre_ICA_clean_V'];
filepath=['E:\\Zhaochenguang\\Data\\TIBS\\CDT2set\\','sub',num2str(sub(i)),con{o},'\\'];
filepath1=['E:\\Zhaochenguang\\Data\\TIBS\\CDT2set\\'];
eventname=[filename,'_tc.txt'];
binname='WM_bin_correct_tc.txt';
trialleft_name=[filename,'_trialleft_tc.txt'];
savepath=['E:\\Zhaochenguang\\Data\\TIBS\\CDT2set\\'];
erpname_1=[filename,'_tc_diff'];
erpname=[filename,'_tc'];
%save=[savepath,savename];
EEG = pop_loadset('filename',[filename,'.set'],'filepath',filepath);
EEG = pop_reref( EEG, []);
EEG = eeg_checkset( EEG );
EEG.event = event2blockmarker(EEG.event);   % event 2 event labeled by task order
EEG  = pop_creabasiceventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' }, 'Eventlist',...
 [filepath,eventname] );
EEG  = pop_binlister( EEG , 'BDF', [filepath1,'/TXT/',binname], 'IndexEL',  1, 'SendEL2', 'EEG', 'Voutput', 'EEG' );
EEG = pop_epochbin( EEG , [0  3000.0],  [ 0 200]);
EEG  = pop_artextval( EEG , 'Channel',  5:62, 'Flag',  1, 'Threshold', [ -100 100], 'Twindow', [ 0 600] );
%EEG  = pop_artextval( EEG , 'Channel',  63, 'Flag', 1 , 'Threshold', [ -50 50], 'Twindow', [ 200 400] );
 EEG = pop_summary_AR_eeg_detection(EEG,[filepath,trialleft_name]);
%EEG = pop_saveset( EEG, 'filename',savename,'filepath',savepath);
ERP = pop_averager( EEG , 'Criterion', 'good', 'ExcludeBoundary', 'on', 'SEM', 'on' );
ERP = pop_savemyerp(ERP, 'erpname', erpname, 'filename',[erpname,'.erp'], 'filepath',filepath, 'Warning', 'on');

%%%%%%%%%%%con/ips
ERP = pop_binoperator( ERP, {  'prepareContraIpsi',  'Lch = [ 1 4 9:-1:6 15 18:-1:16 24 27:-1:25 33 36:-1:34 45:-1:42 53:-1:51 58 59]',...
  'Rch = [ 3 5 11:14 23 20:22 32 29:31 41 38:40 47:50 55:57 62 61]',  'nbin1 = 0.5*bin1@Rch + 0.5*bin5@Lch label C11 Contra',...
  'nbin2 = 0.5*bin1@Lch + 0.5*bin5@Rch label C11 Ipsi',  'nbin3 = 0.5*bin2@Rch + 0.5*bin6@Lch label C12 Contra',  'nbin4 = 0.5*bin2@Lch + 0.5*bin6@Rch label C12 Ipsi',...
  'nbin5 = 0.5*bin3@Rch + 0.5*bin7@Lch label C13 Contra',  'nbin6 = 0.5*bin3@Lch + 0.5*bin7@Rch label C13 Ipsi',...
  'nbin7 = 0.5*bin4@Rch + 0.5*bin8@Lch label C14 Contra',  'nbin8 = 0.5*bin4@Lch + 0.5*bin8@Rch label C14 Ipsi',  'nbin9 = 0.5*bin9@Rch + 0.5*bin13@Lch label C21 Contra',...
  'nbin10 = 0.5*bin9@Lch + 0.5*bin13@Rch label C21 Ipsi',  'nbin11 = 0.5*bin10@Rch + 0.5*bin14@Lch label C22 Contra',...
  'nbin12 = 0.5*bin10@Lch + 0.5*bin14@Rch label C22 Ipsi',  'nbin13 = 0.5*bin11@Rch + 0.5*bin15@Lch label C23 Contra',  'nbin14 = 0.5*bin11@Lch + 0.5*bin15@Rch label C23 Ipsi',...
  'nbin15 = 0.5*bin12@Rch + 0.5*bin16@Lch label C24 Contra',  'nbin16 = 0.5*bin12@Lch + 0.5*bin16@Rch label C24 Ipsi'});

ERP = pop_binoperator( ERP, {  'bin17 = bin1 - bin2 label C11 Contra-Ipsi',  'bin18 = bin3 - bin4 label C12 Contra-Ipsi',...
  'bin19 = bin5 - bin6 label C13 Contra-Ipsi',  'bin20 = bin7 - bin8 label C14 Contra-Ipsi',  'bin21 = bin9 - bin10 label C21 Contra-Ipsi',...
  'bin22 = bin11 - bin12 label C22 Contra-Ipsi',  'bin23 = bin13 - bin14 label C23 Contra-Ipsi',...
  'bin24 = bin15 - bin16 label C24 Contra-Ipsi'});

ERP = pop_binoperator( ERP, {'bin25 = bin21 - bin17 label T1-ΔCDA', 'bin26 = bin22 - bin18 label T2-ΔCDA',...
  'bin27 = bin23 - bin19 label T3-ΔCDA', 'bin28 = bin24 - bin20 label T4-ΔCDA' });
  
ERP = pop_savemyerp(ERP, 'erpname', erpname_1, 'filename',[erpname_1,'.erp'], 'filepath',filepath, 'Warning', 'on');

ERP = pop_ploterps( ERP,  25:28,  51 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'no', 'Box', [ 1 1], 'ChLabel', 'on',...
 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'k-' , 'r-' , 'b-' , 'g-' }, 'LineWidth',...
  1, 'Maximize', 'on', 'Position', [ 103.6 15.5294 107 32], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale',...
 [ 0.0 1000.0   0:200:800 ], 'YDir', 'reverse' );
%%%%%%%% save fig
saveas(gcf,[filepath,'CDA_',filename,'_tc.jpg']);
    end
end

