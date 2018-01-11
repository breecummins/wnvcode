function SSViz_MeanVarBetweenRuleSets(fname,Nm)
	
	close all
	load(fname) %the file should have NormalVars in it

	set(0,'DefaultAxesFontSize',16)
	linesty = {'b-','k-','r-','g-','m-','c-','b--','k--','r--','g--','m--','c--'};
	c=0;
	for m = 1:length(compmethods)-1;
		figure(c+1)
		hold on
		ylabel('mean')
		xlabel('time')
		figure(c+2)
		hold on
		ylabel('variance')
		xlabel('time')
		leg={};
		for p = 1:pskip:numparams;
			leg{end+1}=['vs Param set', int2str(p)];
			figure(c+1)
			mvals = squeeze(NormalVars(1,p,m,:));
			plot(0:tskip:tSpace,mvals,linesty{l});
			figure(c+2)
			vvals = squeeze(NormalVars(2,p,m,:));
			plot(0:tskip:tSpace,vvals,linesty{l});
		end
		figure(c+1)
		plot(tSpace,Nm^2/2*ones(length(tSpace),1),'LineWidth',2)
		axis([0,tSpace(end),0,Nm^2])
		title(['Method ',int2str(basemethod),', Param set ', int2str(baseparam),' vs Method ', int2str(m)])
		legend(leg)
		figure(c+2)
		plot(tSpace,Nm^2*(2*Nm+1)/12*ones(length(tSpace),1),'LineWidth',2)
		axis([0,tSpace(end),0, 2*Nm^2*(2*Nm+1)/12])
		title(['Method ',int2str(basemethod),', Param set ', int2str(baseparam),' vs Method ', int2str(m)])
		legend(leg)
		c=c+2;
	end