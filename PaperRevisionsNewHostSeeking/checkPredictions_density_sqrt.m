function [c11,c12,c13]=checkPredictions_density_sqrt(basedir,old)
	
	load(fullfile(basedir,'alldata.mat'))
	
	beta_points = sqrt(Nc*(1:size(datamean,1)))./sqrt(Ad); %host patch area = # chickens * ft^2/chicken
	beta1 = sqrt(Nc*(0.25:0.05:size(datamean,1)+0.75))./sqrt(Ad);
	if old;
		disp('Fitting old data.')
		beta_points=beta_points/2.;
		beta1 = beta1/2.;
	end
	
	
	figure(1)	

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
	fitsuw = (datamean(:,4,1)+hr)/L; %assuming uniform entry of mosquitoes
	fitsdw = (datamean(:,4,1)+hr)/L; %assuming uniform entry of mosquitoes
	fitscw = (datamean(:,4,1)+hr)/L + 2*(datamean(:,3,1)/L)*avgcwfl/L; %assuming uniform entry of mosquitoes
	
	subplot(3,1,1);
	plot(beta_points,fitscw,'kp','MarkerSize',12)
	set(gca,'XTick',beta_points([1,2,4,6,8]),'XTickLabel',[],'FontSize',24)
	ylabel('P, CW','FontSize',24)
	axis([0.04,0.3,0.27,0.57])

	subplot(3,1,2);
	plot(beta_points,fitsdw,'k^','MarkerSize',8)
	set(gca,'XTick',beta_points([1,2,4,6,8]),'XTickLabel',[],'FontSize',24)
	ylabel('P, DW','FontSize',24)
	axis([0.04,0.3,0.15,0.45])
	
	subplot(3,1,3);
	plot(beta_points,fitsuw,'ko','MarkerSize',8)
	set(gca,'XTick',beta_points([1,2,4,6,8]),'XTickLabel',round(beta_points([1,2,4,6,8])*1000)/10,'FontSize',24)
	xlabel('\beta\times100%','FontSize',24)
	ylabel('P, UW','FontSize',24)
	axis([0.04,0.3,0.15,0.45])
	
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
	
	subplot(3,1,3)
	hold on
	errorbar(beta_points,datamean(:,1,1),datastd(:,1,1),'k.','MarkerSize',16)
	subplot(3,1,2)
	hold on
	errorbar(beta_points,datamean(:,1,2),datastd(:,1,2),'k^','MarkerSize',7,'MarkerFaceColor','k')
	subplot(3,1,1)
	hold on
	errorbar(beta_points,datamean(:,1,3),datastd(:,1,3),'kp','MarkerSize',10,'MarkerFaceColor','k')
	
	% % calculate intercepts
	% p11 = polyfit(beta_points.',datamean(:,1,1),1);
	% p12 = polyfit(beta_points.',datamean(:,1,2),1);
	% p13 = polyfit(beta_points.',datamean(:,1,3),1);
	% p21 = polyfit(beta_points.',datamean(:,1,1),2);
	% p22 = polyfit(beta_points.',datamean(:,1,2),2);
	% p23 = polyfit(beta_points.',datamean(:,1,3),2);
	c11 = sum( (datamean(:,1,1) - beta_points.').*(1-beta_points.') )./sum( (1-beta_points).^2 );
	c12 = sum( (datamean(:,1,2) - beta_points.').*(1-beta_points.') )./sum( (1-beta_points).^2 );
	c13 = sum( (datamean(:,1,3) - beta_points.').*(1-beta_points.') )./sum( (1-beta_points).^2 );
	% c21 = sum( (datamean(:,1,1) - beta_points.').*(1-beta_points.').^2 )./sum( (1-beta_points).^4 );
	% c22 = sum( (datamean(:,1,2) - beta_points.').*(1-beta_points.').^2 )./sum( (1-beta_points).^4 );
	% c23 = sum( (datamean(:,1,3) - beta_points.').*(1-beta_points.').^2 )./sum( (1-beta_points).^4 );
	
	subplot(3,1,1)
	plot(beta1, beta1*(1-c13)+c13,'k--','LineWidth',1.5)
	% plot(beta1, p13(1)*beta1 + p13(2),'r--','LineWidth',1.5)
	% plot(beta1, beta1+ c23*(1-beta1).^2,'b--','LineWidth',1.5)
	% plot(beta1, p23(1)*beta1.^2 + p23(2)*beta1 + p23(3),'g--','LineWidth',1.5)
	% plot(beta1, mean([p23(1),p22(1),p21(1)])*beta1.^2 + mean([p23(2),p22(2),p21(2)])*beta1 + p23(3),'m--','LineWidth',1.5)
	set(gca,'XTick',beta_points([1,2,4,6,8]),'XTickLabel',[],'FontSize',16,'FontName','Arial')
	ylabel('P, CW','FontSize',16,'FontName','Arial')
	axis([0.04,0.3,0.27,0.57])
	
	subplot(3,1,2)
	plot(beta1, beta1*(1-c12)+c12,'k-','LineWidth',1.5)
	% plot(beta1, p12(1)*beta1 + p12(2),'r-','LineWidth',1.5)
	% plot(beta1, 1./(1 + 3*exp(-9*beta1)),'b-','LineWidth',1.5)
	% plot(beta1, beta1+ c22*(1-beta1).^2,'b-','LineWidth',1.5)
	% plot(beta1, p22(1)*beta1.^2 + p22(2)*beta1 + p22(3),'g-','LineWidth',1.5)
	% plot(beta1, mean([p23(1),p22(1),p21(1)])*beta1.^2 + mean([p23(2),p22(2),p21(2)])*beta1 + p22(3),'m-','LineWidth',1.5)
	set(gca,'XTick',beta_points([1,2,4,6,8]),'XTickLabel',[],'FontSize',16,'FontName','Arial')
	ylabel('P, DW','FontSize',16,'FontName','Arial')
	axis([0.04,0.3,0.15,0.45])

	subplot(3,1,3)
	plot(beta1, beta1*(1-c11)+c11,'k:','LineWidth',1.5)
	% plot(beta1, p11(1)*beta1 + p11(2),'r:','LineWidth',1.5)
	% plot(beta1, beta1+ c21*(1-beta1).^2,'b:','LineWidth',1.5)
	% plot(beta1, p21(1)*beta1.^2 + p21(2)*beta1 + p21(3),'g:','LineWidth',1.5)
	% plot(beta1, mean([p23(1),p22(1),p21(1)])*beta1.^2 + mean([p23(2),p22(2),p21(2)])*beta1 + p21(3),'m:','LineWidth',1.5)
	% set(gca,'XTick',beta_points([1,2,4,6,8]),'XTickLabel',round(beta_points([1,2,4,6,8])*1000)/10,'FontSize',24)
	% xlabel('\beta^{1/2}\times100%','FontSize',24)
	set(gca,'XTick',beta_points([1,2,4,6,8]),'XTickLabel',round(beta_points([1,2,4,6,8])*1000)/10,'FontSize',16,'FontName','Arial')
	xlabel('\beta\times100%','FontSize',16,'FontName','Arial')
	ylabel('P, UW','FontSize',16,'FontName','Arial')
	axis([0.04,0.3,0.15,0.45])
	
	for k = 1:3;
		h = subplot(3,1,k);
		pos=get(h,'pos');
		% pos(1) = pos(1) + 0.025;
		pos(2) = pos(2) + 0.01;
		if k ==2;
			pos(2) = pos(2) + 0.01;
		elseif k == 3;
			pos(2) = pos(2) + 0.02;
		end
		pos(4) = 1.2*pos(4);
		set(h,'pos',pos);
	end
	
	% set(gcf,'PaperSize',[8,6])
	% set(gcf,'PaperPosition',[0,0,8,6])
	sz=[0.0, 0.0, 12.35/2.54, 0.75*12.35/2.54];
	set(gcf,'PaperSize',sz(3:4))                 
	set(gcf,'PaperPosition',sz)
	style = hgexport('factorystyle');
	style.Color = 'gray';
	hgexport(2,'~/Figure6.eps',style);      
