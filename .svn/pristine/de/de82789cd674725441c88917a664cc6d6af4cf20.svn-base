function [xm,ym,mm]=SSupdateMosq(xm,ym,theta,spd,dt,h,L,Cm);
	
	dxm = spd.*dt.*cos(theta);
	dym = spd.*dt.*sin(theta);
	
	xm = xm + dxm;
	ym = ym + dym;
	
	%keep mosquitoes in domain
	[xm,ym]=SSMosqWalls(xm,ym,dxm,dym,h,L);
	
	
	if nargin > 7;
		mm(:,1) = Cm;
		mm(:,2) = theta;
	end
	