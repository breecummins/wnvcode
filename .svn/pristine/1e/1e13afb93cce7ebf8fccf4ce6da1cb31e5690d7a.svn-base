function r=setParams(Nm,dt,minang,maxang,minspd,maxspd,rulenum,thresh,satrtn,concav);
	
	%This function sets parameters for main_chemotaxis.m. Nm is the number of mosquitoes, the 'min' and 'max' parameters control the limits of the diroection angle window and of the speed. rulenum is the rule number from the paper. thresh is minimum sensory threshold, satrtn is the saturation level, and concav is the concavity parameter for the response function. In rules 2 and 6, these last three parameters must each be two vectors, with the parameters for choosing direction *first* and for speed *second*.
	
	if ( (rulenum == 2 || rulenum == 6) && (length(thresh)~= 2 || length(satrtn) ~= 2 || length(concav) ~= 2) ) ; 
		disp('Wrong number of response function parameters. Need two each.')
	elseif ( ~(rulenum == 2 || rulenum == 6) && (length(thresh) >1 || length(satrtn) >1 || length(concav) >1) );
		disp('Wrong number of response function parameters. Need one each.')
	end
	
	r.Nm = Nm; %number of mosquitoes
	r.dt = dt; %timestep for making decisions
	r.minang = minang; %angle limits
	r.maxang = maxang;
	r.minspd = minspd; %speed limits
	r.maxspd = maxspd;
	r.rulenum = rulenum;
		
	%Set direction parameters (and memory if needed).
	if rulenum < 5; %gradient rules
		r.dir = 'g';
	elseif rulenum >=5 &&rulenum < 9; %memory rules
		r.dir = 't';
		r.memang = zeros(Nm,1);
		r.memC = zeros(Nm,1);
	else;  %random direction rules
		r.dir = 'r';
	end
	
	%Set speed parameters.
	if rulenum == 2 || rulenum == 6 || rulenum == 9; %speed from concentration
		r.spd = 'c';
	elseif rulenum == 4 || rulenum == 8; %random speed
		r.spd = 'r';
	elseif rulenum == 1; %speed from gradient
		r.spd = 'g';
	elseif rulenum == 5; %speed from memory
		r.spd = 't';
	else;  %fixed speed
		r.spd = 'f';
	end
	
	%Set response function parameters.
	if rulenum == 1 || rulenum == 5; %direction and speed use same sensory modality
		r.thresh_dir = thresh; r.thresh_spd = thresh;
		r.satrtn_dir = satrtn; r.satrtn_spd = satrtn;
		r.concav_dir = concav; r.concav_spd = concav;
	elseif rulenum == 2 || rulenum == 6; %direction and speed use different sensory modalities
		r.thresh_dir = thresh(1); r.thresh_spd = thresh(2);
		r.satrtn_dir = satrtn(1); r.satrtn_spd = satrtn(2);
		r.concav_dir = concav(1); r.concav_spd = concav(2);
	elseif rulenum == 9; %only the speed uses the response function
		r.thresh_dir = []; r.thresh_spd = thresh;
		r.satrtn_dir = []; r.satrtn_spd = satrtn;
		r.concav_dir = []; r.concav_spd = concav;
	elseif rulenum == 10; %neither direction nor speed uses the response function
		r.thresh_dir = []; r.thresh_spd = [];
		r.satrtn_dir = []; r.satrtn_spd = [];
		r.concav_dir = []; r.concav_spd = [];
	else;  %rules 3,4,7, and 8 -- only direction uses response function
		r.thresh_dir = thresh; r.thresh_spd = [];
		r.satrtn_dir = satrtn; r.satrtn_spd = [];
		r.concav_dir = concav; r.concav_spd = [];
	end
		
				
			
						