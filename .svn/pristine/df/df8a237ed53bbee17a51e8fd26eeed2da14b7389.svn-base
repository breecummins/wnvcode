function [ksstats,ksmean, lenstats1, lenstats2, Trec] = KSviz(fname1,fname2,label1,label2,remove,ksstats,ksmean,graph);

	close all
	
	load(fname1);
	
	if ~exist('ksstats','var') || isempty(ksstats);
		if ~exist('remove','var');
			remove = 0;
		end
	
		[ksstats,lenstats1] = KSempiricaldist(fname1,remove);
		[ksmean,lenstats2] = KScompare(fname1,fname2,remove);
	end
	
	if ~exist('label1','var');
		ind = find(fname1=='R',1,'last');
		label1 = fname1(ind:ind+5);
	end
	
	if ~exist('label2','var');
		ind = find(fname2=='R',1,'last');
		label2 = fname2(ind:ind+5);
	end
	
	if exist('graph','var') && graph == 1;
		subind = [1:5:50,51:166];
		set(0,'DefaultAxesFontSize',24)
		hobj=errorbar(Trec(subind),ksstats(1,subind),ksstats(2,subind),ksstats(3,subind),'k');
		hAnnotation = get(hobj,'Annotation');
		hLegendEntry = get(hAnnotation,'LegendInformation');
		set(hLegendEntry,'IconDisplayStyle','off');
		hold on
		plot(Trec,ksstats(1,:),'k','LineWidth',2);
		plot(Trec,ksmean,'k--','LineWidth',2);
		xlabel('Time')
		ylabel('Mean KS statistic with 95% C.I.')
		axis([0,125,0,1])
		legend([label1,' distribution'],[label1,' vs ',label2])
		legend boxoff
		set(gcf, 'PaperSize', [8 6]);
		set(gcf, 'PaperPosition', [0,0,8,6]);
	end	
	