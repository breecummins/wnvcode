%BatchChickenJuice_Density_Uniform.m

clear
close all

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '/scratch03/bcummins/mydata/wnv/AlterAlpha/';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

% INITIALIZE PARAMETERS
BoxLengthPerChick = sqrt(0.0929*5); % in meters (0.0929m^2 = 1 ft^2)
[p,xm0,tm0,mem0,xc,yc,Cmem] = BatchinitParams_Density_Uniform(BoxLengthPerChick);

Cdirmin23 = 2*p.Cdirmin/3;
Cdirmax23 = 2*p.Cdirmax/3;
Cdirmin13 = p.Cdirmin/3;
Cdirmax13 = p.Cdirmax/3;
Cdirmin16 = p.Cdirmin/6;
Cdirmax16 = p.Cdirmax/6;
Cdirmin = p.Cdirmin;
Cdirmax = p.Cdirmax;

% USE SAME VELOCITY EVERY TIME
% load randvels_Density %contains r1 and r2

% USE DIFFERENT VELOCITY EVERY TIME
SetRandomSeed(sum(100*clock));
r1 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,ceil(p.Tf/p.tRand)+1));  
r2 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,ceil(p.Tf/p.tRand)+1));


%EXECUTE DIFFERENT SIMULATIONS
newstring = '_wind4';

fnamestring = ['originalvalues',newstring];
BatchRunSims(basedir, fnamestring, p,xm0,tm0,mem0,xc,yc,Cmem, r1,r2);

fnamestring = ['twothirdsAlphaMinMax',newstring];
p.Cdirmin = Cdirmin23;
p.Cdirmax = Cdirmax23;
BatchRunSims(basedir, fnamestring, p,xm0,tm0,mem0,xc,yc,Cmem, r1,r2);

fnamestring = ['onethirdAlphaMinMax',newstring];
p.Cdirmin = Cdirmin13;
p.Cdirmax = Cdirmax13;
BatchRunSims(basedir, fnamestring, p,xm0,tm0,mem0,xc,yc,Cmem, r1,r2);

fnamestring = ['onesixthAlphaMinMax',newstring];
p.Cdirmin = Cdirmin16;
p.Cdirmax = Cdirmax16;
BatchRunSims(basedir, fnamestring, p,xm0,tm0,mem0,xc,yc,Cmem, r1,r2);

fnamestring = ['twothirdsAlphaMaxOnly',newstring];
p.Cdirmin = Cdirmin;
p.Cdirmax = Cdirmax23;
BatchRunSims(basedir, fnamestring, p,xm0,tm0,mem0,xc,yc,Cmem, r1,r2);

fnamestring = ['onethirdAlphaMaxOnly',newstring];
p.Cdirmin = Cdirmin;
p.Cdirmax = Cdirmax13;
BatchRunSims(basedir, fnamestring, p,xm0,tm0,mem0,xc,yc,Cmem, r1,r2);

fnamestring = ['onesixthAlphaMaxOnly',newstring];
p.Cdirmin = Cdirmin;
p.Cdirmax = Cdirmax16;
BatchRunSims(basedir, fnamestring, p,xm0,tm0,mem0,xc,yc,Cmem, r1,r2);

