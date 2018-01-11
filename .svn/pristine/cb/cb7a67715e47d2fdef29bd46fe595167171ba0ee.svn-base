% ChickenJuice.m

clear
close all

% SET RANDOM SEED
a=version;
randseed = sum(100*clock);
if str2num(a(1:3)) >= 7.7;
	RandStream.setDefaultStream(RandStream('mt19937ar','seed',randseed));
else;
	rand('twister',randseed)
	randn('state',randseed) 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INITIALIZE VALUES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET PARAMETERS IN A SCRIPT
[p,xg,yg] = setParams; 

% INITIAL POSITIONS OF CHICKENS AND MOSQUITOES
[xc,yc] = setChickens(p); 
[xm0,ym0,tm,mem0] = setMosquitoes(p); %includes entrance times

% INITIAL CO2
C = zeros(p.Ng,p.Ng); %initial concentration is zero

% INITIAL VELOCITY
[r1,r2] = setRandomVel(p); %random, time dependent portion of the velocity
U = V1Parametric(xg,yg,p.Vmag); %this is the steady portion of the velocity
V = V2Parametric(xg,yg,p.Vmag); 

% EMPTY VECTORS FOR MOSQUITO POSITION AND MEMORY (INITIALLY MOSQ NOT IN DOMAIN) AND RESULTS
xm=[];
ym=[];
mem=[];
tstart=[];
results.xmfinalpos=[];
results.ymfinalpos=[];
results.tmfinal=[];
results.whichchicken=[];
results.tmentrance=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
	if (mod(t,p.tChick) == 0)
		[xc,yc] = MoveChickens(xc,yc,p.tChick);
	end
	
	% MOVE EXISTING MOSQUITOES
	if (mod(t,p.tMosq) == 0)
		if ~isempty(xm);
			[xm,ym,mem,results,tstart] = MoveMosquitoes(xm,ym,mem,results,xc,yc,U+r1,V+r2,C,Cxp,Cxm,Cyp,Cym,p,t,tstart);
		end
		%INSERT NEW MOSQUITOES ONLY AT DECISION TIMES
		if ~isempty(tm) && t > tm(1);
			[xm,ym,tm,tstart,xm0,ym0,mem, mem0] = insertMosquitoes(t,tm,tstart,xm,ym,mem,xm0,ym0,mem0);
		end
	end
	
	% UPDATE RANDOM WIND
	if (mod(t,p.tRand) == 0)
		[r1,r2] = setRandomVel(p);
	end 

	% REPORT MOSQUITOES THAT HAVE FOUND A HOST
	if (mod(t,p.tReport) == 0) && (~isempty(xm) || isempty(tm));
	 	disp(['Number of mosquito-bird encounters: ',int2str(length(results.whichchicken)),'/',int2str(p.Nm)])
	 	disp(['Number at group 1: ',int2str(sum(results.whichchicken<=7))])
	 	disp(['Number at group 2: ',int2str(sum(results.whichchicken>=8))])
	end
	
	% REPORT NEGATIVE CO2 (BUG CHECK)
	Cmn=min(min(C));
	if Cmn < 0;
		disp(['Cmn = ',num2str(Cmn),' at t = ',num2str(t)])
	end
	
	% GRAPH CO2, CHICKENS, AND MOSQUITOES
	if (isempty(xm) && mod(t,p.tGraph_prior)==0) || (~isempty(xm) && mod(t,p.tGraph_after) == 0);
		GraphC(C,t,xm,ym,results,xc,yc,p);
	end
	
	clear Cxp Cxm Cyp Cym S D A

end

results.tm = []; %this was an intermediate value, not needed

if exist('p.savefname','var');
	save p.savefname p xc yc results
end
