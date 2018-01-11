function bestmatches = SSfindmatches_targeted(basers, baseps, comprs, ksmean_self, van, rmos, wlo, wstd, graph);
	
	%finds the parameter set for comprs that provides the best match to rule set basers, pset baseps, according to a cost function based on lo and hi means and stds.
	%ksmean_self is the mean of the KS stats in a self comparison. Must be calculated with the same van and rmos arguments given here for accurate results.
	%van ==1 means use "vanished" data set; == 0 means use original. rmos = 1 means remove the mosquitoes as they reach the source (instead of giving them zero distance).
	% graph = 1 means graph the z-values. Default is don't.
	%wlo and wstd are optional weights in [0,1]. Default is equal weighting across hi and lo means and standard deviations. If wlo and wstd are vectors, all weight combinations are tried and the bestmatches for each are returned.
	
	if ~exist('wlo','var') || isempty(wlo);
		wlo = 0.5;
	end
	
	if ~exist('wstd','var') || isempty(wstd);
		wstd = 0.5;
	end
	
	[avgdistlo,stddistlo,avgdisthi,stddisthi]=SSdist2source([basers,comprs*ones(1,132)],[baseps,1:132],van);
	
	dist_avglo = [];
	dist_stdlo = [];
	dist_avghi = [];
	dist_stdhi = [];
	for l = 1:132;
		ind = intersect(find(~isnan(avgdistlo(1,:))),find(~isnan(avgdistlo(1+l,:))));
		dist_avglo(l) = sqrt(sum((avgdistlo(1,ind) - avgdistlo(1+l,ind)).^2));
		dist_stdlo(l) = sqrt(sum((stddistlo(1,ind) - stddistlo(1+l,ind)).^2));
		ind = intersect(find(~isnan(avgdisthi(1,:))),find(~isnan(avgdisthi(1+l,:))));
		dist_avghi(l) = sqrt(sum((avgdisthi(1,ind) - avgdisthi(1+l,ind)).^2));
		dist_stdhi(l) = sqrt(sum((stddisthi(1,ind) - stddisthi(1+l,ind)).^2));
	end
	
	bestmatches=[];
	for wl = wlo;
		for ws = wstd;
			costfunc = wl*((1-ws)*dist_avglo + ws*dist_stdlo) + (1-wl)*((1-ws)*dist_avghi + ws*dist_stdhi);
			bestmatches(end+1) = find(costfunc == min(min(costfunc)));
		end
	end
						
	if exist('graph','var') && graph == 1;
		load ~/WNVSixthRuns/AllRules_fixedvariables.mat
		figure
		errorbar(fixedvars.tSpace,avgdistlo(1,:),stddistlo(1,:),'b')
		hold on
		errorbar(fixedvars.tSpace,avgdistlo(bestmatch+1,:),stddistlo(bestmatch+1,:),'r')
		errorbar(fixedvars.tSpace,avgdisthi(1,:),stddisthi(1,:),'b')
		errorbar(fixedvars.tSpace,avgdisthi(bestmatch+1,:),stddisthi(bestmatch+1,:),'r')
		hold off
		xlabel('Time')
		ylabel('Average distance')
	end
	
	
		
		
		
		
		
		
		
		
