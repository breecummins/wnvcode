function [mx my cross_switch whichchicken inradius] = ...
    MoveMosqGrad(s,C,mx,my,Cxp,Cxn,Cyp,Cyn,vx,vy,cross_switch)

% Calculates the movement of each mosquito, per CO2 gradient and wind
% effects

% setup of mosquito removal within the host radius
outsideradius = [];
whichchicken = [];

for k = 1:length(mx);
	mosqdistance = sqrt((s.Sx - mx(k)).^2 + (s.Sy - my(k)).^2 );
    if mosqdistance > s.host_radius;
        % finds unsettled mosquitoes
        outsideradius(end+1) = k;
        inradius = [];
    else
        % finds the nearest chicken to each mosquito
    	inradius = find(mosqdistance == min(mosqdistance...
            (find(mosqdistance <= s.host_radius))));
    	whichchicken(end+1) = inradius;
    end
end

% b is threshold level of CO2
b = InterpFromGrid(mx,my,C,s.h);
% b >= b0 indicates that there is a perceptible level of CO2
direction = (b >= s.b0);

% higher CO2 concentration results in lower velocity
mspeed = s.S_max - (s.S_max-s.S_min).*ResponseFunction(b,s.b0,s.bsat,s.kappa);
% indices of where there is no perceptible CO2
index_noC = find(direction == 0);
% maximum velocity in the absence of CO2
mspeed(index_noC) = s.S_max.*ones(size(index_noC));

% CO2 gradients and interpolation
dCdx = (Cxn-Cxp)/(2*s.h);
dCdy = (Cyn-Cyp)/(2*s.h);
gradxm = InterpFromGrid(mx,my,dCdx,s.h);
gradym = InterpFromGrid(mx,my,dCdy,s.h);
gradmag = sqrt(gradxm.^2 + gradym.^2);

% direction dependent on CO2
theta0 = atan2(gradym,gradxm);
theta = PickDirection(theta0,s.Cdirmin,s.Cdirmax,gradmag,s.b0,s.bsat,s.kappa);

% mosquito steps for CO2: dt*v*direction
cxm = s.mdt.*mspeed.*cos(theta);
cym = s.mdt.*mspeed.*sin(theta);

% current wind velocity functions
u = InterpFromGrid(mx,my,vx,s.h);
v = InterpFromGrid(mx,my,vy,s.h);
vmag = sqrt(u.^2 + v.^2);

% direction dependent on wind
theta0v = atan2(v,u);
thetav = PickDirection(theta0v,s.Vdirmin,s.Vdirmax,...
    vmag,s.wind_thresh,s.wind_sat,s.wind_kappa);

% counters for crosswind behavior changes
if s.wind_mode > 2;
    for counter = 1:length(mx)
        if (cross_switch(1,counter) == 0)
	    	cross_switch(2,counter) = -cross_switch(2,counter);
	        cross_switch(1,counter) = round(crosswind_duration(1) + ...
                (s.dc*rand));
        end
    end
    % decrement the timers
	cross_switch(1,:) = cross_switch(1,:) - 1;
end

% ranging flight; when CO2 is present, flight becomes upwind
if (s.wind_mode == 1)
    % upwind
	target_angle = thetav + pi;
elseif (s.wind_mode == 2)
    % downwind
	target_angle = thetav + pi.*direction;
elseif (s.wind_mode < 5)
    % crosswind with upwind bias
	target_angle = thetav + ((pi/4).*cross_switch(2,:)).*not(direction) ...
        + pi.*direction;
elseif (s.wind_mode == 5)
    % crosswind only
	target_angle = thetav + ((pi/2)*cross_switch(2,:)).*not(direction) ...
        + pi.*direction;
end

% mosquito steps for wind: dt*v*dir
vxm = s.mdt.*mspeed.*cos(target_angle);
vym = s.mdt.*mspeed.*sin(target_angle);

% combine wind and gradient effects on direction, no CO2 makes dependent on
% wind only
windscaling = s.windweight + not(direction)*s.gradweight;
gradscaling = s.gradweight - not(direction)*s.gradweight; 
	
% redefine mosquito locations to next step; third term carries regardless
% of mosquito decisions
xdir = windscaling.*vxm + gradscaling.*cxm + u*s.mdt;
ydir = windscaling.*vym + gradscaling.*cym + v*s.mdt;
mx(outsideradius) = mx(outsideradius) + xdir(outsideradius);
my(outsideradius) = my(outsideradius) + ydir(outsideradius);

% keeps mosquitoes in the domain
for k = 1:length(mx)
    if mx(k) < s.x0
        mx(k) = 2*s.x0 - mx(k);
    end
    if mx(k) > s.xf
        mx(k) = 2*s.xf - mx(k);
    end
    if my(k) < s.y0
        my(k) = 2*s.y0 - my(k);
    end
    if my(k) > s.yf
        my(k) = 2*s.yf - my(k);
    end
end