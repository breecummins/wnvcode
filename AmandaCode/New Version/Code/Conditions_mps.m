function [runcount windtype savename mosqcount chickencount ...
    littlechicken windsense pretime loadname] = Conditions_mps(dummy)

addpath Code/GrowCO2/

% the file with the conditions desired must be manually entered here
load('Code/Conditions/21020dp1800s1r.mat')

mosqcount = condition(1);
chickencount = str2double((condition(2:3)));
littlechicken = condition(4);
windsense = condition(5);

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
    case 'dp', disp('dipoles')
fprintf('pretime %1.0f seconds\n',pretime)
end
fprintf('\n')

savename = [condition,' ',windtype,' ',num2str(pretime),'sec',' ',num2str(runcount),'r'];

if littlechicken == '1'
    loadname = [num2str(chickencount),'L_',windtype,'_',num2str(pretime)];
elseif littlechicken == '2'
    loadname = [num2str(chickencount),'R_',windtype,'_',num2str(pretime)];
end