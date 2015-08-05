% getBusinessdate returns the vector of business dates 
%
% output: businessdate = the vector of business dates
%
% 
% v1 local stored data
% v2 pull data from database for ease of management
% linhe 201504
function businessdate = getBusinessdate()
    
    settings.tmpfileagelimit=86400; % sec
    
    tmpFilename = [mfilename('fullpath') '.tmp.mat']; 
    
    D=dir(tmpFilename);
    if(exist(tmpFilename,'file')==0 || isempty(D) || (now - D.datenum)*86400>settings.tmpfileagelimit || (now - D.datenum)<0 )
        % file not exist, or can't read info, or too old, or tmp file is a future date
        %
        % re-pull data here
        disp('    getBusinessdate:Loading database');
        conn = getSQLConn('180.169.10.158:3306','read','read','backgrounddata');
        if(isempty(conn) || ~isconnection(conn))
            error('futuresutil:businessdate','couldn''t get database connection');
        end
        rs = fetch(conn,'select businessdate from backgrounddata.businessdate order by businessdate asc;');
        dateVec = zeros(1,numel(rs));
        for i = 1:numel(rs);
            dateVec(i) = datenum(cell2mat(rs(i)));
        end
        
        disp('    getBusinessdate:Write to temp file');
        save(tmpFilename, 'dateVec');
    else
        % just use temp file. skipping using the database for increased speed
        % disp('    getBusinessdate:Loading file');
        load(tmpFilename, 'dateVec');
    end
    
    businessdate = dateVec;
    
end
    
         
    
    
    
