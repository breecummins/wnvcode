% BatchChickenJuice_NewMeander.m

clear
close all

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '/scratch03/bcummins/mydata/BigDomainLevy';
fnamestring = 'Meander_allmodes5';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

BoxLengthPerChick = sqrt(0.0929*8)/2; % in meters (0.0929m^2 = 1 ft^2), so 2 ft^2 per chicken
usemosq = 'y';
inittime = 150;
finaltime = 2000;
dwidth = 80;
dlength = 300;
initrad = 100;
groupflag = 4;
[p,xm0,ym0,mem0,xc,yc,Cmem,angmem,modevec] = BatchinitParams_NewMeander(BoxLengthPerChick,dwidth,dlength,initrad,groupflag,usemosq,inittime,finaltime);
p.savefname = fullfile(basedir,fnamestring); 
% p.tGraph_after = 1;
save([p.savefname,'_parameters.mat'], 'p', 'xc', 'yc', 'xm0','ym0')


% PICK HOW OFTEN TO SAVE
recordC=100;

% RUN THE SIMULATION
results = BatchChickenGuts_NewMeander( p, xc, yc, xm0, ym0, mem0, Cmem, angmem,modevec,recordC);

