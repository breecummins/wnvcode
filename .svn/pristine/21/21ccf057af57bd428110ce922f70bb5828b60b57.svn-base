% BatchChickenJuice_Density.m

clear
close all

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '~/WNVBigDomain/';
fnamestring = 'originalhostposition_ft2perchick';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

% CHOOSE THE NUMBER OF SIMULATIONS
numsims = 1;%15; %number of simulations to run for each ensemble

%load randvels_Density %use the same random vel fields


for k = 8%1:8;
	BoxLengthPerChick = sqrt(0.0929*k); % in meters (0.0929m^2 = 1 ft^2)
	if k < 3;
		numiters = 10;
	elseif k < 6;
		numiters = 20;
	else;
		numiters = 1;%30;
	end
	
	for n = 1:numiters;
		[p,xm0,tm0,mem0,xc,yc,Cmem] = BatchinitParams_Density(BoxLengthPerChick);
		if k == 8 && n == 1;
			r1 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng*p.Ly/p.Lx,p.Ng,ceil(p.Tf/p.tRand)+1));  
			r2 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng*p.Ly/p.Lx,p.Ng,ceil(p.Tf/p.tRand)+1));
		end
		
		for windmode = 1%[1,2,5];
			% BLANK STRUCTURE FOR SAVING OUTPUT	
			alloutput = struct();

		    % RANDOM SEED FOR MOSQUITO BEHAVIOR
			SetRandomSeed(0);

		    % SET REMAINING PARAMETERS IN A SCRIPT
		    [p,ym0,angmem] = BatchsetParams(p,windmode,basedir,fnamestring,k,n); 

			for snum = 1:numsims;
		        % NOTIFY USER WHICH RUN
				disp([WindName(windmode),' simulation ',int2str(snum),' of ',int2str(numsims),', iteration ',int2str(n),' of ',int2str(numiters),', host distribution ',int2str(k),' of 8.'])

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
end

