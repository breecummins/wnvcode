function [windtype,savename,chickencount,littlechicken,growtime,titulo] = ...
    GrowConditions(dummy)

chickencount = input('Total number of chickens?  ');
littlechicken = input('Single host side:  left=1 / right=2 ?  ','s');
windtype = input('Wind condition:  clockwise=cl / counter-clockwise=cc / dipole = dp / none=no ?  ','s');
growtime = 60*input('Final time of carbon dioxide growing (min)?  ');

fprintf('\nSUMMARY OF CONDITIONS\n')
fprintf('%.0f hosts\n',chickencount)
switch littlechicken
    case '1'
        fprintf('Single host on left\n')
	case '2'
        fprintf('Single host on right\n')
end
switch windtype
    case 'cl', disp('Clockwise wind')
    case 'cc', disp('Counter-clockwise wind')
    case 'dp', disp('Dipoles')
    case 'no', disp('No wind')
end

if littlechicken == '1'
    savename = [num2str(chickencount),'L_',windtype,'_',num2str(growtime)];
    titulo = [num2str(chickencount),'L--',windtype,'--',num2str(growtime)];
elseif littlechicken == '2'
    savename = [num2str(chickencount),'R_',windtype,'_',num2str(growtime)];
    titulo = [num2str(chickencount),'R--',windtype,'--',num2str(growtime)];
end