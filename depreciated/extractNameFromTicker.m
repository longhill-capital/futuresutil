%
% depreciated
%
%this is depreciated. use getTickerInfo instead
function ret = extractNameFromTicker(input)
    if(iscell(input))
        input = cell2mat(input);
    end
    secondbit = input(2);
    secondbitisnumber = double(secondbit)>=48 & double(secondbit)<=57;
    if(secondbitisnumber)
        ret = input(1);
    else
        ret = input(1:2);
    end
end
