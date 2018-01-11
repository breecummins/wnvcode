
function BCInflowGuts(dt,Tf,C,h,u,v,xg,yg,nu,fname);

	cmx = max(max(C));
	
	if length(u) == 1;
		if u < 0;
			error('This method works only for u >0.')
		elseif u > 0;
			LBind = [];
			RBind = 1:size(C,1);
		else;
			LBind = [];
			RBind = [];
		end
	else;
		if any(size(u)~=size(C)+[0,2]);
			error('u must have two more columns than C.')
		end
		up = 0.5*(u(:,2:end-1)+u(:,3:end));
		um = 0.5*(u(:,1:end-2)+u(:,2:end-1));
		lupp = (up>0);
		lupm = (up<=0);
		lump = (um>0);
		lumm = (um<=0);
		%find locations for outflow BCs
		LBind = find(um(:,1) < 0);
		RBind = find(up(:,end) > 0);
	end
	
	if v < 0;
		error('This method works only for a scalar v >0.')
	end
	
	Cneuman = C;
	Cinflow = C;
	
	clear C

% Inflow = 0 BCs, Outflow = extrapolation BCs
ctr=0;
for t = 0 : dt : Tf;
	
	[Cxmn,Cxpn,Cymn,Cypn] = BCNeumann(Cneuman);
	[Cxmi,Cxpi,Cymi,Cypi] = BCInflow(Cinflow,LBind,RBind);
	
    % CALCULATE DIFFUSION
	Dn = (Cxpn+Cxmn+Cypn+Cymn-4*Cneuman)/h^2;
	Di = (Cxpi+Cxmi+Cypi+Cymi-4*Cinflow)/h^2;

	%FLUXES ON THE EDGES OF THE CELLS USING A CONSERVATIVE UPWINDING SCHEME	
	if length(u) > 1;
		Flxxn = (Cneuman.*lupp + Cxpn.*lupm).*up - (Cxmn.*lump + Cneuman.*lumm).*um;
		Flxxi = (Cinflow.*lupp + Cxpi.*lupm).*up - (Cxmi.*lump + Cinflow.*lumm).*um;
	else;
		Flxxn = (Cneuman - Cymn).*u;
		Flxxi = (Cinflow - Cymi).*u;
	end
	Flxyn = (Cneuman- Cymn).*v; %good only for positive v flows
	Flxyi = (Cinflow- Cymi).*v;
	An = (Flxxn+Flxyn)/h;
	Ai = (Flxxi+Flxyi)/h;
	
	% SUM ALL OF THE TERMS.
    Cneuman = Cneuman + nu*dt*Dn - dt*An; 		
    Cinflow = Cinflow + nu*dt*Di - dt*Ai; 		
    
    % REPORT NEGATIVE CO2 (BUG CHECK)
    if any(Cneuman < 0);
        Cmn=min(min(Cneuman));
        disp(['Neumann BCs, Cmn = ',num2str(Cmn),' at t = ',num2str(t)])
    end
    if any(Cinflow < 0);
        Cmn=min(min(Cinflow));
        disp(['Inflow BCs, Cmn = ',num2str(Cmn),' at t = ',num2str(t)])
    end

	if mod(t,0.01) < dt/2;
		subplot(121)
		pcolor(xg,yg,Cneuman)
		shading interp
		caxis([0,cmx])
		title(['Neumann BCs,Time=',num2str(t)])
		colorbar('SouthOutside')

		subplot(122)
		pcolor(xg,yg,Cinflow)
		shading interp
		caxis([0,cmx])
		title(['Inflow BCs,Time=',num2str(t)])
		colorbar('SouthOutside')
		
		set(gcf,'PaperPosition',[0,0,8.0,6.0])
		set(gcf,'PaperSize',[8.0,6.0])
		saveas(1,['Visualizations/',fname,'_',sprintf('%03d',ctr),'.png'])
		ctr=ctr+1;
		% pause(0.5)
	end
end
