%checkPredictions_density_uniform.m
	
	clear
	close all
	
	basedir = '~/WNVFullBatchRuns/ChangingDensityAverageChickPos_Uniform';
	names = { 'Upwind','Downwind','Crosswind' };
	
	datamean=struct();
	datastd=struct();
	modelfit=struct();
	colors={'b','k','r'};
	
	for k = 1:5;
		for n = 1:3;
			fname = fullfile(basedir,[names{n},'_numchicks',int2str(k)]);
			[data,d,l,avgcwf,L,Nm,hr] = getSimResults_density(fname,1,30);
			md = mean(data);
			sd = std(data);
			if n < 3;
				fit = d*(md(4)+hr)/Nm;
			else;
				fit = d*(md(4)+hr)/Nm + 2*((md(3))/L)*(avgcwf+hr)*d/Nm;
			end
			eval(['datamean.',names{n},'(k,:) = md(1:4);'])
			eval(['datastd.',names{n},'(k,:) = sd(1:4);'])
			eval(['modelfit.',names{n},'(k,:) = fit;'])
			hold on
			h1=errorbar(k,md(1),sd(1),[colors{n},'.'],'LineWidth',2,'MarkerSize',16);
			%h2=plot(k,fit,[colors{n},'^']);
		end
	end
	
	ylim([0,0.5])
	%legend({'UW runs','UW fit','DW runs','DW fit','CW runs','CW fit'},'Orientation','Horizontal','Location','NorthOutside');
	legend({'Upwind','Downwind','Crosswind'},'Orientation','Horizontal','Location','NorthOutside');
	set(gca,'XTick',1:5)
	xlabel('ft^2 per chicken','FontSize',24)
	ylabel('Prop mosquitoes finding group','FontSize',24)
	set(gca,'FontSize',24)
	set(gcf,'PaperSize',[8,6])
	set(gcf,'PaperPosition',[0,0,8,6])
				

	% figure(4)
	% avgtimes = [mean(datamean.Upwind(:,4)),mean(datamean.Downwind(:,4)),mean(datamean.Crosswind(:,4))];
	% stds = [mean(datamean.Upwind(:,4)),mean(datamean.Downwind(:,4)),mean(datamean.Crosswind(:,4))];
	% errorbar(1:3,avgtimes,stds,'.')
	% set(gca,'XTick',1:3,'XTickLabel',{ 'Upwind','Downwind','Crosswind' })
	% ylim([-50,600])
