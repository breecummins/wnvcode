function viewPlume2_RicardoTalk(fnameout,tvec,wind,basedir)
	
	close();
	
	fname = 'Meander_allmodes5_';
	% figfname = fullfile(basedir,'zMeander5_');

	if nargin < 1;
		fnameout = 'BigDomain.fig';
	end
	if nargin < 2;
		tvec=[2500,5000];
	end
	if nargin < 3;
		wind=[1,2,5]; % upwind=1,downwind=2,crosswind=5; can have any combination of these, e.g. [1], [1,5], etc.
	end
	if nargin < 4;
		basedir = '/Volumes/LCD/WNVNotPruned/WNVBigDomain/BigDomainLevy';
	end
	
numsubplots = length(tvec);

load(fullfile(basedir,[fname,'parameters.mat']));

[xg,yg] = meshgrid( p.h/2 : p.h : p.Lx-p.h/2, p.h/2 : p.h : p.Ly-p.h/2 );  % cell-centered discretized domain	

for k = 1:numsubplots;
	t = tvec(k);
	load(fullfile(basedir,[fname,sprintf('%05d',t)]));
	mosqind = [];
	for w = wind;
		mosqind = [mosqind,find(modevec==w).'];
	end
	GraphC_NoColor_RicardoTalk(C(1:2:end,1:2:end),t,xm(mosqind),ym(mosqind),xc,yc,p,xg(1:2:end,1:2:end),yg(1:2:end,1:2:end),modevec(mosqind),numsubplots,k); % C, xm, ym, modevec from data file
end																							% xc, yc, p from parameter file

for k = 1:numsubplots;
	h = subplot(1,numsubplots,k);
	pos = get(h,'pos');
	pos(3) = 1.2*pos(3);
	pos(4) = 1.2*pos(4);
	pos(2) = pos(2) - 0.1;
	set(h,'pos',pos)
end

set(gcf,'PaperSize',[8.3,(4/3)*8.3])
set(gcf,'PaperPosition',[0,0,8.3,(4/3)*8.3])
saveas(gcf,['~/Desktop/',fnameout])
