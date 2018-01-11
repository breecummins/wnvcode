function SSPairwiseRunCompsKSstatSelfOnly_Viz(basers,baseps,ksmean_self,ks025percent_self,ks975percent_self,stdflag);
		

	load ~/WNVSixthRuns/AllRules_fixedvariables.mat  %get fixed variables
	tS = fixedvars.tSpace;

	leg={};
	for k = 1:length(basers);
		pv = SSparamsets(basers(k),baseps(k));
		leg{k}=['RS ', int2str(basers(k)), ', PS [', num2str(pv(1)),', ',num2str(pv(2)),', ',int2str(round(12*pv(3)/pi)),'\pi/12]'];
	end

	clr=get(0,'DefaultAxesColorOrder');
	figure
	hold on
	sparind = [1:4:41,43:2:81,82:length(fixedvars.tSpace)];
	m=length(ksmean_self);
	for k=1:m;
		plot(tS(1:length(ksmean_self{k})),ksmean_self{k},'LineWidth',2,'Color',clr(k,:))
		if stdflag == 1;
			newind = intersect(1:length(ksmean_self{k}),[sparind(k:m:end),length(ksmean_self{k})]);
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
