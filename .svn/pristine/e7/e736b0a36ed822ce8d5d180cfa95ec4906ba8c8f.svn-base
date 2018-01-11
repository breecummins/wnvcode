function [mx my cross_switch whichchicken] = MoveMosquitoes(C,mx,my,...
    S_max,S_min,b0,bsat,kappa,Cxp,Cxn,Cyp,Cyn,h,Cdirmin,Cdirmax,mdt,vx,...
    vy,Vdirmin,Vdirmax,wind_thresh,wind_sat,wind_kappa,wind_mode,...
    cross_switch,windweight,gradweight,Sx,Sy,host_radius,x0,xf,y0,yf,dc,...
    crosswind_duration)

% Calculates the movement of each mosquito, per CO2 gradient and wind
% effects

% remove mosquitoes within the host radius
outsideradius = [];
whichchicken = [];

for k = 1:length(mx);
	mosqdistance = sqrt((Sx - mx(k)).^2 + (Sy - my(k)).^2 );
    if mosqdistance > host_radius;
        % finds unsettled mosquitoes
        outsideradius(end+1) = k;
    else
        % finds the nearest chicken to each mosquito
    	inradius = find(mosqdistance == min(mosqdistance...
            (find(mosqdistance <= host_radius))));
    	whichchicken(end+1) = inradius;
    end
end

% b is threshold level of CO2
b = InterpFromGrid(mx,my,C,h);
% b >= b0 indicates that there is a perceptible level of CO2
direction = (b >= b0);

% higher CO2 concentration results in lower velocity
mspeed = S_max - (S_max-S_min).*ResponseFunction(b,b0,bsat,kappa);
% indices of where there is no perceptible CO2
index_noC = find(direction == 0);
% maximum velocity in the absence of CO2
mspeed(index_noC) = S_max.*ones(size(index_noC));

% CO2 gradients and interpolation
dCdx = (Cxn-Cxp)/(2*h);
dCdy = (Cyn-Cyp)/(2*h);
gradxm = InterpFromGrid(mx,my,dCdx,h);
gradym = InterpFromGrid(mx,my,dCdy,h);
gradmag = sqrt(gradxm.^2 + gradym.^2);

% direction dependent on CO2
theta0 = atan2(gradym,gradxm);
theta = pickDirection(theta0,Cdirmin,Cdirmax,gradmag,b0,bsat,kappa);

% mosquito steps for CO2: dt*v*direction
cxm = mdt.*mspeed.*cos(theta);
cym = mdt.*mspeed.*sin(theta);

% current wind velocity functions
u = InterpFromGrid(mx,my,vx,h);
v = InterpFromGrid(mx,my,vy,h);
vmag = sqrt(u.^2 + v.^2);

% direction dependent on wind
theta0v = atan2(v,u);
thetav = pickDirection(theta0v,Vdirmin,Vdirmax,...
    vmag,wind_thresh,wind_sat,wind_kappa);

% counters for crosswind behavior changes
if wind_mode > 2;
    for counter = 1:length(mx)
        if (cross_switch(1,counter) == 0)
	    	cross_switch(2,counter) = -cross_switch(2,counter);
	        cross_switch(1,counter) = round(crosswind_duration(1) + ...
                (dc*rand));
        end
    end
    % decrement the timers
	cross_switch(1,:) = cross_switch(1,:) - 1;
end

% ranging flight; when CO2 is present, flight becomes upwind
if (wind_mode == 1)
    % upwind
	target_angle = thetav + pi;
elseif (wind_mode == 2)
    % downwind
	target_angle = thetav + pi.*direction;
elseif (wind_mode < 5)
    % crosswind with upwind bias
	target_angle = thetav + ((pi/4).*cross_switch(2,:)).*not(direction) ...
        + pi.*direction;
elseif (wind_mode == 5)
    % crosswind only
	target_angle = thetav + ((pi/2)*cross_switch(2,:)).*not(direction) ...
        + pi.*direction;
end

% mosquito steps for wind: dt*v*dir
vxm = mdt.*mspeed.*cos(target_angle);
vym = mdt.*mspeed.*sin(target_angle);

% combine wind and gradient effects on direction, no CO2 makes dependent on
% wind only
windscaling = windweight + not(direction)*gradweight;
gradscaling = gradweight - not(direction)*gradweight; 
	
% redefine mosquito locations to next step; third term carries regardless
% of mosquito decisions
xdir = windscaling.*vxm + gradscaling.*cxm + u*mdt;
ydir = windscaling.*vym + gradscaling.*cym + v*mdt;
mx(outsideradius) = mx(outsideradius) + xdir(outsideradius);
my(outsideradius) = my(outsideradius) + ydir(outsideradius);

% keeps mosquitoes in the domain
for k = 1:length(mx)
    if mx(k) < x0
        mx(k) = 2*x0 - mx(k);
    end
    if mx(k) > xf
        mx(k) = 2*xf - mx(k);
    end
    if my(k) < y0
        my(k) = 2*y0 - my(k);
    end
    if my(k) > yf
        my(k) = 2*yf - my(k);
    end
end