%BCExperiment1.m

clear

% Initial Hilly CO2

SetRandomSeed(442);

h=0.01;
[xg,yg] = meshgrid(h/2:h:1-h/2,h/2:h:1-h/2);

epsi = 0.2;
poles = 0.2 + 0.6* rand(7,2);
poles = [poles; 0.05 + 0.9* rand(30,2)];
C = zeros(size(xg));

for k = 1:size(poles,1);
	if k <= 7;
		C = C + epsi*exp( -78*( (xg-poles(k,1)).^2 + (yg-poles(k,2)).^2 ) );
	else;
		C = C + (epsi/5)*exp( -78*( (xg-poles(k,1)).^2 + (yg-poles(k,2)).^2 ) );
	end
end


dt = h/10;
Tf = 1.25;
nu = 1.e-3;

%no x velocity
close all
u = 0; v = 1;
BCGuts(dt,Tf,C,h,u,v,xg,yg,nu,'nox/u0');

%constant x velocity
u = 0.5*ones(size(C)+[0,2]); v = 1;
close all
BCGuts(dt,Tf,C,h,u,v,xg,yg,nu,'constx/uhalf');

%random x velocity
SetRandomSeed(442);
u = 0.5*randn(size(C)+[0,2]); v = 1;
close all
BCGuts(dt,Tf,C,h,u,v,xg,yg,nu,'rand5/urand');

SetRandomSeed(442);
u = 0.05*randn(size(C)+[0,2]); v = 1;
close all
BCGuts(dt,Tf,C,h,u,v,xg,yg,nu,'rand05/urand');

SetRandomSeed(442);
u = 0.1*randn(size(C)+[0,2]); v = 1;
close all
BCGuts(dt,Tf,C,h,u,v,xg,yg,nu,'rand1/urand');

SetRandomSeed(442);
u = 0.2*randn(size(C)+[0,2]); v = 1;
close all
BCGuts(dt,Tf,C,h,u,v,xg,yg,nu,'rand2/urand');

SetRandomSeed(442);
u = 0.25*randn(size(C)+[0,2]); v = 1;
close all
BCGuts(dt,Tf,C,h,u,v,xg,yg,nu,'rand25/urand');

SetRandomSeed(442);
u = 0.3*randn(size(C)+[0,2]); v = 1;
close all
BCGuts(dt,Tf,C,h,u,v,xg,yg,nu,'rand3/urand');

SetRandomSeed(442);
u = 0.4*randn(size(C)+[0,2]); v = 1;
close all
BCGuts(dt,Tf,C,h,u,v,xg,yg,nu,'rand4/urand');

SetRandomSeed(442);
u = 0.6*randn(size(C)+[0,2]); v = 1;
close all
BCGuts(dt,Tf,C,h,u,v,xg,yg,nu,'rand6/urand');

SetRandomSeed(442);
u = 0.75*randn(size(C)+[0,2]); v = 1;
close all
BCGuts(dt,Tf,C,h,u,v,xg,yg,nu,'rand75/urand');

SetRandomSeed(442);
u = 1*randn(size(C)+[0,2]); v = 1;
close all
BCGuts(dt,Tf,C,h,u,v,xg,yg,nu,'randfull/urand');
