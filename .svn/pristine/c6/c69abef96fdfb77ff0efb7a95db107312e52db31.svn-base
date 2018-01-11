function [s C] = GrowVariables_mps(chickencount,littlechicken,windtype,...
    growtime)

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
s.D = .000016*50;

% initial condition for CO2
C = zeros(size(s.X));
%-------------------------------------------------------------------------%


% TIME
%-------------------------------------------------------------------------%
% time parameters, in seconds
s.t0 = 0;
s.tf = growtime;

% adjusted time step
s.dt0 = (s.h^2)/(4*s.D);
s.dtnum = ceil((s.tf-s.t0)/s.dt0);
s.dt = min(((s.tf-s.t0)/s.dtnum),s.h);

% time vector
s.tn = s.t0:s.dt:s.tf;

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

% source shut off time
s.sourceoff = s.tf;

% amount of source input, turned off at sourceoff
S = zeros(length(s.Sx),length(s.tn));
for k = 1:length(s.tn)
    for j = 1:length(s.Sx)
        if s.tn(k) <= s.sourceoff
            S(j,k) = (0.10/60)*s.dt;
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