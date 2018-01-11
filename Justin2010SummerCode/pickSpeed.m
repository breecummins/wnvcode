function spd = pickSpeed(fmin,fmax,indepvar,maxI);
	
	%spd = fmin + (fmax - fmin) ./ (1 + stretch*indepvar);
	spd = fmax - (fmax-fmin).*(abs(indepvar)./maxI);
	