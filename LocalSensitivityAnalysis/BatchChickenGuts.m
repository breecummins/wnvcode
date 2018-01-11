function [ xm, ym, results ] = BatchChickenGuts( p, xm0, ym0, tm0, mem0, xc, yc, r1all, r2all )
	
    % INITIAL CO2
    C = zeros(p.Ng,p.Ng); %initial concentration is zero

    % INITIAL VELOCITY
    % [r1,r2] = setRandomVel(p); %random, time dependent portion of the velocity
	rctr = 1;
	r1 = r1all(:,:,rctr);
	r2 = r2all(:,:,rctr);
    [xg,yg] = meshgrid( p.h/2 : p.h : p.L-p.h/2 );  % cell-centered discretized domain
    U = V1Parametric(xg,yg,p.Vmag); %this is the steady portion of the velocity
    V = V2Parametric(xg,yg,p.Vmag); 

    % EMPTY VECTORS FOR MOSQUITO POSITION AND MEMORY (INITIALLY MOSQ NOT IN DOMAIN) AND RESULTS
    xm=[];
    ym=[];
    mem=[];
    tstart=[];
    results.xmfinalpos=[];
    results.ymfinalpos=[];
    results.tmentrance=[];
    results.tmfinal=[];
    results.whichchicken=[];
    
    % RUN THE FOR LOOP
    for t = 0 : p.dt : p.Tf

        % MAKE MATRICES FOR CALCULATING DERIVATIVES
        [Cxp,Cxm,Cyp,Cym] = SliceC(C);

        % SPREAD THE SOURCE CO2 TO THE UNDERLYING GRID
        S = SpreadToGrid(xc,yc,C,p.h,p.sC);

        % CALCULATE DIFFUSION
        D = DiffuseC(C, Cxp, Cxm, Cyp, Cym, p.h);

        % CALCULATE ADVECTION
        A = AdvectC(xg,yg,C,Cxp,Cxm,Cyp,Cym,U+r1,V+r2,p.h,p.Vmag);

        % SUM ALL OF THE TERMS.
        C = C + p.dt*S + p.nu*p.dt*D - p.dt*A; 

        % MOVE THE CHICKENS
        if (mod(t,p.tChick) < p.dt/2);
            [xc,yc] = MoveChickens(xc,yc,p.tChick);
        end

        % MOVE EXISTING MOSQUITOES
        if (mod(t,p.tMosq) < p.dt/2);
            if ~isempty(xm);
                [xm,ym,mem,results,tstart] = MoveMosquitoes(xm,ym,mem,results,xc,yc,U+r1,V+r2,C,Cxp,Cxm,Cyp,Cym,p,t,tstart);
            end
            %INSERT NEW MOSQUITOES ONLY AT DECISION TIMES
            if ~isempty(tm0) && t > tm0(1);
                [xm,ym,tm0,tstart,xm0,ym0,mem, mem0] = insertMosquitoes(t,tm0,tstart,xm,ym,mem,xm0,ym0,mem0);
            end
        end

        % UPDATE RANDOM WIND
        if (mod(t,p.tRand) < p.dt/2) && t>0;
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
				break
			end
		end
				
        clear Cxp Cxm Cyp Cym S D A

    end


end %function

function reportMosquitoes(results,p);
	disp(['Number of mosquito-bird encounters: ',int2str(length(results.whichchicken)),'/',int2str(p.Nm)])
    disp(['Number at group 1: ',int2str(sum(results.whichchicken <= p.Nc(1)))])
    disp(['Number at group 2: ',int2str(sum(results.whichchicken >  p.Nc(1)))])
end %function   