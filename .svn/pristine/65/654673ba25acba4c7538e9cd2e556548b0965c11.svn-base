function F = ResponseFunction(b,b0,bsat,kappa);
	
	%Ricardo's new response function rule. b is the dimensional sensory input for each mosquito at one moment in time, and will be scaled by the saturation level bsat. b0 is the dimensional minimum threshold (also to be scaled by bsat). kappa is a shape parameter in the interval (-bsat/b0, infinity).
	
	%scale inputs
	b = b/bsat;
	b0 = b0/bsat;
	
	%check that kappa is in the right interval
	if kappa < -1/b0;
		error('Shape parameter outside the useful range. Reassign to the interval (-1/b0, infinity).')
	end
	
	%zero out stuff below the sensory threshold; set to one if above saturation
	F = zeros(size(b));
	ind = find(b < b0);
	jnd = find(b > 1);
	F(jnd) = 1;
	
	%set remaining entries to appropriate F values
	if size(ind,1) > 1 || size(jnd,1) > 1;
		tind = [ind;jnd];
	else;
		tind = [ind,jnd];
	end
	knd = setdiff(1:length(b),tind);
	F(knd) = (1+kappa*b0).*(b(knd) - b0)./( (1+kappa*b0*b(knd))*(1-b0) );
	
	%check to be sure calculations are correctly bounded 
	if any(F(:) > 1+1.e-12) || any(F(:) < 0-1.e-12);
		bigind = [find(out > 1+1.e-12);find(out < 0-1.e-12)];
		disp()
		error('Response function is out of bounds. Debug.')
	end
	
