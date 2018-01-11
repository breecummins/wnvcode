function y_vel = V2Parametric_newmeander_notime(x,y,Vmag,t)
	%Parametric definition of the wind along the x-axis
  
	xf = 300;  yf = 200;
	vshift = 1;
  	y_vel = Vmag*((yf/xf)*cos(pi*(x-10)/xf).*sin(pi*(y)/yf +pi )+vshift)/(1+abs(vshift));