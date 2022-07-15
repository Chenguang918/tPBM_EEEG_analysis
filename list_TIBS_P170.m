% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eeglab;
%sub=[3,5:21,23:29,31:50];
%sub=[14];
sub=[3:13,14,15:16,17:19,21,23:29,31,32:37,39:43,45:49,50]; %all
con={'_A','_S'};
for i=1:length(sub)
    for o=1:2
subname=['sub',num2str(sub(i)),con{o}];
filename=[subname,'_pre_ICA_clean_V'];
filepath=['D:\\Zhaochenguang\\Data\\TIBS\\CDT2set\\','sub',num2str(sub(i)),con{o},'\\'];
erpname=[filename,'_erp.erp'];
erpname_2=[filename,'_P170'];
%%%%%%%%%%% loaderp
ERP = pop_loaderp( 'filename', erpname_1, 'filepath', filepath );
%%%%%%%%%%% binoperator
ERP = pop_binoperator( ERP, {  'nbin1 = (bin1 + bin2)*0.5 label 2T',  'nbin2 = (bin3 + bin4)*0.5 label 4T'});
ERP = pop_savemyerp(ERP, 'erpname', erpname_2, 'filename',[erpname_2,'.erp'], 'filepath',filepath, 'Warning', 'on');
%%%%%%%%
    end
end

