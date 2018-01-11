function NormalVars = SSVizNormal(fvfname,baseparam,compparams,whichmethods,statfname,newfname,p,picname)

	%p=0 means don't graph, p=1 means graph


load(fvfname)
load(statfname)

[avg,stddev,norm_vals] = NormalApproxForRankSumTest(fixedvars.Nm,fixedvars.Nm);
scalefactor=0.5*10^5; 
numbins = 50;
maxyaxis = 50;

NormalVars = zeros(2,length(compparams),length(whichmethods),length(fixedvars.tSpace));

for t=1:length(fixedvars.tSpace);
	str=sprintf('%03d',t);
	for l=1:length(compparams); 
		for m=1:length(whichmethods);
			[mu,sig2,vals,x] = SSFitNormal(Ustat(:,l,m,t),fixedvars.Nm);
			NormalVars(:,l,m,t) = [mu;sig2];
			if p == 1;
				plot(scalefactor*norm_vals,'k-','LineWidth',2)
				hold on
				hist(Ustat(:,l,m,t),numbins);
				h = findobj(gca,'Type','patch');
				set(h,'FaceColor','None','EdgeColor','b')
				axis([0,fixedvars.Nm^2,0,maxyaxis])
				vals=scalefactor*max(norm_vals)/max(vals)*vals;
				plot(vals,'c-','LineWidth',2)
				title(['U statistic, time = ',num2str(fixedvars.tSpace(t)),', Method ', int2str(m)])
				legend('Ref distribution',['Param Set ',int2str(baseparam),' vs param set ',int2str(compparams(l))],'Normal approx')
				hold off
				fname = ['~/WNVSecondRuns/movies/Ustat_',picname,str,'.png'];
				saveas(gcf,fname,'png')
			end
		end
	end
end


fname=[newfname,'.mat'];
save(fname,'NormalVars');

