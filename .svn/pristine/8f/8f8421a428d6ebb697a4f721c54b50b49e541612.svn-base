function GraphC(C,t,h,xm,ym,xc,yc)

% if abs(mod(t,0.5) - 0.1) < 1.e-3;
% 	figure;
% end
figure(1);
clf
hold on


%if the concentration becomes negative, report it
Cmn=min(min(C));
if Cmn < 0;
	disp(['Cmn = ',num2str(Cmn),' at t = ',num2str(t)])
end

%graph the concentration with 100 contour lines
Cmx = max(max(C));
contour((h/2:h:1-h/2),(h/2:h:1-h/2),C,(0:0.01*Cmx:Cmx));
%Alternative contour graphing that just shows the CO2 threshold
%at which the mosquitoes change their behavior
%contour((h/2:h:1-h/2),(h/2:h:1-h/2),C,[1e-3 1e-3]);
set(gca,'FontSize',24)
title(['Time = ',num2str(t)])
axis([0,1,0,1])
colormap(cool)
colorbar('FontSize',24);
caxis([0,0.07])
axis off

%Plot mosquitoes
plot(xm,ym,'k.','MarkerSize',16)

%% Plot chickens 
plot(xc,yc,'kv')

% set(gcf,'PaperPosition',[0,0,8.0,6.0])
% set(gcf,'PaperSize',[8.0,6.0])

pause(0.0001)

hold off
