% g_eoddata_generator
% generates g_eoddata_xxxx.mat from output.csv
%
% note that output.csv doesnt care about which exchange this is from. you
% need to generate separate output.csv for each exchange, then convert them
% to mat, then rename mat to g_eoddata_xxxx.mat
%
% he lin 2014/12/2

exch = 'DCE';

[datanum, datastr] = xlsread(['output_',exch,'.csv']);
datastr = datastr(2:end,:);

g_eoddata.datevector = datenum(datanum(:,1:3));
g_eoddata.exchvector = cell2mat(datastr(:,4));
g_eoddata.commodityvector = cell2mat(datastr(:,5));
g_eoddata.tickervector = cell2mat(datastr(:,6));
g_eoddata.filesizevector = datanum(:,7);
g_eoddata.volumevector = datanum(:,8);
g_eoddata.openintvector = datanum(:,9);
g_eoddata.tsvector = datanum(:,10)*86400;
g_eoddata.pricevector =datanum(:,11);

if(strcmp(exch,'SHFE'))
    g_eoddata_shfe = g_eoddata;
    save('g_eoddata_shfe.mat','g_eoddata_shfe');
elseif(strcmp(exch,'CFFEX'))
    g_eoddata_cffex = g_eoddata;
    save('g_eoddata_cffex.mat','g_eoddata_cffex');
elseif(strcmp(exch,'CZCE'))
    g_eoddata_czce = g_eoddata;
    save('g_eoddata_czce.mat','g_eoddata_czce');
elseif(strcmp(exch,'DCE'))
    g_eoddata_dce = g_eoddata;
    save('g_eoddata_dce.mat','g_eoddata_dce');
end
    