%checkPredictionsMoreAveraging.m
	
	clear
	close all
	
	basedir = '~/WNVFullBatchRuns/ChangingNumHostsAverageChickPos';
	names = { 'Upwind','Downwind','Crosswind' };
	
	datamean=struct();
	datastd=struct();
	predictions=struct();
	newpredictions=struct();
	guesspreds=struct();
	
	for k = 1:5;
		for n = 1:3;
			alldata = [];
			for l = 1:10;
				fname = fullfile(basedir,[names{n},'_numchicks',int2str(k),'_iternum',int2str(l)]);
				[data,d,avgcwf,L,Nm,hr] = getSimResults(fname,1,40);
				alldata = [alldata; data];
			end
			md = mean(alldata);
			sd = std(alldata);
			if n < 3;
				preds = d*md(7:8)/Nm;
				predsnew = d*(md(7:8)+2*hr)/Nm;
				predsguess = d*(md(7:8)+hr/2)/Nm;
			else;
				preds = d*md(7:8)/Nm + 2*(md(5:6)/L)*avgcwf*d/Nm;
				predsnew = d*(md(7:8)+2*hr)/Nm + 2*((md(5:6)+2*hr)/L)*(avgcwf+hr)*d/Nm;
				predsguess = d*(md(7:8)+hr/2)/Nm + 2*(md(5:6)/L)*(avgcwf+hr)*d/Nm;
			end
			eval(['datamean.',names{n},'(k,:) = md(1:4);'])
			eval(['datastd.',names{n},'(k,:) = sd(1:4);'])
			eval(['predictions.',names{n},'(k,:) = preds;'])
			eval(['newpredictions.',names{n},'(k,:) = predsnew;'])
			eval(['guesspreds.',names{n},'(k,:) = predsguess;'])
			figure(n);
			title(names{n},'FontSize',24)
			hold on
			if k ~= 5; 
				errorbar(k,md(3),sd(3),'k.','MarkerSize',16)
				errorbar(10-k,md(2),sd(2),'k.','MarkerSize',16,'HandleVisibility','off')
				plot(10-k,predsguess(1),'ko')
				plot(k,predsguess(2),'ko','HandleVisibility','off')
			else;
				errorbar(k,(md(3)+md(2))./2,(sd(3)+sd(2))./2,'k.','MarkerSize',16)
				plot(k,(predsguess(1)+predsguess(2))./2,'ko')
			end
		end
	end
	
	for k=1:3;
		figure(k)
		ylim([0,0.35])
		h=legend('mean','fit');%,'left pred','right pred','left new','right new')	
		set(h,'Location','SouthEast')
		set(gca,'XTick',1:9)
		xlabel('Hosts per group','FontSize',24)
		ylabel('Proportion of mosquitoes locating group','FontSize',24)
		set(gca,'FontSize',24)
		set(gcf,'PaperSize',[8,6])
		set(gcf,'PaperPosition',[0,0,8,6])
	end		
				

	% figure(4)
	% avgtimes = [mean(datamean.Upwind(:,4)),mean(datamean.Downwind(:,4)),mean(datamean.Crosswind(:,4))];
	% stds = [mean(datamean.Upwind(:,4)),mean(datamean.Downwind(:,4)),mean(datamean.Crosswind(:,4))];
	% errorbar(1:3,avgtimes,stds,'.')
	% set(gca,'XTick',1:3,'XTickLabel',{ 'Upwind','Downwind','Crosswind' })
	% ylim([-50,600])
