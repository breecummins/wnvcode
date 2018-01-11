function [ wx wy ] = dipole(s,chickencount)

% DIPOLE

% host number and size
Nh = chickencount;
d = 0.25;

% exhalation
for g = 1:Nh
    if (s.Sx(g) < (s.xf/2)) && (s.Sy(g) < s.yf/2)
        theta(g) = .5*pi*rand;
    elseif (s.Sx(g) > (s.xf/2)) && (s.Sy(g) < s.yf/2)
        theta(g) = .5*pi*rand + (pi/2);
    elseif (s.Sx(g) < (s.xf/2)) && (s.Sy(g) > s.yf/2)
        theta(g) = .5*pi*rand - (pi/2);
    elseif (s.Sx(g) > (s.xf/2)) && (s.Sy(g) > s.yf/2)
        theta(g) = .5*pi*rand + pi;
    end
    f(g,:) = 2*pi*(d^2)*[ cos(theta(g)) sin(theta(g)) ];
end

% velocity
ug = zeros(size(s.X));
vg = zeros(size(s.Y));

for k = 1:Nh
    dx = s.X - s.Sx(k);
    dy = s.Y - s.Sy(k);
    r = dx.^2 + dy.^2;
    
    D1 = ((d^2)-r)./((d^2)+r).^2;
    D2 = 2./((d^2)+r).^2;
    
    fdotx = f(k,1)*dx + f(k,2)*dy;

    ug = ug + f(k,1)*D1 + fdotx.*dx.*D2;
    vg = vg + f(k,2)*D1 + fdotx.*dy.*D2;
    
end
wx = @(X,Y) ug/(2*pi);
wy = @(X,Y) vg/(2*pi);

% plot field (directional arrows in red)
hold on
    axis equal, axis([s.x0 s.xf s.y0 s.yf])
    quiver(s.X,s.Y,wx(s.X,s.Y),wy(s.X,s.Y))
    quiver(s.Sx',s.Sy',f(:,1),f(:,2),'r')
hold off