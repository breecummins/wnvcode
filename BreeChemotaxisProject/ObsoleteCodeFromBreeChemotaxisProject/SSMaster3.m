%SSMaster3.m

clear 
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Directory of methods: 	1. Gradient: pick direction, pick speed
%						2. Gradient: pick direction, speed fixed
%						3. Gradient: pick direction, speed random
%						4. Concentration: direction from memory, pick speed from absolute concentration
%						5. Concentration: direction from memory, speed from memory
%						6. Concentration: direction from memory, speed fixed
%						7. Concentration: direction from memory, speed random
%						8. Concentration: direction random, pick speed from absolute concentration
%						9. Diffusion: direction random, speed fixed
%					   10. Gradient: pick direction, pick speed from absolute concentration

all_descriptions = { 'Grad: pick dir & spd','Grad: pick dir, spd fixed','Grad: pick dir, spd rand','Conc: dir mem, spd conc', 'Conc: dir mem, spd mem', 'Conc: dir mem, spd fixed', 'Conc: dir mem, spd rand','Conc: dir rand, pick spd','Diffusion', 'Grad: pick dir, spd conc',};
fn_descriptions = {'Grad_dir_grad_spd','Grad_dir_fixed_spd','Grad_dir_rand_spd','Mem_dir_conc_spd', 'Mem_dir_mem_spd', 'Mem_dir_fixed_spd', 'Mem_dir_rand_spd', 'Rand_dir_conc_spd','Diffusion' };

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%SET RANDOM SEED
a=version;
if str2num(a(1:3)) >= 7.7;
	RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));
	%defaultStream = RandStream.getDefaultStream;
	%savedState = defaultStream.State;
else;
	rand('twister',sum(100*clock))
	randn('state',sum(100*clock)) 
end

fname='~/WNVFourthRuns/AllRules';
fixedvars.totruns=25; %will give 300 independent U stats between rule sets

%set variables
[fixedvars.L,fixedvars.Ng,fixedvars.nu,fixedvars.dt,fixedvars.Tf,fixedvars.U,fixedvars.xg,fixedvars.yg,fixedvars.h,fixedvars.tGraph] = setParams;
fixedvars.tGraph=0; %don't plot pictures
fixedvars.Tf = 125;
fixedvars.tSpace = [0:.25:10, 10.5:0.5:30, 31:1:fixedvars.Tf];
fixedvars.Methods=1:length(all_descriptions);
fixedvars.descriptions=all_descriptions;

%place mosquitoes
fixedvars.Nm = 200; %NUMBER OF MOSQUITOES    
[fixedvars.xm0,fixedvars.ym0] = PlacePoints(fixedvars.Nm,[0.75 0.85]*fixedvars.L,[0.75,0.85]*fixedvars.L,fixedvars.L,fixedvars.h);

%make fixed concentration gradient
fixedvars.sourcex = 0.4; fixedvars.sourcey = 0.3;
fixedvars.C = exp( -40*((fixedvars.xg-fixedvars.sourcex).^2+(fixedvars.yg-fixedvars.sourcey).^2) );
C_ym1 = [fixedvars.C(1,:); fixedvars.C(1:end-1,:)];
C_yp1 = [fixedvars.C(2:end,:); fixedvars.C(end,:)];
C_xp1 = [fixedvars.C(:,2:end), fixedvars.C(:,end)];
C_xm1 = [fixedvars.C(:,1),fixedvars.C(:,1:end-1)];

fixedvars.dCdx = (C_xp1-C_xm1)/(2*fixedvars.h);
fixedvars.dCdy = (C_yp1-C_ym1)/(2*fixedvars.h);
gm = sqrt( fixedvars.dCdx.^2 + fixedvars.dCdy.^2 );

%find max values for rule sets
fixedvars.maxG = max(max(gm)); 
fixedvars.maxC = max(max(abs(fixedvars.C)));

%set up arrays for storing mosquito data for the different rule sets
fixedvars.NumMethods = length(fixedvars.Methods);

fname1=[fname,'_fixedvariables.mat'];
save(fname1,'fixedvars');

%set rule set parameters
ruleparams.spdfixed=1;	
ruleparams.maxanggrad=pi;
ruleparams.maxangmem=pi;
maxspd=	1.25:0.25:2;
minspd=	0.25:0.25:0.75;
minang=pi/12:pi/12:10*pi/12;				
fixedvars.totparams=length(maxspd)*length(minspd)*length(minang);

%Do runs of interest.
c=0;
for k = maxspd;
	ruleparams.maxspdgrad=k;
	ruleparams.maxspdmem=k;
	ruleparams.maxspdconc=k;
	for l = minspd;
		ruleparams.minspdgrad=l;
		ruleparams.minspdmem=l;
		ruleparams.minspdconc=l;
		for m = minang;
			ruleparams.minanggrad=m;
			ruleparams.minangmem=m;
			c=c+1;
			str=sprintf('%03d',c);
			disp(['Parameter set ',str])
			basefname=[fname,'_paramset',str];
			SpatialStatistics_Empirical(ruleparams,fixedvars,basefname);
		end
	end
end

