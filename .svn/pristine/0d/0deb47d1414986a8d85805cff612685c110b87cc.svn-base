function [vx vy vxpa vxna vypa vyna] = WindMatrixCreation(s,windtype,chickencount)

% Creates a matrix defining the wind, per upwinding scheme

vx = s.windx;
vy = s.windy;

%   for function handles
%     vx = s.windx(s.X,s.Y);
%     vy = s.windy(s.X,s.Y);
%     vx0 = s.windx((s.X(:,1)-s.h),s.Y(:,1));
%     vxL = s.windx((s.X(:,end)+s.h),s.Y(:,end));
%     vy0 = s.windy(s.X(1,:),(s.Y(1,:)-s.h));
%     vyL = s.windy(s.X(end,:),s.Y(end,:)+s.h);

vx0 = s.wx(2:end-1,1);
vxL = s.wx(2:end-1,end);
vy0 = s.wy(1,2:end-1);
vyL = s.wy(end,2:end-1);

vxp = [vx0, vx(:,1:end-1)];
vxn = [vx(:,2:end), vxL];
vyp = [vy0; vy(1:end-1,:)];
vyn = [vy(2:end,:); vyL];

vxpa = (vx + vxp)/2;
vxna = (vx + vxn)/2;
vypa = (vy + vyp)/2;
vyna = (vy + vyn)/2;