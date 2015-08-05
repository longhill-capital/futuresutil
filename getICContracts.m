% getIFContracts returns the list of IC contracts of given date
% 
% input:  date = matlab date format date
% output: contracts = the vector of IF contracts trading at that day

function contracts = getICContracts(date)

contracts = getIFContracts(date);
contracts(1,1:2)='IC';
contracts(2,1:2)='IC';
contracts(3,1:2)='IC';
contracts(4,1:2)='IC';

