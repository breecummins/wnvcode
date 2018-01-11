function [vx vy vxpa vxna vypa vyna] = WindMatrixCreation(windx,windy,...
    X,Y,h)

% Creates a matrix defining the wind, per upwinding scheme

vx = windx(X,Y);
vy = windy(X,Y);

vx0 = windx((X(:,1)-h),Y(:,1));
vxL = windx((X(:,end)+h),Y(:,end));
vy0 = windy(X(1,:),(Y(1,:)-h));
vyL = windy(X(end,:),Y(end,:)+h);

vxp = [vx0, vx(:,1:end-1)];
vxn = [vx(:,2:end), vxL];
vyp = [vy0; vy(1:end-1,:)];
vyn = [vy(2:end,:); vyL];

vxpa = (vx + vxp)/2;
vxna = (vx + vxn)/2;
vypa = (vy + vyp)/2;
vyna = (vy + vyn)/2;