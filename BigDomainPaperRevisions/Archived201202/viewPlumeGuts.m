function viewPlumeGuts(p,xc,yc,xmtraj,ymtraj,t,results)

if length(size(results.C)) == 2;
	dim=3;
	[xg,yg] = meshgrid( p.h/2 : p.h : p.Lx-p.h/2, p.h/2 : p.h : p.Ly-p.h/2 );  % cell-centered discretized domain	
elseif length(size(results.C)) == 3;
	dim=4;	
	xg=zeros(0,0,0);
	yg=zeros(0,0,0);
	for k = 1:length(p.Nc);
    	[xg1,yg1] = meshgrid( p.chickBoxCenter(k,1)-p.Lx/2. + p.h/2 : p.h : p.chickBoxCenter(k,1) + p.Lx/2. - p.h/2, p.chickBoxCenter(k,2)-50 + p.h/2 : p.h : p.chickBoxCenter(k,2) + p.Ly - 50 - p.h/2 );  % cell-centered discretized domain
		xg(:,:,k) = xg1;
		yg(:,:,k) = yg1;
	end
	% Nccum = cumsum(p.Nc);
	% Nccum = [0,Nccum];
end

	if dim == 3;
		C = results.C;
		xm = [];
		ym = [];
		if length(p.wind_mode) == 3;
			modevec = [1*ones(p.Nm,1); 2*ones(p.Nm,1); 5*ones(p.Nm,1)]; 
		elseif length(p.wind_mode) == 1;
			modevec = p.wind_mode*ones(p.Nm,1); 
		end			
		if t >= 1500;
			k = t/100;
			for j = 1:length(xmtraj);
				tempx = xmtraj{j};
				tempy = ymtraj{j};
				if length(tempx) >= k-14;
					xm(j) = tempx(k-14); %entry time
					ym(j) = tempy(k-14); %entry time
				else;
					xm(j) = NaN; %found a host
					ym(j) = NaN; %found a host
				end
			end
		end
		GraphC(C,t,xm,ym,results,xc,yc,p,xg,yg,modevec);
	elseif dim == 4;
		C = results.C;
		if length(p.wind_mode) == 3;
			modevec = [1*ones(p.Nm,1); 2*ones(p.Nm,1); 5*ones(p.Nm,1)]; 
		elseif length(p.wind_mode) == 1;
			modevec = p.wind_mode*ones(p.Nm,1); 
		end			
		maxC = 0;
		for c = 1:length(p.Nc);
			maxC = max(maxC,max(max(C(:,:,c))));
		end
		for c = 1:length(p.Nc);
			% ind = Nccum(c)+1:Nccum(c+1);
			GraphC(C(:,:,c),t,xm,ym,results,xc,yc,p,xg(:,:,c),yg(:,:,c),modevec);
			caxis([0,maxC])
			hold on
		end
		hold off
	end		
	set(gcf,'PaperPosition',[0,0,8.0,6.0])
	set(gcf,'PaperSize',[8.0,6.0])
