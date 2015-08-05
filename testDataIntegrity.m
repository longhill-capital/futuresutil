% testDataIntegrity tests data integrity with certain cretira
% cretira: price high/low values out of bound?
%          volume value bigger than max?
% 
% input: vehicle = 'commodity', etc.
%        ticker = vehicle ticker. e.g. 'cu1505'
%        date = date of the tested ticker, either yyyy-mm-dd or matlab date
%        varargin = pair of the values to be tested. currently accepting:
%                   'price'(price series), 'volume'(volume series)
%
% output: isGood = whether the data is good
%         msg = message of how data is bad

function [isGood, msg] = testDataIntegrity(vehicle, ticker, date, varargin)
isGood = true;
msg = '';

if(~ischar(date))
    date = datestr(date,'yyyy-mm-dd');
end

if(strcmpi(vehicle,'commodity'))
    conn = getSQLConn('180.169.10.158:3306','read','read','commoditystat');
    sql = ['select high,low,volume from commoditystat.',findNameIndex(getTickerInfo(ticker),'exchid'),date(1:4),' WHERE date=''',date,''' and ticker=''',ticker,''';' ];
    rs = fetch(conn, sql);
    if(isempty(rs))
        warning('futuresutil:testDataIntegrity','Didn''t find info from commoditystat database');
        isGood = 1;
        msg = 'Unable to decide. Database empty';
    elseif(size(rs,1)>1)
        warning('futuresutil:testDataIntegrity','found more than 1 entry from commoditystat database');
    end
    arglen =  numel(varargin);
    for i=1:2:arglen
        if(strcmpi(cell2mat(varargin(1,i)),'price'))
            p = cell2mat(varargin(1,i+1));
            %high price range
            if(max(p) > rs{1,1} )
                msg = [msg, ' price>high;']; %#ok<*AGROW>
                isGood = 0;
            end
            %low price range
            if(min(p) < rs{1,2})
                msg = [msg, ' price<low;'];
                isGood = 0;
            end
        elseif(strcmpi(cell2mat(varargin(1,i)),'volume'))
            v = cell2mat(varargin(1,i+1));
            if(max(v)>rs{1,3})
                msg = [msg, ' volume too big;'];
                isGood = 0;    
            end
        end 
    end
    
%elseif((strcmpi(vehicle,'stock ... ')))
%
%
end    
   


end 
