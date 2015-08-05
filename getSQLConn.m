% getSQLConn returns a structure containing database connection
%
% input:    host =  database url. with IP and port
%           user = commodity name. case sensitive (IF, cu, ...)
%           password = db password
%           dbName = default schema
% output:   conn = database connection
%
%
% v1  
% lin he 201504
function conn = getSQLConn(host,user,password,dbName)

fprintf('\t\t\tgetSQLConn: %s:%s@%s:%s\n',user,password,host,dbName);
if(nargin<4)
    dbName = 'chinacommodity';% Database Name
end
if(nargin<3)
    password = 'read';% Database Username/Password
end
if(nargin<2)
    user = 'read';% Database Username/Password
end
if(nargin<1)
    host = '127.0.0.1:3306';% Database Server
end



jdbcString = sprintf('jdbc:mysql://%s/%s', host, dbName);% JDBC Parameters
jdbcDriver = 'com.mysql.jdbc.Driver';

% If warnings about java not found 
% Set this to the path to your MySQL Connector/J JAR
% javaaddpath([getFolder(mfilename('fullpath')),'mysql-connector-java-5.1.33-bin.jar']);
   
% Create the database connection object
conn = database(dbName, user, password, jdbcDriver, jdbcString);
if(~isconnection(conn))
    error('futuresutil:getSQLConn','couldnot get database connection');
end
