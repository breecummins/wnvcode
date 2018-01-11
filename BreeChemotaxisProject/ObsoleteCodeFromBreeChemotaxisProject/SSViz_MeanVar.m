function SSViz_MeanVar(meanvarfname,NumMethods,tSpace,Nm)
	
	close all
	load(meanvarfname)

	set(0,'DefaultAxesFontSize',16)
	linesty = { 'b-','k-','r-','g-','m-','c-','b--','k--','r--','g--','m--','c--' };
	c=0;
	for m = 1:NumMethods-1;
		figure(c+1)
		hold on
		ylabel('mean')
		xlabel('time')
		figure(c+2)
		hold on
		ylabel('variance')
		xlabel('time')
		% figure(c+3)
		% hold on
		% ylabel('normalized variance error')
		% xlabel('time')
		l=1;
		leg={};
		for l = (m+1):NumMethods;
			leg{end+1}=['vs Method ', int2str(l)];
			figure(c+1)
			mvals = squeeze(NormalVars(1,m,l,:));
			plot(tSpace,mvals,linesty{l});
			figure(c+2)
			vvals = squeeze(NormalVars(2,m,l,:));
			plot(tSpace,vvals,linesty{l});
			l=l+1;
			% figure(c+3)
			% evals = (vvals-Nm^2*(2*Nm+1)/12)/(Nm^2*(2*Nm+1)/12);
			% plot(tSpace,evals);
		end
		figure(c+1)
		plot(tSpace,Nm^2/2*ones(length(tSpace),1),'LineWidth',2)
		axis([0,tSpace(end),0,Nm^2])
		title(['Method ',int2str(m)])
		legend(leg)
		figure(c+2)
		plot(tSpace,Nm^2*(2*Nm+1)/12*ones(length(tSpace),1),'LineWidth',2)
		axis([0,tSpace(end),0, 2*Nm^2*(2*Nm+1)/12])
		title(['Method ',int2str(m)])
		legend(leg)
		% figure(c+3)
		% plot(tSpace,zeros(length(tSpace),1),'LineWidth',2)
		% title(['Method ',int2str(m)])
		c=c+2;
	end
