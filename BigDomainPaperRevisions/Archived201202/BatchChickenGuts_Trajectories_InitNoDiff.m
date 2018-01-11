function [ xmtraj, ymtraj, results, C ] = BatchChickenGuts_Trajectories_InitNoDiff( p, xm0, ym0, tm0, mem0, xc, yc, r1all, r2all, Cmem0, angmem0, modevec0, difftimethresh )
	
    % INITIAL CO2
    C = zeros(p.Ng*p.Ly/p.Lx,p.Ng); %initial concentration is zero

    % INITIAL VELOCITY
	if ~isempty(r1all);
		rctr = 1;
		r1 = r1all(:,:,rctr);
		r2 = r2all(:,:,rctr);
    else;
    	[r1,r2] = setRandomVel(p,size(C)); %random, time dependent portion of the velocity
	end
    [xg,yg] = meshgrid( p.h/2 : p.h : p.Lx-p.h/2, p.h/2 : p.h : p.Ly-p.h/2 );  % cell-centered discretized domain

    % EMPTY VECTORS FOR MOSQUITO POSITION AND MEMORY (INITIALLY MOSQ NOT IN DOMAIN) AND RESULTS
    xm=[];
    ym=[];
    mem=[];
	angmem=[];
	Cmem=[];
    tstart=[];
	modevec=[];
    results.xmfinalpos=[];
    results.ymfinalpos=[];
    results.tmentrance=[];
    results.tmfinal=[];
    results.whichchicken=[];
	results.C=zeros(0,0,0);
	nummodes = length(p.wind_mode);
    xmtraj = cell(p.Nm*nummodes,1);
	ymtraj = cell(p.Nm*nummodes,1);
	indsave=1:p.Nm*nummodes;

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

        % CALCULATE ADVECTION
        A = AdvectC(xg,yg,C,Cxp,Cxm,Cyp,Cym,U,V,p.h,p.Vmag,p.vfunc,t);

        % CALCULATE DIFFUSION AND SUM ALL OF THE TERMS.
		if t >= difftimethresh;
        	D = DiffuseC(C, Cxp, Cxm, Cyp, Cym, p.h);
	        C = C + p.dt*S + p.nu*p.dt*D - p.dt*A; 
		    clear Cxp Cxm Cyp Cym S A D
		else;
	        C = C + p.dt*S - p.dt*A; 
			clear Cxp Cxm Cyp Cym S A
		end
		

        % MOVE THE CHICKENS
        if (mod(t,p.tChick) < p.dt/2);
            [xc,yc] = MoveChickens(xc,yc,p.tChick);
        end
        
        % MOVE EXISTING MOSQUITOES
        if (mod(t,p.tMosq) < p.dt/2);
            if ~isempty(xm);
                [xm,ym,mem,results,tstart,Cmem,angmem,modevec] = MoveMosquitoes_NoRemoval(xm,ym,mem,results,xc,yc,U,V,C,Cmem,angmem,p,t,tstart,modevec);
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
				xm = xm(ind); ym = ym(ind); mem = mem(ind,:); tstart = tstart(ind); angmem = angmem(ind); Cmem = Cmem(ind); modevec=modevec(ind);
				indsave = indsave(ind);
				
            end
            %INSERT NEW MOSQUITOES ONLY AT DECISION TIMES
            if ~isempty(tm0) && t >= tm0(1);
                [xm,ym,tm0,tstart,xm0,ym0,mem, mem0,Cmem,Cmem0,angmem,angmem0,modevec0,modevec] = insertMosquitoes(t,tm0,tstart,xm,ym,mem,Cmem,angmem,xm0,ym0,mem0,Cmem0,angmem0,modevec0,modevec);
            end
        end

        % GRAPH CO2, CHICKENS, AND MOSQUITOES
        if (isempty(xm) && (p.tGraph_prior > 0) && (mod(t,p.tGraph_prior) < p.dt/2) ) || (~isempty(xm) && (p.tGraph_after > 0) && (mod(t,p.tGraph_after) < p.dt/2) );
            GraphC(C,t,xm,ym,results,xc,yc,p,xg,yg,modevec);
        end

		% % CHECK TO SEE IF SIMULATION IS OVER
		% if ~isempty(ym);
		% 	stoprun = remainingMosquitoes(ym,p,modevec);
		% 	if stoprun; % REPORT MOSQUITOES THAT HAVE FOUND A HOST AND THEN QUIT
		% 		disp(['All mosquitoes either at a host or out of the domain at time t = ',num2str(t),'.'])
		% 		reportMosquitoes(results,p);
		% 		results.C(:,:,end+1) = C;
		% 		break
		% 	end
		% end
				
        % UPDATE RANDOM WIND
        if (mod(t,p.tRand) < p.dt/2) && t<p.Tf && t>0;
            % [r1,r2] = setRandomVel(p,size(C));
			rctr = rctr+1;
			r1 = r1all(:,:,rctr);
			r2 = r2all(:,:,rctr);
        end 

        % REPORT MOSQUITOES THAT HAVE FOUND A HOST
        if (mod(t,p.tReport) < p.dt/2) && (~isempty(xm) || isempty(tm0));
			reportMosquitoes(results,p,nummodes);
        end

        % REPORT NEGATIVE CO2 (BUG CHECK)
        Cmn=min(min(C));
        if Cmn < 0;
            disp(['Cmn = ',num2str(Cmn),' at t = ',num2str(t)])
        end

		% RECORD PLUME
		if any(abs(t - 100*[1:round(p.Tf/100)]) < p.dt/2);
			disp(t)
			results.C(:,:,end+1) = C;
			if ~isempty(xm)
				for l = 1:length(indsave);
					xmtraj{indsave(l)}(end+1) = xm(l);
					ymtraj{indsave(l)}(end+1) = ym(l);
				end
			end
		end	 

    end


end %function

function reportMosquitoes(results,p,nummodes);
	disp(['Number of mosquito-bird encounters: ',int2str(length(results.whichchicken)),'/',int2str(p.Nm*nummodes)])
    disp(['Number at group 1: ',int2str(sum(results.whichchicken <= p.Nc(1)))])
    disp(['Number at group 2: ',int2str(sum(results.whichchicken >  p.Nc(1)))])
end %function