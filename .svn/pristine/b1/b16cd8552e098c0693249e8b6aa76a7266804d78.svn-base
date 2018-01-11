function viewPlume2(basedir,tvec)
	
	fname = 'Meander_allmodes5_';
	% figfname = fullfile(basedir,'zMeander5_');

	if nargin < 1;
		basedir = '~/WNVBigDomain/BigDomainLevy';
		tvec=[2500,5000];
	end
	
load(fullfile(basedir,[fname,'parameters.mat']));

[xg,yg] = meshgrid( p.h/2 : p.h : p.Lx-p.h/2, p.h/2 : p.h : p.Ly-p.h/2 );  % cell-centered discretized domain	

for t = tvec;
	load(fullfile(basedir,[fname,sprintf('%05d',t)]));
	% GraphC(C,t,xm,ym,results,xc,yc,p,xg,yg,modevec);
	if t == 2500;
		subplotnum = 1;
	elseif t == 5000;
		subplotnum = 2;
	end
	GraphC_NoColor(C,t,xm,ym,xc,yc,p,xg,yg,modevec,subplotnum);
	% saveas(1,[figfname,sprintf('%05d',t),'.fig'])
	% ReportMosqs(results,modevec,p)
end

h = subplot(1,2,1);
pos = get(h,'pos');
pos(3) = 1.2*pos(3);
pos(4) = 1.2*pos(4);
pos(2) = pos(2) - 0.1;
set(h,'pos',pos)
h = subplot(1,2,2);
pos = get(h,'pos');
pos(3) = 1.2*pos(3);
pos(4) = 1.2*pos(4);
pos(2) = pos(2) - 0.1;
set(h,'pos',pos)

set(gcf,'PaperSize',[8.3,(4/3)*8.3])
set(gcf,'PaperPosition',[0,0,8.3,(4/3)*8.3])
saveas(gcf,['~/rsyncfolder/data/WNV/BigDomain/Figure7.fig'])
saveas(gcf,['~/rsyncfolder/data/WNV/BigDomain/Figure7.eps'],'epsc')
