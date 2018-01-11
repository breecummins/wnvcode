function [Cxp Cxn Cyp Cyn A] = CenterDiffApprox(C)

% Executes the center difference approximation of the carbon dioxide matrix

corer=C(2:end-1,:);
corec=C(:,2:end-1);
row1=C(1,:);
rowe=C(end,:);
col1=C(:,1);
cole=C(:,end);

Cxp = [col1,col1,corec];
Cxn = [corec,cole,cole];
Cyp = [row1;row1;corer];
Cyn = [corer;rowe;rowe];

A = (Cxp+Cxn+Cyp+Cyn-(4*C));