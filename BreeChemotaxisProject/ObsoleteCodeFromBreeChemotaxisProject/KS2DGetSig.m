function [sig, D, Z] = KSDGetSig(F,f)
	
	%F and f are two n x 4 matrices, each containing the Fasano-Franceschini cumulative distribution for a data set at the same number of points. Each of the columns uses one of the four possible orderings in the plane. F and f must have these orderings in the same columns, or the comparison is invalid (e.g., <x<y in the first column, <x>y in the second, >x<y in the third, >x>y in the fourth).
	
	%THIS FUNCTION WILL HAVE TO CHANGED IF F and f EVER HAVE DIFFERENT #'s OF POINTS, OR IF A ONE-SIDED COMPARISON IS DESIRED. 

	D = max( max(abs(F-f)));
	n = size(F,1);
	Z = sqrt(n/2)*D;
	sig = NaN;
	
	
	