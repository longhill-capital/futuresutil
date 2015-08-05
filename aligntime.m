% Align price data towards given time interval
% input:    value = value to be aligned
%           time = time stamp of the value (0,0:00AM ~ 1,24:00PM)
%           t_int0 = desired output time scale. 
%                    t_int0 should sit on 1/N seconds so that the resampled
%                    (according to frequency param) data could sit on the
%                    same point
%           frequency = input data sampling frequency - In unit of Hertz. allow sampling timing error. 
%                 0 means no error considered.
%                 ...
%                 2 means re align input samples as a 2 Hertz signal. 
%           then align signal alone t_int0
%
% output:   ret = input value aligned at t_int0 


function ret = aligntime(value, time, t_int0, frequency)
if(nargin==3)
    frequency=0;
end 
if(frequency == 0)
    if(numel(value)~=numel(time))
        error('futuresutil:aligntime','value and time size different');
    end

    [~,IA,IB] = intersect(t_int0, time);
    ret = zeros(1,length(t_int0));
    ret(IA) = value(IB);
    
else
    time =round(time.*86400*frequency)/frequency/86400;
    [~,IA,IB] = intersect(t_int0, time);
    ret = zeros(1,length(t_int0));
    ret(IA) = value(IB);
    

    
    
end 