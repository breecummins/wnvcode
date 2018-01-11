function BatchRunSims_NoDiffusion(basedir, fnamestring, p,xm0,tm0,mem0,xc,yc,Cmem, r1,r2, recordplume);

	if ~exist('recordplume','var');
        recordplume = 250; %default time step at which to record the CO2 plume
    end

	for windmode = [1,2,5];
	    % RANDOM SEED FOR MOSQUITO BEHAVIOR
		SetRandomSeed(0);

	    % SET REMAINING PARAMETERS IN A SCRIPT
	    [p,ym0,angmem] = BatchsetParams(p,windmode,basedir,fnamestring); 

	    % NOTIFY USER WHICH RUN
		disp([WindName(windmode),' simulation, ', fnamestring])

		% RUN THE SIMULATION
	    [ xm, ym, results ] = BatchChickenGuts_NoDiffusion( p, xm0, ym0, tm0, mem0, xc, yc, r1, r2, Cmem, angmem, recordplume );

		% SAVE THE INPUTS AND OUTPUTS
		save(p.savefname, 'p', 'xc', 'yc', 'xm', 'ym', 'results')    
	end 
end %function
