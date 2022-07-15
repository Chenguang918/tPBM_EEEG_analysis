function[EEGevent] = event2blockmarker_3part(EEGevent)
%index=1(value)  =2(str)
index_str=ischar(EEGevent(1).type);
l=length(EEGevent);
if index_str==1
    for i=1:l
    EEGevent(i).type=str2double(EEGevent(i).type);    
    end
end
i1=0;i3=0;
for i=1:l
    index=EEGevent(i).type;
switch index
    case 11
        if (i1<=80)
            core=1000;
        elseif (80<i1)&&(i1<=160)
                core=2000;
        elseif (160<i1)&&(i1<=240)
                core=3000;
        end
        EEGevent(i).type=EEGevent(i).type+core;
        i1=i1+1;
        
    case 21
        if (i1<=80)
            core=1000;
        elseif (80<i1)&&(i1<=160)
                core=2000;
        elseif (160<i1)&&(i1<=240)
                core=3000;
        end
        EEGevent(i).type=EEGevent(i).type+core;
        i1=i1+1;
        
    case 111
        if (i3<=80)
            core=1000;
        elseif (80<i3)&&(i3<=160)
                core=2000;
        elseif (160<i3)&&(i3<=240)
                core=3000;
        end
        EEGevent(i).type=EEGevent(i).type+core;
        i3=i3+1;

        case 121
        if (i3<=80)
            core=1000;
        elseif (80<i3)&&(i3<=160)
                core=2000;
        elseif (160<i3)&&(i3<=240)
                core=3000;
        end
        EEGevent(i).type=EEGevent(i).type+core;
        i3=i3+1;
end
end
end