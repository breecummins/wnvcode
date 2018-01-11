function NormalVars = SSVizNormalBetweenRuleSets2(basemethod,basepsets,compmethods,comppsets,statfnameend,pf,rf)

	%pf=0 means don't graph, pf=1 means graph
	%rf=0 means don't save graphs, rf=1 means do save graphs
	% basemethod is the rule set to which I am comparing the rulesets in compmethods.
	% basepsets is a vector of parameter set identifying numbers that I will compare to the parameter sets in comppsets for each rule set. comppsets is a matrix with length(basepsets) columns. The n-th column contains the parameter sets to compare to basepsets(n).
	%statfnameend is of the form '_somecharacters' and is the specific designator of the stats run desired.

%%%%%%%%%%%%%%%%% change these when changing the data set to work with. Other data sets may necessitate other changes in the code. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
newfnamestart = '~/WNVFifthRuns/NormalVars';
statfnamestart = '~/WNVFifthRuns/Ustat';
load ~/WNVFifthRuns/AllRules_fixedvariables.mat %get fixed variables
tSpace = fixedvars.tSpace;
Nm = fixedvars.Nm;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
set(0,'DefaultAxesFontSize',12)

[avg,stddev] = NormalApproxForRankSumTest(fixedvars.Nm,fixedvars.Nm);
x=0:fixedvars.Nm^2;
norm_vals = NormalDistribution(avg,stddev,x);
scalefactor=0.85*10^5; 
numbins = 50;
maxyaxis = 50;

for bp = 1:length(basepsets);
	disp(basepsets(bp))
	load([statfnamestart,'_ruleset',sprintf('%02d',basemethod),'_paramset',sprintf('%03d',basepsets(bp)),statfnameend])
	NormalVars = zeros(2,size(comppsets,1),length(compmethods),length(tSpace));
	if exist('Ustat_self','var');
		flag = 1;
		SelfNormalVars = zeros(2,length(tSpace));
	else;
		flag =0;
		SelfNormalVars = [];
	end
	for m=1:length(compmethods);
		for p=1:size(comppsets,1); 
			for t=1:length(tSpace);
				mu = mean(Ustat(:,p,m,t));
				sig2 = var(Ustat(:,p,m,t));
				vals = NormalDistribution(mu,sqrt(sig2),x);
				NormalVars(:,p,m,t) = [mu;sig2];
				if flag;
					mu = mean(Ustat_self(:,t));
					sig2 = var(Ustat_self(:,t));
					selfvals = NormalDistribution(mu,sqrt(sig2),x);
					SelfNormalVars(:,t) = [mu;sig2];
				end
				if pf == 1;
					plot(scalefactor*norm_vals,'k-','LineWidth',2)
					hold on
					if flag;
						plot(scalefactor*max(norm_vals)/max(selfvals)*selfvals,'r')
						leg = { 'Ref distribution','Calculated Ref Dist',['RS ',int2str(basemethod),', PSet ',int2str(basepsets(bp)),' vs RS ',int2str(compmethods(m)),', PSet ',int2str(comppsets(p,bp))], 'Normal approx' };
					else;
						leg={ 'Ref distribution',['RS ',int2str(basemethod),', PSet ',int2str(basepsets(bp)),' vs RS ',int2str(compmethods(m)),', PSet ',int2str(comppsets(p,bp))], 'Normal approx' };
					end
					hist(Ustat(:,p,m,t),numbins);
					h = findobj(gca,'Type','patch');
					set(h,'FaceColor','None','EdgeColor','b')
					axis([0,fixedvars.Nm^2,0,maxyaxis])
					vals=scalefactor*max(norm_vals)/max(vals)*vals;
					plot(vals,'c-','LineWidth',2)
					title(['U statistic, time = ',num2str(tSpace(t))])
					legend(leg)
					hold off
					pause(.001)
					if rf == 1;
						picname = ['ruleset',int2str(basemethod),'pset',int2str(basepsets(bp)),'_vs_ruleset',int2str(compmethods(m)),'pset',int2str(comppsets(p,bp))];
						fname = ['~/WNVFifthRuns/movies/Ustat_',picname,'_',sprintf('%03d',t),'.png'];
						saveas(gcf,fname,'png')
					end
				end
			end
		end
	end

	fname=[newfnamestart,'_ruleset',sprintf('%02d',basemethod),'_paramset',sprintf('%03d',basepsets(bp)),statfnameend,'.mat'];
	save(fname,'NormalVars','SelfNormalVars','tSpace','basemethod','basepsets','compmethods','comppsets','Nm');
end
