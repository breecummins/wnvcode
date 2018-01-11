% plothostrulefigs.m

clear
close all

basedirrand = '~/WNV_Archived/WNVNewHostSeeking/NonSeeking/RandWalkOnly';
basedirsamp = '~/WNV_Archived/WNVNewHostSeeking/CompareFlows';
basedirgrad = '~/WNV_Archived/WNVFullBatchRuns/CompareFlows';
fnamestrsamp = 'velprofile';
fnamestrgrad = 'numchicks';
longestflight = 1500;

% collateSimdata_squiggly(basedirrand,fnamestrsamp,longestflight);
% collateSimdata_squiggly(basedirsamp,fnamestrsamp,longestflight);
% collateSimdata_squiggly(basedirgrad,fnamestrgrad,longestflight);

load(fullfile(basedirrand,'alldata.mat'))
randnums=[datamean(2,1,2),datastd(2,1,2),datastop(2,1,2),datastopstd(2,1,2)];

load(fullfile(basedirsamp,'alldata.mat'))
sampnums=[];
for k=1:3;
	sampnums(k,:) = [datamean(2,1,k),datastd(2,1,k),datastop(2,1,k),datastopstd(2,1,k)];
end

load(fullfile(basedirgrad,'alldata.mat'))
gradnums=[];
for k=1:3;
	gradnums(k,:) = [datamean(2,1,k),datastd(2,1,k),datastop(2,1,k),datastopstd(2,1,k)];
end

for k = 1:3;
	Pmat(k,:) = [randnums(1),gradnums(k,1),sampnums(k,1)];
	Ptruncmat(k,:) = [randnums(3),gradnums(k,3),sampnums(k,3)];
end

% figure(1)
% hold on
% bar(Pmat)
% colormap gray
% set(gca,'FontSize',24,'XTick',[1,2,3],'XTickLabel',{'UW','DW','CW'})
% legend({'RW','gradient','sampling'},'Orientation','Horizontal','Location','NorthOutside')
% errorbar((1:3).' - 0.225,Pmat(:,1),2*randnums(2)*ones(3,1),'k+')
% errorbar((1:3).',Pmat(:,2),2*gradnums(:,2),'k+')
% errorbar(0.225+(1:3).',Pmat(:,3),2*sampnums(:,2),'k+')
% hold off
% ylim([0,0.7])
% ylabel('P')
	
figure(2)
hold on
bar(Ptruncmat)
colormap gray
set(gca,'FontSize',16,'XTick',[1,2,3],'XTickLabel',{'UW','DW','CW'})
legend({'RW','G','S'},'Orientation','Horizontal','Location','NorthOutside')
errorbar((1:3).' - 0.225,Ptruncmat(:,1),2*randnums(4)*ones(3,1),'k','LineStyle','none')
errorbar((1:3).',Ptruncmat(:,2),2*gradnums(:,4),'k','LineStyle','none')
errorbar(0.225+(1:3).',Ptruncmat(:,3),2*sampnums(:,4),'k','LineStyle','none')
hold off
ylim([0,0.7])
ylabel('P')
	
sz=[0, 0, 12.35/2.54, 0.75*12.35/2.54];
set(gcf,'PaperSize',sz(3:4))                 
set(gcf,'PaperPosition',sz)      
saveas(2,'~/Figure3.eps')            
% print(2, '-r300', '~/testFig3.eps', '-deps');


