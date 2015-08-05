% get returns a structure containing the primary tickers and all tickers of
% a given day and a given commodity name.
%
% input:    date =  a matlab date number
%           commodity = commodity name. case sensitive (IF, cu, ...)
% output:   prit.primaryticker = string the primary ticker
%           prit.primarytickerindex = index of the primary ticker in prit.alltickers
%           prit.alltickers = all tickers of the day
%           prit.allbenchmark = benchmark (vol/openint) of corresponding prit.alltickers
%           prit.alltimestamp = timestamp of corresponding prit.alltickers when the benchmark is taken. 
%                               generally should be right around close or after close. if timestamp is too early this is a bad sign.
%
%
%%%%%%%%%%%%%%
%%% How to generate g_eoddata
%%% use java program histFuturesNamesExport to get csv file then import to excel. 

function [priticker,prit] = getPrimaryTickerOld(date, commodity)

%% load files
% load endofday.mat  % a bit too slow. use a global variable instead
% test to see if __eoddata exist
global g_eoddata_shfe
global g_eoddata_dce
global g_eoddata_czce
global g_eoddata_cffex
if(isempty(g_eoddata_shfe))
    load g_eoddata_shfe;
end
if(isempty(g_eoddata_dce))
    load g_eoddata_dce;
end
if(isempty(g_eoddata_czce))
    load g_eoddata_czce;
end
if(isempty(g_eoddata_cffex))
    load g_eoddata_cffex;
end
%% see which file to use
if(findNameIndex(commodity,'exchid')==1)
    g_eoddata = g_eoddata_czce;
elseif(findNameIndex(commodity,'exchid')==2)    
    g_eoddata = g_eoddata_dce;
elseif(findNameIndex(commodity,'exchid')==3)
    g_eoddata = g_eoddata_shfe;
elseif(findNameIndex(commodity,'exchid')==4)
    g_eoddata = g_eoddata_cffex;
elseif(findNameIndex(commodity,'exchid')==-1)
    disp(['unknown commodity: ',commodity]);
    return;
end

%% get results

indexd = (g_eoddata.datevector==date);
indexc = strcmpi(g_eoddata.commodityvector(indexd),commodity);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%use either : openintvector or volumevector depending on the need 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

benchmark = g_eoddata.openintvector(indexd); %get day indexed. 
benchmark = benchmark(indexc); %get name indexed


[~,I] = max(benchmark);
temp = g_eoddata.tickervector(indexd);
temp2 = temp(indexc);

priticker = cell2mat(temp2(I));
prit.primaryticker = cell2mat(temp2(I));
prit.primarytickerindex = I;
prit.alltickers = temp2;
prit.allbenchmark = benchmark;
ts = g_eoddata.tsvector(indexd);
ts2 = ts(indexc);
prit.alltimestamp = ts2;

end




