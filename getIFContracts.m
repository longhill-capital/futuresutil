% getIFContracts returns the list of IF contracts of given date
% 
% input:  date = matlab date format date
% output: contracts = the vector of IF contracts trading at that day

function contracts = getIFContracts(date)
% contracts = [];
if(date<datenum(2014,1,1))
    error('date too early');
elseif(date>datenum(2015,12,31))
    error('date too big');
end

roll=zeros(2020,12);
roll(2014, 1) = 17;
roll(2014, 2) = 21;
roll(2014, 3) = 21;
roll(2014, 4) = 18;
roll(2014, 5) = 16;
roll(2014, 6) = 20;
roll(2014, 7) = 18;
roll(2014, 8) = 15;
roll(2014, 9) = 19;
roll(2014,10) = 17;
roll(2014,11) = 21;
roll(2014,12) = 19;
roll(2015, 1) = 16;
roll(2015, 2) = 20;
roll(2015, 3) = 20;
roll(2015, 4) = 17;
roll(2015, 5) = 15;
roll(2015, 6) = 19;
roll(2015, 7) = 17;
roll(2015, 8) = 21;
roll(2015, 9) = 18;
roll(2015,10) = 16;
roll(2015,11) = 20;
roll(2015,12) = 18;

seasonmonth = reshape(([2011;2012;2013;2014;2015;2016;2017]*ones(1,4)*100+ones(7,1)*[3 6 9 12])',1,28);

[y,m,d,~,~,~]=datevec(date);
if(d>roll(y,m)) % after 3rd friday
    c=[y*100+m+1, y*100+m+2];
    c2 = seasonmonth(find(seasonmonth>c(2),2));
    c3 = [c,c2];
    for i=1:4
        contracts(i,:) = ['IF',num2str(c3(i)-200000)]; %#ok<AGROW>
    end 
else
    c=[y*100+m, y*100+m+1];
    c2 = seasonmonth(find(seasonmonth>c(2),2));
    c3 = [c,c2];
    for i=1:4
        contracts(i,:) = ['IF',num2str(c3(i)-200000)]; %#ok<AGROW>
    end 
end

