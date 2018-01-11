%SSMaster3.m

clear 
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory of methods: 	1. Gradient: pick direction, pick speed
%						2. Gradient: pick direction, speed fixed
%						3. Gradient: pick direction, speed random
%						4. Concentration: direction from memory, pick speed from absolute concentration
%						5. Concentration: direction from memory, speed from memory
%						6. Concentration: direction from memory, speed fixed
%						7. Concentration: direction from memory, speed random
%						8. Concentration: direction random, pick speed from absolute concentration
%						9. Diffusion: direction random, speed fixed
%					   10. Gradient: pick direction, pick speed from absolute concentration

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% just adding on to the runs already done; see SSMaster3.m
fname='~/WNVFourthRuns/AllRules';
load ~/WNVFourthRuns/AllRules_fixedvariables.mat;

%set rule set parameters
ruleparams.spdfixed=1;	
ruleparams.maxanggrad=pi;
ruleparams.maxangmem=pi;
maxspd=	1.25:0.25:2;
minspd=	0.25:0.25:0.75;
minang=0;				
fixedvars.totparams=length(maxspd)*length(minspd)*length(minang);

%Do runs of interest.
c=120; %again, add on to runs already done
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
			SpatialStatistics_Empirical(ruleparams,fixedvars,basefname);
		end
	end
end

