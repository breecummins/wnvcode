function [p,ym] = BatchsetParams(p,windmode,basedir,varparam,pm,propchange,origval);
	
	% p is the parameter structure
    % windmode gives the wind behavior. 
	% basedir is the base directory in which to save the file.
	% Optional args: varparam is a string containing the parameter to vary. pm = 'p'
    % (plus), 'm' (minus) indicates whether to add or
    % subtract propchange to or from 1 in order to vary varparam. Result is multiplied by origval.

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% PARAMETER CHANGE FOR SENSITIVITY ANALYSIS
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	p.wind_mode = windmode;     % controls ranging flight behavior: 1 = upwind, 2 = downwind, 
								% 3 = crosswind/upwind, 4 = crosswind/downwind, 5 = pure crosswind
	
	% set where the mosquitoes start (top or bottom of domain)
    if windmode == 1 || windmode == 3;
		ym = (p.L - 2*p.h)*ones(p.Nm,1);
    else;
		ym = 2*p.h*ones(p.Nm,1);
    end
    
	% construct save file name
	wname = WindName(windmode); %string name for ranging behavior
    if exist('pm','var') && pm == 'p';
        eval(['p.',varparam,' = origval*(1 + propchange);'])
        p.savefname = fullfile(basedir,[wname,'_',varparam,'_higher.mat']);	    	
    elseif exist('pm','var') && pm == 'm';
        eval(['p.',varparam,' = origval*(1 - propchange);'])
        p.savefname = fullfile(basedir,[wname,'_',varparam,'_lower.mat']);    	
    else;
        p.savefname = fullfile(basedir,[wname,'_basevalue.mat']);   
    end
    