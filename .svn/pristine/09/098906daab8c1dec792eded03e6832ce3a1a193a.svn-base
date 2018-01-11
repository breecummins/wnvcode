% BatchChickenJuice_SquigglyNoStochasticity.m

clear
close all

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '~/WNVNewHostSeeking/NoStochasticity/';
fnamestring = 'velprofile';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

% CHOOSE THE NUMBER OF SIMULATIONS
numsims = 15; %number of simulations to run for each ensemble

BoxLengthPerChick = sqrt(0.0929); % in meters (0.0929m^2 = 1 ft^2)

for k = 2:3;
	if k ==2;
		[p,xm0,tm0,mem0,xc,yc,Cmem] = BatchinitParams_Density_Uniform(BoxLengthPerChick,'');
		r1 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,ceil(p.Tf/p.tRand)+1));  
		r2 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,ceil(p.Tf/p.tRand)+1));
		p.Cdirmin = 0;			% minimum window length around CO2 gradient direction
		p.Vdirmin = 0;			% minimum window length around wind direction
	elseif k == 3;
		[p,xm0,tm0,mem0,xc,yc,Cmem] = BatchinitParams_Density_Uniform(BoxLengthPerChick,'_squigglyR2');
		p.entrytimerange = [549.6, 550.4];
		edt = p.entrytimerange(2)-p.entrytimerange(1);    
		tm0 = round(edt*rand(p.Nm,1) + p.entrytimerange(1)); %entrance time of mosquitoes	
		tm0 = sort(tm0);
		p.Cdirmin = 0;			% minimum window length around CO2 gradient direction
		p.Vdirmin = 0;			% minimum window length around wind direction
	end
		
	for windmode = [1,2,5];
		% BLANK STRUCTURE FOR SAVING OUTPUT	
		alloutput = struct();

	    % RANDOM SEED FOR MOSQUITO BEHAVIOR
		SetRandomSeed(0);

	    % SET REMAINING PARAMETERS IN A SCRIPT
	    [p,ym0,angmem] = BatchsetParams(p,windmode,basedir,fnamestring,k); 

		for snum = 1:numsims;
	        % NOTIFY USER WHICH RUN
			disp([WindName(windmode),' simulation ',int2str(snum),' of ',int2str(numsims),', velocity distribution ',int2str(k-1),' of 2.'])

			% RUN THE SIMULATION
		    [ xm, ym, results ] = BatchChickenGuts( p, xm0, ym0, tm0, mem0, xc, yc, r1, r2, Cmem, angmem );
			eval(['alloutput.xm',sprintf('%02d',snum),'=xm;']);
			eval(['alloutput.ym',sprintf('%02d',snum),'=ym;']);
			eval(['alloutput.results',sprintf('%02d',snum),'=results;']);
			
	    end %for loop

		% SAVE THE INPUTS AND OUTPUTS
		save(p.savefname, 'p', 'xc', 'yc', 'alloutput')    
	end 
end