function [avg,stddev] = NormalApproxForRankSumTest(n1,n2,sct);
	
	% Returns the mean and standard deviation of the normal approximations for U values. These can be used to calculate significance for a U statistic. sct is a correction term for the standard deviation when ties are present. If sct is a vector or matrix, a vector or matrix of values will be returned provided n1 and n2 are constants.
	
	N = n1+n2;
	
	if ~exist('sct','var');
		sct = 0;
	end
		
	avg = n1*n2/2; 
	stddev = sqrt( n1*n2*(N^3-N-sct) / (12*N*(N-1)) );
		
	% stddev = sqrt(n1*n2*(N+1)/12); %This is the formula for no tied ranks. Easy to see that it is the formula above with sct = 0.
