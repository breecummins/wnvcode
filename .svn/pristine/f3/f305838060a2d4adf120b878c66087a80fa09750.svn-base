%BatchChickenJuice_Density_Uniform_NoDiffusion.m

clear
close all

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '/scratch03/bcummins/mydata/wnv/NoDiffusion/';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

% INITIALIZE PARAMETERS
BoxLengthPerChick = sqrt(0.0929*5); % in meters (0.0929m^2 = 1 ft^2)
[p,xm0,tm0,mem0,xc,yc,Cmem] = BatchinitParams_Density_Uniform(BoxLengthPerChick);

% USE SAME VELOCITY EVERY TIME
load randvels_Density %contains r1 and r2

% % USE DIFFERENT VELOCITY EVERY TIME
% SetRandomSeed(sum(100*clock));
% r1 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,ceil(p.Tf/p.tRand)+1));  
% r2 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,ceil(p.Tf/p.tRand)+1));

% RECORD PLUME EVERY SO MANY MOSQUITO DECISIONS
recordplume = 25;

%EXECUTE SIMULATIONS
fnamestring = 'testrun';
BatchRunSims_NoDiffusion(basedir, fnamestring, p,xm0,tm0,mem0,xc,yc,Cmem, r1,r2, recordplume);

