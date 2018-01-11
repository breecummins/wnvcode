function SSPairwiseRunCompsKSstat_Viz(basers,baseps,comprs,compps,ksmean,ksmean_self,ks025percent_self,ks975percent_self);
	
 
	load ~/WNVSixthRuns/AllRules_fixedvariables.mat  %get fixed variables
	tS = fixedvars.tSpace;
	
	pv = SSparamsets(basers,baseps);
	basestr =['RS ',int2str(basers),' PS [', num2str(pv(1)),', ',num2str(pv(2)),', ',int2str(round(12*pv(3)/pi)),'\pi/12]'];
	
	leg={ [basestr,' vs self']};	
	for k = 1:length(comprs);
		pv = SSparamsets(comprs(k),compps(k));
		leg{end+1}=[basestr, ' vs RS ', int2str(comprs(k)), ' PS [', num2str(pv(1)),', ',num2str(pv(2)),', ',int2str(round(12*pv(3)/pi)),'\pi/12]'];
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
	set(gca,'FontSize',24)
	legend(leg,'Location','NorthOutside','FontSize',16);
	xlabel('Time','FontSize',24)
	ylabel('Mean KS, 95% C.I.','FontSize',24)
	if basers == 10;
		axis([0,125,0,1])
	else;
		axis([0,90,0,0.5])
	end
