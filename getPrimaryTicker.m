% getPrimaryTicker returns a structure containing the primary tickers and all tickers of
% a given day and a given commodity name.
%
% input:    date =  a matlab date number
%           commodity = commodity name. case sensitive (IF, cu, ...)
% output:   prit.primaryticker = string the primary ticker
%           prit.primarytickerindex = index of the primary ticker in prit.alltickers
%           prit.alltickers = all tickers of the day
%           prit.allbenchmark = benchmark (vol/openint) of corresponding prit.alltickers
%
%
%%%%%%%%%%%%%%
% v1 use excel generated data file. 
% v2 use database for data source
% lin he 201504

function [priticker,prit] = getPrimaryTicker(date, commodity)


%% init variables
dateStr = datestr(date,'yyyy-mm-dd');
dateyear = datevec(date);
dateyear = dateyear(1);

% find exchange name below TODO
exch = findNameIndex(commodity, 'exchid');
if(isempty(exch))
    error('futuresutil:getPrimaryTicker','couldnot find exchange name for commodity');
end

%% get data and sort, find biggest one ... 
% to see how the csv file is generated, see readme in the data folder
filenamecsv = [getFolder(mfilename('fullpath')), '/getPrimaryTicker_data/', exch, num2str(dateyear), '.csv'];
filenamemat = [getFolder(mfilename('fullpath')), '/getPrimaryTicker_data/', exch, num2str(dateyear), '.mat'];

% 1, try use global var
global GLOBAL_GETPRIMARYTICKER_DATA_SHFE;
global GLOBAL_GETPRIMARYTICKER_DATA_CFFEX;
global GLOBAL_GETPRIMARYTICKER_DATA_DCE;
global GLOBAL_GETPRIMARYTICKER_DATA_CZCE;
global GLOBAL_GETPRIMARYTICKER_DATA_LOADEDYEAR;  
if(isempty(GLOBAL_GETPRIMARYTICKER_DATA_LOADEDYEAR)) GLOBAL_GETPRIMARYTICKER_DATA_LOADEDYEAR=0; end
rsFromGlobal = [];
switch(lower(exch))
    case {'shfe'}
        rsFromGlobal = GLOBAL_GETPRIMARYTICKER_DATA_SHFE;
    case 'cffex'
        rsFromGlobal = GLOBAL_GETPRIMARYTICKER_DATA_CFFEX;
    case 'dce'
        rsFromGlobal = GLOBAL_GETPRIMARYTICKER_DATA_DCE;
    case 'czce'
        rsFromGlobal = GLOBAL_GETPRIMARYTICKER_DATA_CZCE;
end
if(~isempty(rsFromGlobal) && GLOBAL_GETPRIMARYTICKER_DATA_LOADEDYEAR==dateyear)     
    rs = rsFromGlobal.rs;
    rsdate = rsFromGlobal.rsdate;
    rs = findRS(rsdate,rs,date,commodity);
% 2, try read the mat and save for later use as global
elseif(exist(filenamemat,'file'))
    rs=[];
    rsdate=[];
    load(filenamemat,'rsdate','rs');
    GLOBAL_GETPRIMARYTICKER_DATA_LOADEDYEAR = dateyear;
    switch(lower(exch))
        case {'shfe'}
            GLOBAL_GETPRIMARYTICKER_DATA_SHFE.rs = rs;
            GLOBAL_GETPRIMARYTICKER_DATA_SHFE.rsdate = rsdate;
        case 'cffex'
            GLOBAL_GETPRIMARYTICKER_DATA_CFFEX.rs = rs;
            GLOBAL_GETPRIMARYTICKER_DATA_CFFEX.rsdate = rsdate;
        case 'dce'
            GLOBAL_GETPRIMARYTICKER_DATA_DCE.rs = rs;
            GLOBAL_GETPRIMARYTICKER_DATA_DCE.rsdate = rsdate;
        case 'czce'
            GLOBAL_GETPRIMARYTICKER_DATA_CZCE.rs = rs;
            GLOBAL_GETPRIMARYTICKER_DATA_CZCE.rsdate = rsdate;
    end    
    rs = findRS(rsdate,rs,date,commodity);
% 3, if mat doesnt exist read csv and generate mat    
% you need to manually generate the csv. see csv folder readme file
elseif(exist(filenamecsv,'file'))
    % get data, from file
    [~,~,rsfile] = xlsread(filenamecsv);
    rs = rsfile(:,[2,13,15]);
    % pick the date
    rsdate = zeros(1,size(rs,1));
    for i=1:numel(rsdate)
        rsdate(i) = datenum(rsfile{i,3}, 'yyyy/mm/dd');
    end
    %save mat file first
    save(filenamemat, 'rsdate','rs');
    rs = findRS(rsdate,rs,date,commodity);
%4, if csv doesn''t exist, then go to DB.    
else
    % get data, from db
    sql = ['select ticker,volume,openint from commoditystat.',lower(exch),num2str(dateyear),' where ticker like ''',commodity,'%'' and date=''',dateStr,''' order by ticker asc;'];
    conn = getSQLConn('180.169.10.158:3306','read','read','backgrounddata');
    rs = fetch(conn, sql);
    
end


isize = size(rs,1);
% set up return value
prit.primaryticker='';
prit.primarytickerindex=0;
prit.alltickers=cell(1,isize);
prit.allbenchmark=zeros(1,isize);
% go through the result set from database
if(isize>0)
    for i=1:isize
        prit.alltickers(i) = rs(i,1);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%use either : openintvector or volumevector depending on the need 
        prit.allbenchmark(i) = cell2mat(rs(i,2)); % use volume as benchmark
%         prit.allbenchmark(i) = cell2mat(rs(i,3)); % use openint as benchmark
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
    end
    [~,ind] = sort( prit.allbenchmark, 2, 'descend');    
    prit.primaryticker=cell2mat(prit.alltickers(ind(1)));
    prit.primarytickerindex=ind(1);
else
    warning('futuresutil:getPrimaryTicker','Database returned empty results. Probably ticker not exist on the day or database not updated yet. ');

end
priticker = prit.primaryticker;
end


function rsret = findRS(rsdate,rs,date,commodity)
    % go on picking date
    rs = rs(rsdate==date,:);
    % pick the ticker
    ind = false(1,size(rs,1));
    for i=1:size(rs,1)
        if(strcmpi(getTickerInfo(rs(i,1),rsdate(i)),commodity))
            ind(i) = true;
        else
            ind(i) = false;
        end
    end
    rsret = rs(ind,:);
end


