% ChickenJuice.m

clear
close all

%INITIALIZE VALUES
L=1;
Ng = 40;
h = 1/Ng;
nu = 1.06e-5;
U=1;
dt_adv = h*h/4; %Time-step for advection
dt_dif = h/2; %Time-step for diffusion
Tf = 400;
[xc,yc,tChick] = setChickens(L);

%Simulation grid.
[xg,yg] = meshgrid((-0.5 + (h/2)) : h : (0.5 - (h/2)));
C = zeros(Ng,Ng);

%Specify the boundary grid. In this case we need a set of points
%along the actual boundary.
bb_1 = 0.5*ones(size(xg(1,:)));
bb_2 = yg(:,1)';
bounds_l = [-bb_1',bb_2'];
bounds_r = [bb_1',bb_2'];
bounds_t = [bb_2',bb_1'];
bounds_b = [bb_2',-bb_1'];

[V1p,V1m,V2p,V2m,Vmag] = setInitialVel(xg,yg);
V1 = V1m+V1p;
V2 = V2m+V2p;
[r1,r2] = setRandomVel(V1,V2,Vmag,Ng,dt_adv);

%RUN THE FOR LOOP
Tf_natural = ceil(Tf/dt_adv);
dt_dif_natural = round(dt_dif/dt_adv);
for t_natural = 0 : Tf_natural
  t = dt_adv*t_natural;
	
  % MAKE MATRICES FOR CALCULATING DERIVATIVES
  [Cxp,Cxm,Cyp,Cym] = SliceC_exact_grad(C,bounds_l,bounds_r,bounds_t,bounds_b,nu,t,h);

  % SPREAD THE SOURCE CO2 TO THE UNDERLYING GRID
  S = SpreadToGrid(xc,yc,C,h,U*dt_adv);

  % CALCULATE ADVECTION
%  A = AdvectC(dt_adv, h, V1p, V1m, V2p, V2m, Cxp, Cxm, Cyp, Cym, C);
  A = AdvectCproper(xg,yg,C,Cxp,Cxm,Cyp,Cym,r1,r2,h,Vmag,'',t);

  if (mod(t_natural,dt_dif_natural) == 0)
    % CALCULATE DIFFUSION
    D = DiffuseC_implicit_exact_grad(C, dt_dif, h, nu, 1e-8,bounds_l,bounds_r,bounds_t,bounds_b,t);
    C = S+D-dt_adv*A;
  else
     C = C+S-dt_adv*A;
  end
  
  %Stochastic wind variation
  if (mod(t_natural,25) == 0)
    [r1, r2] = setRandomVel(V1,V2,Vmag,Ng,dt_adv);
  end
end