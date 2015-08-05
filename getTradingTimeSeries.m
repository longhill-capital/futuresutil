function tint=getTradingTimeSeries(vehicleType, frequency, includeLunch, includePreMarket, includePostMarket)

if(nargin==2)
    includeLunch = false;
    includePreMarket = false;
    includePostMarket = false;
end

%%
switch lower(frequency)
    case 'high'
        pricepointFrequencyHigh = 2;
    case 'medium'
        pricepointFrequencyHigh = 1/60;
    case 'low'
        pricepointFrequencyHigh = 1/600;
    otherwise 
        error('unrecognized frequency');
end
%% 
if(includePreMarket)
    premarketLength = 60; %sec;
else
    premarketLength = 0;
end
if(includePostMarket)
    postmarketLength = 60; %sec;
else
    postmarketLength = 0;
end

%%      
switch lower(vehicleType)
    case 'stock'
        error('stock not implemented');
    case 'commodity'
        starttime = 9*3600;
        endtime = 15*3600;
        if(includeLunch)
            tint = [(starttime-premarketLength):1/pricepointFrequencyHigh:(endtime+postmarketLength)]; %#ok<NBRAK>
        else
            tint = [(starttime-premarketLength):1/pricepointFrequencyHigh:10.25*3600, ...
                        10.5*3600+1/pricepointFrequencyHigh:1/pricepointFrequencyHigh:11.5*3600, ...
                        13.5*3600+1/pricepointFrequencyHigh:1/pricepointFrequencyHigh:(endtime+postmarketLength)];
        end        
    case 'indexfutures'
        starttime = 9.25*3600;
        endtime = 15.25*3600;
        if(includeLunch)
            tint = [(starttime-premarketLength):1/pricepointFrequencyHigh:(endtime+postmarketLength)]; %#ok<NBRAK>
        else
            tint = [(starttime-premarketLength):1/pricepointFrequencyHigh:11.5*3600, ...
                        13*3600+1/pricepointFrequencyHigh:1/pricepointFrequencyHigh:(endtime+postmarketLength)];
        end
end
    
%%
tint = tint;




