function [p,xm,tm,mem,xc,yc,Cmem] = BatchinitParams_Density_Uniform_test(BoxLengthPerChick,vfunc,S0);
	
	% chickBoxLength is the side length of the square box containing 9 chickens. 
	% S0 is the source emission (dimensional). 
	% vfunc is a string containing the suffix of the V1Parametric and V2 parametric functions. The empty string is flow from bottom to top, and is the default.
	
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
	p.Tf = 5000; 			% nondimensional time span, the maximum number of mosquito decisions (simulation can be stopped early if all mosquitoes leave the domain)
	p.dt = 1.e-1; 			% nondimensional CO2 time step (< nondim'l mosquito decision time = 1)

	% CO2 GRID GENERATION
	p.L = 100;			% nondimensional domain side length = 100 flight lengths
	p.Ng = 128;			% number of grid points on a side (L/Ng < nondim'l mosq flight length = 1)
	p.h = p.L/p.Ng;		% separation between grid points	
	
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
	p.Nc = 9;			% number of chickens in one group
	p.tChick = 10;		% controls how often to move the chickens (> mosquito decision time = 1)
						% currently stationary
	p.chickBoxCenter = [p.L/2,  p.L/2]; % [x center, y center] for one group of chickens. 
	p.BoxLengthPerChickNonDim = BoxLengthPerChick/p.L0;
	xc = p.chickBoxCenter(1) + [ -p.BoxLengthPerChickNonDim, 0, p.BoxLengthPerChickNonDim].';
	xc = [xc;xc;xc];
	yc1 = (p.chickBoxCenter(2) -p.BoxLengthPerChickNonDim)*ones(3,1);
	yc2 = p.chickBoxCenter(2)*ones(3,1);
	yc3 = (p.chickBoxCenter(2) + p.BoxLengthPerChickNonDim)*ones(3,1);
	yc = [yc1;yc2;yc3];
	
	p.host_radius = 5;	% nondimensional radius in which mosquito vanishes (x flight lengths)
	

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% NONDIMENSIONAL QUANTITIES FOR MOSQUITOES
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% GENERAL MOSQUITO PARAMETERS
	p.Nm = 50; 		% number of mosquitoes
	p.tMosq = 1;  		% controls how often to move mosquitoes (=1 when mosq decision time scales time)
	p.entrytimerange = [349.6, 350.4]; %when to insert the mosquitoes (normal distribution around this range) 
	Xint = p.L*[0,1];
	dx = Xint(2)-Xint(1);    
	xm = dx*rand(p.Nm,1) + Xint(1); %x position of entering mosquitoes
	dt = p.entrytimerange(2)-p.entrytimerange(1);    
	tm = round(dt*rand(p.Nm,1) + p.entrytimerange(1)); %entrance time of mosquitoes	
	tm = sort(tm);
	
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
	Cmem = zeros(p.Nm,1);       % mosquitoes originally have not sensed CO2

	% MOSQUITO PARAMETERS RELATED TO WIND
	p.crosswind_duration = [5,9]; 	% fly +/- perpendicular for x1 to x2 decisions
	dc = p.crosswind_duration(2)-p.crosswind_duration(1); 
	mem = zeros(p.Nm,2);  		%mosquito memory for crosswind flight
    mem(:,1) = round(p.crosswind_duration(1) + dc*rand); %how long to go in the same direction relative to the wind
    mem(:,2) = sign(rand(p.Nm,1)-.5); % which direction to go (+ or -)
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
	p.tGraph_prior = 50;	% controls how often to graph output before mosqs appear 
	p.tGraph_after = 10;		% controls how often to graph output after mosqs appear 
	p.saveGraph = 1;        % controls whether or not to save frames 
