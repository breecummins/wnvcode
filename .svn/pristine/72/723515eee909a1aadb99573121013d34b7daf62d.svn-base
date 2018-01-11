function NormalVars = SSVizNormalBetweenRuleSets(fvfname,statfname,basemethod,baseparam,compmethods,numparams,pskip,tskip,newfname,pf)

	%pf=0 means don't graph, pf=1 means graph


load(fvfname)
tSpace = fixedvars.tSpace;
load(statfname)

[avg,stddev] = NormalApproxForRankSumTest(fixedvars.Nm,fixedvars.Nm);
x=0:fixedvars.Nm^2;
norm_vals = NormalDistribution(avg,stddev,x);
scalefactor=0.5*10^5; 
numbins = 50;
maxyaxis = 50;

NormalVars = zeros(2,numparams/pskip,length(compmethods),length(tSpace)/tskip);

for t=1:tskip:length(tSpace);
	str=sprintf('%03d',t);
	for p=1:pskip:numparams; 
		for m=1:length(compmethods);
			mu = mean(Ustat(:,p,m,t));
			sig2 = var(Ustat(:,p,m,t));
			vals = NormalDistribution(mu,sqrt(sig2),x);
			NormalVars(:,p,m,t) = [mu;sig2];
			if pf == 1;
				plot(scalefactor*norm_vals,'k-','LineWidth',2)
				hold on
				hist(Ustat(:,p,m,t),numbins);
				h = findobj(gca,'Type','patch');
				set(h,'FaceColor','None','EdgeColor','b')
				axis([0,fixedvars.Nm^2,0,maxyaxis])
				vals=scalefactor*max(norm_vals)/max(vals)*vals;
				plot(vals,'c-','LineWidth',2)
				title(['U statistic, time = ',num2str(tSpace(t)),', Method ', int2str(compmethods(m))])
				legend('Ref distribution',['Method ',int2str(basemethod),' & Param Set ',int2str(baseparam),' vs Method ',int2str(compmethods(m)),' & Param Set ',int2str(p)], 'Normal approx')
				hold off
				picname = ['meth',int2str(basemethod),'pset',int2str(baseparam),'_vs_meth',int2str(m),'pset',int2str(p)];
				fname = ['~/WNVSecondRuns/movies/Ustat_',picname,'_',str,'.png'];
				saveas(gcf,fname,'png')
			end
		end
	end
end

fname=[newfname,'.mat'];
save(fname,'NormalVars','tSpace','tskip','basemethod','baseparam','compmethods','numparams','pskip');

