function [xm,ym,tm,tstart,xm0,ym0] = insertMosquitoes_NonSeeking(t,tm,tstart,xm,ym,xm0,ym0);

	ind=find(tm < t);
	xm(end+1:end+length(ind)) = xm0(ind);
	ym(end+1:end+length(ind)) = ym0(ind);
	tstart(end+1:end+length(ind)) = tm(ind);
	xm0=xm0(ind(end)+1:end);
	ym0=ym0(ind(end)+1:end);
	tm=tm(ind(end)+1:end);
	xm=makecolumn(xm);
	ym=makecolumn(ym);
