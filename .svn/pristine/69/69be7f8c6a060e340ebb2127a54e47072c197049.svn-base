function [ wx wy ] = dp(s,chickencount,p,q)

% DIPOLE
% "s" variable struct, "chickencount" number of chickens across domain

% % exhalation
% random?
% s.f = dptheta(s,chickencount);

% velocity
ug = zeros(size(p));
vg = zeros(size(q));

for k = 1:chickencount
    dx = p - s.Sx(k);
    dy = q - s.Sy(k);
    r = dx.^2 + dy.^2;
    
    D1 = ((s.d^2)-r)./((s.d^2)+r).^2;
    D2 = 2./((s.d^2)+r).^2;
    
    fdotx = s.f(k,1)*dx + s.f(k,2)*dy;

    ug = ug + s.f(k,1)*D1 + fdotx.*dx.*D2;
    vg = vg + s.f(k,2)*D1 + fdotx.*dy.*D2;    
end
wx = ug/(4*pi);
wy = vg/(4*pi);

% plot field (directional arrows in red)
hold on
    axis equal, axis([s.x0 s.xf s.y0 s.yf])
    sk = 2;
    p1 = p(1:sk:end,1:sk:end);
    q1 = q(1:sk:end,1:sk:end);
    u1 = ug(1:sk:end,1:sk:end);
    v1 = vg(1:sk:end,1:sk:end);
    quiver(p1,q1,u1,v1)
    quiver(s.Sx',s.Sy',s.f(:,1),s.f(:,2),'r')
hold off