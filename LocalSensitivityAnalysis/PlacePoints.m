function [x,y] = PlacePoints(N,Xint,Yint,L,h,flag)

%
% N = NUMBER OF POINTS TO PLACE IN THE BOX [Xint]x[Yint]
% flag = 'n' means use normal distribution instead of uniform distribution

dx = Xint(2)-Xint(1);    dy = Yint(2)-Yint(1); 

if nargin < 6 || flag ~= 'n';
	%USE UNIFORM DISTRIBUTION
	x = dx*rand(N,1) + Xint(1); 
	y = dy*rand(N,1) + Yint(1);
else;
	%USE NORMAL DISTRIBUTION
	meanvalx=Xint(1)+dx/2; meanvaly = Yint(1)+dy/2; sdx = dx/2; sdy = dy/2;
	x = sdx*randn(N,1) + meanvalx; 
	y = sdy*randn(N,1) + meanvaly;
	
	%IF ANY OF THE POINTS FALL OUTSIDE THE DOMAIN OR TOO CLOSE TO THE BOUNDARY, REVERT TO UNIFORM DIST
	indx = union(find(x > L-2*h), find(x < 2*h));
	if ~isempty(indx);
		x(indx) = dx*rand(length(indx),1) + Xint(1);
	end
	indy = union(find(y > L-2*h), find(y < 2*h));
	if ~isempty(indy);
		y(indy) = dy*rand(length(indy),1) + Yint(1);
	end
end

%plot(x,y,'.'),axis equal,axis([0 1 0 1]),grid on