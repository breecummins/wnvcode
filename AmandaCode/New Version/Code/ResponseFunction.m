function F = ResponseFunction(b,b0,bsat,kappa)

% Determines the value of F
% b is the dimensional sensory input for each mosquito at one moment in
% time, scaled by the saturation level bsat
% b0 is the dimensional minimum threshold, scaled by bsat
% kappa is a shape parameter in the interval (-bsat/b0, infinity)

% percents of concentration gradient present, as compared to maximum
% threshold
b = b/bsat;
b0 = b0/bsat;
	
% check that kappa is in the right interval
if kappa < -1/b0;
	error('Shape parameter outside the useful range, (-1/b0, infinity)')
end

% F = 0 below b0, F = 1 above bsat
F = zeros(size(b));
ind = find(b < b0);
jnd = find(b > 1);
F(jnd) = 1;

% function F between b0 and bsat
if size(ind,1) > 1 || size(jnd,1) > 1;
    tind = [ind;jnd];
else
	tind = [ind,jnd];
end
knd = setdiff(1:length(b),tind);
F(knd) = (1 + (kappa*b0)).*(b(knd) - b0)./((1+(kappa*b0.*b(knd))).*(1-b0));

% finds indices of any value of F out of bounds [0,1]
if any(F(:) > 1+1.e-12) || any(F(:) < 0-1.e-12);
	bigind = [find(F > 1+1.e-12); find(F < 0-1.e-12)];
	disp(bigind)
	error('Response function is out of bounds')
end