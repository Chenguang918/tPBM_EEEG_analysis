function [trl, event] = ft_trialfun_TIBS(cfg)

% read the header information and the events from the data
hdr   = ft_read_header(cfg.dataset);
event = ft_read_event(cfg.dataset);

% determine the number of samples before and after the trigger
pretrig  = -round(cfg.trialdef.prestim  * hdr.Fs);
posttrig =  round(cfg.trialdef.poststim * hdr.Fs);

%% Check relationship with sti-response






%% Check 'boundary'
  for i=1:length(event)
      %judge 1
      if strcmp({'boundary'},getfield(event,{i}, 'value'))
          value(i,:) = 999;
          sample(i,:) =999;
      else
          value(i,:) = str2num(getfield(event,{i}, 'value'));
          sample(i,:) =getfield(event,{i}, 'sample');
      end
  end
 boundary_list=find(value==999);
 response_list=find(value==100 | value==99);
 for ii=1:length(boundary_list)
     if boundary_list(ii)>(response_list(1)-1)&& boundary_list(ii)<(response_list(end))
        lastrep=find(response_list> boundary_list(ii));
        prerep=find(response_list< boundary_list(ii));
        A=response_list(prerep(end));
        B=response_list(lastrep(1));
        for iii=1:(B-A)
        event(A+iii).value='255';  
        end
     else
        event(boundary_list(ii)).value='255'; 
     end
 end
%% Check last response 
index_255=0;
 if value(end)~=100&&99
        value(response_list(end)+1:end)=255;
        index_255=1;
 end
 
% search for "stimulus" events
index1=strcmp({'11'}, {event.value})+strcmp({'21'}, {event.value})+strcmp({'111'}, {event.value})++strcmp({'121'}, {event.value});
pre_sti_num=find(index1~=0);
try
for i1=1:length(pre_sti_num)
    response_target_loc=pre_sti_num(i1)+2; 
    response_target=str2num(getfield(event,{response_target_loc}, 'value'));
    if (response_target==100)||(response_target==99)
    else
        index1(pre_sti_num(i1))=0;
    end
end
catch
end
stimulus_value  = [value(find(index1))];
stimulus_sample = [event(find(index1)).sample]';

% search for "response" events
index2=strcmp({'100'}, {event.value})+strcmp({'99'}, {event.value});
pre_res_num=find(index2~=0);
try
for i2=1:length(pre_res_num)
    sti_target_loc=pre_res_num(i2)-2; 
    sti_target=str2num(getfield(event,{sti_target_loc}, 'value'));
    if (sti_target==11)||(sti_target==21)||(sti_target==111)||(sti_target==121)
    else
        index2(pre_res_num(i2))=0;
    end
end
catch
end
response_value  = [value(find(index2))];
response_sample = [event(find(index2)).sample]';
%% Removel last response
if index_255==1
    ll=find(stimulus_value==255);
stimulus_value(ll)=[];
stimulus_sample(ll)=[];
end

if length(stimulus_sample)~=length(response_sample)
error('the number of stimuli and responses is different');
end

if any((response_sample-stimulus_sample)<=0)
error('there is a response prior to a stimulus');
end

reaction_time = (response_sample-stimulus_sample)/hdr.Fs;

% define the trials
trl(:,1) = stimulus_sample + pretrig;  % start of segment
trl(:,2) = stimulus_sample + posttrig; % end of segment
trl(:,3) = pretrig;                    % how many samples prestimulus
trl(:,4) = stimulus_value;             % stimulus_value
trl(:,5) = response_value;             % response_value
trl(:,6) = reaction_time;              % reaction_time
trl(:,7) = (stimulus_value==3 & response_value==103) | (stimulus_value==4 & response_value==104);

