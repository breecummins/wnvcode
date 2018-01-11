function GraphC(C,t,xm,ym,results,xc,yc,p)

figure(1);
clf
hold on

%graph the concentration with 100 contour lines
Cmx = max(max(C));
contour((p.h/2 : p.h : p.L-p.h/2),(p.h/2 : p.h : p.L-p.h/2),C,linspace(p.CO2_thresh,max(max(C)),15)); %(0:0.01*Cmx:Cmx)
set(gca,'FontSize',24)
axis([0,p.L,0,p.L])
colormap(gray)
colormap(cool)
colorbar
%colorbar('FontSize',24);
%caxis([0,0.07])
axis off

%Plot final position of removed mosquitoes
plot(results.xmfinalpos,results.ymfinalpos,'.','MarkerSize',12,'Color',[0.6,0.6,0.6])

%Plot mosquitoes
plot(xm,ym,'k.','MarkerSize',12)

%% Plot chickens 
plot(xc,yc,'kv','MarkerFaceColor','k')

if p.wind_mode == 1;
	title(['Upwind ranging flight, Time = ',num2str(t)])
	framename = 'upwind';
elseif p.wind_mode == 2;
	title(['Downwind ranging flight, Time = ',num2str(t)])
	framename = 'downwind';
elseif p.wind_mode == 3;
	title(['Crosswind/upwind ranging flight, Time = ',num2str(t)])
	framename = 'crossup';
elseif p.wind_mode == 4;
	title(['Crosswind/downwind ranging flight, Time = ',num2str(t)])
	framename = 'crossdown';
elseif p.wind_mode == 5;
	title(['Crosswind ranging flight, Time = ',num2str(t)])
	framename = 'crosswind';
end

if p.saveGraph;
	set(gcf,'PaperPosition',[0,0,8.0,6.0])
	set(gcf,'PaperSize',[8.0,6.0])
	saveas(gcf,['~/scratch/',framename,'_time',int2str(t),'.png'],'png')
end

%pause(0.0001)

hold off
