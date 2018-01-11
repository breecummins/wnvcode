function results = BatchChickenGuts_Continue( p, xc, yc, xm, ym, mem, Cmem, angmem, modevec, indsave, C, results, tResume )
	
    [xg,yg] = meshgrid( p.h/2 : p.h : p.Lx-p.h/2, p.h/2 : p.h : p.Ly-p.h/2 );  % cell-centered discretized domain

    % VECTORS FOR INDICES AND RESULTS
	recordC=100;
	nummodes = length(p.wind_mode);
	
	% VELOCITY FOR TIME INDEPENDENT BULK FLOW
	U0 = V1Parametric_newmeander_notime(xg,yg,p.Vmag,0); 
    V0 = V2Parametric_newmeander_notime(xg,yg,p.Vmag,0);
	% SLICE VELOCITY AT DOMAIN EDGE
	rightedge = V1Parametric_newmeander_notime(xg(:,end)+p.h,yg(:,end),p.Vmag,0);
	leftedge = V1Parametric_newmeander_notime(xg(:,1)-p.h,yg(:,1),p.Vmag,0);
	topedge = V2Parametric_newmeander_notime(xg(end,:),yg(end,:)+p.h,p.Vmag,0);
	bottomedge = V2Parametric_newmeander_notime(xg(1,:),yg(1,:)-p.h,p.Vmag,0);
	% COUNTER FOR RANDOM VEL
	rctr = 1;
	
	% SPREAD CO2 TO GRID FROM STATIONARY HOSTS (TIME INDEPENDENT)
	S = SpreadToGrid(xc,yc,p.h,p.sC,size(C));
	

    % RUN THE FOR LOOP
    for t = tResume : p.dt : p.Tf
	
        % MAKE MATRICES FOR CALCULATING DERIVATIVES
		corer=C(2:end-1,:);		
		corec=C(:,2:end-1);
		row1=C(1,:);
		rowe=C(end,:);
		col1=C(:,1);
		cole=C(:,end);

		Cyp = [corer;rowe;rowe];
		Cym = [row1;row1;corer];
		Cxp = [corec,cole,cole];
		Cxm = [col1,col1,corec];

        % CALCULATE DIFFUSION
		D = (Cxp+Cxm+Cyp+Cym-4*C)/p.h^2;

        % CALCULATE ADVECTION
        % UPDATE RANDOM WIND
        if (mod(t,p.tRand) < p.dt/2) && t<p.Tf;
			[r1,r2] = setRandomVel(p,size(C));
			% CALCULATE VELOCITY
			U = U0+r1;
			V = V0+r2;
			%SLICE VELOCITY
			Uxp = [U(:,2:end),rightedge];
			Uxm = [leftedge, U(:,1:end-1)];
			Vyp = [V(2:end,:); topedge];
			Vym = [bottomedge; V(1:end-1,:)];
			%CALCULATE VELOCITY AVERAGES ON CELL EDGES
			up = 0.5*(U+Uxp);
			um = 0.5*(U+Uxm);
			vp = 0.5*(V+Vyp);
			vm = 0.5*(V+Vym);		
			logic_upp = (up > 0);
			logic_upm = (up <= 0);
			logic_ump = (um > 0);
			logic_umm = (um <= 0);
			logic_vpp = (vp > 0);
			logic_vpm = (vp <= 0);
			logic_vmp = (vm > 0);
			logic_vmm = (vm <= 0);			
			clear Uxp Uxm Vyp Vym 
        end 
		%FLUXES ON THE EDGES OF THE CELLS USING A CONSERVATIVE UPWINDING SCHEME			
		Flxx = (C.*logic_upp + Cxp.*logic_upm).*up - (Cxm.*logic_ump + C.*logic_umm).*um;
		Flxy = (C.*logic_vpp + Cyp.*logic_vpm).*vp - (Cym.*logic_vmp + C.*logic_vmm).*vm;
		A = (Flxx+Flxy)/p.h;

        % SUM ALL OF THE TERMS.
        C = C + p.dt*S + p.nu*p.dt*D - p.dt*A; 		

        clear Cxp Cxm Cyp Cym D A

        % MOVE EXISTING MOSQUITOES
        if t >= p.inittime && (mod(t,p.tMosq) < p.dt/2);
			ummosq = InterpFromGrid(xm,ym,U,p.h, V1Parametric_newmeander_notime(xm,ym,p.Vmag,t));
			vmmosq = InterpFromGrid(xm,ym,V,p.h, V2Parametric_newmeander_notime(xm,ym,p.Vmag,t));
            [xm,ym,mem,results,Cmem,angmem,modevec,indsave] = MoveMosquitoes_NewMeander(xm,ym,ummosq,vmmosq,mem,results,xc,yc,U,V,C,Cmem,angmem,p,t,modevec,indsave);				
        end

        % GRAPH CO2, CHICKENS, AND MOSQUITOES
        if (t < p.inittime && (p.tGraph_prior > 0) && (mod(t,p.tGraph_prior) < p.dt/2) ) || (t >= p.inittime && (p.tGraph_after > 0) && (mod(t,p.tGraph_after) < p.dt/2) );
            GraphC(C,t,xm,ym,results,xc,yc,p,xg,yg,modevec);
        end

        % REPORT NEGATIVE CO2 (BUG CHECK)
        if any(C < 0);
	        Cmn=min(min(C));
            disp(['Cmn = ',num2str(Cmn),' at t = ',num2str(t)])
        end

		% RECORD PLUME
		if any(abs(t - recordC*[1:round(p.Tf/recordC)]) < p.dt/2);
			disp(['Time = ', int2str(t)])
			reportMosquitoes(results,p,nummodes)
			% SAVE THE INPUTS AND OUTPUTS
			save([p.savefname,'_',sprintf('%05d',t),'.mat'],'xm', 'ym','indsave','modevec','C','t','results','mem','angmem','Cmem','-v7.3')   
		end	 


    end


end %function

function reportMosquitoes(results,p,nummodes);
	disp(['Number of mosquito-bird encounters: ',int2str(sum(~isnan(results.whichchicken))),'/',int2str(p.Nm*nummodes)])
	if p.Nc==40;
		for k=1:4;
		    disp([ 'Number at group ',int2str(k),': ',int2str( sum(results.whichchicken <= k*10)- sum(results.whichchicken < (k-1)*10+1) ) ] )
		end
	end
end %function