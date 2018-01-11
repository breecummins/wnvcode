function [gradmag, theta0] = findGradMagAngle(xm,ym,dCdx,dCdy,h);
	
	gradxm = InterpFromGrid(xm,ym,dCdx,h);
	gradym = InterpFromGrid(xm,ym,dCdy,h);
	gradmag = sqrt( gradxm.^2 + gradym.^2 );
	theta0 = atan2(gradym,gradxm);
	
	

	