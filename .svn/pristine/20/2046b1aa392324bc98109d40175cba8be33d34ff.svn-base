function [s_collect c1] = Check1(Ctotal,index,s,s_collect)

Scurrent = sum(s.S(:,index));
s_collect = s_collect + Scurrent;
c1 = 1;

if Ctotal - s_collect > 1e-10
    disp('Error: the amount of CO_2 is unexpected');
    c1 = 0;
end
    