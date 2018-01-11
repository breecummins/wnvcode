function [L,Ng,nu,dt,Tf,U,xg,yg,h,tGraph,wind_mode] = setParams;
	
	dm=0.5;  			% characteristic velocity = average flying speed of mosquito in m/s (up to 1 m/s is reasonable)
	L0=30; 				% characteristic length = length of square domain in m 			
	S0=0.10/60; 		% concentration from a single source chicken: (units CO2 per unit air) per second. See Brackenbury 1982 notes.
	D =0.16e-4;			% diffusion coefficient of CO2 in air at about 20 degrees Centigrade
	T=L0/dm; 			% characteristic time in seconds (for converting back to dimensional quantities)
	C0 = S0*T; 			% characteristic concentration in units CO2 per unit air (for converting back to dimensional quantities)
	
	nu = D/(dm*L0);  	% nondimensional viscosity
	L=1;				% nondimensional length
	U=1;				% nondimensional source concentration emission per unit nondimensional time
	Tf=15; 				% dimensionless time span
	dt=1.e-2; 			% dimensionless time step
	
	Ng=125;				% number of grid points on each side of the domain
	h = L/Ng;			% separation between grid points
	[xg,yg] = meshgrid( 0 : h : L-h/2 );  % discretized domain
    
    wind_mode = 5;      %Controls mosquito wind-dependent behavior
	
	tGraph = 10*dt;