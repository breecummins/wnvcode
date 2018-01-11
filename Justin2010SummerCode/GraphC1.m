function GraphC1(C,t,h,xm,ym,xc,yc,f)


figure(f);
clf
hold on

%% Plot chickens 
 plot(xc,yc,'rv')

%graph the concentration with 100 contour lines
Cmx = max(max(C));
%contour((h/2:h:1-h/2),(h/2:h:1-h/2),C,(0:0.01*Cmx:Cmx));
%Alternative contour graphing that just shows the CO2 threshold
%at which the mosquitoes change their behavior
contour((h/2:h:1-h/2),(h/2:h:1-h/2),C,[1e-3 1e-3]);
title(['Time = ',num2str(t)],'FontSize',14)
axis([0,1,0,1])
colormap(hot)
colorbar;
axis off

%Plot mosquitoes
plot(xm,ym,'b.')

pause(0.0001)

hold off
