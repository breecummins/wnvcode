function statvec = BinMosquitoes(xmosq,ymosq,Ng,Nm,n);
	
	%Bin the locations of the mosquitoes into boxes containing n grid squares on a side. Default n = 1.
	
	if nargin < 5;
		n=1;
	end
	
	count = zeros(Ng,Ng);
	
	j0 = floor(xmosq*Ng)+1;  
	i0 = floor(ymosq*Ng)+1;
	
	for k = 1:Nm;
		count(i0(k),j0(k)) = count(i0(k),j0(k)) + 1; 
	end
	
	if mod(Ng,n) ~=0;
		disp('Ng/n is non-integer. Choosing n = 1 (i.e., binning within each grid box).')
		n=1;
	end
	
	statvec = zeros(Ng^2/n^2,1);
	xi=1; yi=1;
	for k = 1:Ng^2/n^2;
		yind = yi:yi+n-1;
		xind = xi:xi+n-1;
		for k1 = 1:n
			statvec(k) = statvec(k) + sum(count(yind(k1),xind));
		end
		xi = xi+n;
		if xi > Ng;
			xi = 1;
			yi = yi+n;
		end
	end
	
	
	