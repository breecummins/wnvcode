% SStoyCO2grad.m plots the toy CO2 conc and grad


clear 
close all


%perturbation problem
x0 = 0.4; y0 = 0.3;
[x,y] = meshgrid(0:0.001:1,0:0.001:1);
C = exp(-40*((x-x0).^2 + (y-y0).^2));
x1 = 0.3; y1 = 0.75;
Cperturb = 0.1*exp(-40*((x-x1).^2 + (y-y1).^2));
Csum = C + Cperturb;
m = max(max(Csum));
if m > 1.001;
	m
	Cfinal = Csum/m;
else;
	m=1;
	Cfinal = Csum;
end
load ~/WNVSixthRuns/AllRules_fixedvariables.mat

% figure
% contour(x,y,C,30);
% colorbar;
% colormap(hot);
% set(gca,'FontSize',24)
figure
contour(x,y,Cfinal,30);
hold on
plot(fixedvars.xm0,fixedvars.ym0,'k.','MarkerSize',16)
colorbar;
colormap(hot);
set(gca,'FontSize',24, 'CLim', [0, 1])
axis equal
axis([0,1,0,1])
axis off
title('Time = 0')


% %straight line path
% r = 0:0.005:0.5;
% C = exp(-40*r.^2);
% dCdx = -80*r.*cos(pi/4).*C;
% dCdy = -80*r.*sin(pi/4).*C;
% 
% gradmag = sqrt(dCdx.^2 + dCdy.^2);
% ngm = gradmag/max(gradmag);
% 
% %mosq moving at steady speed of 0.005/dt
% dC = abs([0,C(2:end) - C(1:end-1)]);
% nct = dC/max(dC);
% 
% % %try different scaling
% % sf = max(gradmag)*0.005; % 0.005 is distance moved in one time step
% % ncf = dC/sf;
% 
% 
% plot(r,C);
% hold on;
% plot(r,ngm,'r');
% plot(r,nct,'k');
% %plot(r,ncf,'g');
% 
% title('Straight Line Path');
% xlabel('Distance to source');
% legend('Normalized CO_2 concentration','Normalized CO_2 gradient','Normalized temporal gradient');

% %segmented path
% x = [0.5*cos(pi/4):-0.005:0];
% y = [0.5*sin(pi/4):-0.005:0,0];
% n = length(y);
% m = length(x);
% x = [x, zeros(1,n)];
% y = [0.5*sin(pi/4)*ones(1,m), y];
% 
% rseg = sqrt(x.^2 + y.^2);
% Cseg = exp(-40*rseg.^2);
% dCdxseg = -80*x.*Cseg;
% dCdyseg = -80*y.*Cseg;
% 
% gradmagseg = sqrt(dCdxseg.^2 + dCdyseg.^2);
% ngmseg = gradmagseg/max(gradmagseg);
% 
% %mosq moving at steady speed of 0.005/dt
% dCseg = abs([0,Cseg(2:end) - Cseg(1:end-1)]);
% nctseg = dCseg/max(dCseg);
% 
% plot(rseg,Cseg,'b--');
% plot(rseg,ngmseg,'r--');
% plot(rseg,nctseg,'k--');
% %plot(r,ncf,'g--');
% 
% title('Segmented Path');
% xlabel('Distance to source');
% legend('Normalized CO_2 concentration, straight','Normalized CO_2 gradient, straight','Normalized temporal gradient, straight','Normalized CO_2 concentration, segmented','Normalized CO_2 gradient, segmented','Normalized temporal gradient, segmented');
% 
% 
% figure
% plot(r,'b-')
% hold on
% plot(rseg(end:-1:1),'r-')
% 
% figure
% plot(C,'b-')
% hold on
% plot(Cseg(end:-1:1),'r-')
% 
% figure
% plot(r,C,'b-')
% hold on
% plot(rseg,Cseg,'r-')









