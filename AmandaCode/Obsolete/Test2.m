%=========================================================================%
% TOY PROBLEM (m/min)
%=========================================================================%

x0 = 0; xf = 5; y0 = 0; yf = 10;
diff_x = xf-x0; diff_y = yf-y0;
Nx = 10*(diff_x); Ny = 10*(diff_y);
h = (diff_x)/Nx;
x = x0+(h/2) : h : xf; y = y0+(h/2) : h : yf;
[X Y] = meshgrid(x,y);

D = .000016*60;
C = zeros(size(X));

t0 = 0; tf = 120;
dt = (h^2)/(4*D);
tn = t0:dt:tf;

K = (D*dt)/(h^2);

Sx = (diff_x).*[.2 .7 .9]; Sy = (diff_y).*[.2 .8 .6];
host_radius = .1;
for j = 1:length(Sx)
    S(1,j) = (.1)*60*dt;
end

w = .001;
windx = @(X,Y) w*(-sin(pi*(X/diff_x)).*cos(pi*(Y/diff_y)));
windy = @(X,Y) w*(diff_y/diff_x)(-sin(pi*(X/diff_x)).*cos(pi*(Y/diff_y)));

m = 200;
mosqx0 = (diff_x/2)-h; mosqxf = (diff_x/2)+h;
mosqy0 = y0; mosqyf = y0+(2*h);
mdx = mosqxf-mosqx0; mdy = mosqyf-mosqy0;
mx = mdx*rand(1,m) + mosqx0; my = mdy*rand(1,m) + mosqy0;
mdt = 1/60;

% CARBON DIOXIDE
Cm = .1*60*dt;
CM = 50*.1*60*dt;

[vx vy vxpa vxna vypa vyna] = WindMatrixCreation(windx,windy,X,Y,h);
for index = 1:length(tn)
    [Cxp Cxn Cyp Cyn A] = CenterDiffApprox(C);
    vC = Wind(vxpa,vxna,vypa,vyna,Cxp,Cxn,Cyp,Cyn,C,h);
    [C_bare Cp] = Source(C,S,Sx,Sy,index);
    C_new = C_bare + (K*A) - (vC*dt);
    % MOVE MOSQUITOES -  SAMPLING TECHNIQUE
    
    