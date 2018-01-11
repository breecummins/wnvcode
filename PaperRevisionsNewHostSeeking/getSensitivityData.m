function data = getSensitivityData(results,p);
	data=[];
	data(1) = length(results.whichchicken)/p.Nm;
	data(2) = sum(results.whichchicken <= p.Nc(1))/p.Nm;
	data(3) = sum(results.whichchicken > p.Nc(1))/p.Nm;
	data(4) = mean(results.tmfinal - results.tmentrance);
end %function	
