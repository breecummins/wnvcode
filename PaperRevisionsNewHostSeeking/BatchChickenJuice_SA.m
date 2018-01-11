% BatchChickenJuice.m

clear
close all

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '~/WNVNewHostSeeking/SensitivityAnalysis/MoreParams';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

% SET INITIAL PARAMETERS, INCLUDING RANDOMLY CHOSEN VALUES THAT WE WANT FIXED ACROSS SIMULATIONS.
BoxLengthPerChick = sqrt(0.0929); % in meters (0.0929m^2 = 1 ft^2)
[p,xm0,tm0,mem0,xc,yc,Cmem] = BatchinitParams_Density_Uniform(BoxLengthPerChick);
r1 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,round(p.Tf/p.tRand)+1));  
r2 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,round(p.Tf/p.tRand)+1));

% CHOOSE THE NUMBER OF SIMULATIONS
minsims = 15; %mininmum number of simulations to run for each ensemble
maxsims = 50; %maximum number of simulations to run for each ensemble
stopcritcst = 0.01; %threshold for stopping, will be multiplied by the change in the parameter

%%%%%%%%%%%%%%%%%%%%%%
% BE SURE TO CHANGE currentmaxsims when running second varlist (if needed).
%%%%%%%%%%%%%%%%%%%%%%

%VARIED VALUES
propchange = 0.1; 
%varlist = { 'spdMax','host_radius','crosswind_duration' };
% currentmaxsims = minsims*ones(1,5); %placeholder for the number of simulations needed for the base parameter set (max over all parameter runs) for upwind
% varlist = { 'nu', 'sC', 'randratio', 'CO2_thresh','spdMin', 'Cdirmin','gradweight', 'Vdirmin' };
% currentmaxsims = [16,22,minsims,minsims,19]; 
varlist = { 'Cdirmin','gradweight', 'Vdirmin' };
currentmaxsims = [16,22,minsims,minsims,19]; 


%for windmode = [1,2,5];
for windmode = [5];
	cms = currentmaxsims(windmode);

    for k = 1:length(varlist);

		varparam = varlist{k};
		origval = eval(['p.',varparam]); %save original parameter value

		for pm = ['p','m']; % plus or minus 10% of original param value

			% TRACK MEANS IN ORDER TO STOP LOOP EARLY IF CONVERGENCE ATTAINED
			recordmeans = [];

			% BLANK STRUCTURE FOR SAVING OUTPUT	
			alloutput = struct();

		    % RANDOM SEED FOR MOSQUITO BEHAVIOR
			SetRandomSeed(0);

			for snum = 1:maxsims;
		        % NOTIFY USER WHICH RUN
				disp(['Ranging flight = ',int2str(windmode),', varying ',varparam,' in ',pm,' direction, simulation number = ',int2str(snum),'.'])

			    % SET REMAINING PARAMETERS IN A SCRIPT
			    [p,ym0,angmem] = BatchsetParams_SA(p,windmode,basedir,varparam,pm,propchange,origval);

				% RUN THE SIMULATION
		    	[ xm, ym, results ] = BatchChickenGuts( p, xm0, ym0, tm0, mem0, xc, yc, r1, r2, Cmem, angmem );
				eval(['alloutput.xm',sprintf('%02d',snum),'=xm;']);
				eval(['alloutput.ym',sprintf('%02d',snum),'=ym;']);
				eval(['alloutput.results',sprintf('%02d',snum),'=results;']);
				
			    % ASSESS IF MEAN HAS CONVERGED
			    [recordmeans,cms,flag]=stopSims_SA(snum,minsims,maxsims,stopcritcst,results,p,recordmeans,cms);
				if flag == 'done';
					break
				else;
					continue
				end
	      	end %for loop
		
			% SAVE THE MAX NUMBER OF ITERS
			currentmaxsims(windmode) = cms;
			
			% SAVE THE INPUTS AND OUTPUTS
		    save(p.savefname, 'p', 'xc', 'yc', 'alloutput')     

			% RESET PARAMETER TO ORIGINAL VALUE
			eval(['p.',varparam,'= origval;']);  
	    end 
	end
end


% BASE VALUES
for windmode = [1,2,5];
	alloutput = struct();

    % RANDOM SEED FOR MOSQUITO BEHAVIOR
	SetRandomSeed(0);

	for snum = 1:currentmaxsims(windmode);
		% INFORMATIVE MESSAGES
		disp(['Ranging flight = ',int2str(windmode),', base run, simulation number = ',int2str(snum),' of ',int2str(currentmaxsims(windmode)),'.'])

	    % SET REMAINING PARAMETERS IN A SCRIPT
		[p,ym0,angmem] = BatchsetParams_SA(p,windmode,basedir);
	
		% RUN THE SIMULATION
		[ xm, ym, results ] = BatchChickenGuts( p, xm0, ym0, tm0, mem0, xc, yc, r1, r2, Cmem, angmem );
		eval(['alloutput.xm',sprintf('%02d',snum),'=xm;']);
		eval(['alloutput.ym',sprintf('%02d',snum),'=ym;']);
		eval(['alloutput.results',sprintf('%02d',snum),'=results;']);

	end

	% SAVE THE INPUTS AND OUTPUTS	
	save(p.savefname, 'p', 'xc', 'yc', 'alloutput')  

end
