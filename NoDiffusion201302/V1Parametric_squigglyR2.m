function U = V1Parametric_squigglyR2(x,y,Vmag)
	%Parametric definition of the wind along the x-axis
  
	a = 0.05*pi;
	b = sqrt(3)/(2*a);
	c = 1/2;
	
	corterm = 1;
	
	U = -a*b*Vmag*cos(a*y).*((x+10)/110)*corterm;
