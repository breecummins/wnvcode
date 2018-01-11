function SSNewRuleKSstats_Viz(baseps,compps,ksmean,ksmean_self,ks025percent_self,ks975percent_self);
	
 
	load ~/WNVNewRule/Rule02_fixedvariables.mat  %get fixed variables
	tS = fixedvars.tSpace;
	
	basestr = ['PS ', int2str(baseps)];	
	leg={ [basestr,' vs ',basestr]};	
	for k = 1:length(compps);
		leg{end+1}=[basestr, ' vs PS ', int2str(compps(k))];
	end
	
	m = length(ksmean);
	% lastt = length(ksmean_self);
	l = [];
	for k=1:m;
		l(k) = length(ksmean{k});
	end
	lastt = min([l,length(ksmean_self)]);
	
	figure
	plot(tS(1:lastt),ksmean_self(1:lastt),'LineWidth',2)
	hold on
	sparind = [1:4:41,43:2:81,82:length(fixedvars.tSpace)];
	newind = intersect(1:lastt,sparind);
	hobj=errorbar(tS(newind),ksmean_self(newind),ks025percent_self(newind)-ksmean_self(newind),ks975percent_self(newind)-ksmean_self(newind),'.');
	hAnnotation = get(hobj,'Annotation');
	hLegendEntry = get(hAnnotation,'LegendInformation');
	set(hLegendEntry,'IconDisplayStyle','off')
	clr=get(0,'DefaultAxesColorOrder');
	for k=1:m;
		ltt = min(lastt,length(ksmean{k}));
		if k<size(clr,1);
			plot(tS(1:ltt),ksmean{k}(1:ltt),'Color',clr(k+1,:),'LineWidth',2)
		else;
			nk = mod(k,size(clr,1))+1;
			plot(tS(1:ltt),ksmean{k}(1:ltt),'--','Color',clr(nk,:),'LineWidth',2)
		end
	end
	hold off
	box off
	set(gca,'FontSize',24)
	legend(leg,'FontSize',16);
	xlabel('Time','FontSize',24)
	ylabel('Mean KS, 95% C.I.','FontSize',24)
	axis([0,90,0,0.5])
