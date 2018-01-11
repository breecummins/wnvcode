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

%set variables
fname='~/WNVSixthRuns/Rule5onlyMaxScaling';
load ~/WNVSixthRuns/AllRules_fixedvariables.mat
fixedvars.Methods=5;
fixedvars.NumMethods = length(fixedvars.Methods);
fname1=[fname,'_fixedvariables.mat'];
save(fname1,'fixedvars');


%set rule set parameters
ruleparams.fixedspd=1;	
ruleparams.maxang=pi;
maxspd=	1.25:0.25:2;
minspd=	0.25:0.25:0.75;
minang=0:pi/12:10*pi/12;				
fixedvars.totparams=length(maxspd)*length(minspd)*length(minang);

%Do runs of interest.
c=0; 
for k = maxspd;
	ruleparams.maxspd=k;
	for l = minspd;
		ruleparams.minspd=l;
		for m = minang;
			ruleparams.minang=m;
			c=c+1;
			str=sprintf('%03d',c);
			disp(['Parameter set ',str])
			basefname=[fname,'_paramset',str];
			for n = 1:fixedvars.totruns;
				disp(['Run ',int2str(n)])

				[SpatialDistX,SpatialDistY] = SSExploreMosquitoBehavior6_rule5(ruleparams,fixedvars);
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
	end
end
