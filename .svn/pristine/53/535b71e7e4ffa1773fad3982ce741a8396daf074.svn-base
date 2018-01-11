function zval = SSUstatStacks(basers,baseps,comprs,compps,graph,van,rmos,p)

%Compare rule set basers with param set baseps to each rule set/param set pair comprs(k), compps(k).
%graph == 1 means graph the results; == 0 means don't. Default behavior is no graph.
%van == 1 means use the altered data set where the mosquitoes are removed within a certain radius of the source. Default is use original unaltered data set.
%van == 1 and rmos == 0 means the vanished mosqitoes are given a distance of 0. van == 1 and rmos == 1 means the mosquitoes are removed from the data set when they reach the source
% p is the precision to use in the Wilcoxon rank sum test. Default is none. p <= 1 not accepted.

basedir='~/WNVSixthRuns/';

disp(['Evaluating rule set ', int2str(basers), ', param set ', int2str(baseps),'...'])
fname = fullfile(basedir,['StackAllTimes_RuleSet',sprintf('%02d',basers),'_paramset',sprintf('%03d',baseps),'.mat']);
load(fname);
if exist('van','var') && van == 1;
	basedist = edvanished;
else;
	basedist = eucdist;
end

% Ustat =[];
% sct=[];
zval = [];
for k = 1:length(comprs);
	disp(['Evaluating rule set ', int2str(comprs(k)), ', param set ', int2str(compps(k)),'...'])
	fname = fullfile(basedir,['StackAllTimes_RuleSet',sprintf('%02d',comprs(k)),'_paramset',sprintf('%03d',compps(k)),'.mat']);
	load(fname);
	if exist('van','var') && van == 1;
		compdist = edvanished;
	else;
		compdist = eucdist;
	end
	
	if exist('p','var') && ~isempty(p) && p > 1;
		for t = 1:size(basedist,2);
			%[Ustat(k,t),sct(k,t)] = WilcoxonRankSum(basedist(:,t),compdist(:,t),p);
			samp1 = round(basedist(:,t)*10^p)*10^(-p);
			samp2 = round(compdist(:,t)*10^p)*10^(-p);
			[sig,h,stats] = ranksum(samp1,samp2);
			zval(k,t) = stats.zval;
		end
	elseif exist('van','var') && van == 1 && exist('rmos','var') && rmos == 1;
		for t = 1:size(basedist,2);
			%[Ustat(k,t),sct(k,t)] = WilcoxonRankSum(basedist(:,t),compdist(:,t));
			ib = find(basedist(:,t) > 0);
			ic = find(compdist(:,t) > 0);
			[sig,h,stats] = ranksum(basedist(ib,t),compdist(ic,t));
			zval(k,t) = stats.zval;
		end
	else;
		for t = 1:size(basedist,2);
			%[Ustat(k,t),sct(k,t)] = WilcoxonRankSum(basedist(:,t),compdist(:,t));
			[sig,h,stats] = ranksum(basedist(:,t),compdist(:,t));
			zval(k,t) = stats.zval;
		end
	end
	
end

% N = size(basedist,1);
% [avg,stddev] = NormalApproxForRankSumTest(N,N,sct);
% z = discrete_zscore(Ustat,avg,stddev);
% % z = Zscore(Ustat,avg,stddev);

if exist('graph','var') && graph ==1;
	leg={};
	for k = 1:length(comprs);
		pv = SSparamsets(compps(k));
		leg{k}=['RS ', int2str(comprs(k)), ', PS [', num2str(pv(1)),', ',num2str(pv(2)),', ',num2str(pv(3)),']'];
	end

	load(fullfile(basedir,['AllRules_fixedvariables.mat']))
	figure
	plot(fixedvars.tSpace,zval)
	hold on 
	plot(fixedvars.tSpace,2.575*ones(size(fixedvars.tSpace)),'k','LineWidth',2)
	plot(fixedvars.tSpace,1.96*ones(size(fixedvars.tSpace)),'r','LineWidth',2)
	plot(fixedvars.tSpace,-2.575*ones(size(fixedvars.tSpace)),'k','LineWidth',2)
	plot(fixedvars.tSpace,-1.96*ones(size(fixedvars.tSpace)),'r','LineWidth',2)
	hold off
	legend(leg)
	pv = SSparamsets(baseps);
	title(['Rule set ',int2str(basers),', Param set [', num2str(pv(1)),', ',num2str(pv(2)),', ',num2str(pv(3)),']'])
	xlabel('Time')
	ylabel('z-score')
end

