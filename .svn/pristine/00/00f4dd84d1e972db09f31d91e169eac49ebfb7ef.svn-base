function plot2groupratios(basedir)
	
	load(fullfile(basedir,'alldata.mat'));
		
	mean(total)
	std(total)
	figure
	hold on
	errorbar((1:5)./(10-(1:5))-0.02,datamean(:,1),datastd(:,1),'k.','MarkerSize',16)
	errorbar((1:5)./(10-(1:5))+0.02,datamean(:,2),datastd(:,2),'k^','MarkerSize',7,'MarkerFaceColor','k')
	errorbar((1:5)./(10-(1:5)),datamean(:,3),datastd(:,3),'kp','MarkerSize',10,'MarkerFaceColor','k')	
	plot([0,1],[0,1],'k-')
	plot([0,1],[1,1],'k-')
	
	axis([0,1.25,0,1.3])
	legend({'Upwind','Downwind','Crosswind'},'Location','SouthEast')
	set(gca,'XTick',[1/9,2/8,3/7,4/6,5/5],'XTickLabel',{'1/9','2/8','3/7','4/6','5/5'})
	xlabel('Ratio of number of hosts (S/L)','FontSize',16)
	ylabel('Ratio of contacts (S/L)','FontSize',16)
	set(gca,'FontSize',16)
	% set(gcf,'PaperSize',[8,6])
	% set(gcf,'PaperPosition',[0,0,8,6])

	sz=[0.0, 0.0, 12.35/2.54, 0.75*12.35/2.54];
	set(gcf,'PaperSize',sz(3:4))                 
	set(gcf,'PaperPosition',sz)      
	saveas(1,'~/Figure5.eps')            
	