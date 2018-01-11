% BatchChickenJuice_Continue.m

clear
close all

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '/scratch03/bcummins/mydata/BigDomainLevy';
fnamestring = 'Meander_allmodes';

% MAKE SURE CONTINUING CHOICES ARE THE SAME 
SetRandomSeed(209580);

% LOAD LAST FILE
load(fullfile(basedir,[p.savefname,'_parameters.mat']));
load(fullfile(basedir,[p.savefname,'_13700.mat']));

tResume = t+p.dt;

%MAY WANT TO EXTEND DOMAIN: new p.Lx,p.Ly, add zeros to C, new final time

% RUN THE SIMULATION
[ xmtraj, ymtraj, results] = BatchChickenGuts_Continue( p, xc, yc, xm, ym, mem, Cmem, angmem, modevec, indsave, C, results, tResume);

