function giantoutputmatrix = collateSimdata_SA(basedir,vnames,rangingbehaviors,outputnums);
	
	% Compiles SA output. Examples of inputs:
	% basedir='~/WNVNewHostSeeking/SensitivityAnalysis/FirstParams';
	% vnames = { 'host_radius','spdMax', 'crosswind_duration' };
	% rangingbehaviors = [1,2,5];
	% outputnumbers = [1,2,3]; %All the outputs are 1:4; default. (1=total finding host, 2=group 1, 3=group 2, 4=avg time)
	
	if ~exist('outputnums','var') || isempty(outputnums);
		outputnums = 1:4;
	end

	giantoutputmatrix = zeros(length(rangingbehaviors),length(vnames),length(outputnums),5);
	w=0;
	for windmode = rangingbehaviors;
		w=w+1;
		for k = 1:length(vnames);
			varname = vnames{k};
			[inputs, outputs] = calcsensitivityindex(varname,windmode,basedir);
			tctr = 0;
			for op = outputnums;
				tctr=tctr+1;
				giantoutputmatrix(w,k,tctr,:) = outputs(:,op);
			end
		end
	end