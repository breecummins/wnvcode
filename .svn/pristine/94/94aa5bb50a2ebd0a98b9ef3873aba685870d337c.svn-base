function stoprun = remainingMosquitoes(ym,p,modevec);
	
	% This function checks to see if any mosquitoes are still in the domain looking for a host. If stoprun = true, then all the mosquitoes are gone and the time evolution should stop.
	
	stoprun = false;
	
	if length(p.wind_mode) == 1;
		if p.wind_mode == 1 || p.wind_mode == 3; %upwind travelers will pass out the bottom of the domain
			if all(ym < -10*p.h);
				stoprun = true;
			end
		else;  									%downwind travelers will pass out the top of the domain
			if all(ym > p.Ly+10*p.h);
				stoprun = true;
			end
		end
	elseif all(p.wind_mode == [1,2,5]);
		ind1 = find(modevec == 1);
		if all(ym(ind1) < -100*p.h) || all(ym(ind1(end)+1:end) > p.Ly+100*p.h);
			stoprun = true;
		end
	end
			
			