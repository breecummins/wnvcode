% BatchChickenJuice_Density_Uniform_test.m

clear
close all

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '/scratch03/bcummins/mydata/wnv/AlterAlpha/';
fnamestring = 'originalvalues_test';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

% INITIALIZE PARAMETERS
BoxLengthPerChick = sqrt(0.0929*5); % in meters (0.0929m^2 = 1 ft^2)
[p,xm0,tm0,mem0,xc,yc,Cmem] = BatchinitParams_Density_Uniform_test(BoxLengthPerChick);

% USE SAME VELOCITY EVERY TIME
load randvels_Density

for windmode = 5;%[1,2,5];
    % RANDOM SEED FOR MOSQUITO BEHAVIOR
	SetRandomSeed(0);

    % SET REMAINING PARAMETERS IN A SCRIPT
    [p,ym0,angmem] = BatchsetParams(p,windmode,basedir,fnamestring); 

    % NOTIFY USER WHICH RUN
	disp([WindName(windmode),' simulation '])

	% RUN THE SIMULATION
    [ xm, ym, results ] = BatchChickenGuts( p, xm0, ym0, tm0, mem0, xc, yc, r1, r2, Cmem, angmem );

	% SAVE THE INPUTS AND OUTPUTS
	save(p.savefname, 'p', 'xc', 'yc', 'xm', 'ym', 'results')    
end 

Cdirmin23 = 2*p.Cdirmin/3;
Cdirmax23 = 2*p.Cdirmax/3;
Cdirmin13 = p.Cdirmin/3;
Cdirmax13 = p.Cdirmax/3;

fnamestring = 'twothirdsAlphaMinMax';
fnamestring = 'onethirdAlphaMinMax';
fnamestring = 'twonthirdsAlphaMax';
fnamestring = 'onethirdAlphaMax';


