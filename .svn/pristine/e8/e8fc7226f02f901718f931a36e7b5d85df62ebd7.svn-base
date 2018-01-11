%checkPredictions_meander.m
	
	clear
	close all
	
	basedir = '~/WNVFullBatchRuns/CompareFlows';
	names = { 'Upwind','Downwind','Crosswind' };
	
	datamean=zeros(0,0,0);
	datastd=zeros(0,0,0);
	datastop=zeros(0,0,0);
	datastopstd=zeros(0,0,0);
	colors={'b','k','r'};
	
	for k = [2,3]; %data set 1 was flawed -- mosquitoes released too early
		for n = 1:3;
			fname = fullfile(basedir,[names{n},'_numchicks',int2str(k)]);
			[data,d,l,avgcwf,L,Nm,hr] = getSimResults_density(fname,0);
			md = mean(data);
			sd = std(data);
			datamean(k-1,:,n) = md;
			datastd(k-1,:,n) = sd;
			data = getSimResults_stop(fname,350);
			md = mean(data);
			sd = std(data);
			datastop(k-1,:,n) = md;
			datastopstd(k-1,:,n) = sd;
		end
	end
	
	% figure
	% hold on
	% xaxis = 1:size(datamean,1);
	% errorbar(xaxis,datamean(:,1,1),datastd(:,1,1),'k.','MarkerSize',16)
	% errorbar(xaxis,datamean(:,1,2),datastd(:,1,2),'k^','MarkerSize',7,'MarkerFaceColor','k')
	% errorbar(xaxis,datamean(:,1,3),datastd(:,1,3),'kp','MarkerSize',10,'MarkerFaceColor','k')
	% 
	% ylim([0,0.75])
	% legend({'Upwind','Downwind','Crosswind'},'Orientation','Horizontal','Location','NorthOutside');
	% set(gca,'XTick',1:2,'XTickLabel',{'straight','meander'})
	% xlabel('Plume Type','FontSize',24)
	% ylabel('Prop mosquitoes finding group','FontSize',24)
	% set(gca,'FontSize',24)
	% set(gcf,'PaperSize',[8,6])
	% set(gcf,'PaperPosition',[0,0,8,6])
	% 
	% figure
	% hold on
	% xaxis = 1:size(datamean,1);
	% errorbar(xaxis,datamean(:,2,1),datastd(:,1,1),'k.','MarkerSize',16)
	% errorbar(xaxis,datamean(:,2,2),datastd(:,1,2),'k^','MarkerSize',7,'MarkerFaceColor','k')
	% errorbar(xaxis,datamean(:,2,3),datastd(:,1,3),'kp','MarkerSize',10,'MarkerFaceColor','k')
	% 
	% % ylim([0,0.75])
	% legend({'Upwind','Downwind','Crosswind'},'Orientation','Horizontal','Location','NorthOutside');
	% set(gca,'XTick',1:2,'XTickLabel',{'straight','meander'})
	% xlabel('Plume Type','FontSize',24)
	% ylabel('Average time to host','FontSize',24)
	% set(gca,'FontSize',24)
	% set(gcf,'PaperSize',[8,6])
	% set(gcf,'PaperPosition',[0,0,8,6])
	
				

