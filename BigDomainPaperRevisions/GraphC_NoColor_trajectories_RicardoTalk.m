function GraphC_NoColor_trajectories_RicardoTalk(C,trajx,trajy,xc,yc,p,xg,yg)

close()

%graph the concentration with the CO2 threshold contour only
Cmx = max(max(C));
contour(xg,yg,C,[p.CO2_thresh,p.CO2_thresh]); 
set(gca,'FontSize',16)
axis equal
colormap(gray)

hold on

%Plot trajectories
plot(trajx,trajy,'k-','LineWidth',2)

%% Plot chickens 
plot(xc,yc,'kv','MarkerFaceColor','k')

axis([-1000,1600,-800,1600])
set(gca,'XTick',-1000:200:1600,'XTickLabel',{'-100','-80','-60','-40','-20','0','20','40','60','80','100','120','140','160'})
set(gca,'YTick',-800:200:1600,'YTickLabel',{'-80','-60','-40','-20','0','20','40','60','80','100','120','140','160'})
xlabel('Distance (m)')

title('Example Trajectories');

hold off
