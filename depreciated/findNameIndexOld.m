function ret = findNameIndex(input,field)

    categoryindex = getCategoryIndex();
    temp1 = strcmpi(categoryindex(:,1),input);
    temp2 = find(temp1);
    if(isempty(temp2))
        ret = -1;
        return;
    end
    if(length(temp2)~=1)
        error('findNameIndex not unique entry');
    end
    
    switch(field)
        case 'index'
            ret = cell2mat(categoryindex(temp2,2));
        case 'category'
            ret = cell2mat(categoryindex(temp2,3));
        case 'exchid'
            ret = cell2mat(categoryindex(temp2,4));
        case 'multiplier'
            ret = cell2mat(categoryindex(temp2,6));
        case 'fee'
            ret = cell2mat(categoryindex(temp2,8));
        otherwise
            error('not recognized');
    end
end
        
        
    
