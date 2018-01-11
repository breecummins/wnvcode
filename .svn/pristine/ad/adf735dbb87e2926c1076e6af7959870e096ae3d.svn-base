function GraphC(C,t,xm,ym,results,xc,yc,p,xg,yg,modevec)

clf

%graph the concentration with 100 contour lines
Cmx = max(max(C));
contour(xg,yg,C,linspace(p.CO2_thresh,max(max(C)),15)); %(0:0.01*Cmx:Cmx)
% contour(xg,yg,C,[p.CO2_thresh,p.CO2_thresh]); 
set(gca,'FontSize',24)
if t >= 0 && t < 1000 && isempty(xm);
	% axis([0,p.Lx,0,p.Ly*0.1*t/100+p.Ly*0.1])
	axis([-600,600,0,1000])
else;
	if ~isempty(xm);
		axis([min(xm),max(xm),min(ym),max(ym)])
	else;
		axis([-2000,2000,-2000,3000])
	end
end
axis equal
colormap(gray)
colormap(cool)
colorbar
%colorbar('FontSize',24);
%caxis([0,0.07])
%axis off

hold on

%Plot final position of removed mosquitoes
plot(results.xmfinalpos,results.ymfinalpos,'.','MarkerSize',12,'Color',[0.6,0.6,0.6])

%Plot mosquitoes
nummodes = length(p.wind_mode);
if nummodes == 1;
	plot(xm,ym,'k.','MarkerSize',12)
elseif ~isempty(xm);
	indu = find(modevec ==1);
	indd = find(modevec ==2);
	indc = find(modevec ==5);
	plot(xm(indu),ym(indu),'k.','MarkerSize',12)
	plot(xm(indd),ym(indd),'b.','MarkerSize',12)
	plot(xm(indc),ym(indc),'r.','MarkerSize',12)
end	

%% Plot chickens 
plot(xc,yc,'kv','MarkerFaceColor','k')

if length(p.wind_mode) > 1;
	title(['All plume finding, Time = ',num2str(t)])
	framename = 'all';
else;	
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
end

if p.saveGraph;
	set(gcf,'PaperPosition',[0,0,8.0,6.0])
	set(gcf,'PaperSize',[8.0,6.0])
	saveas(gcf,['~/scratch/',framename,'_time',int2str(t),'.png'],'png')
end

hold off

pause(0.0001)

