% BatchChickenJuice_StraightPlume_InitNoDiff.m

clear
close all

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '/scratch03/bcummins/mydata';
fnamestring = 'StraightNoDiff_allmodes';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

BoxLengthPerChick = sqrt(0.0929*8)/2; % in meters (0.0929m^2 = 1 ft^2)
vfunc = '';
usemosq = 'y';
inittime = 1500;
dwidth = 30;
dlength = 200;
initrad = 100;
groupflag = 4;
[p,xm0,ym0,tm0,mem0,xc,yc,Cmem,angmem,modevec] = BatchinitParams_Density_ManyPlumes(BoxLengthPerChick,vfunc,dwidth,dlength,initrad,groupflag,usemosq,inittime);
r1 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng*p.Ly/p.Lx,p.Ng,ceil(p.Tf/p.tRand)+1));  
r2 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng*p.Ly/p.Lx,p.Ng,ceil(p.Tf/p.tRand)+1));
p.savefname = fullfile(basedir,[fnamestring,'.mat']); 

% RUN THE SIMULATION
[ xmtraj, ymtraj, results ] = BatchChickenGuts_Trajectories_InitNoDiff( p, xm0, ym0, tm0, mem0, xc, yc, r1, r2, Cmem, angmem,modevec,tm0(1));

% SAVE THE INPUTS AND OUTPUTS
save(p.savefname, 'p', 'xc', 'yc', 'xmtraj', 'ymtraj','results')    

