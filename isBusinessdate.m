% isBusinessdate returns whether true or not the passed in date is a
% businessdate for chinese exchanges. 
%
%
%
% linhe 201504
function ret = isBusinessdate(matlabdate)

%% check year range.   
% for valid time, see return range of getBusinessdate(), which refers to
% database table
    [y,~,~,~,~,~] = datevec(matlabdate);
    if y>2015 || y<2010
        error('futuresutil:isBusinessdate','Year out of range');
    end
%% do the calc
    businessdate = getBusinessdate();
    
    if(isempty(find(businessdate==matlabdate,1)))
        ret = false;
    else
        ret = true;
    end
end