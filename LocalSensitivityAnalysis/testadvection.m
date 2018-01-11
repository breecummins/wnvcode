function testadvection

%test to be sure that the advection function does not violate conservation

%set up the grid and initial CO2 concentration
L = 1; Ng = 64; h = L./Ng;
[xg,yg] = meshgrid(h/2:h:L-h/2);
C = zeros(size(xg));
C(yg > (0.25)) = 1.e-5;

%time step using only advection; track total CO2
dt = 1.e-3;
for t = 0:dt:8;
	[Cxp,Cxm,Cyp,Cym] = SliceC(C);
	
	%CALCULATE VELOCITY AVERAGES ON CELL EDGES
	[U,V] = swirlingflow(xg,yg,L);
	[Uxp,Vxp] = swirlingflow(xg+h,yg,L);
	[Uxm,Vxm] = swirlingflow(xg-h,yg,L);
	[Uyp,Vyp] = swirlingflow(xg,yg+h,L);
	[Uym,Vym] = swirlingflow(xg,yg-h,L);

	up = 0.5*(U+Uxp);
	um = 0.5*(U+Uxm);
	vp = 0.5*(V+Vyp);
	vm = 0.5*(V+Vym);
	
	% %check that edges are zero
	% disp(['Range on top = ',num2str(min(vp(end,:))),'-',num2str(max(vp(end,:)))])
	% disp(['Range on bottom = ',num2str(min(vm(1,:))),'-',num2str(max(vm(1,:)))])
	% disp(['Range on left = ',num2str(min(um(:,1))),'-',num2str(max(um(:,1)))])
	% disp(['Range on right = ',num2str(min(up(:,end))),'-',num2str(max(up(:,end)))])
	
	%FLUXES ON THE EDGES OF THE CELLS
	Flxx = (C.*(up>0) + Cxp.*(up<=0)).*up - (Cxm.*(um>0) + C.*(um<=0)).*um;
	Flxy = (C.*(vp>0) + Cyp.*(vp<=0)).*vp - (Cym.*(vm>0) + C.*(vm<=0)).*vm;

	g = (Flxx+Flxy)/h;
	
	C = C - dt.*g;
	
	%graph
	if mod(t,0.01) == 0;
		surf(xg,yg,C,'EdgeColor','None')
		view(2)
		colorbar
		caxis([0,1.1e-5])
		totalCO2 = sum(sum(C))/h^2
		% max(max(C))
		% min(min(C))
		pause(0.05)
	end
	%check for neg values
	if any(any(C<0));
		negC = min(min(C))
	end
end
end %function

%flow tangent at boundaries
function [U,V] = swirlingflow(xg,yg,L)
	%construct swirling flow
	Vmag = 0.01;
 	U = Vmag*(-cos(pi*(xg/L-1/2)) .* sin(pi*(yg-1/2)));
 	V = Vmag*(cos(pi*(yg/L-1/2)) .* sin(pi*(xg-1/2)));
	% quiver(xg,yg,U,V),axis equal
end %function
