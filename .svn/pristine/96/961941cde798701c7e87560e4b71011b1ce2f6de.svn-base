function [UWtraj,DWtraj, CWtraj, Csave, p, xc, yc]=MakeTrajectories();
	
% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

Nc = [7,3];
[p,xm0,tm0,mem0,xc,yc,Cmem] = BatchinitParams_2groups(Nc);
r1 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,ceil(p.Tf/p.tRand)+1));  
r2 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,ceil(p.Tf/p.tRand)+1));
p.Nm = 20;
for windmode = [1,2,5];
   % RANDOM SEED FOR MOSQUITO BEHAVIOR
	SetRandomSeed(0);

   % SET REMAINING PARAMETERS IN A SCRIPT
   [p,ym0,angmem] = BatchsetParams(p,windmode,'','',0,0); 

	% RUN THE SIMULATION
    [ xmtraj, ymtraj, results ] = BatchChickenGutsTraj( p, xm0(1:p.Nm), ym0(1:p.Nm), tm0(1:p.Nm), mem0(1:p.Nm,:), xc, yc, r1, r2, Cmem(1:p.Nm), angmem(1:p.Nm) );
	if windmode == 1;
		UWtraj.xm = xmtraj;
		UWtraj.ym = ymtraj;
	elseif windmode == 2;
		DWtraj.xm = xmtraj;
		DWtraj.ym = ymtraj;
	elseif windmode == 5;
		CWtraj.xm = xmtraj;
		CWtraj.ym = ymtraj;
		Csave = results.C;
	end
end

end %function

function [ xmtraj, ymtraj, results ] = BatchChickenGutsTraj( p, xm0, ym0, tm0, mem0, xc, yc, r1all, r2all, Cmem0, angmem0 )
	
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
	xmtraj = cell(p.Nm,1);
	ymtraj = cell(p.Nm,1);
	indsave=1:p.Nm;
	for l = 1:p.Nm;
		xmtraj{l}(1) = xm0(l);
		ymtraj{l}(1) = ym0(l);
	end
    
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

        % CALCULATE DIFFUSION
        D = DiffuseC(C, Cxp, Cxm, Cyp, Cym, p.h);

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
                [xm,ym,mem,results,tstart,Cmem,angmem] = MoveMosquitoes_NoRemoval(xm,ym,mem,results,xc,yc,U,V,C,Cmem,angmem,p,t,tstart);
				%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				% REMOVE THE MOSQUITOES WHO FIND A HOST
				%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
				ind =[];
				for k = 1:length(xm);
					dist = sqrt( (xc - xm(k)).^2 + (yc - ym(k)).^2 );
					if all(dist > p.host_radius);
						ind(end+1) =k;
					else;
						jnd = find(dist == min(dist(find(dist <= p.host_radius))));
						results.whichchicken(end+1) = jnd;
						results.xmfinalpos(end+1) = xm(k);
						results.ymfinalpos(end+1) = ym(k);
						results.tmfinal(end+1) = t;
						results.tmentrance(end+1) = tstart(k);
					end
				end
				xm = xm(ind); ym = ym(ind); mem = mem(ind,:); tstart = tstart(ind); angmem = angmem(ind); Cmem = Cmem(ind); indsave = indsave(ind);
				
				for l = 1:length(indsave);
					xmtraj{indsave(l)}(end+1) = xm(l);
					ymtraj{indsave(l)}(end+1) = ym(l);
				end
				
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
		if any(abs(t - 250*[1:round(p.Tf/250)]) < p.dt/2);
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


