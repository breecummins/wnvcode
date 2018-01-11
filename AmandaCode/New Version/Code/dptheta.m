function f = dptheta(s,chickencount)
    
% exhalation
for g = 1:chickencount
    if (s.Sx(g) < (s.xf/2)) && (s.Sy(g) < s.yf/2)
        theta(g) = .5*pi*rand;
    elseif (s.Sx(g) > (s.xf/2)) && (s.Sy(g) < s.yf/2)
        theta(g) = .5*pi*rand + (pi/2);
    elseif (s.Sx(g) < (s.xf/2)) && (s.Sy(g) > s.yf/2)
        theta(g) = .5*pi*rand - (pi/2);
    elseif (s.Sx(g) > (s.xf/2)) && (s.Sy(g) > s.yf/2)
        theta(g) = .5*pi*rand + pi;
    end
    f(g,:) = 2*pi*(s.d^2)*[ cos(theta(g)) sin(theta(g)) ];
end