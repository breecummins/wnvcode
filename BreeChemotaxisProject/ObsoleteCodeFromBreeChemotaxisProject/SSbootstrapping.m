function [Ustat,zscore] = SSbootstrapping(basers,baseps,comprs,compps,numboot,numsamp,p,graph);
	
	
	%Compare rule set basers with param set baseps to each rule set/param set pair comprs(k), compps(k). Use bootstrapping numboot times with numsamp each time (rather than one comparison).
	% p is the precision to use in the Wilcoxon rank sum test. Default is none. 
	%graph == 1 means graph the results; == 0 means don't. Default behavior is no graph.

	basedir='~/WNVSixthRuns/';

	if nargin < 7 || isempty(p) || p <= 1;
		pflag = 0;
	else;
		pflag = 1;
	end

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
	
	try;
		disp(['Evaluating rule set ', int2str(basers), ', param set ', int2str(baseps),'...'])
		load(fullfile(basedir,['StackAllTimes_RuleSet',sprintf('%02d',basers),'_paramset',sprintf('%03d',baseps),'.mat']))
		basedist = eucdist;
	catch;
		basedist=stackfilesalltimes(basers,baseps,1,basedir);
	end

	Ustat =[];
	sct=[];
	
	for k = 1:length(comprs);
		disp(['Evaluating rule set ', int2str(comprs(k)), ', param set ', int2str(compps(k)),'...'])
		try;	
			load(fullfile(basedir,['StackAllTimes_RuleSet',sprintf('%02d',comprs(k)),'_paramset',sprintf('%03d',compps(k)),'.mat']))
			compdist = eucdist;
		catch;
			compdist=stackfilesalltimes(comprs(k),compps(k),1,basedir);
		end	
		
		tempU = [];
		temps = [];

		for b = 1:numboot;
			disp(['Bootstrap repetition #', int2str(b)])
			ivec1 = 1+round(4999*rand(1,numsamp));
			ivec2 = 1+round(4999*rand(1,numsamp));
			for t = 1:size(basedist,2);
				if pflag;
					[tempU(b,t),temps(b,t)] = WilcoxonRankSum(basedist(ivec1,t),compdist(ivec2,t),p);
				else;
					tempU(b,t) = WilcoxonRankSum(basedist(ivec1,t),compdist(ivec2,t));
				end
			end
		end			
		if pflag;
			sct(k,:) = mean(temps,1);
		else;
			sct(k,:) = zeros(1,size(basedist,2));
		end										
		Ustat(k,:) = mean(tempU,1);

	end

	N = numsamp;
	[avg,stddev] = NormalApproxForRankSumTest(N,N,sct);
	zscore=(Ustat - avg)./stddev;

	if nargin >7 && graph ==1;
		leg={};
		for k = 1:length(comprs);
			pv = SSparamsets(compps(k));
			leg{k}=['RS ', int2str(comprs(k)), ', PS [', num2str(pv(1)),', ',num2str(pv(2)),', ',num2str(pv(3)),']'];
		end

		load(fullfile(basedir,['AllRules_fixedvariables.mat']))
		plot(fixedvars.tSpace,zscore)
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
		ylabel('Standard deviations')
	end

	