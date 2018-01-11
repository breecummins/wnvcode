function [ xm, ym, results ] = BatchChickenGuts( p, xm0, ym0, tm0, mem0, xc, yc, Cmem0, angmem0, modevec0 )
	
	% MAKE GRIDS
	xg=zeros(0,0,0);
	yg=zeros(0,0,0);
	for k = 1:length(p.Nc);
    	[xg1,yg1] = meshgrid( p.chickBoxCenter(k,1)-p.Lx/2. + p.h/2 : p.h : p.chickBoxCenter(k,1) + p.Lx/2. - p.h/2, p.chickBoxCenter(k,2)-50 + p.h/2 : p.h : p.chickBoxCenter(k,2) + p.Ly - 50 - p.h/2 );  % cell-centered discretized domain
		xg(:,:,k) = xg1;
		yg(:,:,k) = yg1;
	end

    % INITIAL CO2
    C = zeros(size(xg)); %initial concentration is zero

    % INITIAL VELOCITY
    [r1,r2] = setRandomVel(p,size(xg)); %random, time dependent portion of the velocity

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
	results.C=zeros(0,0,0,0);
	
	Nccum = cumsum(p.Nc);
	Nccum = [0,Nccum];
    
    % RUN THE FOR LOOP
    for t = 0 : p.dt : p.Tf
	
		% CALCULATE VELOCITY
		U=zeros(0,0,0);
		V=zeros(0,0,0);		
		for k=1:length(p.Nc);
			U(:,:,k) = eval(['V1Parametric',p.vfunc,'(xg(:,:,k),yg(:,:,k),p.Vmag,t)']); %this is the steady portion of the velocity
		    V(:,:,k) = eval(['V2Parametric',p.vfunc,'(xg(:,:,k),yg(:,:,k),p.Vmag,t)']); 
		end
		U = U+r1;
		V = V+r2;

        % MAKE MATRICES FOR CALCULATING DERIVATIVES
		Cxp=zeros(0,0,0);
		Cxm=zeros(0,0,0);		
		Cyp=zeros(0,0,0);
		Cym=zeros(0,0,0);		
		for k=1:length(p.Nc);
        	[Cxp(:,:,k),Cxm(:,:,k),Cyp(:,:,k),Cym(:,:,k)] = SliceC(C(:,:,k));
		end

        % SPREAD THE SOURCE CO2 TO THE UNDERLYING GRID
		S=zeros(0,0,0);		
		for k=1:length(p.Nc);
			ind = Nccum(k)+1:Nccum(k+1);
			xcshift = xc(ind)-(p.chickBoxCenter(k,1)-p.Lx/2.);
			ycshift = yc(ind)-(p.chickBoxCenter(k,2)-50);
        	S(:,:,k) = SpreadToGrid(xcshift,ycshift,p.h,p.sC,size(C(:,:,k)));
		end

        % CALCULATE DIFFUSION
		D=zeros(0,0,0);		
		for k=1:length(p.Nc);
        	D(:,:,k) = DiffuseC(C(:,:,k), Cxp(:,:,k), Cxm(:,:,k), Cyp(:,:,k), Cym(:,:,k), p.h);
		end

        % CALCULATE ADVECTION
		A=zeros(0,0,0);
		for k=1:length(p.Nc);
        	A(:,:,k) = AdvectC(xg(:,:,k),yg(:,:,k),C(:,:,k),Cxp(:,:,k),Cxm(:,:,k),Cyp(:,:,k),Cym(:,:,k),U(:,:,k),V(:,:,k),p.h,p.Vmag,p.vfunc,t);
		end

        % SUM ALL OF THE TERMS.
        C = C + p.dt*S + p.nu*p.dt*D - p.dt*A; 

        % % MOVE THE CHICKENS
        % if (mod(t,p.tChick) < p.dt/2);
        %     [xc,yc] = MoveChickens(xc,yc,p.tChick);
        % end
        % 
        % % MOVE EXISTING MOSQUITOES
        % if (mod(t,p.tMosq) < p.dt/2);
        %     if ~isempty(xm);
        %         [xm,ym,mem,results,tstart,Cmem,angmem] = MoveMosquitoes(xm,ym,mem,results,xc,yc,U,V,C,Cmem,angmem,p,t,tstart);
        %     end
        %     %INSERT NEW MOSQUITOES ONLY AT DECISION TIMES
        %     if ~isempty(tm0) && t > tm0(1);
        %         [xm,ym,tm0,tstart,xm0,ym0,mem, mem0,Cmem,Cmem0,angmem,angmem0] = insertMosquitoes(t,tm0,tstart,xm,ym,mem,Cmem,angmem,xm0,ym0,mem0,Cmem0,angmem0);
        %     end
        % end

        % GRAPH CO2, CHICKENS, AND MOSQUITOES
        if (isempty(xm) && (p.tGraph_prior > 0) && (mod(t,p.tGraph_prior) < p.dt/2) ) || (~isempty(xm) && (p.tGraph_after > 0) && (mod(t,p.tGraph_after) < p.dt/2) );
            for k=1:length(p.Nc);			
				ind = Nccum(k)+1:Nccum(k+1);
				GraphC(C(:,:,k),t,xm,ym,results,xc(ind),yc(ind),p,xg(:,:,k),yg(:,:,k),modevec);
				hold on
			end
			hold off
        end

		% % CHECK TO SEE IF SIMULATION IS OVER
		% if ~isempty(ym);
		% 	stoprun = remainingMosquitoes(ym,p);
		% 	if stoprun; % REPORT MOSQUITOES THAT HAVE FOUND A HOST AND THEN QUIT
		% 		disp(['All mosquitoes either at a host or out of the domain at time t = ',num2str(t),'.'])
		% 		reportMosquitoes(results,p);
		% 		results.C(:,:,:,end+1) = C;
		% 		break
		% 	end
		% end
				
        % UPDATE RANDOM WIND
        if (mod(t,p.tRand) < p.dt/2) && t<p.Tf && t>0;
            [r1,r2] = setRandomVel(p,size(xg));
        end 

			%         % REPORT MOSQUITOES THAT HAVE FOUND A HOST
			%         if (mod(t,p.tReport) < p.dt/2) && (~isempty(xm) || isempty(tm0));
			% reportMosquitoes(results,p);
			%         end

        % REPORT NEGATIVE CO2 (BUG CHECK)
        Cmn=min(min(C));
        if Cmn < 0;
            disp(['Cmn = ',num2str(Cmn),' at t = ',num2str(t)])
        end

		% RECORD PLUME
		if any(abs(t - 100*[1:round(p.Tf/100)]) < p.dt/2);
			disp(t)
			results.C(:,:,:,end+1) = C;
		end	 

        clear Cxp Cxm Cyp Cym S D A

    end


end %function

function reportMosquitoes(results,p);
	disp(['Number of mosquito-bird encounters: ',int2str(length(results.whichchicken)),'/',int2str(p.Nm)])
    disp(['Number at group 1: ',int2str(sum(results.whichchicken <= p.Nc(1)))])
    disp(['Number at group 2: ',int2str(sum(results.whichchicken >  p.Nc(1)))])
end %function   