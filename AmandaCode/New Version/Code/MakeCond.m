% MakeCond.m
% Saves a file that is loaded in Conditions_mps.m to replace user inputs

mkdir('Conditions/')

fprintf('\n')
disp('Vector count:  single = 1, group = 2');
disp('Host side:  left = 1, right = 2');
disp('Vector-wind sensitivity:  yes = 1, no = 0');
fprintf('\n')

runcount = input('Number of runs?  ');
condition = input('Condition?  ','s');
windtype = input('Wind condition:  clockwise = cl / counterclockwise = cc / dipole = dp / none = no ?  ','s');
pretime = 60*input('Amount of time for CO2 growth (min)?  ');

save(['Code/Conditions/',condition,windtype,num2str(pretime),'s',num2str(runcount),'r.mat'],'runcount','condition','windtype','pretime')
disp('Condition file saved.');