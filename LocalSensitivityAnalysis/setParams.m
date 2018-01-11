function [p,xg,yg] = setParams;
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% DIMENSIONAL QUANTITIES FOR INTERPRETING RESULTS
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	p.dm = 1;  			% characteristic velocity (m/s) = average mosquito flying speed (up to 1 m/s)
	p.T = 0.1;			% characteristic time (s) = average navigation decision time of the mosquito
	p.L0 = p.dm*p.T; 	% characteristic length (m) = average flight length of the mosquito 			
	p.S0 = 0.10/60; 	% CO2 emission from a chicken ((units CO2/unit air)/s) (Brackenbury 1982 notes)
	p.D = 0.16e-4;		% diffusion coefficient of CO2 in air at about 20 C (m^2/s)
	p.Csat = 1.25e-3; 	% characteristic concentration (units CO2/unit air) =  saturation level of 
						% mosquito sensing. 1.25e-3 = 1250 ppm: rough guess based on the antenna paper.
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% NONDIMENSIONAL QUANTITIES FOR CO2 AND WIND
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% CONSTANTS FOR CO2 EQUATIONS
	p.nu = p.D/(p.dm*p.L0); 	% nondimensional viscosity
	p.sC = (p.S0/p.Csat)*p.T; 	% nondimensional source CO2 emission per unit nondimensional time
	
	% TIME PARAMETERS FOR CO2 EQUATIONS	
	p.Tf = 600; 			% nondimensional time span, the total number of mosquito decisions
	p.dt = 1.e-1; 			% nondimensional CO2 time step (< nondim'l mosquito decision time = 1)

	% CO2 GRID GENERATION
	p.L = 100;			% nondimensional domain side length = 100 flight lengths
	p.Ng = 128;			% number of grid points on a side (L/Ng < nondim'l mosq flight length = 1)
	p.h = p.L/p.Ng;		% separation between grid points
	[xg,yg] = meshgrid( p.h/2 : p.h : p.L-p.h/2 );  % cell-centered discretized domain
	
	% WIND PARAMETERS
	p.Vmag = 0.2;		% nondimensional magnitude of wind flow, < nondim'l mosq flight speed
	p.tRand = 20;		% controls how often to change the random velocity
	p.randratio = 0.75; % magnitude of random velocity with respect to streaming flow
	p.randmean = 0;		% mean of random velocity
	p.randstddev = 0.5;	% std dev of random velocity
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% NONDIMENSIONAL QUANTITIES FOR CHICKENS
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	p.Nc = [7,3];		% number of chickens split between two groups
 	p.tChick = 10;		% controls how often to move the chickens (> mosquito decision time = 1)
						% currently stationary
	density_factor = sqrt(p.Nc(2)./p.Nc(1));
	p.chickLoc = [p.L/4,  p.L/2, p.L/6, p.L/6;  ...
				 3*p.L/4, p.L/2, density_factor*p.L/6, density_factor*p.L/6]; 
						% [x center, y center, x spread, y spread] for each of two groups. Center and 
						% extent of rectangles in which to place chickens (not quite randomly). The 
						% density factor keeps the densities the same as the number of chickens varies.

	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% NONDIMENSIONAL QUANTITIES FOR MOSQUITOES
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% GENERAL MOSQUITO PARAMETERS
    p.Nm = 200; 		% number of mosquitoes
	p.tMosq = 1;  		% controls how often to move mosquitoes (=1 when mosq decision time scales time)
	p.host_radius = 5;	% nondimensional radius in which mosquito vanishes (x flight lengths)
	p.entrytimerange = [320,330]; %when to insert the mosquitoes (normal distribution around this range) 

	% MOSQUITO PARAMETERS RELATED TO ABSOLUTE CO2
	p.CO2_thresh = 0.01; 	% nondimensional response threshold to CO2 (1% of max)
	p.CO2_sat = 1;			% nondimensional CO2 saturation (=1 when saturation is used to scale conc)
	p.CO2_kappa = 0;		% curvature parameter for response function; 0 = linear model
	p.spdMin = .4;			% minimum speed in the presence of CO2
    p.spdMax = 1.5;			% maximum allowed speed; speed below CO2 threshold
	
	% MOSQUITO PARAMETERS RELATED TO CO2 GRADIENT
	p.grad_thresh = p.CO2_thresh/10; 			% nondimensional response threshold to CO2 gradient 
												% (shallowest gradient is CO2 threshold/x flight lengths)
	p.grad_sat = (p.CO2_sat - p.CO2_thresh)/5;	% nondimensional CO2 gradient saturation 
												% (sharpest gradient is max difference/x flight lengths)
	p.grad_kappa = 0;			% curvature parameter for response function; 0 = linear model
	p.Cdirmin = pi/6;			% minimum window length around CO2 gradient direction
	p.Cdirmax = pi;				% maximum window length around CO2 gradient direction
	p.gradweight = 0.5; 		% scaling factor for mosq response to CO2 gradient when CO2 > CO2_thresh
	
	% MOSQUITO PARAMETERS RELATED TO WIND
	p.wind_mode = 2;      	    % controls ranging flight behavior: 1 = upwind, 2 = downwind, 
								% 3 = crosswind/upwind, 4 = crosswind/downwind, 5 = pure crosswind
	p.crosswind_duration = [5,9]; 	% fly +/- perpendicular for x1 to x2 decisions   
	p.wind_thresh = 0;			% nondimensional response threshold to wind (no threshold)
	p.wind_sat = 0.5;			% nondimensional wind saturation (half typical mosquito speed)
	p.wind_kappa = 0;			% curvature parameter for response function; 0 = linear model
	p.Vdirmin = pi/6;			% minimum window length around wind direction
	p.Vdirmax = pi/2;			% maximum window length around wind direction
    p.windweight = 1-p.gradweight;	% scaling factor for mosq response to wind when CO2 > CO2_thresh
   
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% VISUALIZATION AND REPORTING PARAMETERS
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	p.tReport = 25;	    	% controls how often to print the summary state of the mosquitoes 
   	p.tGraph_prior = 10;	% controls how often to graph output before mosqs appear 
	p.tGraph_after = 2;		% controls how often to graph output after mosqs appear 
	p.saveGraph = 1;        % controls whether or not to save frames 
