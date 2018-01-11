function SItable = maketable_SA(basedir,vnames,rangingbehaviors,outputnums,threshold);


	% Compiles SA output. Examples of inputs:
	% basedir='~/WNVNewHostSeeking/SensitivityAnalysis/FirstParams';
	% vnames = { 'host_radius','spdMax', 'crosswind_duration' };
	% rangingbehaviors = [1,2,5];
	% outputnums = [1,4]; %All the outputs are 1:4; default. (1=total finding host, 2=group 1, 3=group 2, 4=avg time)
	
	propchange = 0.1; %not saved anywhere -- the proportional change in the input variables (see BatchChickenJuice_SA.m)
	
	if ~exist('threshold','var') || isempty(threshold);
		threshold = 0.1;
	end
	
	giantoutputmatrix = collateSimdata_SA(basedir,vnames,rangingbehaviors,outputnums);
	outputnames = getSensitivityNames(outputnums);
	
	SItable = {};
	w=0;
	for windmode = rangingbehaviors;
		w=w+1;
		v = squeeze(giantoutputmatrix(w,:,:,4));
		e = squeeze(giantoutputmatrix(w,:,:,5));
		b = squeeze(giantoutputmatrix(w,:,:,2));
		bm = squeeze(giantoutputmatrix(w,:,:,1));
		bp = squeeze(giantoutputmatrix(w,:,:,3));
		k = find(abs(v)>=threshold);
		[ind,jnd] = ind2sub(size(v), k);
		SItable{w}.vnames = {vnames{ind}};
		SItable{w}.outputnames = {outputnames{jnd}};
		SItable{w}.SI = v(k);
		SItable{w}.err = e(k);
		SItable{w}.baseval = b(k);
		SItable{w}.lowerval = bm(k);
		SItable{w}.upperval = bp(k);
		SItable{w}.scaledSI10percent = v(k)*propchange;
		SItable{w}.scalederr10percent = e(k)*propchange;
	end

	