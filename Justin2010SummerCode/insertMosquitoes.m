function [xm,ym,tm,xm0,ym0,mem, mem0] = insertMosquitoes(t,tm,xm,ym,mem,xm0,ym0,mem0);

	ind=find(tm < t);
	xm(end+1:end+length(ind)) = xm0(ind);
	ym(end+1:end+length(ind)) = ym0(ind);
    mem((end+1:end+length(ind)),:) = mem0(ind,:);
	xm0=xm0(ind(end)+1:end);
	ym0=ym0(ind(end)+1:end);
    mem0=mem0((ind(end)+1:end),:);
	tm=tm(ind(end)+1:end);
	xm=makecolumn(xm);
	ym=makecolumn(ym);