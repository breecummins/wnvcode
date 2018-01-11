function BatchChickenJuice_Test()

close all

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '~/WNVBigDomain/';
fnamestring = 'TestMosq';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

BoxLengthPerChick = sqrt(0.0929*8)/2; % in meters (0.0929m^2 = 1 ft^2)
vfunc = '';
usemosq = 'y';
inittime = 0;
dwidth = 30;
dlength = 200;
initrad = 100;
groupflag = 4;
[p,xm0,ym0,tm0,mem0,xc,yc,Cmem,angmem,modevec] = BatchinitParams_Test(BoxLengthPerChick,vfunc,dwidth,dlength,initrad,groupflag,usemosq,inittime);
r1 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng*p.Ly/p.Lx,p.Ng,1));  
r2 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng*p.Ly/p.Lx,p.Ng,1));
p.savefname = fullfile(basedir,[fnamestring,'.mat']); 

% RUN THE SIMULATION
[ xmtraj, ymtraj, results ] = BatchChickenGuts_Trajectories_InitNoDiff_local( p, xm0, ym0, tm0, mem0, xc, yc, r1, r2, Cmem, angmem,modevec);

% SAVE THE INPUTS AND OUTPUTS
save(p.savefname, 'p', 'xc', 'yc', 'xmtraj', 'ymtraj','results')    

end %function

function [ xmtraj, ymtraj, results ] = BatchChickenGuts_Trajectories_InitNoDiff_local( p, xm0, ym0, tm0, mem0, xc, yc, r1all, r2all, Cmem0, angmem0, modevec0 )
	
    % keep CO2 constant
    load testC.mat

    % INITIAL VELOCITY
    % [r1,r2] = setRandomVel(p); %random, time dependent portion of the velocity
	rctr = 1;
	r1 = r1all(:,:,rctr);
	r2 = r2all(:,:,rctr);
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
	nummodes = length(p.wind_mode);
    xmtraj = cell(p.Nm*nummodes,1);
	ymtraj = cell(p.Nm*nummodes,1);
	indsave=1:p.Nm*nummodes;
	timethresh = tm0(1);

    % RUN THE FOR LOOP
    for t = 0 : p.dt : p.Tf
	
		% CALCULATE VELOCITY
		U = eval(['V1Parametric',p.vfunc,'(xg,yg,p.Vmag,t)']); %this is the steady portion of the velocity
	    V = eval(['V2Parametric',p.vfunc,'(xg,yg,p.Vmag,t)']); 
		if t >= timethresh;
			U = U+r1;
			V = V+r2;
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

        % REPORT MOSQUITOES THAT HAVE FOUND A HOST
        if (mod(t,p.tReport) < p.dt/2) && (~isempty(xm) || isempty(tm0));
			reportMosquitoes(results,p,nummodes);
        end

		% RECORD PLUME
		if any(abs(t - 1*[1:round(p.Tf)]) < p.dt/2);
			%disp(t)
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

