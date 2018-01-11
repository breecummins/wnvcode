%SSViz.m

clear
close all

basestr='Diffusion';
pathstr='~/rsyncfolder/data/WNV/FirstRuleRuns/';
fname=[pathstr,'Simulations/MosqResultsForEmpiricalStats',basestr,'_0200_run0001.mat'];
load(fname)
fname=[pathstr,'Stats',basestr,'.mat'];
load(fname)

NormalVars=zeros(2,NumMethods,NumMethods,length(tSpace));
numbins=125;
[avg,stddev,norm_vals] = NormalApproxForRankSumTest(Nm,Nm);
scalefactor=1.6*10^5; %works for numbins=125
p=0; %0=do not plot; 1 = plot

for t=1:length(tSpace);
	str=sprintf('%04d',t);
	for k1=1:NumMethods; 
		for j1=1:NumMethods;
			if j1>k1;
				[mu,sig2,vals,x] = SSFitNormal(Ustat(:,k1,j1,t),Nm);
				NormalVars(:,k1,j1,t) = [mu;sig2];
				if p ==1;
					hist(Ustat(:,k1,k1,t),numbins)
					hold on
					hist(Ustat(:,j1,j1,t),numbins)
					hist(Ustat(:,k1,j1,t),numbins)
					h = findobj(gca,'Type','patch');
					set(h(1),'FaceColor','None','EdgeColor','b')
					set(h(2),'FaceColor','None','EdgeColor','r')
					set(h(3),'FaceColor','None','EdgeColor','k')
					plot(scalefactor*norm_vals,'k-','LineWidth',2)
					vals=scalefactor*max(norm_vals)/max(vals)*vals;
					plot(vals,'c-','LineWidth',2)
					axis([0,length(xm0)^2,0,200])
					title(['U statistic, time = ',num2str(tSpace(t))])
					legend(descriptions_short{k1},descriptions_short{j1},[descriptions_short{k1},' vs ', descriptions_short{j1}],'Normal Approx','Normal Approx')
					hold off
					fname = ['~/rsyncfolder/data/WNV/FirstRuleRuns/statsmovies_normal/Ustat_',descriptions_filename{k1},'_vs_',descriptions_filename{j1},basestr,str,'.png'];
					saveas(gcf,fname,'png')
				end	
			end
		end
	end
end


fname=[pathstr,'MeanVarOnUStats',basestr,'.mat'];
save(fname,'NormalVars');

























