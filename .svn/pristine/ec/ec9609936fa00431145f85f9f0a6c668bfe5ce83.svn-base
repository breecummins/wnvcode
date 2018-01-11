% BatchChickenJuice_NewMeander_ManyPlumes.m

clear
close all

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '~/WNVBigDomain/';
fnamestring = 'Manyplumes_allmodes2';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

BoxLengthPerChick = sqrt(0.0929*8)/2; % in meters (0.0929m^2 = 1 ft^2)
vfunc = '_newmeander';
usemosq = 'n';
inittime = 1500;
dwidth = 30;
dlength = 200;
initrad = 100;
groupflag = 5;
[p,xm0,ym0,tm0,mem0,xc,yc,Cmem,angmem,modevec] = BatchinitParams_Density_ManyPlumes(BoxLengthPerChick,vfunc,dwidth,dlength,initrad,groupflag,usemosq,inittime);
p.savefname = fullfile(basedir,[fnamestring,'.mat']); 

% RUN THE SIMULATION
[ xm, ym, results ] = BatchChickenGuts_ManyPlumes( p, xm0, ym0, tm0, mem0, xc, yc, Cmem, angmem, modevec);

% SAVE THE INPUTS AND OUTPUTS
save(p.savefname, 'p', 'xc', 'yc', 'xm', 'ym','results')    

