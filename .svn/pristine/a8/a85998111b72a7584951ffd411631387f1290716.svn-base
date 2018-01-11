function testUstat(rsets,psets,num)

% Compare rule set rsets(1) with paramset psets(1) to rsets(2), psets(2). If num is not assigned, then all pairwise Ustats between runs are calculated; otherwise the two are compared using only run #num.

Ustat=[];

if nargin > 2;

	load(['~/WNVSixthRuns/AllRules_paramset',sprintf('%03d',psets(1)),'_run',sprintf('%02d',num)])
	ed1 = squeeze(EuclideanDist(:,rsets(1),:));
	load(['~/WNVSixthRuns/AllRules_paramset',sprintf('%03d',psets(2)),'_run',sprintf('%02d',num)])
	ed2 = squeeze(EuclideanDist(:,rsets(2),:));
	
	for t = 1:size(ed1,2);
		Ustat(t) = WilcoxonRankSum(ed1(:,t),ed2(:,t));
	end
	
	
else;
	c=0;
	for k = 1:25;
		load(['~/WNVSixthRuns/AllRules_paramset',sprintf('%03d',psets(1)),'_run',sprintf('%02d',k)])
		ed1 = squeeze(EuclideanDist(:,rsets(1),:));
		for l = 1:25;
			load(['~/WNVSixthRuns/AllRules_paramset',sprintf('%03d',psets(2)),'_run',sprintf('%02d',l)])
			ed2 = squeeze(EuclideanDist(:,rsets(2),:));
			clear EuclideanDist SpatialDistX SpatialDistY
			c=c+1;
			if mod(c,10) == 0;
				disp([int2str(c),' of 625.'])
			end
			for t = 1:size(ed1,2);
				Ustat(c,t) = WilcoxonRankSum(ed1(:,t),ed2(:,t));
			end
		end
	end
end

load ~/WNVSixthRuns/AllRules_fixedvariables

N=fixedvars.Nm;
[avg,stddev] = NormalApproxForRankSumTest(N,N);
val = mean(Ustat,1) - avg;
stddevsout=val/stddev;

figure(1)
plot(fixedvars.tSpace,stddevsout)
hold on 
plot(fixedvars.tSpace,2.575*ones(size(fixedvars.tSpace)),'k','LineWidth',2)
plot(fixedvars.tSpace,1.96*ones(size(fixedvars.tSpace)),'r','LineWidth',2)
plot(fixedvars.tSpace,-2.575*ones(size(fixedvars.tSpace)),'k','LineWidth',2)
plot(fixedvars.tSpace,-1.96*ones(size(fixedvars.tSpace)),'r','LineWidth',2)
hold off

figure(2)
plot(fixedvars.tSpace,mean(Ustat,1))
hold on 
plot(fixedvars.tSpace,N^2/2*ones(size(fixedvars.tSpace)),'k','LineWidth',2)
ylim([0,N^2])
hold off
