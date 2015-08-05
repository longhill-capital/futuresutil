% getTickerInfo returns contract name, delivery year and month data from ticker and date of the ticker
% input: commodity =  'WT','a', etc. 
%        field = string name of field to be returned
%           valid field names are:
%               'index'
%               'exchid'
%               'multiplier'
%               'margin'
%               'fee'
%               'category'/'subcategoryid'
% output: ret = returned value, corresponding to field
%
%
% v1 use local data file
% v2 pull data from db
% linhe 201504
function ret = findNameIndex(commodity,field)
%%
settings.tmpfileagelimit=86400; % life of temp data in second 
%%
switch(field)
    case 'index'
        ind = 1;
    case 'exchid'
        ind = 3;
    case 'multiplier'
        ind = 4;
    case 'category'
        ind = 5;
    case 'subcategoryid'
        ind = 5;
    case 'margin'
        ind = 6;
    case 'fee'
        ind = 7;
    otherwise
        error('not recognized');
end
%% load data
tmpFilename = [mfilename('fullpath') '.tmp.mat']; 
D=dir(tmpFilename);
if(exist(tmpFilename,'file')==0 || isempty(D) || (now - D.datenum)*86400>settings.tmpfileagelimit || (now - D.datenum)<0 )
    % file not exist, or can't read info, or too old, or tmp file is a future date
    %
    % re-pull data here
    disp('    findNameIndex:Loading database');
    conn = getSQLConn('180.169.10.158:3306','read','read','backgrounddata');
    if(isempty(conn) || ~isconnection(conn))
        error('futuresutil:findNameIndex','couldn''t get database connection');
    end
    conn = getSQLConn('180.169.10.158:3306','read','read','backgrounddata');
%     sql = 'SELECT idcommodityinfo, commodity, exchname, quotingmultiplier,subcategoryid,margin FROM backgrounddata.commodityinfo;';
    sql = 'SELECT a.idcommodityinfo, a.commodity, a.exchname, a.quotingmultiplier,a.subcategoryid,a.margin,b.exchcommission FROM backgrounddata.commodityinfo as a inner join backgrounddata.feeandcommission as b ON b.commodity=a.commodity;';
    rs = fetch(conn, sql);

    disp('    findNameIndex:Write to temp file');
    save(tmpFilename, 'rs');
else
    % just use temp file. skipping using the database for increased speed
%     disp('    findNameIndex:Loading file');
    load(tmpFilename, 'rs');
end

%% get return 
ret = '';

for i=1: size(rs, 1)
   if(strcmpi(cell2mat(rs(i,2)),commodity)==1)
       ret = cell2mat(rs(i,ind));
       break;
   end
end
if(isempty(ret))
    error('futuresutil:findNameIndex','couldn''t find exchange name for commodity');
end


    
