function [Cxm,Cxp,Cym,Cyp] = BCPeriodic(C);
	
	% Periodic BCs
		corer=C(2:end-1,:);		
		corec=C(:,2:end-1);
		row1=C(1,:);
		rowe=C(end,:);
		col1=C(:,1);
		cole=C(:,end);
		row2=C(2,:);
		rowem1=C(end-1,:);
		col2=C(:,2);
		colem1=C(:,end-1);

		Cyp = [corer;rowe;rowe];
		Cym = [zeros(size(row1));row1;corer];
		Cxp = [corec,cole,col2];
		Cxm = [colem1,col1,corec];

	