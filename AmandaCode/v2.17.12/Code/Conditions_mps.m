function [runcount windtype movieask savename mosqcount chickencount ...
    littlechicken windsense pretime loadname] = Conditions_mps(dummy)

addpath Code/GrowCO2/

runcount = input('Number of runs?  ');

fprintf('\n')
disp('Vector count:  single = 1, group = 2');
disp('Host side:  left = 1, right = 2');
disp('Vector-wind sensitivity:  yes = 1, no = 0');
conditiontitle = ['  condition   ', '  mosqcount    ', 'chickencount  ',...
    'littlechicken ', 'windsense     '];
conditiontable = xlsread('Conditions.xlsx','Sheet1','A8:E23');
disp(conditiontitle);
disp(conditiontable);

condition = input('Condition?  ','s');
mosqcount = condition(1);
chickencount = str2double((condition(2:3)));
littlechicken = condition(4);
windsense = condition(5);

fprintf('\n')
opt1 = what('GrowCO2/');
opt2 = getfield(opt1,'mat');
disp('CO2 fields available')
disp(opt2)
fprintf('\n')

windtype = input('Wind condition:  clockwise = cl / counterclockwise = cc / none = no ?  ','s');
% movement = input('Mosquito movement technique:  gradient = g / sampling = s ?  ','s');
pretime = 60*input('Amount of time for CO2 growth (min)?  ');

fprintf('\n')
fprintf('SUMMARY OF CONDITIONS\n')
switch mosqcount
    case '1', disp('single mosquito')
    case '2', disp('mosquito cluster')
end
fprintf('%1.0f hosts total\n',chickencount)
switch littlechicken
    case '1', disp('single chicken on left')
    case '2', disp('single chicken on right')
end
switch windsense
    case '0', disp('no wind sensitivity')
    case '1', disp('some wind sensitivity')
end
switch windtype
    case 'cl', disp('clockwise wind')
    case 'cc', disp('counter-clockwise wind')
    case 'no', disp('no wind')
fprintf('release time %1.0f seconds\n',pretime)
end
fprintf('\n')

movieask = input('Visual:  display = d / movie = m / save = a / none = n ?  ','s');
savename = [condition,' ',windtype,' ',num2str(pretime),'sec',' ',num2str(runcount),'r'];

if littlechicken == '1'
    loadname = [num2str(chickencount),'L_',windtype,'_',num2str(pretime)];
elseif littlechicken == '2'
    loadname = [num2str(chickencount),'R_',windtype,'_',num2str(pretime)];
end