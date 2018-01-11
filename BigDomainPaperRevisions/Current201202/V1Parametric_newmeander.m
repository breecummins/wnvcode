function x_vel = V1Parametric_newmeander(x,y,Vmag,t)
	%Parametric definition of the wind along the x-axis
  
	xf = 200;  yf = 400;
	ushift = 0; vshift = 10;
  	x_vel = Vmag*(-sin(pi*(x-10)/xf).*cos(pi*(y-t)/yf)+ushift)/(1+abs(ushift)); 
