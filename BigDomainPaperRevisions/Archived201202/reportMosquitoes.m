function reportMosquitoes(results,p);
	disp(['Number of mosquito-bird encounters: ',int2str(length(results.whichchicken)),'/',int2str(p.Nm)])
	sch=sort(results.whichchicken);
	for k = 1:length(p.Nc);
		numchick = find(sch <= p.Nc(k),1,'last');
		if k > 1;
			numchick = numchick - find(sch <= p.Nc(k-1),'last');
		end	
	    disp(['Number at group ',int2str(k),': ',int2str(numchick)])
	end 