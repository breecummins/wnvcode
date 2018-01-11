function theta = pickDirectionNewRule(theta0,fmin,fmax,indepvar,b0,kappa);
	
	win = fmax - (fmax-fmin).*SSNewRule(indepvar,b0,kappa);
	theta = theta0 + win.*(-1 + 2*rand(length(theta0),1));
	
	%correct direction if the independent variable is pointing backwards
	ind = find(indepvar < 0);
	theta(ind) = theta(ind) -pi;
