function [s C] = Variable_struct(chickencount,littlechicken,windtype,...
    mosqcount,windsense,pretime,loadname)

addpath GrowCO2/

% C02 SETUP
%-------------------------------------------------------------------------%
% domain bounds
s.x0 = 0;
s.xf = 30.5;
s.y0 = 0;
s.yf = 15.2;

% number of intervals
s.Nx = 10*(s.xf-s.x0);
s.Ny = 10*(s.yf-s.y0);

% h = (xf-x0)/Nx = (yf-y0)/Ny
s.h = (s.xf-s.x0)/s.Nx;

% gridpoints for CO2
s.x = s.x0+(s.h/2):s.h:s.xf;
s.y = s.y0+(s.h/2):s.h:s.yf;
[X Y] = meshgrid(s.x,s.y);
s.X = X;
s.Y = Y;

% diffusion constant (16 mm^2/s = .16 cm^2/s)
s.D = .000016*60;

% initial condition for CO2
load(['GrowCO2/',loadname,'.mat'],'C')
%-------------------------------------------------------------------------%


% TIME
%-------------------------------------------------------------------------%
% time parameters, in minutes
s.t0 = pretime;
s.tf = 720;

% adjusted time step
s.dt0 = (s.h^2)/(4*s.D);
s.dtnum = ceil((s.tf-s.t0)/s.dt0);
s.dt = min(((s.tf-s.t0)/s.dtnum),s.h);

% time vector
s.tn = s.t0:s.dt:s.tf;
%-------------------------------------------------------------------------%


% MISCELLANY
%-------------------------------------------------------------------------%
% interval of frames to plot
s.frames = 10;

% coefficient for center difference approximation matrix
s.K = (s.D*s.dt/(s.h^2));
%-------------------------------------------------------------------------%


% SOURCE
%-------------------------------------------------------------------------%
% source positions: x0 + h/2 < Sx < xf - h/2; y0 + h/2 < Sy < yf - h/2
% vectors are set up as percents of total domain to facilitate changes in
% domain units or size
if chickencount == 10
    switch littlechicken
        case '2'
            s.Sx = (s.xf-s.x0).*[.03 .03 .03 .03 .05 .05 .05 .05 .07 .96];
            s.Sy = (s.yf-s.y0).*[.78 .82 .86 .90 .78 .82 .86 .90 .84 .84];
        case '1'
            s.Sx = (s.xf-s.x0).*[.93 .95 .95 .95 .95 .97 .97 .97 .97 .04];
            s.Sy = (s.yf-s.y0).*[.84 .78 .82 .86 .90 .78 .82 .86 .90 .84];
    end
elseif chickencount == 9
    switch littlechicken
        case '2'
            s.Sx = (s.xf-s.x0).*[.03 .03 .03 .03 .05 .05 .05 .05 .96];
            s.Sy = (s.yf-s.y0).*[.78 .82 .86 .90 .78 .82 .86 .90 .84];
        case '1'
            s.Sx = (s.xf-s.x0).*[.95 .95 .95 .95 .97 .97 .97 .97 .04];
            s.Sy = (s.yf-s.y0).*[.78 .82 .86 .90 .78 .82 .86 .90 .84];
    end
end

% sufficient distance from vector to host to count as contact
s.host_radius = .50;

% source shut off time
s.sourceoff = s.tf;

% amount of source input, turned off at sourceoff
S = zeros(length(s.Sx),length(s.tn));
for k = 1:length(s.tn)
    for j = 1:length(s.Sx)
        if s.tn(k) <= s.sourceoff
            S(j,k) = (.001680)*60;
        elseif s.tn(k) > s.sourceoff
            S(:,k) = 0;
        end
    end
end
s.S = S;
%-------------------------------------------------------------------------%


