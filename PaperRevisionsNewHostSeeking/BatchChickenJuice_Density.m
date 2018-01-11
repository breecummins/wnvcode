% BatchChickenJuice_Density.m

clear
close all

% matlabpool

% SAVE FILES IN THE FOLLOWING FOLDER
%basedir = '~/WNVNewHostSeeking/ChangingDensityAverageChickPos';
basedir = '/scratch03/bcummins/mydata/WNVNewHostSeeking/ChangingDensityAverageChickPos';
fnamestring = 'ft2perchick';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

% CHOOSE THE NUMBER OF SIMULATIONS
numsims = 15; %number of simulations to run for each ensemble

load randvels_Density %use the same random vel fields

for k = 1:8;
	BoxLengthPerChick = sqrt(0.0929*k); % in meters (0.0929m^2 = 1 ft^2)
	if k < 3;
		numiters = 10;
	elseif k < 6;
		numiters = 20;
	else;
		numiters = 30;
	end
	
	for n = 1:numiters;
		[p0,xm0,tm0,mem0,xc,yc,Cmem] = BatchinitParams_Density(BoxLengthPerChick);
		% if k == 1 && n == 1;
		% 	r1 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,ceil(p.Tf/p.tRand)+1));  
		% 	r2 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,ceil(p.Tf/p.tRand)+1));
		% end
		
		% parfor windmode = 3%1:3;
		for windmode = 3;
			% BLANK STRUCTURE FOR SAVING OUTPUT	
			alloutput = struct();

		    % RANDOM SEED FOR MOSQUITO BEHAVIOR
			SetRandomSeed(0);

		    % SET REMAINING PARAMETERS IN A SCRIPT
		    [p,ym0,angmem] = BatchsetParams_parallel(p0,windmode,basedir,fnamestring,k,n); 

			for snum = 1:numsims;
		        % NOTIFY USER WHICH RUN
				disp([WindName(p.wind_mode),' simulation ',int2str(snum),' of ',int2str(numsims),', iteration ',int2str(n),' of ',int2str(numiters),', host distribution ',int2str(k),' of 8.'])

				% RUN THE SIMULATION
			    [ xm, ym, results ] = BatchChickenGuts( p, xm0, ym0, tm0, mem0, xc, yc, r1, r2, Cmem, angmem );
				alloutput = UpdateVars(xm,ym,results,snum,alloutput);
		
		    end %for loop
	
			% % SAVE THE INPUTS AND OUTPUTS
			% savefile(p,xc,yc,alloutput);
		end 
	end
end

