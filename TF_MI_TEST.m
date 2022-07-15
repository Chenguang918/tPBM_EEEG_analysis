clear all
%sub=[3,4,5:13,15:16,33:37,39:40,41,42:43,50]; %1064
sub=[14,17,18,19,21,23,24,25,26,27,28,29,31,45,46,47,48,49]; % 852
con={'_A','_S'};
filepath=['I:\Zhaochenguang\Data\TIBS\Filedtrip_TF\'];
savepath=['I:\Zhaochenguang\Data\TIBS\Filedtrip_TF\MI\'];
conditionpool=[11,21,111,121];
outputdir = savepath;
for ii=1:length(sub)
    for o=1:2
        subname=['sub',num2str(sub(ii)),con{o}]
        filename=[subname,'_pre_ICA_clean_V_TF'];
        subjectdata.subjectnr         = filename;
        load([filepath,filename,'.mat'])
        for i=1:4
        right_resp=[];clean=[];
        index=conditionpool(i);
        eval(['condition=find(data_TF.trialinfo(:,1)==',num2str(index),');']);
        right_resp=find(data_TF.trialinfo(condition,2)==100);
        clean=find(data_TF.trialinfo(condition(right_resp),4)==1);
        eval(['condition',num2str(index),'_index=condition(right_resp(clean));']);
        end
%         data_MI=data_TF;
        condition11=squeeze(mean(data_TF.powspctrm(condition11_index,:,:,:),1));
        condition21=squeeze(mean(data_TF.powspctrm(condition21_index,:,:,:),1));
        condition111=squeeze(mean(data_TF.powspctrm(condition111_index,:,:,:),1));
        condition121=squeeze(mean(data_TF.powspctrm(condition121_index,:,:,:),1));
        condition1_MI=(condition11-condition21)./(condition11+condition21);
        condition2_MI=(condition111-condition121)./(condition111+condition121);
        data_MI1=data_TF;data_MI2=data_TF;
        data_MI1.powspctrm=condition1_MI;
        data_MI2.powspctrm=condition2_MI;
        data_MI1.dimord='chan_freq_time';
        data_MI2.dimord='chan_freq_time';
        save([outputdir filesep subjectdata.subjectnr '_MI1'],'data_MI1','-V7.3')
        save([outputdir filesep subjectdata.subjectnr '_MI2'],'data_MI2','-V7.3')
    end
end

        


