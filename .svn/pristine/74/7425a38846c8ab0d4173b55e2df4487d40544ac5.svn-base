function ReportMosqs(results,modevec,p);
	
disp(['Number of mosquito-bird encounters: ',int2str(sum(~isnan(results.whichchicken))),'/',int2str(p.Nm*length(p.wind_mode))])
if p.Nc==40;
	for k=1:4;
	    disp([ 'Number at group ',int2str(k),': ',int2str( sum(results.whichchicken <= k*10)- sum(results.whichchicken < (k-1)*10+1) ) ] )
	end
end

disp(['Upwind Contacts: ', num2str( (2000-sum(modevec==1))),', ',num2str( (2000-sum(modevec==1))/2000 )])
disp(['Downwind Contacts: ', num2str( (2000-sum(modevec==2))),', ',num2str( (2000-sum(modevec==2))/2000 )])
disp(['Crosswind Contacts: ', num2str( (2000-sum(modevec==5))),', ',num2str( (2000-sum(modevec==5))/2000 )])

