function V = V2Parametric_gust(x,y,Vmag,t)
	%Parametric definition of the wind along the x-axis
	
	if mod(t,20) < 10;
		V = 2*Vmag*ones(size(x));
	else;
		V = zeros(size(x));
  	end
	
