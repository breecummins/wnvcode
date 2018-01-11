function ksd = KS1D(samp1,samp2);
	
	%Calculates KS distance between 2 samples, each n by 1 vectors.
	
	samp1 = makecolumn(samp1);
	samp2 = makecolumn(samp2);
	if size(samp1,2) > 1 || size(samp2,2) > 1;
		error('Input arguments must both be vectors, not matrices.')
	end

	if size(samp1,1) ~= size(samp2,1);
		error('Samples must have the same number of rows.')
	else;
		nsamp = size(samp1,1);
	end

	cdf1 = zeros(nsamp,1);
	cdf2 = zeros(nsamp,1);
	
	samp1 = sort(samp1);
	samp2 = sort(samp2);
	
	for a = 1:nsamp;
		for b = 1:nsamp; 
			if samp1(b) <= samp1(a);
				cdf1(a) = cdf1(a) +1./nsamp;
			end
			if samp2(b) <= samp2(a);
				cdf2(a) = cdf2(a) +1./nsamp;
			end
		end
	end
	
	ksd = max(max(abs(cdf1-cdf2)));
	 