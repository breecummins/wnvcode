% BatchChickenJuice_2groups.m

clear
close all

matlabpool

% SAVE FILES IN THE FOLLOWING FOLDER
% basedir = '~/WNVNewHostSeeking/ChangingNumHostsAverageChickPos/';
basedir = '/scratch03/bcummins/mydata/WNVNewHostSeeking/ChangingNumHostsAverageChickPos/';
fnamestring = 'numchicks';

% MAKE SURE INITIAL CHOICES ARE THE SAME 
SetRandomSeed(418);

% CHOOSE THE NUMBER OF SIMULATIONS
numsims = 15; %number of simulations to run for each ensemble
numiters = 10;

% % STRUCTURE FOR SAVING CHICKEN POSITIONS
% chickpos_xc=cell(0);
% chickpos_yc=cell(0);

for k = 1:5;
	Nc = [10-k, k];
	% xcmat = [];
	% ycmat = [];
	for l = 1:numiters;
		[p0,xm0,tm0,mem0,xc,yc,Cmem] = BatchinitParams_2groups(Nc);
		% xcmat[:,l] = xc; %save chicken positions for no source runs
		% ycmat[:,l] = yc; %save chicken positions for no source runs
		if k == 1 && l == 1;
			r1 = p0.Vmag*p0.randratio*(p0.randmean + p0.randstddev*randn(p0.Ng,p0.Ng,ceil(p0.Tf/p0.tRand)+1));  
			r2 = p0.Vmag*p0.randratio*(p0.randmean + p0.randstddev*randn(p0.Ng,p0.Ng,ceil(p0.Tf/p0.tRand)+1));
		end
	
		parfor windmode = 1:3;
		% for windmode = [1,2,5];
			% BLANK STRUCTURE FOR SAVING OUTPUT	
			alloutput = struct();

		    % RANDOM SEED FOR MOSQUITO BEHAVIOR
			SetRandomSeed(0);

		    % SET REMAINING PARAMETERS IN A SCRIPT
		    [p,ym0,angmem] = BatchsetParams_parallel(p0,windmode,basedir,fnamestring,k,l); 

			for snum = 1:numsims;
		        % NOTIFY USER WHICH RUN
				disp([WindName(p.wind_mode),' simulation ',int2str(snum),' of ',int2str(numsims),', host distribution ',int2str(k),' of 5, iteration ',int2str(l),' of ',int2str(numiters),'.'])

				% RUN THE SIMULATION
			    [ xm, ym, results ] = BatchChickenGuts( p, xm0, ym0, tm0, mem0, xc, yc, r1, r2, Cmem, angmem );
				alloutput = UpdateVars(xm,ym,results,snum,alloutput);
			
		    end %for loop
		
			% SAVE THE INPUTS AND OUTPUTS
			savefile(p,xc,yc,alloutput);
		end 
	end
	% chickpos_xc{k} = xcmat; %save chicken positions for no source runs
	% chickpos_yc{k} = ycmat; %save chicken positions for no source runs
end

% % Test null hypothesis with no CO2
% for k = 1:5;
% 	Nc = [10-k, k];
% 	[p,xm0,tm0,mem0,xc,yc] = BatchinitParams(Nc,0);
% 	xc = eval(['chickpos.xc',int2str(k)]);  %use the same chicken positions as before
% 	yc = eval(['chickpos.yc',int2str(k)]);
% 	
% 	for windmode = [1,2,5];
% 		% BLANK STRUCTURE FOR SAVING OUTPUT	
% 		alloutput = struct();
% 
% 	    % RANDOM SEED FOR MOSQUITO BEHAVIOR
% 		SetRandomSeed(0);
% 
% 	    % SET REMAINING PARAMETERS IN A SCRIPT
% 	    [p,ym0] = BatchsetParams(p,windmode,basedir,snum); 
% 		p.savefname = fullfile(basedir,[WindName(windmode),int2str(k),'_noCO2.mat']);   
% 
% 		for snum = 1:numsims;
% 	        % NOTIFY USER WHICH RUN
% 			disp([WindName(windmode),' simulation ',int2str(snum),' of ',int2str(numsims),', host distribution ',int2str(k),' of ',int2str(5),', no CO2.'])
% 
% 			% RUN THE SIMULATION
% 		    [ xm, ym, results ] = BatchChickenGuts( p, xm0, ym0, tm0, mem0, xc, yc, r1, r2 );
% 			eval(['alloutput.xm',sprintf('%02d',snum),'=xm;']);
% 			eval(['alloutput.ym',sprintf('%02d',snum),'=ym;']);
% 			eval(['alloutput.results',sprintf('%02d',snum),'=results;']);
% 	
% 	    end %for loop
% 		
% 		% SAVE THE INPUTS AND OUTPUTS
% 	    save(p.savefname, 'p', 'xc', 'yc', 'alloutput')    
% 	end 
% end

