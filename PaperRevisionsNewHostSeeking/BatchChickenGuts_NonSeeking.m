function [ xm, ym, results ] = BatchChickenGuts_NonSeeking( p, xm0, ym0, tm0, xc, yc, r1all, r2all,randwalk,advect,rwonlyflag )
	
    % INITIAL CO2
    C = zeros(p.Ng,p.Ng); %initial concentration is zero

    % INITIAL VELOCITY
    % [r1,r2] = setRandomVel(p); %random, time dependent portion of the velocity
	rctr = 1;
	r1 = r1all(:,:,rctr);
	r2 = r2all(:,:,rctr);
    [xg,yg] = meshgrid( p.h/2 : p.h : p.L-p.h/2 );  % cell-centered discretized domain

    % EMPTY VECTORS FOR MOSQUITO POSITION (INITIALLY MOSQ NOT IN DOMAIN) AND RESULTS
    xm=[];
    ym=[];
    tstart=[];
    results.xmfinalpos=[];
    results.ymfinalpos=[];
    results.tmentrance=[];
    results.tmfinal=[];
    results.whichchicken=[];
    
    % RUN THE FOR LOOP
    for t = 0 : p.dt : p.Tf
	
		% CALCULATE VELOCITY
		U = eval(['V1Parametric',p.vfunc,'(xg,yg,p.Vmag,t)']); %this is the steady portion of the velocity
	    V = eval(['V2Parametric',p.vfunc,'(xg,yg,p.Vmag,t)']); 
		U = U+r1;
		V = V+r2;
	
		% CO2 calculations are irrelevant

        % MOVE THE CHICKENS
        if (mod(t,p.tChick) < p.dt/2);
            [xc,yc] = MoveChickens(xc,yc,p.tChick);
        end

        % MOVE EXISTING MOSQUITOES
        if (mod(t,p.tMosq) < p.dt/2);
            if ~isempty(xm);
				[xm,ym,results,tstart] = MoveMosquitoes_NonSeeking(xm,ym,results,xc,yc,U,V,p,t,tstart,randwalk,advect);
            end
            %INSERT NEW MOSQUITOES ONLY AT DECISION TIMES
            if ~isempty(tm0) && t > tm0(1);
                [xm,ym,tm0,tstart,xm0,ym0] = insertMosquitoes_NonSeeking(t,tm0,tstart,xm,ym,xm0,ym0);
            end
        end

        % GRAPH CO2, CHICKENS, AND MOSQUITOES
        if (isempty(xm) && (p.tGraph_prior > 0) && (mod(t,p.tGraph_prior) < p.dt/2) ) || (~isempty(xm) && (p.tGraph_after > 0) && (mod(t,p.tGraph_after) < p.dt/2) );
            GraphWind(U,V,t,xm,ym,results,xc,yc,p)
        end

		% CHECK TO SEE IF SIMULATION IS OVER
		if ~isempty(ym);
			if exist('rwonlyflag','var') && rwonlyflag;
				if any(abs(ym-50) < 100) || any(abs(xm-50) < 100);
					stoprun = false;
				else;
					stoprun = true;
				end
			else;
				stoprun = remainingMosquitoes(ym,p);
			end
			if stoprun; % REPORT MOSQUITOES THAT HAVE FOUND A HOST AND THEN QUIT
				disp(['All mosquitoes either at a host or out of the domain at time t = ',num2str(t),'.'])
				reportMosquitoes(results,p);
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
        if ( mod(t,p.tReport) < p.dt/2 ) && ( t > 0 ) && (~isempty(xm) || isempty(tm0));
			reportMosquitoes(results,p);
        end

    end


end %function

function reportMosquitoes(results,p);
	disp(['Number of mosquito-bird encounters: ',int2str(length(results.whichchicken)),'/',int2str(p.Nm)])
    disp(['Number at group 1: ',int2str(sum(results.whichchicken <= p.Nc(1)))])
    disp(['Number at group 2: ',int2str(sum(results.whichchicken >  p.Nc(1)))])
end %function