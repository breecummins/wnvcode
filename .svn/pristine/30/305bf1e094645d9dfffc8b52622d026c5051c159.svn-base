function [mu,sig2,vals,x] = SSFitNormal(ustats,Nm);
	
	%fits normal distribution to ustats on the range [0,Nm^2]. vals returns the normal distribution evaluated on x=0:Nm^2.
	mu = mean(ustats);
	sig2 = var(ustats);

	if nargin == 2;
		x=0:Nm^2;
		vals = (1/sqrt(2*pi*sig2))*exp(-(x-mu).^2./(2*sig2));
	else;
		x=[];
		vals=[];
	end
	
	