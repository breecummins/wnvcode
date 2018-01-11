function D = DiffuseC(C,Cxp, Cxm, Cyp, Cym,h);
		
	%EXPLICIT CENTER DIFFERENCE FORMULATION	
	D = (Cxp+Cxm+Cyp+Cym-4*C)/h^2;



