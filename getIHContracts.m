% getIFContracts returns the list of IC contracts of given date
% 
% input:  date = matlab date format date
% output: contracts = the vector of IF contracts trading at that day

function contracts = getIHContracts(date)

contracts = getIFContracts(date);
contracts(1,1:2)='IH';
contracts(2,1:2)='IH';
contracts(3,1:2)='IH';
contracts(4,1:2)='IH';

