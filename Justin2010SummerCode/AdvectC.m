function A = AdvectC(dt, h, V1p, V1m, V2p, V2m, Cxp, Cxm, Cyp, Cym, C);
		
	%UPWINDING FORMULATION
	% corer=C(2:end-1,:);
	% corec=C(:,2:end-1);
	% row1=C(1,:);
	% rowe=C(end,:);
	% col1=C(:,1);
	% cole=C(:,end);
	% 
	% Cyp = [corer;rowe;rowe];
	% Cym = [row1;row1;corer];
	% Cxp = [corec,cole,cole];
	% Cxm = [col1,col1,corec];
	
	dCdxp = (Cxp-C)/h;
	dCdxm = (C-Cxm)/h;
	dCdyp = (Cyp-C)/h;
	dCdym = (C-Cym)/h;
		
	advC = -(V1p.*dCdxm + V1m.*dCdxp + V2p.*dCdym + V2m.*dCdyp);
    A = dt*advC;
	%A = A+C;
	
  

