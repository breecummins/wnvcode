function [fll, flg, fgl, fgg] = KS2DCumDist(x,y);
	
	if length(x) ~= length(y);
		error('The 2D Kolmogorov-Smirnov test requires equal numbers of x and y coordinates.')
	else;
		n = length(x);
	end
	
	fll = zeros(n,1);
	flg = zeros(n,1);
	fgl = zeros(n,1);
	for a = 1:n;
		for b = 1:n; 
			if x(b) <= x(a) && y(b) <= y(a);
				fll(a) = fll(a) +1./n;
			elseif 	x(b) <= x(a) && y(b) > y(a);
				flg(a) = flg(a) +1./n;
			elseif 	x(b) > x(a) && y(b) <= y(a);
				fgl(a) = fgl(a) +1./n;
			end
		end
	end
	
	fgg = ones(size(fll))-fll-flg-fgl;	
	