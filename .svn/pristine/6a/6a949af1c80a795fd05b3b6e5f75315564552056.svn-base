function vals = NormalDistribution(avg,stddev,t);
	
	% t is a vector of values where the normal approximation should be calculated
	vals = ( 1./(sqrt(2*pi)*stddev) ) * exp( -(t-avg).^2 ./ (2*stddev.^2) );