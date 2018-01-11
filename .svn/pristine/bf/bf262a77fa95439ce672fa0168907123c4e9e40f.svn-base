function [p,xm,ym,tm,mem,xc,yc,Cmem,angmem,modevec] = BatchinitParams_Test(BoxLengthPerChick,vfunc,dwidth,dlength,initradius,groupflag,usemosq,inittime,S0);
	
	% chickBoxLength is the side length of the square box containing 9 chickens. 
	% S0 is the source emission (dimensional). 
	% vfunc is a string containing the suffix of the V1Parametric and V2 parametric functions. The empty string is flow from bottom to top, and is the default.
	% dwidth is the width of each plume subdomain in meters. dlength is the subdomain length in meters.
	% groupflag identifies which host group to simulate
	% usemosq = 'y' means simulate 2000 mosquitoes. Otherwise, simulate none.
	% inittime = 0 means release the mosquitoes at time 0. Otherwise, release them at default (currently 1500).

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% DIMENSIONAL QUANTITIES FOR INTERPRETING RESULTS
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	p.dm = 1;  			% characteristic velocity (m/s) = average mosquito flying speed (up to 1 m/s)
	p.T = 0.1;			% characteristic time (s) = average navigation decision time of the mosquito
	p.L0 = p.dm*p.T; 	% characteristic length (m) = average flight length of the mosquito 
	if exist('S0','var') && ~isempty(S0);
		p.S0 = S0;
	else;	
		p.S0 = 0.10/60; 	% CO2 emission from a chicken ((units CO2/unit air)/s) (Brackenbury 1982 notes)
		%p.S0 = 0.10/60/4; 	% The fudge factor of 4 makes up for the difference in density
	end
	p.D = 0.16e-4;		% diffusion coefficient of CO2 in air at about 20 C (m^2/s)
	p.Csat = 4.e-3;%1.25e-3; 	% characteristic concentration (units CO2/unit air) =  saturation level of 
						% mosquito sensing. 1.25e-3 = 1250 ppm: rough guess based on the antenna paper. Corrected for change in density.

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% NONDIMENSIONAL QUANTITIES FOR CO2 AND WIND
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% CONSTANTS FOR CO2 EQUATIONS
	p.nu = p.D/(p.dm*p.L0); 	% nondimensional viscosity
	p.sC = (p.S0/p.Csat)*p.T; 	% nondimensional source CO2 emission per unit nondimensional time

	% TIME PARAMETERS FOR CO2 EQUATIONS	
	p.Tf = 1000; 			% nondimensional time span, the maximum number of mosquito decisions (simulation can be stopped early if all mosquitoes leave the domain)
	p.dt = 0.1; 			% nondimensional CO2 time step (< nondim'l mosquito decision time = 1)

	% CO2 GRID GENERATION
	p.Lx = dwidth/p.L0; %CHANGED	
	p.h = 50/64;		% separation between grid points
	p.Ng = floor(p.Lx/p.h);			% number of grid points on a side (L/Ng < nondim'l mosq flight length = 1)
		
	p.Ly = dlength/p.L0; %CHANGED
	
	% WIND PARAMETERS
	p.Vmag = 0.2;		% nondimensional magnitude of wind flow, < nondim'l mosq flight speed
	p.tRand = 20;		% controls how often to change the random velocity
	p.randratio = 0.75; % magnitude of random velocity with respect to streaming flow
	p.randmean = 0;		% mean of random velocity
	p.randstddev = 0.5;	% std dev of random velocity
	if exist('vfunc','var');
		p.vfunc = vfunc;
	else;
		p.vfunc = '';
	end

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% NONDIMENSIONAL QUANTITIES FOR CHICKENS
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	p.minChickDist = 0.5*BoxLengthPerChick/p.L0;	
	p.host_radius = 5;	% nondimensional radius in which mosquito vanishes (x flight lengths)
	p.tChick = 10;		% controls how often to move the chickens (> mosquito decision time = 1)
						% currently stationary
	
	%CHANGED all host stuff
	if groupflag == 5;
		weightvec = [0.5,2,4,3,1];

		%5 groups
		p.Nc = [10, 20, 30, 10, 20];			% number of chickens per group
		p.chickBoxLength = weightvec.*sqrt(p.Nc)*BoxLengthPerChick/p.L0;
		p.chickBoxWidth = (1./weightvec).*sqrt(p.Nc)*BoxLengthPerChick/p.L0;
		p.chickBoxCenter = [50, 50; -550, -300; 600, 0; -250, 200; 350, -100]; % [x center, y bottom] for each group of chickens. 
		[xc,yc] = setChickensConstantDensity(p); %chicken positions
		ncx = mean(p.chickBoxCenter(:,1));
		ncy = mean(p.chickBoxCenter(:,2));
		
		p.Lx = p.Lx + max(p.chickBoxLength);
		p.dt = 2*p.dt; %make time and space coarser
		p.h = 2*p.h;		
		p.Ng = floor(p.Lx/p.h);		

	elseif groupflag == 4;
		p.Nc = 10;			% number of chickens in one group
		p.chickBoxCenter = [100, 50]; % [x center, y bottom] for one group of chickens. 
		p.chickBoxLength = sqrt(p.Nc)*BoxLengthPerChick/p.L0;
		p.chickBoxWidth = sqrt(p.Nc)*BoxLengthPerChick/p.L0;
		[xc,yc] = setChickensConstantDensity(p); %chicken positions
		xc1 = xc - 50; yc1 = yc + 100;
		xc2 = xc + 50; yc2 = yc + 200;
		xc3 = xc - 25; yc3 = yc + 150;
		xc = [xc;xc1;xc2;xc3];
		yc = [yc;yc1;yc2;yc3];
		ncx = mean(xc);
		ncy = mean(yc);
		p.Nc = 40;
	else;
		disp('Host group not recognized. Aborting.')
		exit
	end


	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% NONDIMENSIONAL QUANTITIES FOR MOSQUITOES
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% GENERAL MOSQUITO PARAMETERS
	p.wind_mode = [1,2,5]; %CHANGED
	nummodes = length(p.wind_mode);
	if usemosq == 'y';
		p.Nm = 500; 		% number of mosquitoes per wind behavior %CHANGED
		disp('Mosquitoes will be simulated.')
	else;
		p.Nm = 0;
		disp('Mosquitoes will NOT be simulated.')
	end
	p.tMosq = 1;  		% controls how often to move mosquitoes (=1 when mosq decision time scales time)
	tm = inittime*ones(1,nummodes*p.Nm); %CHANGED
	disp(['Mosquito insertion time is at t=',num2str(inittime),' in nondiml units.'])
	p.initradius = initradius/p.L0; %CHANGED all initial position stuff
	thetam = -pi/2 + (pi)*rand(p.Nm,1); %angular position of entering mosquitoes
	xm = p.initradius*cos(thetam) + ncx;
	ym = p.initradius*sin(thetam) + ncy;
	xm = repmat(xm,nummodes,1);
	ym = repmat(ym,nummodes,1);
	modevec = [1*ones(p.Nm,1); 2*ones(p.Nm,1); 5*ones(p.Nm,1)]; 

	% MOSQUITO PARAMETERS RELATED TO ABSOLUTE CO2
	p.CO2_thresh = 0.01; 	% nondimensional response threshold to CO2 (1% of max)
	p.CO2_sat = 1;			% nondimensional CO2 saturation (=1 when saturation is used to scale conc)
	p.CO2_kappa = 0;		% curvature parameter for response function; 0 = linear model
	p.spdMin = 0.4;			% minimum speed in the presence of CO2
	p.spdMax = 1.5;			% maximum allowed speed; speed below CO2 threshold

	% MOSQUITO PARAMETERS RELATED TO CO2 DIFFERENCE
	p.dif_thresh = (p.CO2_thresh/10)*0.0042/0.0833; % nondimensional response threshold to CO2 difference
	p.dif_sat = (p.CO2_sat - p.CO2_thresh)/50;	% nondimensional CO2 difference saturation 
	p.dif_kappa = 0;			% curvature parameter for response function; 0 = linear model
	p.Cdirmin = (pi/6)/6;			% minimum window length around CO2 gradient direction
	p.Cdirmax = pi;				% maximum window length around CO2 gradient direction
	p.gradweight = 0.5; 		% scaling factor for mosq response to CO2 when CO2 > CO2_thresh
	Cmem = zeros(nummodes*p.Nm,1);       % mosquitoes originally have not sensed CO2
	angmem = 2*pi*rand(size(thetam));
	angmem = [angmem;angmem;angmem];

	% MOSQUITO PARAMETERS RELATED TO WIND
	p.crosswind_duration = 100*[5,9]; 	% fly +/- perpendicular for x1 to x2 decisions %CHANGED
	dc = p.crosswind_duration(2)-p.crosswind_duration(1); 
	mem = zeros(nummodes*p.Nm,2);  		%mosquito memory for crosswind flight
    mem(:,1) = round(p.crosswind_duration(1) + dc*rand(nummodes*p.Nm,1)); %how long to go in the same direction relative to the wind
    mem(:,2) = sign(rand(nummodes*p.Nm,1)-.5); % which direction to go (+ or -)
	p.wind_thresh = 0;			% nondimensional response threshold to wind (no threshold)
	p.wind_sat = 0.5;			% nondimensional wind saturation (half typical mosquito speed)
	p.wind_kappa = 0;			% curvature parameter for response function; 0 = linear model
	p.Vdirmin = pi/6;			% minimum window length around wind direction
	p.Vdirmax = pi/2;			% maximum window length around wind direction
	p.windweight = 1-p.gradweight;	% scaling factor for mosq response to wind when CO2 > CO2_thresh

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% VISUALIZATION AND REPORTING PARAMETERS
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	p.tReport = p.Tf;%25;	    	% controls how often to print the summary state of the mosquitoes 
	p.tGraph_prior = 0;	% controls how often to graph output before mosqs appear 
	p.tGraph_after = 25;%1;		% controls how often to graph output after mosqs appear 
	p.saveGraph = 0;%1;        % controls whether or not to save frames 
