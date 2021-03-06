% getFolder removes the filename part trailing the last \ from the string
% generated by mfilename('fullpath') to get the folder info.
%
% input: fullpath = output of mfilename('fullpath') 
%            e.g. C:\Users\LHC\workspace\Matlab\volavol\getVolatility
% ouput: folderpath
%            e.g. C:\Users\LHC\workspace\Matlab\volavol\
%
% linhe 201504
%

function folderpath = getFolder(fullpath)

% try windows path
ind = strfind(fullpath,'\');
% if doesnt look like windows path try linux path
if(isempty(ind))
    ind = strfind(fullpath,'/');
end
% if again empty error
if(isempty(ind))
    error('futuresutil:getFolder','couldn''t find \ nor /');
end

lastind = ind(end);

folderpath = fullpath(1:lastind);

