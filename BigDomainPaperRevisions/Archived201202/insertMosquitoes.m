function [xm,ym,tm,tstart,xm0,ym0,mem, mem0,Cmem,Cmem0,angmem,angmem0,modevec0,modevec] = insertMosquitoes(t,tm,tstart,xm,ym,mem,Cmem,angmem,xm0,ym0,mem0,Cmem0,angmem0,modevec0,modevec);

	ind=find(tm <= t);
	xm(end+1:end+length(ind)) = xm0(ind);
	ym(end+1:end+length(ind)) = ym0(ind);
    mem((end+1:end+length(ind)),:) = mem0(ind,:);
	tstart(end+1:end+length(ind)) = tm(ind);
    Cmem((end+1:end+length(ind))) = Cmem0(ind);
    angmem((end+1:end+length(ind))) = angmem0(ind);
	modevec(end+1:end+length(ind)) = modevec0(ind);
	xm0=xm0(ind(end)+1:end);
	ym0=ym0(ind(end)+1:end);
    mem0=mem0((ind(end)+1:end),:);
    Cmem0=Cmem0((ind(end)+1:end));
    angmem0=angmem0((ind(end)+1:end));
    modevec0=modevec0((ind(end)+1:end));
	tm=tm(ind(end)+1:end);
	xm=makecolumn(xm);
	ym=makecolumn(ym);
	Cmem=makecolumn(Cmem);
	angmem=makecolumn(angmem);
	modevec=makecolumn(modevec);