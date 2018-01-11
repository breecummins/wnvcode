function test_InterpFromGrid(p);
	
	[xg,yg] = meshgrid( p.h/2 : p.h : p.Lx-p.h/2, p.h/2 : p.h : p.Ly-p.h/2 );  % cell-centered discretized domain
    
	cst = 1.e-3*pi;
	Z = sin(cst*xg).*cos(cst*yg);
	
	xt = p.h/2 + (p.Lx-p.h)*rand(20,1);
	yt = p.h/2 + (p.Ly-p.h)*rand(20,1);
	
	Zapprox = InterpFromGrid(xt,yt,Z,p.h);
	Ztrue = sin(cst*xt).*cos(cst*yt);
	
	surf(xg,yg,Z,'edgecolor','none')
	hold on
	plot3(xt,yt,Ztrue,'k.')
	plot3(xt,yt,Zapprox,'m.')
	
	
	errh=max(abs(Zapprox-Ztrue)./Ztrue)
	
	[xg,yg] = meshgrid( p.h/4 : p.h/2 : p.Lx-p.h/4, p.h/4 : p.h/2 : p.Ly-p.h/4 );  % test 2x as fine grid spacing
    
	cst = 1.e-3*pi;
	Z = sin(cst*xg).*cos(cst*yg);
	Zapprox2 = InterpFromGrid(xt,yt,Z,p.h/2);
	
	errhalfh = max(abs(Zapprox2-Ztrue)./Ztrue)
	
	ratiomaxerr = errh/errhalfh 
	
	
	