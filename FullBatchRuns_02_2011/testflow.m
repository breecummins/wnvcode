%testflow.m

L = 10;			% nondimensional domain side length = 100 flight lengths
Ng = 20;			% number of grid points on a side (L/Ng < nondim'l mosq flight length = 1)
h = L/Ng;		% separation between grid points	
[xg,yg] = meshgrid( h/2 : h : L-h/2 );
Vmag = 0.2;		% nondimensional magnitude of wind flow, < nondim'l mosq flight speed


for t = 0:0.1:100;
	U=V1Parametric_time(xg,yg,Vmag,t);
	V=V2Parametric_time(xg,yg,Vmag,t);
	quiver(xg,yg,U,V)
	axis([-1,11,-1,11])
	pause(0.01)
end