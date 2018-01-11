% squarewind.m

L =  1;
h = 4/70;
Vmag = 0.2;
xf = 3/7;  yf = 2/7;
vshift = 1;

[xg,yg] = meshgrid(h/2:h:L,h/2:h:L);

u = Vmag*(-sin(pi*(xg+1/7)/xf).*cos(pi*(yg)/yf + pi))/(1+abs(vshift)); 
v = Vmag*((yf/xf)*cos(pi*(xg+1/7)/xf).*sin(pi*(yg)/yf +pi )+vshift)/(1+abs(vshift));

quiver(xg,yg,u,v)