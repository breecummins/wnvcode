function [C,tn,dt,S,Sx,Sy,K,windx,windy,h,X,Y,mx,my,S_max,S_min,b0,bsat,...
    kappa,Cdirmin,Cdirmax,mdt,mt0,Vdirmin,Vdirmax,wind_thresh,wind_sat,...
    wind_kappa,wind_mode,cross_switch,windweight,gradweight,host_radius,...
    x0,xf,y0,yf,Gsat,Gthresh,dc,crosswind_duration,frames,Nx,D] =...
    Variable_cm(chickencount,littlechicken,windtype,mosqcount,windsense)

% C02 SETUP
%-------------------------------------------------------------------------%
% domain bounds
x0 = 0;
xf = 3048;
y0 = 0;
yf = 1524;

% number of intervals
Nx = (xf-x0);
Ny = (yf-y0);

% h = (xf-x0)/Nx = (yf-y0)/Ny
h = (xf-x0)/Nx;

% gridpoints for CO2
x = x0+(h/2):h:xf;
y = y0+(h/2):h:yf;
[X Y] = meshgrid(x,y);

% diffusion constant (16 mm^2/s = .16 cm^2/s)
D = .16*60;

% initial condition for CO2
C = zeros(size(X));
%-------------------------------------------------------------------------%


% TIME
%-------------------------------------------------------------------------%
% time parameters, in minutes
t0 = 0;
tf = 720;

% adjusted time step
dt0 = (h^2)/(4*D);
dtnum = ceil((tf-t0)/dt0);
dt = min(((tf-t0)/dtnum),h);

% time vector
tn = t0:dt:tf;
%-------------------------------------------------------------------------%


% MISCELLANY
%-------------------------------------------------------------------------%
% interval of frames to plot
frames = 1;

% coefficient for center difference approximation matrix
K = (D*dt/(h^2));
%-------------------------------------------------------------------------%


% SOURCE
%-------------------------------------------------------------------------%
% source positions: x0 + h/2 < Sx < xf - h/2; y0 + h/2 < Sy < yf - h/2
% vectors are set up as percents of total domain to facilitate changes in
% domain units or size
if chickencount == 10
    switch littlechicken
        case '1'
            Sx = xf.*[.03 .03 .03 .03 .05 .05 .05 .05 .07 .96];
            Sy = yf.*[.78 .82 .86 .90 .78 .82 .86 .90 .84 .84];
        case '2'
            Sx = xf.*[.93 .95 .95 .95 .95 .97 .97 .97 .97 .04];
            Sy = yf.*[.84 .78 .82 .86 .90 .78 .82 .86 .90 .84];
    end
elseif chickencount == 9
    switch littlechicken
        case '1'
            Sx = xf.*[.03 .03 .03 .03 .05 .05 .05 .05 .96];
            Sy = yf.*[.78 .82 .86 .90 .78 .82 .86 .90 .84];
        case '2'
            Sx = xf.*[.95 .95 .95 .95 .97 .97 .97 .97 .04];
            Sy = yf.*[.78 .82 .86 .90 .78 .82 .86 .90 .84];
    end
end

% sufficient distance from vector to host to count as contact
host_radius = 10;

% source shut off time
sourceoff = tf;

% amount of source input, turned off at sourceoff
S = zeros(length(Sx),length(tn));

for k = 1:length(tn)
    for j = 1:length(Sx)
        if tn(k) <= sourceoff
            S(j,k) = (.1)*60*dt;
        elseif tn(k) > sourceoff
            S(:,k) = 0;
        end
    end
end
%-------------------------------------------------------------------------%


% WIND
%-------------------------------------------------------------------------%
switch windtype
    case 'clockwise'
        windx = @(X,Y) .0001*(-sin(pi*(X/xf)).*cos(pi*(Y/yf)));
        windy = @(X,Y) .0001*(yf/xf)*(cos(pi*(X/xf)).*sin(pi*(Y/yf)));
    case 'counter-clockwise'
        windx = @(X,Y) .0001*(sin(pi*(X/xf)).*cos(pi*(Y/yf)));
        windy = @(X,Y) .0001*(yf/xf)*(-cos(pi*(X/xf)).*sin(pi*(Y/yf)));
    case 'none'
        windx = @(X,Y) 0*X;
        windy = @(X,Y) 0*Y;
end

% for test of wind sensitivity
maxvx = max(max(windx(X,Y)));
minvx = min(min(windx(X,Y)));
%-------------------------------------------------------------------------%


% MOSQUITOES
%-------------------------------------------------------------------------%
% number of mosquitoes
switch mosqcount
    case '1'
        m = 1;
    case '2'
        m = 200;
end

% mosquito start box edges
mosqx0 = ((xf-x0)/2)-h;
mosqxf = ((xf-x0)/2)+h;
mosqy0 = y0;
mosqyf = y0+(2*h);

% initial randomized coordinates of mosquitoes within the start box
mdx = mosqxf-mosqx0;
mdy = mosqyf-mosqy0;
mx = mdx*rand(1,m) + mosqx0;
my = mdy*rand(1,m) + mosqy0;

% mosquito timestep
mdt = 1/60;

% mosquito entrance time
mt_try = 30;
mt0 = mt_try + rem(mt_try,mdt);

% response threshold to CO2
b0 = 0.001;
% CO2 saturation
bsat = .1;
% saturation gradient .0099
Gsat = (bsat - b0);
% threshold gradient
Gthresh = b0;
% curvature parameter for response function (0 = linear model)
kappa = 0;
% window lengths around CO2 gradient direction
Cdirmin = pi/6;
Cdirmax = pi;

% minimum mosquito speed in the presence of CO2 (.4 m = 1.33 ft)
S_min = 40*60;
% maximum allowed speed; speed below CO2 threshold (1.5 m = 5 ft)
S_max = 150*60;

% magnitude of wind flow, < mosq flight speed
Vmag = S_min/20;
% window lengths around wind direction
Vdirmin = pi/3;
Vdirmax = 2*pi;

% response thresholds to wind
switch windsense
    % no wind sensitivity
    case '0'
        wind_thresh = 1;
        wind_sat = 1;
    % no wind sensitivity
    case '1'
        wind_thresh = .00005;
        wind_sat = .0001;
end

% curvature parameter for response function (0 = linear model)
wind_kappa = 0;
% 1. upwind / 2. downwind / 3,4. crosswind with bias / 5. crosswind
wind_mode = 1;
% fly +/- perpendicular for x1 to x2 decisions
crosswind_duration = round([5,5]./mdt);
% change in number of decisions?
dc = crosswind_duration(2)-crosswind_duration(1);

% mosquito memory for crosswind flight
cross_switch = zeros(2,m);
% how long to go in the same direction relative to the wind
cross_switch(1,:) = round(crosswind_duration(1) + (dc*rand));
% which direction to go (+ or -)
cross_switch(2,:) = sign(rand(1,m)-.5);
% scaling factor for mosquito response to CO2 gradient above CO2 threshold
gradweight = 0.9;
% scaling factor for mosquito response to wind above CO2 threshold
windweight = 1-gradweight;
%-------------------------------------------------------------------------%