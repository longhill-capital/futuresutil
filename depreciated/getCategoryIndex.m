%
%
% depreciated. 
% no longer called by findNameIndex

function ret = getCategoryIndex()
%    1             2            3           4           5                6              7                                8           .
% [ name, sequential index, categoryid, exchangeid, output name, volume multiplier, primary<->secondary threshold       fee rate     .
%                                                      | this the name field but with fixed length
%                                                                       | the volume diff between trading unit and quotation unit
%                                                                                       |the threshold between primary and secondary contract
%                                                                                                                        |exch/broker fee rate. (integer or float. if the number<1, commission=rate*nominal. if>1 commission=rate )           .
%
%
% category id: 1 AGRI; 2 METAL; 3 PRECIOUS; 4 ENERGY CHEM; 5 FINANCIAL
% exch id: 1 CZCE; 2 DCE; 3 SHFE; 4 CFFEX








ret={
'A',  1,1,2,'A ',  10, .7,  2;
'J',  2,4,2,'J ', 100, .6,  8e-5;
'B',  3,1,2,'B ',  10,NaN,  2;
'C',  4,1,2,'C ',  10, .6,  1.2;
'L',  5,4,2,'L ',   5, .5,  2.5;
'M',  6,1,2,'M ',  10, .7,  2;
'P',  7,1,2,'P ',  10, .6,  2.5; 
'Y',  8,1,2,'Y ',  10, .6,  2.5;
'V',  9,4,2,'V ',   5,NaN,  2;
'JM',10,4,2,'JM',  60,NaN,  10e-5;
'CF',11,1,1,'CF',   5, .7,  4.3;
'CS',12,1,1,'CS',   0,NaN,  NaN;    %--no longer in use
'RI',13,1,1,'RI',  20,NaN,  2.5;
'ER',13,1,1,'ER',  10,NaN,  NaN;
'OI',15,1,1,'OI',  10, .7,  2.5;
'RO',15,1,1,'RO',   5,NaN,  NaN;
'SR',17,1,1,'SR',  10, .6,  3;
'TA',18,4,1,'TA',   5, .5,  3;
'ME',19,4,1,'ME',  50,NaN,  7; % till ME1506
'MA',19,4,1,'MA',  10,NaN,  7; % start from MA1506
'PM',21,1,1,'PM',  50,NaN,  5;
'WH',22,1,1,'WH',  20, .7,  2.5;
'WS',22,1,1,'WS',  10,NaN,  NaN;
'WT',24,1,1,'WT',  10,NaN,  NaN;    %--no longer in use
'FG',25,4,1,'FG',  20,NaN,  3;
'RM',26,1,1,'RM',  10,NaN,  1.5;
'RS',27,1,1,'RS',  10,NaN,  2;
'AL',28,2,3,'AL',   5, .7,  3;
'AU',29,3,3,'AU',1000, .6,  10;
'CU',30,2,3,'CU',   5, .5,  5e-5;
'FU',31,4,3,'FU',  50, .5,  2e-5;
'PB',32,2,3,'PB',   5,NaN,  4e-5;
'RU',33,4,3,'RU',  10, .5,  4.5e-5; %before 1208 multiplier is 5
'ZN',34,2,3,'ZN',   5, .5,  3;
'WR',35,2,3,'WR',  10,NaN,  4e-5;
'RB',36,2,3,'RB',  10, .5,  4.5e-5;
'AG',37,3,3,'AG',  15,NaN,  5e-5;
'BU',38,4,3,'BU',  10,NaN,  3e-5;
'BB',39,4,2,'BB', 500,NaN,  10e-5;
'FB',40,4,2,'FB', 500,NaN,  10e-5;
'JD',41,1,2,'JD',  10,NaN,  15e-5; 
'I', 42,4,2,'I ', 100,NaN,  8e-5; 
'IF',43,5,4,'IF', 300,NaN,  2.5e-5;
'TF',44,5,4,'TF', 1e5,NaN,  3;
'HC',45,2,3,'HC',  10,NaN,  8e-5;
'PP',46,4,2,'PP',   5,NaN,  5e-5;
'TC',47,4,1,'TC', 200,NaN,  8;
'JR',48,1,1,'JR',  20,NaN,  3;
'LR',49,1,1,'LR',   20,NaN, NaN;
};
end