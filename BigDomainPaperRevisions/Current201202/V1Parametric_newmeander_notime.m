function x_vel = V1Parametric_newmeander_notime(x,y,Vmag,t)
	%Parametric definition of the wind along the x-axis
  
	xf = 300;  yf = 200;
	vshift = 1;
  	x_vel = Vmag*(-sin(pi*(x-10)/xf).*cos(pi*(y)/yf + pi))/(1+abs(vshift)); 
