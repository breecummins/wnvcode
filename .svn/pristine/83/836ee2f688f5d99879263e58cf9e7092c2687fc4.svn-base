%Parametric definition of the wind along the x-axis
function x_vel = V1Parametric(xg,yg,Vmag)
  
  xf = 3/7;  yf = 2/7;
  vshift = 1;
  x_vel = Vmag*(-sin(pi*(xg+1/7)/xf).*cos(pi*(yg)/yf + pi))/(1+abs(vshift));