function [bestmatch,avgdistlo,stddistlo,avgdisthi,stddisthi] = SSfindmatches(basers, comprs, van, baseps,avgdistlo, stddistlo, avgdisthi, stddisthi,wlo,wstd);
	
	%finds the best matching parameter sets (best matching in terms of minimum distance between averages over time) between rule sets basers R1 and comprs R2, both scalars. van ==1 means use "vanished" data set; == 0 menas use original. 
	
	%baseps is an optional argument that finds the best match to basers, baseps within ruleset comprs. If baseps is a vector, only the best match will be returned.
	%avgdist and stddist are the outputs of testraddist and may be input if already calculated.
	
	if ~exist('baseps','var');
		baseps=1:132;
	end
	
	nump = length(baseps);
	
	if ~exist('wlo','var') || isempty(wlo);
		wlo = 0.5;
	end
	
	if ~exist('wstd','var') || isempty(wstd);
		wstd = 0.5;
	end
	
	if ~exist('avgdistlo','var');
		%[avgdist,stddist]=testraddist([basers*ones(1,nump),comprs*ones(1,132)],[baseps,1:132],van);
		[avgdistlo,stddistlo,avgdisthi,stddisthi]=SSdist2source([basers*ones(1,nump),comprs*ones(1,132)],[baseps,1:132],van);
	end
	
	% dist_avg = [];
	% dist_std = [];
	dist_avglo = [];
	dist_stdlo = [];
	dist_avghi = [];
	dist_stdhi = [];
	for k = 1:nump;
		for l = 1:132;
			% dist_avg(k,l) = sqrt(sum((avgdist(k,:) - avgdist(132+l,:)).^2));
			% dist_std(k,l) = sqrt(sum((stddist(k,:) - stddist(132+l,:)).^2));
			ind = intersect(find(~isnan(avgdistlo(k,:))),find(~isnan(avgdistlo(nump+l,:))));
			dist_avglo(k,l) = sqrt(sum((avgdistlo(k,ind) - avgdistlo(nump+l,ind)).^2));
			dist_stdlo(k,l) = sqrt(sum((stddistlo(k,ind) - stddistlo(nump+l,ind)).^2));
			ind = intersect(find(~isnan(avgdisthi(k,:))),find(~isnan(avgdisthi(nump+l,:))));
			dist_avghi(k,l) = sqrt(sum((avgdisthi(k,ind) - avgdisthi(nump+l,ind)).^2));
			dist_stdhi(k,l) = sqrt(sum((stddisthi(k,ind) - stddisthi(nump+l,ind)).^2));
		end
	end
	
	% costfunc = 0.5*dist_avg + 0.5*dist_std;
	costfunc = wlo*((1-wstd)*dist_avglo + wstd*dist_stdlo) + (1-wlo)*((1-wstd)*dist_avghi + wstd*dist_stdhi);
	
	[ind,jnd] = find(costfunc == min(min(costfunc)));
	zval = SSUstatStacks(basers,baseps(ind),comprs,jnd,0,van);
	bestmatch = [baseps(ind),jnd];
	
	load ~/WNVSixthRuns/AllRules_fixedvariables.mat
		
	figure(1)
	plot(fixedvars.tSpace,zval)
	hold on 
	plot(fixedvars.tSpace,2.575*ones(size(fixedvars.tSpace)),'k','LineWidth',2)
	plot(fixedvars.tSpace,1.96*ones(size(fixedvars.tSpace)),'r','LineWidth',2)
	plot(fixedvars.tSpace,-2.575*ones(size(fixedvars.tSpace)),'k','LineWidth',2)
	plot(fixedvars.tSpace,-1.96*ones(size(fixedvars.tSpace)),'r','LineWidth',2)
	hold off
	xlabel('Time')
	ylabel('z-score')
	
	
	
	figure(2)
	errorbar(fixedvars.tSpace,avgdistlo(ind,:),stddistlo(ind,:),'b')
	hold on
	errorbar(fixedvars.tSpace,avgdistlo(jnd+nump,:),stddistlo(jnd+nump,:),'r')
	errorbar(fixedvars.tSpace,avgdisthi(ind,:),stddisthi(ind,:),'b')
	errorbar(fixedvars.tSpace,avgdisthi(jnd+nump,:),stddisthi(jnd+nump,:),'r')
	hold off
	xlabel('Time')
	ylabel('Average distance')
		
	
	
		
		
		
		
		
		
		
		
		