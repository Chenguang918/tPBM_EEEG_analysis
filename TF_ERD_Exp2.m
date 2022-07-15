clear all
sub=[1:4,6:7,9:12,15:21]; % Exp2
con={'A','S'};
filepath=['G:\Zhaochenguang\Data\TIBS2.0\Filedtrip_TF\'];
savepath=['G:\Zhaochenguang\Data\TIBS2.0\Filedtrip_TF\ERD\'];
conditionpool=[11,21,111,121];
outputdir = savepath;
for ii=1:length(sub)
    for o=1:2
        subname = ['sub',num2str(sub(ii)),con{o}];
        filename = [subname,'_filt_int_removeICA_TF'];
        subjectdata.subjectnr = filename;
        load([filepath,filename,'.mat'])
        for i=1:4
        right_resp=[];clean=[];
        index=conditionpool(i);
        eval(['condition=find(data_TF.trialinfo(:,1)==',num2str(index),');']);
        right_resp=find(data_TF.trialinfo(condition,2)==100);
        clean=find(data_TF.trialinfo(condition(right_resp),4)==1);
        eval(['condition',num2str(index),'_index=condition(right_resp(clean));']);
        end

        condition1=squeeze(mean(data_TF.powspctrm([condition11_index' condition21_index'],:,:,:),1));
        condition2=squeeze(mean(data_TF.powspctrm([condition111_index' condition121_index'],:,:,:),1));
        condition1_BC=repmat(squeeze(mean(condition1(:,:,7:15),3)),1,1,41);
        condition2_BC=repmat(squeeze(mean(condition2(:,:,7:15),3)),1,1,41);
        condition1_ERD=(condition1-condition1_BC)./condition1_BC;
        condition2_ERD=(condition2-condition2_BC)./condition2_BC;

        
        data_ERD1=data_TF;data_ERD2=data_TF;
        data_ERD1.powspctrm=condition1_ERD;
        data_ERD2.powspctrm=condition2_ERD;
        data_ERD1.dimord='chan_freq_time';
        data_ERD2.dimord='chan_freq_time';
        save([outputdir filesep subjectdata.subjectnr '_ERD1'],'data_ERD1','-V7.3')
        save([outputdir filesep subjectdata.subjectnr '_ERD2'],'data_ERD2','-V7.3')
    end
end

        


