% g_eoddata_generator
% generates g_eoddata_xxxx.mat from output.csv
%
% note that output.csv doesnt care about which exchange this is from. you
% need to generate separate output.csv for each exchange, then convert them
% to mat, then rename mat to g_eoddata_xxxx.mat
%
% he lin 2014/12/2 second version.

filename = 'output_cffex.csv';

fid = fopen(filename,'r');
fgetl(fid); % remove first header line. 
c = fgetl(fid);
line=0;
while(ischar(c))
    line=line+1;
    c=fgetl(fid);
end
% line=151100;
disp(['line no:',num2str(line)]);
clear g_eoddata;
g_eoddata.datevector=zeros(line,1);
g_eoddata.exchvector=cell(line,1);
g_eoddata.commodityvector=cell(line,1);
g_eoddata.tickervector=cell(line,1);
g_eoddata.filesizevector=zeros(line,1);
g_eoddata.volumevector=zeros(line,1);
g_eoddata.openintvector=zeros(line,1);
g_eoddata.tsvector=zeros(line,1);
fclose(fid);


fid = fopen(filename,'r');
fgetl(fid);
c = fgetl(fid);
line=0;
while(ischar(c))
    line=line+1;
    incell = textscan(c,'%d %d %d %s %s %s %d %d %d %s %f','delimiter',',');
    
    date = datenum(double(incell{1}),double(incell{2}),double(incell{3}));
    g_eoddata.datevector(line) = date;
    if (date == 0 )
        a=1;
    end
    g_eoddata.exchvector(line)=incell{4};
    g_eoddata.commodityvector(line)=incell{5};
    g_eoddata.tickervector(line)=incell{6};
%     try
%         g_eoddata.filesizevector(line)=incell{7};
%     catch
%         g_eoddata.filesizevector(line)=0;
%     end
%     try
%         g_eoddata.volumevector(line)=incell{7};
%     catch
%         g_eoddata.volumevector(line)=0;
%     end
%     try
%         g_eoddata.openintvector(line)=incell{7};
%     catch
%         g_eoddata.openintvector(line)=0;
%     end    
%     try
%         if(str2num(cell2mat(incell{10}))==0)
%             g_eoddata.tsvector(line)=0;
%         else
%             time=textscan(cell2mat(incell{10}),'%f %f %f %f','delimiter',':');
%             g_eoddata.tsvector(line)=double(time{1})*3600+double(time{2})*60+double(time{3});
%         end
%     catch
%         g_eoddata.tsvector(line)=-1;
%     end

    g_eoddata.filesizevector(line)=incell{7};
    g_eoddata.volumevector(line)=incell{8};
    g_eoddata.openintvector(line)=incell{9};
    if(isempty(incell{10}) || str2double(cell2mat(incell{10}))==0)
        g_eoddata.tsvector(line)=0;
    else
        time=textscan(cell2mat(incell{10}),'%f %f %f %f','delimiter',':');
        try
            g_eoddata.tsvector(line)=double(time{1})*3600+double(time{2})*60+double(time{3});
        catch
            g_eoddata.tsvector(line)=0;
        end
    end
    g_eoddata.pricevector(line) = incell{11};

    c=fgetl(fid);
end
fclose(fid);

    
    
if(~isempty(strfind(filename,'SHFE')) || ~isempty(strfind(filename,'shfe')))
    g_eoddata_shfe = g_eoddata;
    save('g_eoddata_shfe.mat','g_eoddata_shfe');
elseif(~isempty(strfind(filename,'CFFEX')) || ~isempty(strfind(filename,'cffex')))
    g_eoddata_cffex = g_eoddata;
    save('g_eoddata_cffex.mat','g_eoddata_cffex');
elseif(~isempty(strfind(filename,'CZCE')) || ~isempty(strfind(filename,'czce')))
    g_eoddata_czce = g_eoddata;
    save('g_eoddata_czce.mat','g_eoddata_czce');
elseif(~isempty(strfind(filename,'DCE')) || ~isempty(strfind(filename,'dce')))
    g_eoddata_dce = g_eoddata;
    save('g_eoddata_dce.mat','g_eoddata_dce');
end
