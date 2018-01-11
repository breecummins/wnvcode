%SSMasterPerturbation.m

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

%set variables
load ~/WNVSixthRuns/AllRules_fixedvariables.mat %use mostly what was used earlier, but overwrite some things -- methods and CO2 gradient
fixedvars.Methods=[1,2,6];
fixedvars.NumMethods = length(fixedvars.Methods);


%make fixed concentration gradient
fixedvars.sourcex = 0.4; fixedvars.sourcey = 0.3;
C = exp( -40*((fixedvars.xg-fixedvars.sourcex).^2+(fixedvars.yg-fixedvars.sourcey).^2) );
fixedvars.sourcex_perturb = 0.3; fixedvars.sourcey_perturb = 0.75;
Cp = 0.1*exp( -40*((fixedvars.xg-fixedvars.sourcex_perturb).^2+(fixedvars.yg-fixedvars.sourcey_perturb).^2) );
fixedvars.C = C+Cp;
figure
contour(fixedvars.xg,fixedvars.yg,fixedvars.C,30);
input('Press "Enter" to continue.')
close
C_ym1 = [fixedvars.C(1,:); fixedvars.C(1:end-1,:)];
C_yp1 = [fixedvars.C(2:end,:); fixedvars.C(end,:)];
C_xp1 = [fixedvars.C(:,2:end), fixedvars.C(:,end)];
C_xm1 = [fixedvars.C(:,1),fixedvars.C(:,1:end-1)];

fixedvars.dCdx = (C_xp1-C_xm1)/(2*fixedvars.h);
fixedvars.dCdy = (C_yp1-C_ym1)/(2*fixedvars.h);
gm = sqrt( fixedvars.dCdx.^2 + fixedvars.dCdy.^2 );

%find max values for rule sets
fixedvars.maxG = max(max(gm)); 
fixedvars.maxC = max(max(abs(fixedvars.C)));

%save common variables
fname='~/WNVSixthRuns/Perturbation';
fname1=[fname,'_fixedvariables.mat'];
save(fname1,'fixedvars');


%set rule set parameters
ruleparams.fixedspd=1;	
ruleparams.maxang=pi;
psets =	[ 1.25,0.5,pi/12; 1.25,0.75,4*pi/12; 1.25,0.5,0];
fixedvars.totparams=3;


%Do runs of interest.
for k = 1:3;
	ruleparams.maxspd=psets(k,1);
	ruleparams.minspd=psets(k,2);
	ruleparams.minang=psets(k,3);
	str=sprintf('%03d',k);
	disp(['Parameter set ',str])
	basefname=[fname,'_paramset',str];
	for n = 1:fixedvars.totruns;
		disp(['Run ',int2str(n)])

		[SpatialDistX,SpatialDistY] = SSExploreMosquitoBehavior6(ruleparams,fixedvars);
		strr = sprintf('%02d',n);
		ffname = [basefname,'_run',strr,'.mat'];

		radvec=zeros(fixedvars.Nm,size(SpatialDistX,2),size(SpatialDistX,3));
		tot = size(SpatialDistX,3)*size(SpatialDistX,2);
		for t = 1:size(SpatialDistX,3);
			for q = 1:size(SpatialDistX,2);
				EuclideanDist(:,q,t) = sqrt( (SpatialDistX(:,q,t) - fixedvars.sourcex).^2 +  (SpatialDistY(:,q,t) - fixedvars.sourcey).^2 );
			end
		end

		save(ffname, 'SpatialDistX', 'SpatialDistY','EuclideanDist','ruleparams');
		clear SpatialDistX SpatialDistY EuclideanDist ffname
	end	
end

