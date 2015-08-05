% getTickerInfo returns contract name, delivery year and month data from ticker and date of the ticker
% input: ticker  e.g. 'WT409','a1201'
%        date   string(yyyyMMdd) or integer (matlab date) format date
%               default date = today, and in this case retrun 0 as year/month
%
% output: name = contract name e.g.'WT'
%         year = delivery year e.g. 2014
%         month = delivery month e.g. 09
%
% 
% linhe 201504


function [name, year, month] = getTickerInfo(ticker,date)
%if only one param, use default date today, and dont output deliver year/month
ignoreyearmonth=0;
if(nargin==1)
    date = today;
    ignoreyearmonth = 1;
end
if(iscell(ticker))
    ticker = cell2mat(ticker);
end
lastisnumber=0; % if the last digit is a number
for i=1:numel(ticker)
%     if(isempty(str2num(ticker(i))) || strcmpi(ticker(i),'i') || strcmpi(ticker(i),'j'))  
    if(isnan(str2double(ticker(i))) || strcmpi(ticker(i),'i') || strcmpi(ticker(i),'j'))  

        lastisnumber=0;
    else
        if(lastisnumber==0)
            break;
        end
    end
end
name = ticker(1:i-1);
if(ignoreyearmonth)
    month = 0;
    year = 0;
    return;
end
month = str2double(ticker(end-1:end));
if(numel(ticker)-i==3)
    year=ticker(i:i+1);
    year=str2double(['20',year]);
else
    year=ticker(i);
    if(ischar(date))
        if(isempty(strfind(date,'-')))
            tradingdate = datenum(date,'yyyymmdd');
        else
            tradingdate = datenum(date,'yyyy-mm-dd');
        end
    else
        tradingdate = date;
    end
    [tradingyear, tradingmonth, ~,~,~,~] = datevec(tradingdate);


    year=str2double(['200',year]);
    while(year<tradingyear)
        year = year+10;
    end

    if(tradingyear == year && tradingmonth>month)
        year = year+10;
        warning('futuresutil:getTickerInfo','adding 10 years to tradingyear, suspecius'); %#ok<WNTAG>
    end
    if(year>2020)
        error('futuresutil:getTickerInfo','suspecious year');
    end
end
    

end