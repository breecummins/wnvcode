%SSMaster5.m

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
load ~/WNVFifthRuns/AllRules_fixedvariables.mat
fname='~/WNVFifthRuns/AllRules';


%set rule set parameters
ruleparams.spdfixed=1;	
ruleparams.maxanggrad=pi;
ruleparams.maxangmem=pi;
maxspd=	2;
minspd=	0.75;
minang=pi/12:pi/12:10*pi/12;				

%Do runs of interest.
c=122; 
for k = maxspd;
	ruleparams.maxspdgrad=k;
	ruleparams.maxspdmem=k;
	ruleparams.maxspdconc=k;
	for l = minspd;
		ruleparams.minspdgrad=l;
		ruleparams.minspdmem=l;
		ruleparams.minspdconc=l;
		for m = minang;
			ruleparams.minanggrad=m;
			ruleparams.minangmem=m;
			c=c+1;
			str=sprintf('%03d',c);
			disp(['Parameter set ',str])
			basefname=[fname,'_paramset',str];
			for n = 1:fixedvars.totruns;
				disp(['Run ',int2str(n)])

				[SpatialDistX,SpatialDistY] = ExploreMosquitoBehavior2(ruleparams,fixedvars);
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

