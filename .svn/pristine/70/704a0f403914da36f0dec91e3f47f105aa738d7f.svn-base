clear
close all

% [x,y]=meshgrid(0:0.05:1);
% 
% a = 5*pi;
% b = 1/4 * 0.1;
% c = 8*x * 0.1;
% 
% V1 = -a*b*cos(a*y).*(x+0.1);
% V2 = c+b*sin(a*y);
% quiver(x,y,V1,V2),axis equal
% 
% 

% figure
% %my flow 
% [x,y]=meshgrid(0:100/128:100);
% 
% V = 0.2;
% a = 0.025*pi;
% b = ((sqrt(7)-1)/4);
% 
% V1 = b*V*sin(a*y);
% V2 = b*V*cos(a*(x-30)) + V/2;
% quiver(x,y,V1,V2),axis equal
% 
% sqrt(max(max(V1.^2+V2.^2)))

%new Ricardo flow
[x,y]=meshgrid(0:100/128:100);

V = 0.2;
a = 0.05*pi;
b = sqrt(3)/(2*a);
c = 1/2;

% V1 = -a*b*V*cos(a*y).*((x+10)/110);
% V2 = b*V*sin(a*y)/110 + c*V*((x+10)/110);
% %quiver(x,y,V1,V2,'k'),axis equal
% %figure
% 
% quiver(x(1:5:end,1:5:end),y(1:5:end,1:5:end),V1(1:5:end,1:5:end),V2(1:5:end,1:5:end),'k'),axis equal

figure
V1 = -a*b*V*cos(a*y).*((x+10)/110);
V2 = b*V*sin(a*y)/110 + c*V;
quiver(x(1:5:end,1:5:end),y(1:5:end,1:5:end),V1(1:5:end,1:5:end),V2(1:5:end,1:5:end),'k'),axis equal

sqrt(max(max(V1.^2+V2.^2)))

