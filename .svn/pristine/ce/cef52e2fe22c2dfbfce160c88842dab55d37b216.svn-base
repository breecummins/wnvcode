function viewPlume2_RicardoTalk(mosq,fnameout,basedir)
	
	close();
	
	fname = 'Meander_allmodes5_';
	tvec = 100:100:14500;

	if nargin < 3;
		basedir = '/Volumes/LCD/WNVNotPruned/WNVBigDomain/BigDomainLevy';
	end
	
	load(fullfile(basedir,[fname,'parameters.mat']));
	
	if nargin < 2;
		fnameout = 'crosswindtraj.fig';
	end
	
	if nargin < 1;
		%mosq = [334,154,1,1420];
		%mosq = round(1999*rand(1,4)) + 1; %upwind mosquitoes
		%mosq = [2191, 3474, 2970, 3261];
		%mosq = round(1999*rand(1,4)) + 2001; %downwind 
		mosq = [5317, 5236, 5028, 5460];
		% mosq = round(1999*rand(1,4)) + 4001; %crosswind
		
		for k = 1:length(mosq);
			if mosq(k) <= 2000;
				ypos = ym0(mosq(k)) >= 200;
				while ~ypos;
					mosq(k) = round(1999*rand) + 1;
					ypos = ym0(mosq(k)) >= 200;
				end
			elseif mosq(k) <= 4000;
				ypos = ym0(mosq(k)) <= 0;
				while ~ypos;
					mosq(k) = round(1999*rand) + 2001;
					ypos = ym0(mosq(k)) <= 0;
				end
			end
		end
		disp('Mosquito indices are: ')
		for k = 1:length(mosq);
			disp(sprintf('%d',mosq(k)))
		end
	end

trajx = NaN(length(tvec),length(mosq));
trajy = NaN(length(tvec),length(mosq));

[xg,yg] = meshgrid( p.h/2 : p.h : p.Lx-p.h/2, p.h/2 : p.h : p.Ly-p.h/2 );  % p from parameter file, cell-centered discretized domain	

for k = 1:length(tvec);
	t = tvec(k);
	load(fullfile(basedir,[fname,sprintf('%05d',t)]));
	for m = 1:length(mosq);
		ind = find(indsave==mosq(m));
		if ~isempty(ind);
			trajx(k,m) = xm(ind); 
			trajy(k,m) = ym(ind);
		end
	end 
end																			% xc, yc, p from parameter file
GraphC_NoColor_trajectories_RicardoTalk(C(1:2:end,1:2:end),trajx,trajy,xc,yc,p,xg(1:2:end,1:2:end),yg(1:2:end,1:2:end)); % C from data file

set(gcf,'PaperSize',[8.3,(4/3)*8.3])
set(gcf,'PaperPosition',[0,0,8.3,(4/3)*8.3])
saveas(gcf,['~/Desktop/',fnameout])

end

function windmode = checkWindMode(mosq);
	if mosq < 2001;
		windmode = 1;
	elseif mosq < 4001;
		windmode = 2;
	else;
		windmode = 5;
	end
	
end	
	