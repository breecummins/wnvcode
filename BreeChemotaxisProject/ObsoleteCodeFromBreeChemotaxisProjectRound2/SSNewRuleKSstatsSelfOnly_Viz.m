function SSNewRuleKSstatsSelfOnly_Viz(baseps,ksmean_self,ks025percent_self,ks975percent_self,stdflag);
		

	load ~/WNVNewRule/Rule02_fixedvariables.mat  %get fixed variables
	tS = fixedvars.tSpace;

	leg={};
	for k = 1:length(baseps);
		leg{k}=['PS ',int2str(baseps(k))];
	end

	clr=get(0,'DefaultAxesColorOrder');
	figure
	hold on
	sparind = [1:4:41,43:2:81,82:length(fixedvars.tSpace)];
	for k=baseps;
		plot(tS(1:length(ksmean_self{k})),ksmean_self{k},'LineWidth',2,'Color',clr(k,:))
		if stdflag == 1;
			newind = intersect(1:length(ksmean_self{k}),[sparind(k:length(baseps):end),length(ksmean_self{k})]);
			hobj=errorbar(tS(newind),ksmean_self{k}(newind),ks025percent_self{k}(newind)-ksmean_self{k}(newind),ks975percent_self{k}(newind)-ksmean_self{k}(newind),'.','Color',clr(k,:));
			hAnnotation = get(hobj,'Annotation');
			hLegendEntry = get(hAnnotation,'LegendInformation');
			set(hLegendEntry,'IconDisplayStyle','off')
		end
	end
	hold off
	legend(leg,'FontSize',16);
	xlabel('Time','FontSize',24)
	ylabel('Mean KS, 95% C.I.','FontSize',24)
	set(gca,'FontSize',24)
	axis([0,125,0,0.5])
