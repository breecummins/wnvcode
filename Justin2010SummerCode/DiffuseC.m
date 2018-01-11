function D = DiffuseC(C, dt, h, nu, Cxp, Cxm, Cyp, Cym);
	
	
	%EXPLICIT CENTER DIFFERENCE FORMULATION
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
	
	
	D = nu*(dt/h^2)*(Cxp+Cxm+Cyp+Cym-4*C);
	%D = D+C;