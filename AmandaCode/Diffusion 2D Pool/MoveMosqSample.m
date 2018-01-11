function [mx my whichchicken G_old theta outsideradius inradius mxkeep mykeep mxind myind] = MoveMosqSample(C,s,index,G_old,theta,mx,my,vx,vy,inradius,whichchicken,mxkeep,mykeep,mxind,myind)

% Calculates the movement of each mosquito, per CO2 and wind effects

% setup of mosquito removal within the host radius
outsideradius = [];

for k = 1:length(mx)
	mosqdistance = sqrt((s.Sx - mx(k)).^2 + (s.Sy - my(k)).^2 );
    mosq_close = min(mosqdistance);
    mxind(end+1) = mx(k);
    myind(end+1) = my(k);
    if mosq_close > s.host_radius;
        % finds unsettled mosquitoes
        outsideradius(end+1) = k;
    else
        % finds settled mosquitoes and the nearest chicken
    	inradius(end+1) = k;
        mxkeep(end+1) = mx(k);
        mykeep(end+1) = my(k);
        host_close = find(mosq_close == mosqdistance);
        whichchicken(end+1) = host_close;
    end
end

mx = mx(outsideradius);
my = my(outsideradius);

% mosquito memory for crosswind flight
cross_switch = zeros(2,length(mx));
% how long to go in the same direction relative to the wind
cross_switch(1,:) = round(s.crosswind_duration(1) + (s.dc*rand));
% which direction to go (+ or -)
cross_switch(2,:) = sign(rand(1,length(mx))-.5);

% b >= b0 indicates that there is a perceptible change in CO2
% G is the amount of carbon dioxide at each mosquito location
G = InterpFromGrid(mx,my,C,s.h);
dG_mosq = abs(G-G_old(outsideradius))/s.dCM;
direction = (dG_mosq >= s.dCm);

% higher CO2 concentration results in lower velocity
mspeed = s.S_max - (s.S_max-s.S_min).*ResponseFunction(dG_mosq,s.b0,s.bsat,s.kappa);
% indices of where there is no perceptible CO2
index_noC = find(direction == 0);
% maximum velocity in the absence of CO2
mspeed(index_noC) = s.S_max.*ones(size(index_noC));

% direction dependent on CO2 concentration comparison
if (s.tn(index) - s.mt0 < s.mdt)
    theta0c = 2*pi.*rand(1,length(outsideradius));
elseif isempty(outsideradius)
    theta0c = 0;
else
    G1 = (G_old(outsideradius) <= G);
    G2 = (G_old(outsideradius) > G);
    theta = theta(outsideradius);
    theta0c = (G1.*theta) + (G2.*(-theta));
end
thetac = PickDirection(theta0c,s.Cdirmin,s.Cdirmax,dG_mosq,s.dCm,s.dCM,s.kappa);

G_old = G;

% mosquito steps for CO2: dt*v*direction
cxm = s.mdt.*mspeed.*cos(thetac);
cym = s.mdt.*mspeed.*sin(thetac);

% current wind velocity functions
u = InterpFromGrid(mx,my,vx,s.h);
v = InterpFromGrid(mx,my,vy,s.h);
vmag = sqrt(u.^2 + v.^2);

% direction dependent on wind
if isempty(outsideradius)
    theta0v = 0;
else
    theta0v = atan2(v,u);
end
thetav = PickDirection(theta0v,s.Vdirmin,s.Vdirmax,vmag,s.wind_thresh,s.wind_sat,s.wind_kappa);

% counters for crosswind behavior changes
if s.wind_mode > 2;
    for counter = 1:length(mx)
        if (cross_switch(1,counter) == 0)
	    	cross_switch(2,counter) = -cross_switch(2,counter);
	        cross_switch(1,counter) = round(s.crosswind_duration(1) + ...
                (dc*rand));
        end
    end
    % decrement the timers
	cross_switch(1,:) = cross_switch(1,:) - 1;
end

% ranging flight; when CO2 is present, flight becomes upwind
if (s.wind_mode == 1)    % upwind
	target_angle = thetav + pi;
elseif (s.wind_mode == 2)    % downwind
	target_angle = thetav + pi.*direction;
elseif (s.wind_mode < 5)    % crosswind with upwind bias
	target_angle = thetav + ((pi/4).*cross_switch(2,:)).*not(direction) ...
        + pi.*direction;
elseif (s.wind_mode == 5)    % crosswind only
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
mx = mx + xdir;
my = my + ydir;

theta = atan2(ydir,xdir);

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