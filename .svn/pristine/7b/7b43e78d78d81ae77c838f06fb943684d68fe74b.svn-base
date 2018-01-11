%plot2groupratios.m
	
	clear
	close all
	
	basedir = '~/WNVFullBatchRuns/ChangingNumHostsAverageChickPos';
	names = { 'Upwind','Downwind','Crosswind' };
	
	datamean=struct();
	datastd=struct();
	smallmean=struct();
	largemean=struct();
	total=zeros(0,0);
	
	for k = 1:5;
		for n = 1:3;
			alldata = [];
			for l = 1:10;
				fname = fullfile(basedir,[names{n},'_numchicks',int2str(k),'_iternum',int2str(l)]);
				data = getSimResults(fname,0);
				alldata = [alldata; data];
			end
			smallgroup = alldata(:,3);
			largegroup = alldata(:,2);
			ratios = smallgroup./largegroup;
			md = mean(ratios);
			sd = std(ratios);
			
			eval(['datamean.',names{n},'(k)= md;'])
			eval(['datastd.',names{n},'(k)= sd;'])
			eval(['smallmean.',names{n},'(k)= mean(smallgroup);'])
			eval(['largemean.',names{n},'(k)= mean(largegroup);'])
			total(k,n)= mean(largegroup+smallgroup);						
		end
	end
	
	mean(total)
	std(total)
	figure
	hold on
	errorbar((1:5)./(10-(1:5))-0.02,eval(['datamean.',names{1}]),eval(['datastd.',names{1}]),'k.','MarkerSize',16)
	errorbar((1:5)./(10-(1:5))+0.02,eval(['datamean.',names{2}]),eval(['datastd.',names{2}]),'k^','MarkerSize',7,'MarkerFaceColor','k')
	errorbar((1:5)./(10-(1:5)),eval(['datamean.',names{3}]),eval(['datastd.',names{3}]),'kp','MarkerSize',10,'MarkerFaceColor','k')	
	plot([0,1],[0,1],'k-')
	plot([0,1],[1,1],'k-')
	
	axis([0,1.25,0,1.3])
	legend({'Upwind','Downwind','Crosswind'},'Location','SouthEast')
	set(gca,'XTick',[1/9,2/8,3/7,4/6,5/5],'XTickLabel',{'1/9','2/8','3/7','4/6','5/5'})
	xlabel('Ratio of number of hosts (S/L)','FontSize',24)
	ylabel('Ratio of contacts (S/L)','FontSize',24)
	set(gca,'FontSize',24)
	set(gcf,'PaperSize',[8,6])
	set(gcf,'PaperPosition',[0,0,8,6])

