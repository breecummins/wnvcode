function y_vel = V2Parametric_newmeander(x,y,Vmag,t)
	%Parametric definition of the wind along the x-axis
  
	xf = 200;  yf = 400;
	ushift = 0; vshift = 10;
  	y_vel = Vmag*((yf/xf)*cos(pi*(x-10)/xf).*sin(pi*(y-t)/yf)+vshift)/(1+abs(vshift));