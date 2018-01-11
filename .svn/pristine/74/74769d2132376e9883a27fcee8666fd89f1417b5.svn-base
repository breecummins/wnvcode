function [p,ym] = BatchsetParams(p,windmode,basedir,chicknum,iternum);
	
	% p is the parameter structure
    % windmode gives the wind behavior. 
	% basedir is the base directory in which to save the file.
	% Last two args modify filename to avoid overwriting

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
	if exist('iternum','var');
    	p.savefname = fullfile(basedir,[WindName(windmode),'_numchicks',int2str(chicknum),'_iternum',int2str(iternum),'.mat']);   
	else;
	   	p.savefname = fullfile(basedir,[WindName(windmode),'_numchicks',int2str(chicknum),'.mat']);   
	end    
    