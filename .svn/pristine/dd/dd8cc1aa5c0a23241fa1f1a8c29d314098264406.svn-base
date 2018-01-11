function test_InterpFromGrid(p);
	
	[xg,yg] = meshgrid( p.h/2 : p.h : p.L-p.h/2, p.h/2 : p.h : p.L-p.h/2 );  % cell-centered discretized domain
    
	cst = 1.e-2*pi;
	Z = sin(cst*xg).*cos(cst*yg);
	
	xt = p.h/2 + (p.L-p.h)*rand(20,1);
	yt = p.h/2 + (p.L-p.h)*rand(20,1);
	
	Zapprox = InterpFromGrid(xt,yt,Z,p.h);
	Ztrue = sin(cst*xt).*cos(cst*yt);
	
	surf(xg,yg,Z,'edgecolor','none')
	hold on
	plot3(xt,yt,Ztrue,'k.')
	plot3(xt,yt,Zapprox,'m.')
	
	
	max(abs(Zapprox-Ztrue)./Ztrue)
	
