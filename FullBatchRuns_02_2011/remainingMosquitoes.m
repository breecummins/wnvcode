function stoprun = remainingMosquitoes(ym,p);
	
	% This function checks to see if any mosquitoes are still in the domain looking for a host. If stoprun = true, then all the mosquitoes are gone and the time evolution should stop.
	
	if p.wind_mode == 1 || p.wind_mode == 3; %upwind travelers will pass out the bottom of the domain
		if any(ym > -5*p.h);
			stoprun = false;
		else;
			stoprun = true;
		end
	else;  									%downwind travelers will pass out the top of the domain
		if any(ym < p.L+5*p.h);
			stoprun = false;
		else;
			stoprun = true;
		end
	end
			