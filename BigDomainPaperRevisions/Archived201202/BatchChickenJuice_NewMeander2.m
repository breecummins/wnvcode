% BatchChickenJuice_NewMeander2.m

clear
close all

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '/scratch03/bcummins/mydata';
fnamestring = 'Meander400_notime5short_allmodes';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

BoxLengthPerChick = sqrt(0.0929*8)/2; % in meters (0.0929m^2 = 1 ft^2)
usemosq = 'y';
inittime = 150;
dwidth = 30;
dlength = 200;
initrad = 100;
groupflag = 4;
[p,xm0,ym0,tm0,mem0,xc,yc,Cmem,angmem,modevec] = BatchinitParams_Trajectories(BoxLengthPerChick,dwidth,dlength,initrad,groupflag,usemosq,inittime);
p.savefname = fullfile(basedir,[fnamestring,'.mat']); 
p.Tf = 6000;

% RUN THE SIMULATION
[ xmtraj, ymtraj, results] = BatchChickenGuts_Trajectories( p, xm0, ym0, tm0, mem0, xc, yc, Cmem, angmem,modevec);

% SAVE THE INPUTS AND OUTPUTS
save(p.savefname, 'p', 'xc', 'yc', 'xmtraj', 'ymtraj','results')    

