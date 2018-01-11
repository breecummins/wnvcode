% BatchChickenJuice.m

clear
close all

% SAVE FILES IN THE FOLLOWING FOLDER
basedir = '~/WNVSensitivityAnalysis/MosqBehaviorCollectionReset/';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

% SET INITIAL PARAMETERS, INCLUDING RANDOMLY CHOSEN VALUES THAT WE WANT FIXED ACROSS SIMULATIONS.
[p,xm0,tm0,mem0,xc,yc] = BatchinitParams();
r1 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,round(p.Tf/p.tRand)+1));  
r2 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(p.Ng,p.Ng,round(p.Tf/p.tRand)+1));
size(r1)

% CHOOSE THE NUMBER OF SIMULATIONS
minsims = 10; %mininmum number of simulations to run for each ensemble
maxsims = 50; %maximum number of simulations to run for each ensemble
stopcritcst = 0.01; %threshold for stopping, will be multiplied by the change in the parameter
currentmaxsims = minsims*ones(1,5); %placeholder for the number of simulations needed for the base parameter set (max over all parameter runs) for upwind


%VARIED VALUES
propchange = 0.1; 
%varlist = { 'nu', 'sC', 'randratio', 'CO2_thresh','spdMin', 'spdMax', 'Cdirmin','gradweight', 'Vdirmin' };
%varlist = { 'crosswind_duration' };
varlist = { 'host_radius' };
%varlist={};

for windmode = [1,2,5];
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
			    [p,ym0] = BatchsetParams(p,windmode,basedir,varparam,pm,propchange,origval); 

				% RUN THE SIMULATION
			    [ xm, ym, results ] = BatchChickenGuts( p, xm0, ym0, tm0, mem0, xc, yc, r1, r2 );
				eval(['alloutput.xm',sprintf('%02d',snum),'=xm;']);
				eval(['alloutput.ym',sprintf('%02d',snum),'=ym;']);
				eval(['alloutput.results',sprintf('%02d',snum),'=results;']);
				
			    % ASSESS IF MEAN HAS CONVERGED
			    [recordmeans,cms,flag]=stopSims(snum,minsims,maxsims,stopcritcst,results,p,recordmeans,cms);
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
	    [p,ym0] = BatchsetParams(p,windmode,basedir); 
	
		% RUN THE SIMULATION
	    [ xm, ym, results ] = BatchChickenGuts( p, xm0, ym0, tm0, mem0, xc, yc, r1, r2 );
		eval(['alloutput.xm',sprintf('%02d',snum),'=xm;']);
		eval(['alloutput.ym',sprintf('%02d',snum),'=ym;']);
		eval(['alloutput.results',sprintf('%02d',snum),'=results;']);

	end

	% SAVE THE INPUTS AND OUTPUTS	
	save(p.savefname, 'p', 'xc', 'yc', 'alloutput')  

end
