function theta = pickDirection(theta0,fmin,fmax,indepvar,b0,bsat,kappa);
	
	win = fmax - (fmax-fmin).*ResponseFunction(indepvar,b0,bsat,kappa);
	theta = theta0 + win.*(-1 + 2*rand(length(theta0),1));
	
