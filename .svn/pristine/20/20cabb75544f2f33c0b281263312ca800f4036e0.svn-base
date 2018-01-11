%plot straight and meandering odor plumes side by side

clear
close all;

load ~/WNV_Archived/WNVNewHostSeeking/CompareFlows/Crosswind_velprofile2.mat
straightC=alloutput.results01.C(:,:,3);
load ~/WNV_Archived/WNVNewHostSeeking/CompareFlows/Crosswind_velprofile3.mat
meanderC=alloutput.results01.C(:,:,3);

h=subplot(1,2,1);
pos=get(h,'pos');
pos(3) = 2*pos(3);
pos(4) = 2*pos(4);
pos(2) = pos(2) - 0.4;
pos(1) = pos(1) - 0.23;
set(h,'pos',pos)
C = straightC;
Cmx = max(max(C));
contour((p.h/2 : p.h : p.L-p.h/2),(p.h/2 : p.h : p.L-p.h/2),C,linspace(p.CO2_thresh,max(max(C)),20)); %(0:0.01*Cmx:Cmx)
hold on
%% Plot chickens 
plot(xc,yc,'kv','MarkerFaceColor','k')
axis equal
axis([0.3*p.L,0.85*p.L,0.45*p.L,p.L])
colormap(gray)
axis off

h=subplot(1,2,2);
pos=get(h,'pos');
pos(3) = 2*pos(3);
pos(4) = 2*pos(4);
pos(2) = pos(2) - 0.4;
pos(1) = pos(1) - 0.23;
set(h,'pos',pos)
C = meanderC;
Cmx = max(max(C));
contour((p.h/2 : p.h : p.L-p.h/2),(p.h/2 : p.h : p.L-p.h/2),C,linspace(p.CO2_thresh,max(max(C)),20)); %(0:0.01*Cmx:Cmx)
hold on
%% Plot chickens 
plot(xc,yc,'kv','MarkerFaceColor','k')
axis equal
axis([0.3*p.L,0.85*p.L,0.45*p.L,p.L])
colormap(gray)
axis off

sz=[0.0, 0.0, 12.35/2.54, 0.75*12.35/2.54];
set(gcf,'PaperSize',sz(3:4))                 
set(gcf,'PaperPosition',sz)      
print -depsc -loose ~/Figure4.eps
