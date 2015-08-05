% MySQLtime2double converts mysql time to matlab time in double format
% input: t = mysql time
%        intraday: boolean, whether return only the decimal part with in a
%        day
% output: out = matlab time. if intraday==true 
%
% linhe 201504
function out = MySQLtime2double(t,intraday)

%% init
%default intraday = false
if(nargin==1)
    intraday=false;
end

%% 
out = zeros(size(t,1),1);

if(intraday)
    for i=1:size(t,1)
        if(ischar(t))
            str = t(i,:);
        elseif(iscell(t))
            str = t{i};
        end 
        out(i) = str2double(str(12:13))*3600 + str2double(str(15:16))*60 + str2double(str(18:19));
        out(i) = out(i)/86400;
    end
else 
    for i=1:size(t,1)
        if(ischar(t))
            str = t(i,:);
        elseif(iscell(t))
            str = t{i};
        end
        out(i) =  datenum(str,'yyyy-mm-dd HH:MM:SS');
    end 
end