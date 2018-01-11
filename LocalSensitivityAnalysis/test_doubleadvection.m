function results = test_doubleadvection(Vvec);
	
	% SET PARAMETERS
	[p,xg,yg] = setParams;

	% RESET TOTAL TIME SPAN FOR THIS EXPERIMENT
	p.Tf = 500;
	Trec = 10;
	Tvec = 0:Trec:p.Tf;

	% SET CHICKENS
	[xc,yc] = setChickens(p);

	for Vmag = Vvec;

		p.Vmag = Vmag;
		
		% INITIAL CONDITIONS
		C = zeros(p.Ng,p.Ng); %initial concentration is zero

		% INITIAL VELOCITY
		U = V1Parametric(xg,yg,p.Vmag); %this is the steady portion of the velocity
		V = V2Parametric(xg,yg,p.Vmag); 
		
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
		eval(['results.V',int2str(Vmag*10),'.C = Chistory;'])
		eval(['results.V',int2str(Vmag*10),'.xg = xg;'])
		eval(['results.V',int2str(Vmag*10),'.yg = yg;'])
		eval(['results.V',int2str(Vmag*10),'.xc = xc;'])
		eval(['results.V',int2str(Vmag*10),'.yc = yc;'])
		eval(['results.V',int2str(Vmag*10),'.params = p;'])
		eval(['results.V',int2str(Vmag*10),'.Tvec = Tvec;'])

	end %for loop

	
	
	
	
	
	
	