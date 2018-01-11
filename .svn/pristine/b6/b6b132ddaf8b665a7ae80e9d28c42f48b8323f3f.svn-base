

xf = 10;  yf = 20;
[x,y]=meshgrid(0 : 0.5 : 1*xf, 0 : 0.5 : 1*yf);

ushift = 0;
vshift = 1;

for t = 1:0.2:11
u = (-sin(pi*x/xf).*cos(pi*(y-t)/yf)+ushift)/(1+abs(ushift)); 
v = ((yf/xf)*cos(pi*x/xf).*sin(pi*(y-t)/yf)+vshift)/(1+abs(ushift));
quiver(x,y,u,v,'r'),axis equal
streamslice(x,y,u,v,2);

   
  pause(.1)
end