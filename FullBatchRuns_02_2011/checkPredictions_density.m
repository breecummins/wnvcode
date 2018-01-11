%checkPredictions_density.m
	
	clear
	close all
	
	load ~/WNVFullBatchRuns/ChangingDensityAverageChickPos/alldata.mat;
	
	Nc = 10; Ad = (10*100/2.54/12)^2; %area of domain in ft^2
	beta_points = Nc*(1:size(datamean,1))./Ad;
	beta1 = Nc*(0.25:0.05:size(datamean,1)+0.25)./Ad;
	
	
	figure(1)
	% hold on
	% errorbar(beta_points,datamean(:,1,1),datastd(:,1,1),'k.','MarkerSize',16)
	% errorbar(beta_points,datamean(:,1,2),datastd(:,1,2),'k^','MarkerSize',7,'MarkerFaceColor','k')
	% errorbar(beta_points,datamean(:,1,3),datastd(:,1,3),'kp','MarkerSize',10,'MarkerFaceColor','k')
	% 
	% %calculate fits
	% fitsuw = (datamean(:,4,1)+hr/2)/L; %assuming uniform entry of mosquitoes
	% fitsdw = (datamean(:,4,1)+hr)/L; %assuming uniform entry of mosquitoes
	% fitscw = (datamean(:,4,1)+hr)/L + 2*(datamean(:,3,1)/L)*avgcwfl/L; %assuming uniform entry of mosquitoes
	% plot(beta_points,fitsuw,'ko','MarkerSize',8)
	% plot(beta_points,fitsdw,'k^','MarkerSize',8)
	% plot(beta_points,fitscw,'kp','MarkerSize',12)
	% 
	% ylim([0.15,0.45])
	% [legend_h,object_h]=legend({'UW','DW','CW','UW fit','DW fit','CW fit'},'Orientation','Horizontal','Location','NorthOutside');
	% set(gca,'XTick',beta_points,'XTickLabel',round(beta_points*1000)/10)
	% xlabel('\beta\times100','FontSize',24)
	% ylabel('P','FontSize',24)
	% set(gca,'FontSize',24)
	% set(gcf,'PaperSize',[8,6])
	% set(gcf,'PaperPosition',[0,0,8,6])
	

	subplot(3,1,3)
	hold on
	errorbar(beta_points,datamean(:,1,1),datastd(:,1,1),'k.','MarkerSize',16)
	subplot(3,1,2)
	hold on
	errorbar(beta_points,datamean(:,1,2),datastd(:,1,2),'k^','MarkerSize',7,'MarkerFaceColor','k')
	subplot(3,1,1)
	hold on
	errorbar(beta_points,datamean(:,1,3),datastd(:,1,3),'kp','MarkerSize',10,'MarkerFaceColor','k')
	
	%calculate fits
	fitsuw = (datamean(:,4,1)+hr/2)/L; %assuming uniform entry of mosquitoes
	fitsdw = (datamean(:,4,1)+hr)/L; %assuming uniform entry of mosquitoes
	fitscw = (datamean(:,4,1)+hr)/L + 2*(datamean(:,3,1)/L)*avgcwfl/L; %assuming uniform entry of mosquitoes
	
	subplot(3,1,1);
	plot(beta_points,fitscw,'kp','MarkerSize',12)
	set(gca,'XTick',beta_points,'XTickLabel',[],'FontSize',24)
	ylabel('P, CW','FontSize',24)
	ylim([0.25,0.5])

	subplot(3,1,2);
	plot(beta_points,fitsdw,'k^','MarkerSize',8)
	set(gca,'XTick',beta_points,'XTickLabel',[],'FontSize',24)
	ylabel('P, DW','FontSize',24)
	ylim([0.1,0.35])
	
	subplot(3,1,3);
	plot(beta_points,fitsuw,'ko','MarkerSize',8)
	set(gca,'XTick',beta_points,'XTickLabel',round(beta_points*1000)/10,'FontSize',24)
	xlabel('\beta\times100','FontSize',24)
	ylabel('P, UW','FontSize',24)
	ylim([0.1,0.35])
	
	for k = 1:3;
		h = subplot(3,1,k);
		pos=get(h,'pos');
		pos(2) = pos(2) + 0.025;
		pos(4) = pos(4)+0.025;
		set(h,'pos',pos);
	end
	
	set(gcf,'PaperSize',[8,6])
	set(gcf,'PaperPosition',[0,0,8,6])
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
	figure(2)
	% hold on
	% errorbar(beta_points,datamean(:,1,1),datastd(:,1,1),'k.','MarkerSize',16)
	% errorbar(beta_points,datamean(:,1,2),datastd(:,1,2),'k^','MarkerSize',7,'MarkerFaceColor','k')
	% errorbar(beta_points,datamean(:,1,3),datastd(:,1,3),'kp','MarkerSize',10,'MarkerFaceColor','k')
	% 
	% % calculate intercepts
	% c1 = sum(datamean(:,1,1) - beta_points.')./sum(1-beta_points);
	% c2 = sum(datamean(:,1,2) - beta_points.')./sum(1-beta_points);
	% c3 = sum(datamean(:,1,3) - beta_points.')./sum(1-beta_points);
	% 
	% plot(beta1, beta1*(1-c1)+c1,'k:','LineWidth',1.5)
	% plot(beta1, beta1*(1-c2)+c2,'k-','LineWidth',1.5)
	% plot(beta1, beta1*(1-c3)+c3,'k--','LineWidth',1.5)
	% 
	% ylim([0.15,0.45])
	% [legend_h,object_h]=legend({'UW','DW','CW','UW fit','DW fit','CW fit'},'Orientation','Horizontal','Location','NorthOutside');
	% set(gca,'XTick',beta_points,'XTickLabel',round(beta_points*1000)/10)
	% xlabel('\beta\times100','FontSize',24)
	% ylabel('P','FontSize',24)
	% set(gca,'FontSize',24)
	% set(gcf,'PaperSize',[8,6])
	% set(gcf,'PaperPosition',[0,0,8,6])
	
	subplot(3,1,3)
	hold on
	errorbar(beta_points,datamean(:,1,1),datastd(:,1,1),'k.','MarkerSize',16)
	subplot(3,1,2)
	hold on
	errorbar(beta_points,datamean(:,1,2),datastd(:,1,2),'k^','MarkerSize',7,'MarkerFaceColor','k')
	subplot(3,1,1)
	hold on
	errorbar(beta_points,datamean(:,1,3),datastd(:,1,3),'kp','MarkerSize',10,'MarkerFaceColor','k')
	
	% calculate intercepts
	c1 = sum(datamean(:,1,1) - beta_points.')./sum(1-beta_points);
	c2 = sum(datamean(:,1,2) - beta_points.')./sum(1-beta_points);
	c3 = sum(datamean(:,1,3) - beta_points.')./sum(1-beta_points);
	
	subplot(3,1,1)
	plot(beta1, beta1*(1-c3)+c3,'k--','LineWidth',1.5)
	set(gca,'XTick',beta_points,'XTickLabel',[],'FontSize',24)
	ylabel('P, CW','FontSize',24)
	ylim([0.25,0.5])
	
	subplot(3,1,2)
	plot(beta1, beta1*(1-c2)+c2,'k-','LineWidth',1.5)
	set(gca,'XTick',beta_points,'XTickLabel',[],'FontSize',24)
	ylabel('P, DW','FontSize',24)
	ylim([0.1,0.35])

	subplot(3,1,3)
	plot(beta1, beta1*(1-c1)+c1,'k:','LineWidth',1.5)
	set(gca,'XTick',beta_points,'XTickLabel',round(beta_points*1000)/10,'FontSize',24)
	xlabel('\beta\times100','FontSize',24)
	ylabel('P, UW','FontSize',24)
	ylim([0.1,0.35])
	
	for k = 1:3;
		h = subplot(3,1,k);
		pos=get(h,'pos');
		pos(2) = pos(2) + 0.025;
		pos(4) = pos(4)+0.025;
		set(h,'pos',pos);
	end
	
	set(gcf,'PaperSize',[8,6])
	set(gcf,'PaperPosition',[0,0,8,6])
	


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
	
	% figure(2)
	% hold on
	% errorbar(beta_points,datamean(:,1,1),datastd(:,1,1),'k.','MarkerSize',16)
	% errorbar(beta_points,datamean(:,1,2),datastd(:,1,2),'k^','MarkerSize',7,'MarkerFaceColor','k')
	% errorbar(beta_points,datamean(:,1,3),datastd(:,1,3),'kp','MarkerSize',10,'MarkerFaceColor','k')
	% 
	% % calculate intercepts
	% c1 = sum(datamean(:,1,1) - beta_points.')./sum(1-beta_points);
	% c2 = sum(datamean(:,1,2) - beta_points.')./sum(1-beta_points);
	% c3 = sum(datamean(:,1,3) - beta_points.')./sum(1-beta_points);
	% 
	% plot(beta1, Nc./(1+Nc./beta1) + c1*(1-beta1),'k:','LineWidth',1.5)
	% plot(beta1, Nc./(1+Nc./beta1) + c2*(1-beta1),'k-','LineWidth',1.5)
	% plot(beta1, Nc./(1+Nc./beta1) + c3*(1-beta1),'k--','LineWidth',1.5)
	% 
	% ylim([0.15,0.45])
	% [legend_h,object_h]=legend({'UW','DW','CW','UW fit','DW fit','CW fit'},'Orientation','Horizontal','Location','NorthOutside');
	% set(gca,'XTick',beta_points,'XTickLabel',round(beta_points*1000)/10)
	% xlabel('(Area of patch/Area of domain)100%','FontSize',24)
	% ylabel('P_{tot}','FontSize',24)
	% set(gca,'FontSize',24)
	% set(gcf,'PaperSize',[8,6])
	% set(gcf,'PaperPosition',[0,0,8,6])
	

	% figure
	% hold on
	% errorbar(beta_points,datamean(:,1,1),datastd(:,1,1),'k.','MarkerSize',16)
	% errorbar(beta_points,datamean(:,1,2),datastd(:,1,2),'k^','MarkerSize',7,'MarkerFaceColor','k')
	% errorbar(beta_points,datamean(:,1,3),datastd(:,1,3),'kp','MarkerSize',10,'MarkerFaceColor','k')
	% 
	% 
	% % calculate intercepts
	% c1 = mean(datamean(:,1,1) - sqrt(beta_points).');
	% c2 = mean(datamean(:,1,2) - sqrt(beta_points).');
	% c3 = mean(datamean(:,1,3) - sqrt(beta_points).');	
	% 
	% plot(beta1, sqrt(beta1)+c1,'k:','LineWidth',1.5)
	% plot(beta1, sqrt(beta1)+c2,'k-','LineWidth',1.5)
	% plot(beta1, sqrt(beta1)+c3,'k--','LineWidth',1.5)
	% 
	% ylim([0.15,0.45])
	% [legend_h,object_h]=legend({'UW','DW','CW','UW fit','DW fit','CW fit'},'Orientation','Horizontal','Location','NorthOutside');
	% set(gca,'XTick',beta_points,'XTickLabel',round(beta_points*1000)/1000)
	% xlabel('Area of patch/Area of domain','FontSize',24)
	% ylabel('P_{tot}','FontSize',24)
	% set(gca,'FontSize',24)
	% set(gcf,'PaperSize',[8,6])
	% set(gcf,'PaperPosition',[0,0,8,6])
	
	
	
	
	
	
	% figure(3)
	% hold on
	% xaxis = 1:size(datamean,1);
	% errorbar(xaxis,datamean(:,1,1),datastd(:,1,1),'k.','MarkerSize',16)
	% errorbar(xaxis,datamean(:,1,2),datastd(:,1,2),'k^','MarkerSize',7,'MarkerFaceColor','k')
	% errorbar(xaxis,datamean(:,1,3),datastd(:,1,3),'kp','MarkerSize',10,'MarkerFaceColor','k')
	% 
	% % calculate intercepts
	% mxi = (Nm*(1:4)/(1+Nc)/Ad).';
	% beta1 = mean(datamean(1:4,1,1) - mxi);
	% beta2 = mean(datamean([1,3,4],1,2) - mxi([1,3,4])) ;
	% beta3 = mean(datamean(1:4,1,3) - mxi) ;	
	% 
	% satxval=4.8;
	% fx = 0.25:0.01:satxval;
	% 
	% f=Nm/(1+Nc)*fx/Ad + beta1;
	% f=(fx/Ad)*(1-beta1/1000) + beta1;
	% plot(fx,f,'k:','LineWidth',1.5)
	% hold on 
	% plot([satxval,9],[f(end),f(end)],'k:','LineWidth',1.5,'HandleVisibility','Off')
	% 
	% f=Nm/(1+Nc)*fx/Ad + beta2;
	% f=(fx/Ad)*(1-beta2) + beta2;
	% plot(fx,f,'k-','LineWidth',1.5)
	% plot([satxval,9],[f(end),f(end)],'k-','LineWidth',1.5,'HandleVisibility','Off')
	% 
	% f=Nm/(1+Nc)*fx/Ad + beta3;
	% f=(fx/Ad)*(1-beta3) + beta3;
	% plot(fx,f,'k--','LineWidth',1.5)
	% plot([satxval,9],[f(end),f(end)],'k--','LineWidth',1.5,'HandleVisibility','Off')
	% 
	% ylim([0.15,0.45])
	% [legend_h,object_h]=legend({'UW','DW','CW','UW fit','DW fit','CW fit'},'Orientation','Horizontal','Location','NorthOutside');
	% set(gca,'XTick',xaxis)
	% xlabel('ft^2 per chicken','FontSize',24)
	% ylabel('P_{tot}','FontSize',24)
	% set(gca,'FontSize',24)
	% set(gcf,'PaperSize',[8,6])
	% set(gcf,'PaperPosition',[0,0,8,6])
	
	% % make break
	% y_break_start = 0;
	% y_break_end = 0.27;
	% y_break_mid=(y_break_end-y_break_start)./2+y_break_start;
	% 
	% figure
	% hold on
	% xaxis = 1:size(datamean,1);
	% errorbar(xaxis,datamean(:,1,1)-y_break_mid,datastd(:,1,1),'k.','MarkerSize',16)
	% errorbar(xaxis,datamean(:,1,2)-y_break_mid,datastd(:,1,2),'k^','MarkerSize',7,'MarkerFaceColor','k')
	% errorbar(xaxis,datamean(:,1,3)-y_break_mid,datastd(:,1,3),'kp','MarkerSize',10,'MarkerFaceColor','k')
	% 
	% % slope
	% Nm = 200; Nc = 10; Ad = (10*100/2.54/12)^2; %area of domain in ft^2
	% mxi = (Nm*(1:4)/(1+Nc)/Ad).';	
	% 
	% % calculate intercepts
	% beta1 = mean(datamean(1:4,1,1) - mxi);
	% oldval = 0.18;
	% beta2 = mean(datamean([1,3,4],1,2) - mxi([1,3,4])) ;
	% oldval = 0.195;
	% beta3 = mean(datamean(1:4,1,3) - mxi) ;
	% oldval = 0.32;
	% 
	% 
	% satxval=4.8;
	% fx = 0.25:0.01:satxval;
	% 
	% f=Nm/(1+Nc)*fx/Ad + beta1;
	% plot(fx,f-y_break_mid,'k:','LineWidth',1.5)
	% hold on 
	% plot([satxval,9],[f(end)-y_break_mid,f(end)-y_break_mid],'k:','LineWidth',1.5,'HandleVisibility','Off')
	% 
	% f=Nm/(1+Nc)*fx/Ad + beta2;
	% plot(fx,f-y_break_mid,'k-','LineWidth',1.5)
	% plot([satxval,9],[f(end)-y_break_mid,f(end)-y_break_mid],'k-','LineWidth',1.5,'HandleVisibility','Off')
	% 
	% f=Nm/(1+Nc)*fx/Ad + beta3;
	% plot(fx,f-y_break_mid,'k--','LineWidth',1.5)
	% plot([satxval,9],[f(end)-y_break_mid,f(end)-y_break_mid],'k--','LineWidth',1.5,'HandleVisibility','Off')
	% 
	% ylim([0,0.45-y_break_mid])
	% %gridLegend(gca,3,{'Upwind','Downwind','Crosswind','Upwind','Downwind','Crosswind'},'Orientation','Horizontal','Location','NorthOutside', 'Box', 'off');
	% [legend_h,object_h]=legend({'UW','DW','CW','UW','DW','CW'},'Orientation','Horizontal','Location','NorthOutside');
	% % numcols=3;
	% % numpercolumn = 6/numcols;
	% % pos = get(legend_h, 'position');
	% % width = numcols*pos(3);
	% % rescale = pos(3)/width;
	% % sheight = 1/numpercolumn;                  % height between data lines
	% % height = 1-sheight/2;                            % height of the box. Used to top margin offset
	% % line_width = dx*rescale;                        % rescaled linewidth to match original
	% % spacer = xdata(1)*rescale;                    % rescaled spacer used for margins
	% 
	% 
	% set(gca,'XTick',xaxis)
	% xlabel('ft^2 per chicken','FontSize',24)
	% ylabel('Prop mosquitoes finding host','FontSize',24)
	% set(gca,'FontSize',24)
	% set(gcf,'PaperSize',[8,6])
	% set(gcf,'PaperPosition',[0,0,8,6])
	% 
	% %make break
	% xlim=get(gca,'xlim');
	% ytick=get(gca,'YTick');
	% [junk,i]=min(ytick<=y_break_start);
	% y=(ytick(i)-ytick(i-1))./2+ytick(i-1);
	% dy=(ytick(2)-ytick(1))./10;
	% 
	% %patch
	% dx=(xlim(2)-xlim(1))./10;
	% yy=repmat([y-2.*dy y-dy],1,6);
	% xx=xlim(1)+dx.*[0:11];
	% pobj=patch([xx(:);flipud(xx(:))], [yy(:);flipud(yy(:)-2.*dy)],[1 1 1]);
	% hatch(pobj,45,'k','-',8)
	% %hatch(pobj,-45,'k','-',8)
	% set(gca,'xlim',xlim);
	% 
	% % %line
	% % xtick=get(gca,'XTick');
	% % x=xtick(1);
	% % dx=(xtick(2)-xtick(1))./2;
	% % line([x-dx x   ],[y-2.*dy y-dy   ]);
	% % line([x    x+dx],[y+dy    y+2.*dy]);
	% % line([x-dx x   ],[y-3.*dy y-2.*dy]);
	% % line([x    x+dx],[y+2.*dy y+3.*dy]);
	% 
	% % map back
	% set(gca,'YTick',[y_break_mid,0.2,0.3,0.4]-y_break_mid,'YTickLabel',{'0','0.2','0.3','0.4'})	
	
	
				