%main_chemotaxis.m;

clear
close all

%SET RANDOM SEED
a=version;
if str2num(a(1:3)) >= 7.7;
	RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));
else;
	rand('twister',sum(100*clock))
	randn('state',sum(100*clock)) 
end

%SET PARAMETERS
%mosq params
Nm = 200; 
dt = 0.1;
%dt = 0.05;
s0 = 1; %typical speed, 1 m/s 
L = s0*dt; %typical mosquito flight length between decisions (1m/s * 0.1 s = 10 cm)


%response function params
c0 = 0.05; Csat = 0.9; %(Mostly) arbitrary. One paper shows evidence that Csat > 3*c0, and in our toy problem max(C) = 1.
Cdiff = 0.9 - 0.05; Lhat = 0.1; %needed so that saturation levels do not change
Csat = 0.9*Csat; % c0 = 2*c0; 
Cdiff = 0.9*Cdiff;
g0 = (c0/6)/Lhat;  %The shallowest spatial gradient that a mosquito can respond to. I chose c0/6 because mosquitoes can sense 50 ppm changes but they don't react unless abs CO2 >= ~300 ppm threshold. So the smallest sensed change is about 1/6 the threshold.
Gsat = Cdiff/(5*Lhat); %The steepest slope that a mosquito can respond to. The expression (Csat-c0)/5L should be taken to mean that the mosquito can sense a maximal change over 5 L.
%The following choices for the memory method are supposed to be linked to the gradient method.
t0 = g0*Lhat/2; %This is the threshold for the memory method. It is divided by two because the mosquito doesn't know the difference along the gradient, only along its flight path.
Tsat = Gsat*Lhat; %This is the highest change that a mosquito can differentially respond to over a single time step. Above this it saturates.  If it happens faster, then the mosquito can't tell the difference. Note that the units are concentration, NOT concentration/time. 

%run params
totruns = 25;
X = [-0.075,0.075]; Y = [0.55,0.6]; %starting box
T = 125;  %total time to run
Trec = [0:0.2:min(10,T), 11:T]; %times to record distances
basedir = '~/WNVChemotaxisOnly/ConcaveDown/'; %where to save files

% %graph params
% v=-1:0.01:1;
% [xg,yg] = meshgrid(v,v);
% C = CO2(xg,yg);

%Rule 2
rulenum = 2; 
minang = pi/2; maxang = pi;
minspd = 0.1; maxspd = 1.9;
thresh = [g0,c0]; satrtn = [Gsat, Csat]; concav = [0,0]; concav = [200,200]; %
c=100;
fname = [basedir,'Rule02_PS',sprintf('%02d',c),'.mat'];

%RUN SIMULATIONS
r = setParams(Nm,dt,minang,maxang,minspd,maxspd,rulenum,thresh,satrtn,concav);
disp('Rule 2....')
R = runSimulation(totruns,X,Y,T,Trec,r,fname);
% R = runSimulation(totruns,X,Y,T,Trec,r,fname,C,v,v);

%Rule 6
rulenum = 6; 
minang = pi/12; maxang = pi;
minspd = 0.1; maxspd = 1.9;
thresh = [t0,c0]; satrtn = [Tsat, Csat];  concav = [0,0]; concav = [200,200];
c=20;
fname = [basedir,'Rule06_PS',sprintf('%02d',c),'.mat'];

%RUN SIMULATIONS
r = setParams(Nm,dt,minang,maxang,minspd,maxspd,rulenum,thresh,satrtn,concav);
disp('Rule 6....')
R = runSimulation(totruns,X,Y,T,Trec,r,fname);
% R = runSimulation(totruns,X,Y,T,Trec,r,fname,C,v,v);


% %Diffusion
% rulenum = 10; 
% minang = []; maxang = [];
% minspd = []; maxspd = [];
% thresh = []; satrtn = []; concav = [];
% fname = [basedir,'Rule10.mat'];
% 
% %RUN SIMULATIONS
% r = setParams(Nm,dt,minang,maxang,minspd,maxspd,rulenum,thresh,satrtn,concav);
% disp('Rule 10 (diffusion)....')
% R = runSimulation(totruns,X,Y,T,Trec,r,fname);
% % R = runSimulation(totruns,X,Y,T,Trec,r,fname,C,v,v);
% 
% 
% c=0;
% maxang = pi;
% minspd = []; maxspd = [];
% for minang = 0:pi/12:pi/2;
% 	c=c+1;
% 	disp([int2str(c),' of 7 runs for rules 3 and 7.'])
% 		
% 	%Rule 3
% 	rulenum = 3; 
% 	thresh = g0; satrtn = Gsat; concav = 0;
% 	fname = [basedir,'Rule03_PS',int2str(c),'.mat'];
% 
% 	%RUN SIMULATIONS
% 	r = setParams(Nm,dt,minang,maxang,minspd,maxspd,rulenum,thresh,satrtn,concav);
% 	disp('Rule 3....')
% 	R = runSimulation(totruns,X,Y,T,Trec,r,fname);
% 	% R = runSimulation(totruns,X,Y,T,Trec,r,fname,C,v,v);
% 
% 	%Rule 7
% 	rulenum = 7; 
% 	thresh = t0; satrtn = Tsat; concav = 0;
% 	fname = [basedir,'Rule07_PS',int2str(c),'.mat'];
% 
% 	%RUN SIMULATIONS
% 	r = setParams(Nm,dt,minang,maxang,minspd,maxspd,rulenum,thresh,satrtn,concav);
% 	disp('Rule 7....')
% 	R = runSimulation(totruns,X,Y,T,Trec,r,fname);
% 	% R = runSimulation(totruns,X,Y,T,Trec,r,fname,C,v,v);
% end
% 	
% c=0;
% maxang = pi;
% for minang = 0:pi/12:pi/2;
% 	for minspd = [0.1,0.25:0.25:0.75];
% 		for maxspd = [1.25:0.25:1.75,1.9];
% 			c = c+1;
% 			disp([int2str(c),' of 112 parameter sets for rules 2 and 6.'])
% 			
% 			%Rule 2
% 			rulenum = 2; 
% 			thresh = [g0,c0]; satrtn = [Gsat, Csat]; concav = [0,0];
% 			fname = [basedir,'Rule02_PS',sprintf('%02d',c),'.mat'];
% 
% 			%RUN SIMULATIONS
% 			r = setParams(Nm,dt,minang,maxang,minspd,maxspd,rulenum,thresh,satrtn,concav);
% 			disp('Rule 2....')
% 			R = runSimulation(totruns,X,Y,T,Trec,r,fname);
% 			% R = runSimulation(totruns,X,Y,T,Trec,r,fname,C,v,v);
% 			
% 			%Rule 6
% 			rulenum = 6; 
% 			thresh = [t0,c0]; satrtn = [Tsat, Csat]; concav = [0,0];
% 			fname = [basedir,'Rule06_PS',sprintf('%02d',c),'.mat'];
% 
% 			%RUN SIMULATIONS
% 			r = setParams(Nm,dt,minang,maxang,minspd,maxspd,rulenum,thresh,satrtn,concav);
% 			disp('Rule 6....')
% 			R = runSimulation(totruns,X,Y,T,Trec,r,fname);
% 			% R = runSimulation(totruns,X,Y,T,Trec,r,fname,C,v,v);
% 		end
% 	end
% end
% 
% 
