function SSViz_MeanVarBetweenRuleSets2(bm,bp,cm,cp,fnameend)
	
	%bm and bp are the rule set and parameter set that everything is compared to, respectively. cm and cp are the methods and parameter sets to compare to; they must be subests of compmethods and comppsets in the file.
	%fnameend is a string that to designate a specific NormalVars file.

	close all
	load(['~/WNVFifthRuns/NormalVars_ruleset',sprintf('%02d',bm),'_paramset',sprintf('%03d',bp),fnameend]) 
	ind = find(basepsets == bp);
	
	mind = [];
	pind = [];
	for elem = cm;
		mind(end+1) = find(compmethods == elem);
		k=0;
		for pelem = makerow(squeeze(cp(:,mind(end)))); %if k = column vector, k will be the whole column; but if k = row vec, then k will be taken element-wise from the vector
			k=k+1;
			pind(k,mind(end)) = find(comppsets(:,mind(end)) == pelem);
		end
	end
		
	set(0,'DefaultAxesFontSize',24,'DefaultLineLineWidth',1)
	linesty = { 'b-','k-','r-','g-','m-','c-','b--','k--','r--','g--','m--','c--','b:','k:','r:','g:','m:','c:' };
	c=0;
	errmean = [];
	errvar=[];
	dt = diff(tSpace);
	for m = 1:length(mind);
		figure(c+1)
		smvals = squeeze(SelfNormalVars(1,:));
		plot(tSpace,smvals,'r','LineWidth',2)
		hold on
		ylabel('U Statistic Mean')
		xlabel('Nondimensional Time')
		figure(c+2)
		svvals = squeeze(SelfNormalVars(2,:));
		plot(tSpace,svvals,'r','LineWidth',2)
		hold on
		ylabel('U Statistic Variance')
		xlabel('Nondimensional Time')
		leg={ 'Self' };
		for p = 1:size(pind,1); 
			lsp = mod(p,length(linesty));
			if lsp == 0;
				lsp = length(linesty);
			end
			figure(c+1)
			mvals = squeeze(NormalVars(1,pind(p,m),mind(m),:));
			plot(tSpace,mvals,linesty{lsp});
			figure(c+2)
			vvals = squeeze(NormalVars(2,pind(p,m),mind(m),:));
			plot(tSpace,vvals,linesty{lsp});
			
			errmean(m,p)=sum(abs(mvals(2:end) - smvals(2:end).').*dt.');  %need the (2:end) b/c dt is a diff
			errvar(m,p)=sum(abs(vvals(2:end) - svvals(2:end).').*dt.');
			
			load(['~/WNVFifthRuns/AllRules_paramset',sprintf('%03d',comppsets(pind(p,m),ind)),'_run01.mat'])
			mxsp = ruleparams.maxspdgrad;
			mnsp = ruleparams.minspdgrad;
			angcoeff = round(12*ruleparams.minanggrad/pi);
			leg{end+1}=[sprintf('%1.3g',mnsp),', ',sprintf('%1.3g',mxsp),', ',int2str(angcoeff),'\pi/12'];
			
		end
		minerr = min(errmean(m,:));
		minind = find(errmean(m,:) == minerr);	
		disp(['Best fit to mean for rule set ', int2str(compmethods(mind(m))), ' is param set ', int2str(comppsets(pind(minind,m))),' with an error value ', num2str(minerr)])
		figure(c+1)
		plot(tSpace,Nm^2/2*ones(length(tSpace),1),'k','LineWidth',2)
		axis([0,tSpace(end),0,Nm^2])
		load(['~/WNVFifthRuns/AllRules_paramset',sprintf('%03d',bp),'_run01.mat'])
		mxsp = ruleparams.maxspdgrad;
		mnsp = ruleparams.minspdgrad;
		angcoeff = round(12*ruleparams.minanggrad/pi);
		pstr=['(',sprintf('%1.3g',mnsp),', ',sprintf('%1.3g',mxsp),', ',int2str(angcoeff),'\pi/12)'];
		title(['Rule #',int2str(basemethod),' ',pstr,' vs Rule #', int2str(compmethods(mind(m)))])
		legend(leg,'Location','BestOutside')
		figure(c+2)
		plot(tSpace,Nm^2*(2*Nm+1)/12*ones(length(tSpace),1),'k','LineWidth',2)
		axis([0,tSpace(end),0, 2*Nm^2*(2*Nm+1)/12])
		title(['Rule #',int2str(basemethod),' ',pstr,' vs Rule #', int2str(compmethods(mind(m)))])
		legend(leg,'Location','BestOutside')
		c=c+2;
	end
	