% WIND
%-------------------------------------------------------------------------%
switch windtype
    case 'cl'
        s.windx = @(X,Y) .0005*(-sin(pi*(X/s.xf)).*cos(pi*(Y/s.yf)));
        s.windy = @(X,Y) .0005*(s.yf/s.xf)*(cos(pi*(X/s.xf)).*sin(pi*(Y/s.yf)));
    case 'cc'
        s.windx = @(X,Y) .0005*(sin(pi*(X/s.xf)).*cos(pi*(Y/s.yf)));
        s.windy = @(X,Y) .0005*(s.yf/s.xf)*(-cos(pi*(X/s.xf)).*sin(pi*(Y/s.yf)));
    case 'no'
        s.windx = @(X,Y) 0*X;
        s.windy = @(X,Y) 0*Y;
end

% for test of wind sensitivity
s.maxvx = max(max(s.windx(X,Y)));
s.minvx = min(min(s.windx(X,Y)));
%-------------------------------------------------------------------------%


% MOSQUITOES
%-------------------------------------------------------------------------%
% number of mosquitoes
switch mosqcount
    case '1'
        s.m = 1;
    case '2'
        s.m = 200;
end

% mosquito start box edges
s.mosqx0 = ((s.xf-s.x0)/2)-s.h;
s.mosqxf = ((s.xf-s.x0)/2)+s.h;
s.mosqy0 = s.y0;
s.mosqyf = s.y0+(2*s.h);

% initial randomized coordinates of mosquitoes within the start box
s.mdx = s.mosqxf-s.mosqx0;
s.mdy = s.mosqyf-s.mosqy0;
s.mx = s.mdx*rand(1,s.m) + s.mosqx0;
s.my = s.mdy*rand(1,s.m) + s.mosqy0;

% mosquito timestep
s.mdt = 1/60;

% mosquito entrance time
s.mt_try = pretime;
s.mt0 = s.mt_try + rem(s.mt_try,s.mdt);


% CARBON DIOXIDE
%-------------------------------------------------------------------------%
% response threshold and saturation to CO2
s.b0 = 0.01;
s.bsat = 1;
% threshold and saturation (0.99) gradients
s.Gthresh = s.b0;
s.Gsat = (s.bsat - s.b0);
% threshold and saturation differentials (sampling method)
s.dCm = .0000002;
s.dCM = .000080;
% curvature parameter for response function (0 = linear model)
s.kappa = 0;
% window lengths around CO2 gradient direction
s.Cdirmin = pi/6;
s.Cdirmax = pi;

% minimum mosquito speed in the presence of CO2 (.4 m = 1.33 ft)
s.S_min = .4*60;
% maximum allowed speed; speed below CO2 threshold (1.5 m = 5 ft)
s.S_max = 1.5*60;

% magnitude of wind flow, < mosq flight speed
s.Vmag = s.S_min/20;
% window lengths around wind direction
s.Vdirmin = pi/12;
s.Vdirmax = pi;

% response thresholds to wind
switch windsense
    % no wind sensitivity
    case '0'
        s.wind_thresh = 1;
        s.wind_sat = 1;
    % some wind sensitivity
    case '1'
        s.wind_thresh = .00005;
        s.wind_sat = .0001;
end

% curvature parameter for response function (0 = linear model)
s.wind_kappa = 0;
% 1. upwind / 2. downwind / 3,4. crosswind with bias / 5. crosswind
s.wind_mode = 1;
% fly +/- perpendicular for x1 to x2 decisions
s.crosswind_duration = round([5,5]./s.mdt);
% change in number of decisions?
s.dc = s.crosswind_duration(2)-s.crosswind_duration(1);

% % mosquito memory for crosswind flight
% s.cross_switch = zeros(2,s.m);
% % how long to go in the same direction relative to the wind
% s.cross_switch(1,:) = round(s.crosswind_duration(1) + (s.dc*rand));
% % which direction to go (+ or -)
% s.cross_switch(2,:) = sign(rand(1,s.m)-.5);
% scaling factor for mosquito response to CO2 gradient above CO2 threshold
s.gradweight = 0.9;
% scaling factor for mosquito response to wind above CO2 threshold
s.windweight = 1-s.gradweight;
%-------------------------------------------------------------------------%