% BatchChickenJuice_Density_Uniform.m

clear
close all

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '~/WNVFullBatchRuns/ChangingDensityAverageChickPos_Uniform/';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

% CHOOSE THE NUMBER OF SIMULATIONS
numsims = 15; %number of simulations to run for each ensemble

for k = 5:5;
	chickBoxLength = sqrt(0.0929*k); % in meters (0.0929m^2 = 1 ft^2)
	[p,xm0,tm0,mem0,xc,yc] = BatchinitParams_Density_Uniform(chickBoxLength);
	if k == 5;
		r1 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,ceil(p.Tf/p.tRand)+1));  
		r2 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,ceil(p.Tf/p.tRand)+1));
	end

	for windmode = [1,2,5];
		% BLANK STRUCTURE FOR SAVING OUTPUT	
		alloutput = struct();

	    % RANDOM SEED FOR MOSQUITO BEHAVIOR
		SetRandomSeed(0);

	    % SET REMAINING PARAMETERS IN A SCRIPT
	    [p,ym0] = BatchsetParams(p,windmode,basedir,k); 

		for snum = 1:numsims;
	        % NOTIFY USER WHICH RUN
			disp([WindName(windmode),' simulation ',int2str(snum),' of ',int2str(numsims),', host distribution ',int2str(k),' of 5.'])

			% RUN THE SIMULATION
		    [ xm, ym, results ] = BatchChickenGuts( p, xm0, ym0, tm0, mem0, xc, yc, r1, r2 );
			eval(['alloutput.xm',sprintf('%02d',snum),'=xm;']);
			eval(['alloutput.ym',sprintf('%02d',snum),'=ym;']);
			eval(['alloutput.results',sprintf('%02d',snum),'=results;']);
		
	    end %for loop
	
		% SAVE THE INPUTS AND OUTPUTS
		save(p.savefname, 'p', 'xc', 'yc', 'alloutput')    
	end 
end

