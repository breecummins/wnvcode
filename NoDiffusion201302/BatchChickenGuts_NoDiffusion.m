function [ xm, ym, results ] = BatchChickenGuts_NoDiffusion( p, xm0, ym0, tm0, mem0, xc, yc, r1all, r2all, Cmem0, angmem0, recordplume )
	
    if ~exist('recordplume','var');
        recordplume = 250; %default time step at which to record the CO2 plume
    end

    % INITIALIZE CO2 AND MAKE GRID
    C = zeros(p.Ng,p.Ng); %initial concentration is zero
    [xg,yg] = meshgrid( p.h/2 : p.h : p.L-p.h/2 );  % cell-centered discretized domain

    % CALCULATE STEADY BULK VELOCITY
    U0 = eval(['V1Parametric',p.vfunc,'(xg,yg,p.Vmag)']); 
    V0 = eval(['V2Parametric',p.vfunc,'(xg,yg,p.Vmag)']); 

    % GET BULK VELOCITY OUTSIDE DOMAIN EDGE
    rightedge = eval(['V1Parametric',p.vfunc,'(xg(:,end)+p.h,yg(:,end),p.Vmag)']);
    leftedge = eval(['V1Parametric',p.vfunc,'(xg(:,1)-p.h,yg(:,1),p.Vmag)']);
    topedge = eval(['V2Parametric',p.vfunc,'(xg(end,:),yg(end,:)+p.h,p.Vmag)']);
    bottomedge = eval(['V2Parametric',p.vfunc,'(xg(1,:),yg(1,:)-p.h,p.Vmag)']);

    % INITIALIZE RANDOM VELOCITY COUNTER
	rctr = 0;

    % SPREAD CO2 TO GRID FROM STATIONARY HOSTS (TIME INDEPENDENT)
    S = SpreadToGrid(xc,yc,p.h,p.sC,size(C));

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

        if mod(t,25) < p.dt/2;
            disp(t)
        end
	   
		% UPDATE RANDOM WIND
        if (mod(t,p.tRand) < p.dt/2) && t<p.Tf;
            % GET NEW RANDOM VEL
            rctr = rctr+1;
            r1 = r1all(:,:,rctr);
            r2 = r2all(:,:,rctr);
            % ADD TO BULK FLOW
            U = U0+r1;
            V = V0+r2;
            % SLICE VELOCITY
            Uxp = [U(:,2:end),rightedge];
            Uxm = [leftedge, U(:,1:end-1)];
            Vyp = [V(2:end,:); topedge];
            Vym = [bottomedge; V(1:end-1,:)];
            % CALCULATE VELOCITY AVERAGES ON CELL EDGES
            up = 0.5*(U+Uxp);
            um = 0.5*(U+Uxm);
            vp = 0.5*(V+Vyp);
            vm = 0.5*(V+Vym);       
            clear Uxp Uxm Vyp Vym 
            % FIND WIND DIRECTION ON CELL EDGES
            logic_upp = (up > 0);
            logic_upm = (up <= 0);
            logic_ump = (um > 0);
            logic_umm = (um <= 0);
            logic_vpp = (vp > 0);
            logic_vpm = sparse(vp <= 0);
            logic_vmp = (vm > 0);
            logic_vmm = sparse(vm <= 0);            
            % FIND LOCATIONS FOR OUTFLOW BCS
            leftind = find(um(:,1) < 0);
            rightind = find(up(:,end) > 0);
            bottomind = find(vm(1,:) < 0);
            topind = find(vp(end,:) > 0);
        end 

        % MAKE GHOST CELL VALUES FOR C USING INFLOW/OUTFLOW BCS
        z = zeros(size(C(:,1)));        
        Cxp = [C(:,2:end),z];
        Cxm = [z,C(:,1:end-1)];
        Cyp = [C(2:end,:);z.'];
        Cym = [z.';C(1:end-1,:)];
        Cxp(rightind,end) = 2*C(rightind,end) - C(rightind,end-1);
        Cxm(leftind,1) = 2*C(leftind,1) - C(leftind,2);
        Cyp(end,topind) = 2*C(end,topind) - C(end-1,topind);
        Cym(1,bottomind) = 2*C(1,bottomind) - C(2,bottomind);

        % CALCULATE ADVECTION: FLUXES ON EDGES OF CELLS USING CONSERVATIVE UPWINDING 
        Flxx = (C.*logic_upp + Cxp.*logic_upm).*up - (Cxm.*logic_ump + C.*logic_umm).*um;
        Flxy = (C.*logic_vpp + Cyp.*logic_vpm).*vp - (Cym.*logic_vmp + C.*logic_vmm).*vm;
        A = (Flxx+Flxy)/p.h;
        clear Cxp Cxm Cyp Cym

        % UPDATE CONCENTRATION USING EULER'S METHOD
        C = C + p.dt*(S - A); 
        clear A

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

    end


end %function

function reportMosquitoes(results,p);
	disp(['Number of mosquito-bird encounters: ',int2str(length(results.whichchicken)),'/',int2str(p.Nm)])
    disp(['Number at group 1: ',int2str(sum(results.whichchicken <= p.Nc(1)))])
    disp(['Number at group 2: ',int2str(sum(results.whichchicken >  p.Nc(1)))])
end %function   