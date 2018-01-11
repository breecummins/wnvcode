function GraphWind(U,V,t,xm,ym,results,xc,yc,p)

figure(1);
clf
hold on

%wind vectors
quiver((p.h/2 : 4*p.h : p.L-p.h/2),(p.h/2 : 4*p.h : p.L-p.h/2),U(1:4:end,1:4:end),V(1:4:end,1:4:end)); 
set(gca,'FontSize',24)
axis([0,p.L,0,p.L])
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

pause(0.0001)

hold off
