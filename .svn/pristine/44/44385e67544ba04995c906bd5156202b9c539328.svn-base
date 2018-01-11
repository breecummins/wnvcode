function SSViewMosqProportion(rsets,psets,stdflag,perturb)

% Find the mean proportion of agents that have located the source for each rsets(k), psets(k) during all runs. If stdflag == 1, graph the standard deviations. If perturb == 1, use the perturbation data.

basedir = '~/WNVSixthRuns/';

load(fullfile(basedir,['AllRules_fixedvariables']))
Nm = fixedvars.Nm;

avgfound=zeros(length(rsets),length(fixedvars.tSpace));
stdfound=zeros(length(rsets),length(fixedvars.tSpace));

tic
for k = 1:length(rsets)
	if mod(k,10) == 0;
		disp([int2str(k), ' of ', int2str(length(rsets)),' rule/parameter set pairs.'])
	end
	if perturb == 1;
		load(fullfile(basedir,['StackAllTimesPerturb_RuleSet',sprintf('%02d',rsets(k)),'_paramset',sprintf('%03d',psets(k))]))
	else;
		load(fullfile(basedir,['StackAllTimes_RuleSet',sprintf('%02d',rsets(k)),'_paramset',sprintf('%03d',psets(k))]))
	end
	for t = 1:size(edvanished,2);
		tempfound = [];
		for s = 1:25;
			snd = (s-1)*Nm+1:s*Nm;
			tempfound(s) = sum(edvanished(snd,t)==0);
		end
		avgfound(k,t) = mean(tempfound./Nm);
		stdfound(k,t) = std(tempfound./Nm);
	end
end
toc


leg={};
for k = 1:length(rsets)
	pv = SSparamsets(rsets(k),psets(k));
	leg{end+1} = ['RS ',int2str(rsets(k)),', PS [', num2str(pv(1)),', ',num2str(pv(2)),', ',int2str(round(12*pv(3)/pi)),'\pi/12]'];;
end

figure
hold on
sparind = [1:4:41,43:2:81,82:length(fixedvars.tSpace)];
m = size(avgfound,1);
clr = get(0,'DefaultAxesColorOrder');
for k = 1:m;
	ind = find(avgfound(k,:)>0);
	if stdflag == 1;  %plot errorbars first so that means so up better against the bars
		% newind = intersect(ind,sparind(k:m:end));
		newind = intersect(ind,sparind(1:5:end));
		if k<size(clr,1);
			hobj=errorbar(fixedvars.tSpace(newind),avgfound(k,newind),stdfound(k,newind),'','Color',clr(k,:));
		else;
			nk = mod(k,size(clr,1))+1;
			hobj=errorbar(fixedvars.tSpace(newind),avgfound(k,newind),stdfound(k,newind),'','Color',clr(nk,:));
		end
		hAnnotation = get(hobj,'Annotation');
		hLegendEntry = get(hAnnotation,'LegendInformation');
		set(hLegendEntry,'IconDisplayStyle','off')
	end
end
for k = 1:m; %plot means secod so that they show up better
	ind = find(avgfound(k,:)>0);
	if k<size(clr,1);
		plot(fixedvars.tSpace(ind),avgfound(k,ind),'Color',clr(k,:),'LineWidth',2)
	else;
		nk = mod(k,size(clr,1))+1;
		plot(fixedvars.tSpace(ind),avgfound(k,ind),'--','Color',clr(nk,:),'LineWidth',2)
	end		
end
set(gca,'FontSize',24)
legend(leg,'FontSize',16,'Location','NorthEastOutside')
xlabel('Time','FontSize',24)
ylabel('Proportion of agents at source','FontSize',24)
axis([0,125,0,1])

