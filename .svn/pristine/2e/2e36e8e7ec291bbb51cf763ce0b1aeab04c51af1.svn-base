function [xm,ym,results,tstart] = MoveMosquitoes_NonSeeking(xm,ym,results,xc,yc,U,V,p,t,tstart,randwalk,advect);
	
	if randwalk;
		% pick random direction, move at max speed
		theta = 2*pi*rand(size(xm));
	    cxm = p.tMosq.*p.spdMax.*cos(theta);
		cym = p.tMosq.*p.spdMax.*sin(theta);
	else;
		cxm = zeros(size(xm));
		cym = cxm;
	end
	if advect;
		% interpolate velocity to mosquito position for advection
		um = InterpFromGrid(xm,ym,U,p.h, eval(['V1Parametric',p.vfunc,'(xm,ym,p.Vmag,t)']));
		vm = InterpFromGrid(xm,ym,V,p.h, eval(['V2Parametric',p.vfunc,'(xm,ym,p.Vmag,t)']));
	else;
		um = zeros(size(xm));
		vm = um;
	end
	% move mosquitoes
	xm = xm + cxm + um*p.tMosq;
	ym = ym + cym + vm*p.tMosq;
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% REMOVE THE MOSQUITOES WHO FIND A HOST
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	ind =[];
	for k = 1:length(xm);
		dist = sqrt( (xc - xm(k)).^2 + (yc - ym(k)).^2 );
		if all(dist > p.host_radius);
			ind(end+1) =k;
		else;
			jnd = find(dist == min(dist(find(dist <= p.host_radius))));
			results.whichchicken(end+1) = jnd;
			results.xmfinalpos(end+1) = xm(k);
			results.ymfinalpos(end+1) = ym(k);
			results.tmfinal(end+1) = t;
			results.tmentrance(end+1) = tstart(k);
		end
	end
	xm = xm(ind); ym = ym(ind); tstart = tstart(ind);
	