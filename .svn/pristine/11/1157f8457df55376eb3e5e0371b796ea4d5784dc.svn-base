function [p,ym,angmem] = BatchsetParams(p,windmode,basedir,fnamestring,chicknum,iternum);
	
	% p is the parameter structure
    % windmode gives the wind behavior. 
	% basedir is the base directory in which to save the file.
	% fnamestring identifies the particular experiment
	% Last two args modify filename to avoid overwriting

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% PARAMETER CHANGE FOR SENSITIVITY ANALYSIS
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	p.wind_mode = windmode;     % controls ranging flight behavior: 1 = upwind, 2 = downwind, 
								% 3 = crosswind/upwind, 4 = crosswind/downwind, 5 = pure crosswind
	
	% set where the mosquitoes start (top or bottom of domain)
    if windmode == 1 || windmode == 3;
		ym = (p.L - 2*p.h)*ones(p.Nm,1);
		angmem = (-pi/2)*ones(p.Nm,1); %if they come in the top, give them a memory of going down
    else;
		ym = 2*p.h*ones(p.Nm,1);
		angmem = (pi/2)*ones(p.Nm,1); %if they come in the bottom, give them a memory of going up
    end

	% construct save file name
	if exist('iternum','var');
    	p.savefname = fullfile(basedir,[WindName(windmode),'_',fnamestring,'_iternum',int2str(iternum),'.mat']);   
	else;
	   	p.savefname = fullfile(basedir,[WindName(windmode),'_',fnamestring,'.mat']);   
	end    
    