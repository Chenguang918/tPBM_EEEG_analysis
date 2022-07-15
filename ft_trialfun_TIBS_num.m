function [trl, event] = ft_trialfun_TIBS_num(cfg)

% read the header information and the events from the data
hdr   = ft_read_header(cfg.dataset);
event = ft_read_event(cfg.dataset);

% determine the number of samples before and after the trigger
pretrig  = -round(cfg.trialdef.prestim  * hdr.Fs);
posttrig =  round(cfg.trialdef.poststim * hdr.Fs);

  for i=1:length(event)
      if ischar(event(i).value)
      else
      value(i,:) =event(i).value ;
      end
  end
  
 boundary_list=find(value==800000);
 response_list=find(value==100 | value==99);
 for ii=1:length(boundary_list)
     if boundary_list(ii)>(response_list(1)-3)
        lastrep=find(response_list> boundary_list(ii));
        prerep=find(response_list< boundary_list(ii));
        A=response_list(prerep(end));
        B=response_list(lastrep(1));
        for iii=1:(B-A)
        value(A+iii)=255; 
        end
     end
 end
 if value(end)~=100&&99
     value((response_list(end)+1):end)=255;
 end
% search for "stimulus" events
index1=[find(value==11 | value==21 | value==111 | value==121)];
stimulus_value  = [value(index1)];
stimulus_sample = [event(index1).sample]';

% search for "response" events
index2=[find(value==100 | value==99)];
response_value  = [value(index2)];
response_sample = [event(index2).sample]';

if length(stimulus_sample)~=length(response_sample)
error('the number of stimuli and responses is different');
end

% if any((response_sample-stimulus_sample)<=0)
% error('there is a response prior to a stimulus');
% end

reaction_time = (response_sample-stimulus_sample)/hdr.Fs;

% define the trials
trl(:,1) = stimulus_sample + pretrig;  % start of segment
trl(:,2) = stimulus_sample + posttrig; % end of segment
trl(:,3) = pretrig;                    % how many samples prestimulus
trl(:,4) = stimulus_value;             % stimulus_value
trl(:,5) = response_value;             % response_value
trl(:,6) = reaction_time;              % reaction_time
trl(:,7) = (stimulus_value==3 & response_value==103) | (stimulus_value==4 & response_value==104);