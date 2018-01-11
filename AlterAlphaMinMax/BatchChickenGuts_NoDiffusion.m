function [ xm, ym, results ] = BatchChickenGuts_NoDiffusion( p, xm0, ym0, tm0, mem0, xc, yc, r1all, r2all, Cmem0, angmem0, recordplume )
	
    if ~exist('recordplume','var');
        recordplume = 250; %default time step at which to record the CO2 plume
    end

% INITIAL CO2
    C = zeros(p.Ng,p.Ng); %initial concentration is zero

    % INITIAL VELOCITY
    % [r1,r2] = setRandomVel(p); %random, time dependent portion of the velocity
	rctr = 1;
	r1 = r1all(:,:,rctr);
	r2 = r2all(:,:,rctr);
    [xg,yg] = meshgrid( p.h/2 : p.h : p.L-p.h/2 );  % cell-centered discretized domain

    % EMPTY VECTORS FOR MOSQUITO POSITION AND MEMORY (INITIALLY MOSQ NOT IN DOMAIN) AND RESULTS
    xm=[];
    ym=[];
    mem=[];
	angmem=[];
	Cmem=[];
    tstart=[];
    results.xmfinalpos=[];
    results.ymfinalpos=[];
    results.tmentrance=[];
    results.tmfinal=[];
    results.whichchicken=[];
	results.C=zeros(0,0,0);
    
    % RUN THE FOR LOOP
    for t = 0 : p.dt : p.Tf
	
		% CALCULATE VELOCITY
		U = eval(['V1Parametric',p.vfunc,'(xg,yg,p.Vmag,t)']); %this is the steady portion of the velocity
	    V = eval(['V2Parametric',p.vfunc,'(xg,yg,p.Vmag,t)']); 
		U = U+r1;
		V = V+r2;

        % MAKE MATRICES FOR CALCULATING DERIVATIVES
        [Cxp,Cxm,Cyp,Cym] = SliceC(C);

        % SPREAD THE SOURCE CO2 TO THE UNDERLYING GRID
        S = SpreadToGrid(xc,yc,p.h,p.sC,size(C));

        % % CALCULATE DIFFUSION
        % D = DiffuseC(C, Cxp, Cxm, Cyp, Cym, p.h);
        D = 0;

        % CALCULATE ADVECTION
        A = AdvectC(xg,yg,C,Cxp,Cxm,Cyp,Cym,U,V,p.h,p.Vmag,p.vfunc,t);

        % SUM ALL OF THE TERMS.
        C = C + p.dt*S + p.nu*p.dt*D - p.dt*A; 

        % MOVE THE CHICKENS
        if (mod(t,p.tChick) < p.dt/2);
            [xc,yc] = MoveChickens(xc,yc,p.tChick);
        end

        % MOVE EXISTING MOSQUITOES
        if (mod(t,p.tMosq) < p.dt/2);
            if ~isempty(xm);
                [xm,ym,mem,results,tstart,Cmem,angmem] = MoveMosquitoes(xm,ym,mem,results,xc,yc,U,V,C,Cmem,angmem,p,t,tstart);
            end
            %INSERT NEW MOSQUITOES ONLY AT DECISION TIMES
            if ~isempty(tm0) && t > tm0(1);
                [xm,ym,tm0,tstart,xm0,ym0,mem, mem0,Cmem,Cmem0,angmem,angmem0] = insertMosquitoes(t,tm0,tstart,xm,ym,mem,Cmem,angmem,xm0,ym0,mem0,Cmem0,angmem0);
            end
        end

        % GRAPH CO2, CHICKENS, AND MOSQUITOES
        if (isempty(xm) && (p.tGraph_prior > 0) && (mod(t,p.tGraph_prior) < p.dt/2) ) || (~isempty(xm) && (p.tGraph_after > 0) && (mod(t,p.tGraph_after) < p.dt/2) );
            GraphC(C,t,xm,ym,results,xc,yc,p);
        end

		% CHECK TO SEE IF SIMULATION IS OVER
		if ~isempty(ym);
			stoprun = remainingMosquitoes(ym,p);
			if stoprun; % REPORT MOSQUITOES THAT HAVE FOUND A HOST AND THEN QUIT
				disp(['All mosquitoes either at a host or out of the domain at time t = ',num2str(t),'.'])
				reportMosquitoes(results,p);
				results.C(:,:,end+1) = C;
				break
			end
		end
				
        % UPDATE RANDOM WIND
        if (mod(t,p.tRand) < p.dt/2) && t<p.Tf && t>0;
            % [r1,r2] = setRandomVel(p);
			rctr = rctr+1;
			r1 = r1all(:,:,rctr);
			r2 = r2all(:,:,rctr);
        end 

        % REPORT MOSQUITOES THAT HAVE FOUND A HOST
        if (mod(t,p.tReport) < p.dt/2) && (~isempty(xm) || isempty(tm0));
			reportMosquitoes(results,p);
        end

        % REPORT NEGATIVE CO2 (BUG CHECK)
        Cmn=min(min(C));
        if Cmn < 0;
            disp(['Cmn = ',num2str(Cmn),' at t = ',num2str(t)])
        end

		% RECORD PLUME
		if any(abs(t - recordplume*[1:round(p.Tf/recordplume)]) < p.dt/2);
			results.C(:,:,end+1) = C;
		end	 

        clear Cxp Cxm Cyp Cym S D A

    end


end %function

function reportMosquitoes(results,p);
	disp(['Number of mosquito-bird encounters: ',int2str(length(results.whichchicken)),'/',int2str(p.Nm)])
    disp(['Number at group 1: ',int2str(sum(results.whichchicken <= p.Nc(1)))])
    disp(['Number at group 2: ',int2str(sum(results.whichchicken >  p.Nc(1)))])
end %function   