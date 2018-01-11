% BatchChickenJuice_NonSeeking.m

clear
close all

fnamestring = 'velprofile';

% % SAVE FILES IN THE FOLLOWING FOLDER
% basedir = '~/WNVNewHostSeeking/NonSeeking/AdvectionPlusRandWalk';
% randwalk=1;
% advect=1;
% rwonlyflag=0;

% % SAVE FILES IN THE FOLLOWING FOLDER
% basedir = '~/WNVNewHostSeeking/NonSeeking/AdvectionOnly';
% randwalk=0;
% advect=1;
% rwonlyflag=0;
% adonlyflag=1;

% % SAVE FILES IN THE FOLLOWING FOLDER
% basedir = '~/WNVNewHostSeeking/NonSeeking/AdvectionPlusRandWalk_LowerSpeed';
% randwalk=1;
% advect=1;
% spdflag = 1;
% rwonlyflag=0;

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '~/WNVNewHostSeeking/NonSeeking/RandWalkOnly';
randwalk=1;
advect=0;
rwonlyflag = 1;

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

% CHOOSE THE NUMBER OF SIMULATIONS
if exist('adonlyflag','var') && adonlyflag;
	numsims = 1;
else;
	numsims = 15; %number of simulations to run for each ensemble
end

BoxLengthPerChick = sqrt(0.0929); % in meters (0.0929m^2 = 1 ft^2)

for k = 2:3;
	if k ==2;
		[p,xm0,tm0,mem0,xc,yc,Cmem] = BatchinitParams_Density_Uniform(BoxLengthPerChick,'');
		r1 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,ceil(p.Tf/p.tRand)+1));  
		r2 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,ceil(p.Tf/p.tRand)+1));
		p.entrytimerange = [-0.51,0.49];
		p.tReport = p.Tf;%25;	    	% controls how often to print the summary state of the mosquitoes 
		edt = p.entrytimerange(2)-p.entrytimerange(1);    
		tm0 = round(edt*rand(p.Nm,1) + p.entrytimerange(1)); %entrance time of mosquitoes	
		tm0 = sort(tm0);
		if exist('spdflag','var') && spdflag;
			p.spdMax = p.spdMax/2;
		end
		% p.tGraph_after = 1;
	elseif k == 3;
		[p,xm0,tm0,mem0,xc,yc,Cmem] = BatchinitParams_Density_Uniform(BoxLengthPerChick,'_squigglyR2');
		p.entrytimerange = [-0.51,0.49];
		p.tReport = p.Tf;%25;	    	% controls how often to print the summary state of the mosquitoes 
		edt = p.entrytimerange(2)-p.entrytimerange(1);    
		tm0 = round(edt*rand(p.Nm,1) + p.entrytimerange(1)); %entrance time of mosquitoes	
		tm0 = sort(tm0);
		if exist('spdflag','var') && spdflag;
			p.spdMax = p.spdMax/2;
		end
		%p.tGraph_after = 1;		% controls how often to graph output after mosqs appear 
	end
		
	for windmode = 2;
		% BLANK STRUCTURE FOR SAVING OUTPUT	
		alloutput = struct();

	    % RANDOM SEED FOR MOSQUITO BEHAVIOR
		SetRandomSeed(0);

	    % SET REMAINING PARAMETERS
	    ym0 = 2*p.h*ones(p.Nm,1);
		p.savefname = fullfile(basedir,['Downwind_',fnamestring,int2str(k),'.mat']); 
		p.wind_mode = windmode; 

		for snum = 1:numsims;
	        % NOTIFY USER WHICH RUN
			disp([WindName(windmode),' simulation ',int2str(snum),' of ',int2str(numsims),', velocity distribution ',int2str(k-1),' of 2.'])

			% RUN THE SIMULATION
		    [ xm, ym, results ] = BatchChickenGuts_NonSeeking( p, xm0, ym0, tm0, xc, yc, r1, r2, randwalk, advect,rwonlyflag );
			eval(['alloutput.xm',sprintf('%02d',snum),'=xm;']);
			eval(['alloutput.ym',sprintf('%02d',snum),'=ym;']);
			eval(['alloutput.results',sprintf('%02d',snum),'=results;']);
			
	    end %for loop

		% SAVE THE INPUTS AND OUTPUTS
		save(p.savefname, 'p', 'xc', 'yc', 'alloutput')    
	end 
end