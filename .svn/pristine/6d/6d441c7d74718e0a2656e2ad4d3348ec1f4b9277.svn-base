%SSMaster6.m

clear 
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory of methods: 	1. Gradient: pick direction, pick speed
%					    2. Gradient: pick direction, pick speed from absolute concentration
%						3. Gradient: pick direction, speed fixed
%						4. Gradient: pick direction, speed random
%						5. Concentration: direction from memory, speed from memory
%						6. Concentration: direction from memory, pick speed from absolute concentration
%						7. Concentration: direction from memory, speed fixed
%						8. Concentration: direction from memory, speed random
%						9. Concentration: direction random, pick speed from absolute concentration
%					   10. Diffusion: direction random, speed fixed

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%SET RANDOM SEED
a=version;
if str2num(a(1:3)) >= 7.7;
	RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));
	%defaultStream = RandStream.getDefaultStream;
	%savedState = defaultStream.State;
else;
	rand('twister',sum(100*clock))
	randn('state',sum(100*clock)) 
end

%set (fixed) parameters
fixedvars.totruns=25; %will give 300 independent U stats within rule sets
fixedvars.dt=1.e-2; % dimensionless time step (how often the mosquito makes a decision)
fixedvars.s0 = 1; %typical mosquito speed
fixedvars.L=fixedvars.s0*fixedvars.dt;	% nondimensional length based on mosquito parameters
fixedvars.maxang=pi; %max angle for all rule sets
fixedvars.maxspd=1.25; %max speed for all rule sets
fixedvars.minspd=0.75; %min speed for all rule sets
fixedvars.minang=pi/3; %min angle for all rule sets
fixedvars.tGraph=0;%100*fixedvars.dt; %how often to plot pictures
fixedvars.Tf = 125;
fixedvars.tSpace = [0:.25:10, 10.5:0.5:30, 31:1:fixedvars.Tf]; %when to record agent positions

%choose methods
fixedvars.Methods=2;
fixedvars.NumMethods = length(fixedvars.Methods);

%build grid
fixedvars.domainL = 100*fixedvars.L;  %This is effectively 100 decisions in each direction
Ng=125;				% number of grid points on each side of the domain
fixedvars.h = fixedvars.domainL/Ng;			% separation between grid points
[fixedvars.xg,fixedvars.yg] = meshgrid( 0 : fixedvars.h : fixedvars.domainL-fixedvars.h/2 );  % discretized domain

%place mosquitoes
fixedvars.Nm = 200; %NUMBER OF MOSQUITOES    
[fixedvars.xm0,fixedvars.ym0] = PlacePoints(fixedvars.Nm,[0.75 0.85]*fixedvars.domainL,[0.75,0.85]*fixedvars.domainL,fixedvars.domainL,fixedvars.h);

%make fixed concentration gradient
fixedvars.sourcex = 0.4*fixedvars.domainL; fixedvars.sourcey = 0.3*fixedvars.domainL;
fixedvars.C = exp( -(40/fixedvars.domainL^2)*((fixedvars.xg-fixedvars.sourcex).^2+(fixedvars.yg-fixedvars.sourcey).^2) );
C = fixedvars.C; 
C_ym1 = [C(1,:); C(1:end-1,:)];
C_yp1 = [C(2:end,:); C(end,:)];
C_xp1 = [C(:,2:end), C(:,end)];
C_xm1 = [C(:,1),C(:,1:end-1)];
fixedvars.dCdx = (C_xp1-C_xm1)/(2*fixedvars.h);
fixedvars.dCdy = (C_yp1-C_ym1)/(2*fixedvars.h);

%assign variable parameter ranges
Csat = [1,0.8]; %conc saturation level
c0 = 0.027 ./ Csat; %nondimensional conc minimum threshold
fixedvars.fudgefactor = 25; %fudge factor chosen to get about the same number of mosquitoes left at t =125 as in rule 2, pset 27 in WNVSixthRuns, when Csat = 1 and kappac = 0.
Gsat = (Csat - c0) ./ (fixedvars.fudgefactor*fixedvars.L); %spac gradient saturation level
g0 = c0 ./ (fixedvars.fudgefactor*fixedvars.L);  %nondimensional gradient minimum threshold
kappahi = 200;
kappaclo = -kappahi ./ (1+kappahi.*c0.*(1+c0));
kappaglo = -kappahi ./ (1+kappahi.*g0.*(1+g0));
kappac= [0,200,kappaclo(1); 0,200, kappaclo(2)];
kappag= [0,200,kappaglo(1); 0,200, kappaglo(2)];
fixedvars.totparams=length(Csat)*size(kappac,2);

%save common variables
fname='~/WNVNewRule/Rule02';
fname1=[fname,'_fixedvariables.mat'];
save(fname1,'fixedvars');

%Do runs of interest.
c=0; 
for k = 1:length(Csat);
	newruleparams.Csat=Csat(k);
	newruleparams.Gsat=Gsat(k);
	newruleparams.c0=c0(k);
	newruleparams.g0=g0(k);
	for l = 1:length(kappac);
		newruleparams.kappac=kappac(k,l);
		newruleparams.kappag=kappag(k,l);
		c=c+1;
		str=sprintf('%03d',c);
		disp(['Parameter set ',str])
		basefname=[fname,'_newruleparam',str];
		for n = 1:fixedvars.totruns;
			disp(['Run ',int2str(n)])

			[SpatialDistX,SpatialDistY] = SSExploreMosquitoBehaviorNewRule(newruleparams,fixedvars);
			strr = sprintf('%02d',n);
			ffname = [basefname,'_run',strr,'.mat'];

			radvec=zeros(fixedvars.Nm,size(SpatialDistX,2),size(SpatialDistX,3));
			tot = size(SpatialDistX,3)*size(SpatialDistX,2);
			for t = 1:size(SpatialDistX,3);
				for q = 1:size(SpatialDistX,2);
					EuclideanDist(:,q,t) = sqrt( (SpatialDistX(:,q,t) - fixedvars.sourcex).^2 +  (SpatialDistY(:,q,t) - fixedvars.sourcey).^2 );
				end
			end

			save(ffname, 'SpatialDistX', 'SpatialDistY','EuclideanDist','newruleparams');
			clear SpatialDistX SpatialDistY EuclideanDist ffname
		end	
	end
end

