function z = Zscore(obs,avg,stddev);
	
	z = (obs -avg)./stddev;