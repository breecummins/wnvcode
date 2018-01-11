function U = V1Parametric_time(x,y,Vmag,t)
	%Parametric definition of the wind along the x-axis
	
	T = 100;
	
	mt = mod(t,T);
	if mt < T/2;
		theta = -pi/4 + (pi/T) * mt;
	else;
		theta = pi/4 - (pi/T) * (mt-T/2);
	end
	U = Vmag*sin(theta)*ones(size(x));
  
	
