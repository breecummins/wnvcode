function [distsqd] = initialCalculations(xc,yc,xg,yg);
	
	
	%cache the distances from the *stationary* chickens to the rest of the grid
    for k=1:length(xc);
    	distsqd(:,:,k) = (xg-xc(k)).^2 + (yg-yc(k)).^2;
    end