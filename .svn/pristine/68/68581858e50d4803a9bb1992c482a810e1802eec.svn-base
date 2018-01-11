% Compare corrected interpolations and densities to old data.
clear
close all

fnamenew='~/WNVNewHostSeeking_CorrectedInterpolation/ChangingDensityAverageChickPos/alldata.mat';
fnameold='~/WNV_Archived/WNVNewHostSeeking/ChangingDensityAverageChickPos_DensityAtOneQuarter/alldata.mat';


load(fnamenew)
datameannew = datamean;
datastdnew = datastd;

load(fnameold)
datameanold = datamean;
datastdold = datastd;

beta_points = Nc*(1:size(datamean,1))./Ad;

figure(1)	

subplot(3,1,3)
hold on
errorbar(beta_points/4.,datameanold(:,1,1),datastdold(:,1,1),'r.','MarkerSize',16)
subplot(3,1,2)
hold on
errorbar(beta_points/4.,datameanold(:,1,2),datastdold(:,1,2),'r^','MarkerSize',7,'MarkerFaceColor','r')
subplot(3,1,1)
hold on
errorbar(beta_points/4.,datameanold(:,1,3),datastdold(:,1,3),'rp','MarkerSize',10,'MarkerFaceColor','r')

subplot(3,1,3)
hold on
errorbar(beta_points,datameannew(:,1,1),datastdnew(:,1,1),'k.','MarkerSize',16)
ylim([0.15,0.45])
ylabel('P, UW','FontSize',24)
set(gca,'XTick',beta_points,'XTickLabel',round(beta_points*1000)/10,'FontSize',24)
xlabel('\beta\times100%','FontSize',24)
subplot(3,1,2)
hold on
errorbar(beta_points,datameannew(:,1,2),datastdnew(:,1,2),'k^','MarkerSize',7,'MarkerFaceColor','k')
ylim([0.15,0.45])
ylabel('P, DW','FontSize',24)
set(gca,'XTick',beta_points,'XTickLabel',[],'FontSize',24)
subplot(3,1,1)
hold on
errorbar(beta_points,datameannew(:,1,3),datastdnew(:,1,3),'kp','MarkerSize',10,'MarkerFaceColor','k')
ylim([0.3,0.6])
set(gca,'XTick',beta_points,'XTickLabel',[],'FontSize',24)
ylabel('P, CW','FontSize',24)

for k = 1:3;
	h = subplot(3,1,k);
	pos=get(h,'pos');
	pos(2) = pos(2) + 0.025;
	pos(4) = pos(4)+0.025;
	set(h,'pos',pos);
end

set(gcf,'PaperSize',[8,6])
set(gcf,'PaperPosition',[0,0,8,6])



newdata(:,1) = [datameanold(:,1,1); datameannew(:,1,1)];
newdata(:,2) = [datameanold(:,1,2); datameannew(:,1,2)];
newdata(:,3) = [datameanold(:,1,3); datameannew(:,1,3)];

sqrtbeta = sqrt([beta_points/4.,beta_points]);
c11 = sum( (newdata(:,1) - sqrtbeta.').*(1-sqrtbeta.') )./sum( (1-sqrtbeta).^2 );
c12 = sum( (newdata(:,2) - sqrtbeta.').*(1-sqrtbeta.') )./sum( (1-sqrtbeta).^2 );
c13 = sum( (newdata(:,3) - sqrtbeta.').*(1-sqrtbeta.') )./sum( (1-sqrtbeta).^2 );
beta1 = sqrt(Nc*(0.1:0.05:size(datamean,1)+0.75))./sqrt(Ad);

figure(2)	

subplot(3,1,3)
hold on
errorbar(sqrtbeta(1:end/2),datameanold(:,1,1),datastdold(:,1,1),'r.','MarkerSize',16)
subplot(3,1,2)
hold on
errorbar(sqrtbeta(1:end/2),datameanold(:,1,2),datastdold(:,1,2),'r^','MarkerSize',7,'MarkerFaceColor','r')
subplot(3,1,1)
hold on
errorbar(sqrtbeta(1:end/2),datameanold(:,1,3),datastdold(:,1,3),'rp','MarkerSize',10,'MarkerFaceColor','r')

subplot(3,1,3)
hold on
errorbar(sqrtbeta(end/2+1:end),datameannew(:,1,1),datastdnew(:,1,1),'k.','MarkerSize',16)
subplot(3,1,2)
hold on
errorbar(sqrtbeta(end/2+1:end),datameannew(:,1,2),datastdnew(:,1,2),'k^','MarkerSize',7,'MarkerFaceColor','k')
subplot(3,1,1)
hold on
errorbar(sqrtbeta(end/2+1:end),datameannew(:,1,3),datastdnew(:,1,3),'kp','MarkerSize',10,'MarkerFaceColor','k')

