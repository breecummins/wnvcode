function [Cxm,Cxp,Cym,Cyp] = BCNeumann(C);
	
	% Neumann BCs
		corer=C(2:end-1,:);		
		corec=C(:,2:end-1);
		row1=C(1,:);
		rowe=C(end,:);
		col1=C(:,1);
		cole=C(:,end);

		Cyp = [corer;rowe;rowe];
		Cym = [row1;row1;corer];
		Cxp = [corec,cole,cole];
		Cxm = [col1,col1,corec];

	