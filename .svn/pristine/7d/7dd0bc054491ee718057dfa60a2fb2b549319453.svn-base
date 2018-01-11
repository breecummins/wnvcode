function MakeTrajectories_viz(UWtraj,DWtraj,CWtraj,Csave, p,xc,yc)
	
	%get mosquito data
	UWind=1;
	DWind=2;
	CWind=13;
	
	UWind = 2;


	figure(1);
	clf
	hold on
	set(gca,'FontSize',16)
	axis([0,p.L,0,p.L])
	axis off
	% set(gcf,'PaperPosition',[0,0,8.0,6.0])
	% set(gcf,'PaperSize',[8.0,6.0])
	
	% %graph the concentration with 15 contour lines
	C = Csave(:,:,end);
	contour((p.h/2 : p.h : p.L-p.h/2),(p.h/2 : p.h : p.L-p.h/2),C,p.CO2_thresh); 
	% contour((p.h/2 : p.h : p.L-p.h/2),(p.h/2 : p.h : p.L-p.h/2),C,linspace(p.CO2_thresh,max(max(C)),30)); 
	colormap(gray)
	% colormap(jet)
		
	plot(UWtraj.xm{UWind},UWtraj.ym{UWind},'Color',[0,0,0],'Linewidth',2)
	plot(DWtraj.xm{DWind},DWtraj.ym{DWind},'Color',[0.4,0.4,0.4],'Linewidth',2)
	plot(CWtraj.xm{CWind},CWtraj.ym{CWind},'Color',[0.6,0.6,0.6],'Linewidth',2)
	plot(xc,yc,'kv','MarkerFaceColor','k')
	text(0.35*100,0.9*100,'UW','Color',[0,0,0],'FontSize',16)
	text(0.75*100,0.1*100,'DW','Color',[0.4,0.4,0.4],'FontSize',16)
	text(0.15*100,0.1*100,'CW','Color',[0.6,0.6,0.6],'FontSize',16)
	
	sz=[0.0, 0.0, 12.35/2.54, 0.75*12.35/2.54];
	set(gcf,'PaperSize',sz(3:4))                 
	set(gcf,'PaperPosition',sz)      
	saveas(1,'~/Figure2.eps')            
	

	% plot(UWtraj.xm{UWind},UWtraj.ym{UWind},'k','Linewidth',2)
	% plot(DWtraj.xm{DWind},DWtraj.ym{DWind},'b','Linewidth',2)
	% plot(CWtraj.xm{CWind},CWtraj.ym{CWind},'r','Linewidth',2)
	% plot(xc,yc,'kv','MarkerFaceColor','k')
	% text(0.85*100,0.7*100,'UW','Color','k','FontSize',24)
	% text(0.75*100,0.1*100,'DW','Color','b','FontSize',24)
	% text(0.15*100,0.1*100,'CW','Color','r','FontSize',24)
	
