% BatchChickenJuice_SquigglyFlow.m

clear
close all

matlabpool

% SAVE FILES IN THE FOLLOWING FOLDER
% basedir = '~/WNVNewHostSeeking/CompareFlows/';
basedir = '/scratch03/bcummins/mydata/WNVNewHostSeeking/CompareFlows/';
fnamestring = 'velprofile';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

% CHOOSE THE NUMBER OF SIMULATIONS
numsims = 15; %number of simulations to run for each ensemble

BoxLengthPerChick = sqrt(0.0929); % in meters (0.0929m^2 = 1 ft^2)

for k = 2:3;
	if k ==2;
		% continue %skip these runs because I already did them
		[p0,xm0,tm0,mem0,xc,yc,Cmem] = BatchinitParams_Density_Uniform(BoxLengthPerChick,'');
		r1 = p0.Vmag*p0.randratio*(p0.randmean + p0.randstddev*randn(p0.Ng,p0.Ng,ceil(p0.Tf/p0.tRand)+1));  
		r2 = p0.Vmag*p0.randratio*(p0.randmean + p0.randstddev*randn(p0.Ng,p0.Ng,ceil(p0.Tf/p0.tRand)+1));
	elseif k == 3;
		[p0,xm0,tm0,mem0,xc,yc,Cmem] = BatchinitParams_Density_Uniform(BoxLengthPerChick,'_squigglyR2');
		p0.entrytimerange = [549.6, 550.4];
		edt = p0.entrytimerange(2)-p0.entrytimerange(1);    
		tm0 = round(edt*rand(p0.Nm,1) + p0.entrytimerange(1)); %entrance time of mosquitoes	
		tm0 = sort(tm0);
	end
		
	parfor windmode = 1:3;
	% for windmode = [5];
		% BLANK STRUCTURE FOR SAVING OUTPUT	
		alloutput = struct();

	    % RANDOM SEED FOR MOSQUITO BEHAVIOR
		SetRandomSeed(0);

	    % SET REMAINING PARAMETERS IN A SCRIPT
	    [p,ym0,angmem] = BatchsetParams_parallel(p0,windmode,basedir,fnamestring,k); 

		for snum = 1:numsims;
	        % NOTIFY USER WHICH RUN
			disp([WindName(p.wind_mode),' simulation ',int2str(snum),' of ',int2str(numsims),', velocity distribution ',int2str(k-1),' of 2.'])

			% RUN THE SIMULATION
		    [ xm, ym, results ] = BatchChickenGuts( p, xm0, ym0, tm0, mem0, xc, yc, r1, r2, Cmem, angmem );
			alloutput = UpdateVars(xm,ym,results,snum,alloutput);
			
	    end %for loop

		% SAVE THE INPUTS AND OUTPUTS
		savefile(p,xc,yc,alloutput);
	end 
end