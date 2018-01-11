function c2 = Check2(C)

% checks that the carbon dioxide amounts are accurate

% WAITING ON EXACT SOLUTION FUNCTION

cround = round(C.*(1e10));
tround = round(t.*(1e10));

c2 = isequal(cround,tround);