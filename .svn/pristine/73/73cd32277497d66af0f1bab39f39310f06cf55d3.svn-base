%Two functions defined
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function results = test_doublepoints(Ngvec);
	
	% SET PARAMETERS
	[p,xg,yg] = setParams;

	% RESET TOTAL TIME SPAN FOR THIS EXPERIMENT
	p.Tf = 500;
	Trec = 10;
	Tvec = 0:Trec:p.Tf;
	
	% SET CHICKENS
	[xc,yc] = setChickens(p);

	for Ng = Ngvec;
	
		% INITIAL CONDITIONS
		[p, xg, yg, C, U, V] = initializeUC(p,Ng);
	
		% SAVE RESULTS
		Chistory=zeros(0,0,0);
	
		% EVOLVE THE CO2
		for t = 0 : p.dt : p.Tf

			% MAKE MATRICES FOR CALCULATING DERIVATIVES
			[Cxp,Cxm,Cyp,Cym] = SliceC(C);

			% SPREAD THE SOURCE CO2 TO THE UNDERLYING GRID
			S = SpreadToGrid(xc,yc,C,p.h,p.sC);

			% CALCULATE DIFFUSION
			D = DiffuseC(C, Cxp, Cxm, Cyp, Cym, p.h);

			% CALCULATE ADVECTION
		  	A = AdvectC(xg,yg,C,Cxp,Cxm,Cyp,Cym,U,V,p.h,p.Vmag);

			% SUM ALL OF THE TERMS.
			C = C + p.dt*S + p.nu*p.dt*D - p.dt*A; 
		
			% SAVE HISTORY
			if mod(t,Trec) == 0;
				Chistory(:,:,end+1) = C;
			end
		end %for loop
		
		% ASSIGN RESULTS TO STRUCTURE
		eval(['results.Ng',int2str(Ng),'.C = Chistory;'])
		eval(['results.Ng',int2str(Ng),'.xg = xg;'])
		eval(['results.Ng',int2str(Ng),'.yg = yg;'])
		eval(['results.Ng',int2str(Ng),'.xc = xc;'])
		eval(['results.Ng',int2str(Ng),'.yc = yc;'])
		eval(['results.Ng',int2str(Ng),'.params = p;'])
		eval(['results.Ng',int2str(Ng),'.Tvec = Tvec;'])
		
	end %for loop
	
end %function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p, xg, yg, C, U, V] = initializeUC(p,Ng);
	% CO2 GRID GENERATION
	p.Ng=Ng;			% number of grid points on each side of the domain (L=100 and Ng = 128 means roughly 1.25 cells per flight path)
	p.h = p.L/p.Ng;		% separation between grid points
	[xg,yg] = meshgrid( p.h/2 : p.h : p.L-p.h/2 );  % cell-centered discretized domain

	% INITIAL CO2
	C = zeros(p.Ng,p.Ng); %initial concentration is zero

	% INITIAL VELOCITY
	U = V1Parametric(xg,yg,p.Vmag); %this is the steady portion of the velocity
	V = V2Parametric(xg,yg,p.Vmag); 
end %function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






