%Parametric definition of the wind along the x-axis
function y_vel = V2Parametric(xg,yg,Vmag)

  xf = 3/7;  yf = 2/7;
  vshift = 1;
  y_vel = Vmag*((yf/xf)*cos(pi*(xg+1/7)/xf).*sin(pi*(yg)/yf +pi )+vshift)/(1+abs(vshift));
