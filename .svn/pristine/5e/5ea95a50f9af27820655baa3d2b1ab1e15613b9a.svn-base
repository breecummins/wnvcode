function GraphC_NoColor_RicardoTalk(C,t,xm,ym,xc,yc,p,xg,yg,modevec,numsubplots,k)

%close()

subplot(1,numsubplots,k)

%graph the concentration with 100 contour lines
Cmx = max(max(C));
% contour(xg,yg,C,linspace(p.CO2_thresh,max(max(C)),15)); %(0:0.01*Cmx:Cmx)
contour(xg,yg,C,[p.CO2_thresh,p.CO2_thresh]); 
set(gca,'FontSize',16)
axis equal
colormap(gray)

hold on

%Plot mosquitoes
nummodes = length(p.wind_mode);
indu = find(modevec ==1);
indd = find(modevec ==2);
indc = find(modevec ==5);
plot(xm(indu),ym(indu),'k.','MarkerSize',12)
plot(xm(indd),ym(indd),'ko')
plot(xm(indc),ym(indc),'k+')

%% Plot chickens 
plot(xc,yc,'kv','MarkerFaceColor','k')

% pvec = get(gcf,'OuterPosition');
% pvec(3) = 2*pvec(3);
% pvec(4) = 1.5*pvec(4);
% set(gcf,'OuterPosition',pvec)

axis([0,600,0,800])
set(gca,'XTick',[0,200,400,600],'XTickLabel',{'0','20','40','60'})
set(gca,'YTick',[0,200,400,600,800],'YTickLabel',{'0','20','40','60','80'})
xlabel('Distance (m)')

title(['Time = ',num2str(t/10),' s'])

% if subplotnum == 2;
% 	set(gcf,'PaperSize',[17.35,(4/3)*17.35])
% 	set(gcf,'PaperPosition',[0,0,17.35,(4/3)*17.35])
% 	saveas(gcf,['~/rsyncfolder/data/WNV/BigDomain/Figure7.fig'])
% 	saveas(gcf,['~/rsyncfolder/data/WNV/BigDomain/Figure7.eps'],'epsc')
% end

hold off


