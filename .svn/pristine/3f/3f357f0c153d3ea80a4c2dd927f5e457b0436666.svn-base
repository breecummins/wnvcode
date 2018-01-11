function z = discrete_zscore(obs,avg,stddev);
	
	dif = obs -avg;
	mask = (dif >=0);
	dfactor = 0.5*(-1).^mask; %needed for correction from discrete to continuous distribution
	z = (dif + dfactor)./stddev;