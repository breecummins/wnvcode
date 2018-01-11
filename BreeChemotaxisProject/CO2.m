function [C, mag, ang] = CO2(x,y);
	
	%This function returns the concentration level for the toy problem at the coordinates (x,y) (x and y may be scalar, vector, or matrix-valued). The CO2 source is located at the origin.
	
	C = exp(-10*(x.^2 + y.^2));
	Cx = -20.*x.*exp(-10*(x.^2 + y.^2));
	Cy = -20.*y.*exp(-10*(x.^2 + y.^2));
	
	mag = sqrt(Cx.^2 + Cy.^2);
	ang = atan2(Cy,Cx);
	
	