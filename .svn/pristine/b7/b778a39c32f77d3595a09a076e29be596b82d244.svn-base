function N = GrowVisuals(C,savename,titulo,s)
% Produces animations of the current data being processed; screen captures
% are possible with lines 34-36; the direction field of wind flow can be
% shown with line 18


minC = min(min(C));
maxC = max(max(C));

contour(s.X,s.Y,C,minC:((maxC-minC)/20):maxC);
title(titulo);
axis equal, axis([s.x0 s.xf s.y0 s.yf]), colorbar
colormap(cool)
N = gcf;
saveas(N,['GrowCO2/images/',savename,'.bmp'])

% ,[s.dCm,s.dCM],':k','LineWidth',2