subplot(3,1,1)
plot(beta1, beta1*(1-c13)+c13,'k--','LineWidth',1.5)
set(gca,'XTick',sqrtbeta(end/2+1:2:end),'XTickLabel',[],'FontSize',24)
ylabel('P, CW','FontSize',24)
axis([0,0.3,0.27,0.57])

subplot(3,1,2)
plot(beta1, beta1*(1-c12)+c12,'k-','LineWidth',1.5)
set(gca,'XTick',sqrtbeta(end/2+1:2:end),'XTickLabel',[],'FontSize',24)
ylabel('P, DW','FontSize',24)
axis([0,0.3,0.15,0.45])

subplot(3,1,3)
plot(beta1, beta1*(1-c11)+c11,'k:','LineWidth',1.5)
set(gca,'XTick',sqrtbeta(end/2+1:2:end),'XTickLabel',round(sqrtbeta(end/2+1:2:end)*1000)/10,'FontSize',24)
xlabel('\beta^{1/2}\times100%','FontSize',24)
ylabel('P, UW','FontSize',24)
axis([0,0.3,0.15,0.45])

for k = 1:3;
	h = subplot(3,1,k);
	pos=get(h,'pos');
	pos(2) = pos(2) + 0.025;
	pos(4) = pos(4)+0.025;
	set(h,'pos',pos);
end

set(gcf,'PaperSize',[8,6])
set(gcf,'PaperPosition',[0,0,8,6])






%Compare temporal host-seeking method with gradient method.

% 
% 
% wind = {'Upwind','Downwind','Crosswind'};
% 
% data1 = zeros(0,0,0,2);
% data2 = zeros(0,0,0,2);
% means1 = zeros(0,0,2);
% stds1 = zeros(0,0,2);
% means2 = zeros(0,0,2);
% stds2 = zeros(0,0,2);
% 
% for c=1:3;
% 	name = wind{c};
% 	for k =1:5;
% 		
% 		% load data files
% 		% fname1=['~/WNVNewHostSeeking/',name,'_unifdens',int2str(k)];
% 		% fname2=['~/WNVFullBatchRuns/ChangingDensityAverageChickPos_Uniform/',name,'_numchicks',int2str(k)];
% 		% 
% 		
% 		% extract mosquito data
% 		for l=1:length(fieldnames(a1))/3;
% 			results = eval(['a1.results',sprintf('%02d',l)]);
% 			data1(c,k,l,1) = length(results.whichchicken)/p.Nm;
% 			data1(c,k,l,2) = mean(results.tmfinal - results.tmentrance);
% 			means1(c,k,:) = mean(squeeze(data1(c,k,:,:)));
% 			stds1(c,k,:) = std(squeeze(data1(c,k,:,:)));
% 		
% 			results = eval(['a2.results',sprintf('%02d',l)]);
% 			data2(c,k,l,1) = length(results.whichchicken)/p.Nm;
% 			data2(c,k,l,2) = mean(results.tmfinal - results.tmentrance);
% 			means2(c,k,:) = mean(squeeze(data2(c,k,:,:)));
% 			stds2(c,k,:) = std(squeeze(data2(c,k,:,:)));
% 			
% 		end
% 	end
% end
% 
% colors1={'bs','bo','b^'};
% colors2={'rs','ro','r^'};
% 
% figure(1)
% hold on
% for n = 1:3;
% 	if n == 1;
% 		fudge = -0.1;
% 	elseif n == 2;
% 		fudge = 0.1;
% 	elseif n == 3;
% 		fudge = 0;
% 	end
% 			 
% 	errorbar((1:5)+fudge,squeeze(means1(n,:,1)),squeeze(stds1(n,:,1)),colors1{n})
% 	errorbar((1:5)+fudge,squeeze(means2(n,:,1)),squeeze(stds2(n,:,1)),colors2{n})
% end
% 
% ylim([0,0.5])
% legend({'UW New','UW Grad','DW New', 'DW Grad', 'CW New', 'CW Grad'},'Location','BestOutside');
% set(gca,'XTick',1:5)
% xlabel('ft^2 per chicken','FontSize',24)
% ylabel('Prop mosquitoes finding group','FontSize',24)
% set(gca,'FontSize',24)
% set(gcf,'PaperSize',[8,6])
% set(gcf,'PaperPosition',[0,0,8,6])
% 
% figure(2)
% hold on
% for n = 1:3; 
% 	errorbar(1:5,squeeze(means1(n,:,2)),squeeze(stds1(n,:,2)),colors1{n})
% 	errorbar(1:5,squeeze(means2(n,:,2)),squeeze(stds2(n,:,2)),colors2{n})
% end
% 
% legend({'UW New','UW Grad','DW New', 'DW Grad', 'CW New', 'CW Grad'},'Location','BestOutside');
% set(gca,'XTick',1:5)
% xlabel('ft^2 per chicken','FontSize',24)
% ylabel('Average time to host','FontSize',24)
% set(gca,'FontSize',24)
% set(gcf,'PaperSize',[8,6])
% set(gcf,'PaperPosition',[0,0,8,6])
% 
% 
% 
