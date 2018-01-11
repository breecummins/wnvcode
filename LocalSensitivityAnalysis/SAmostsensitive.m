function SItable = SAmostsensitive(basedir,vnames,rangingbehaviors,outputnums,threshold);

	if ~exist('threshold','var') || isempty(threshold);
		threshold = 0.1;
	end
	
	giantoutputmatrix = SAdata(basedir,vnames,rangingbehaviors,outputnums);
	outputnames = getSensitivityNames(outputnums);
	
	SItable = {};
	w=0;
	for windmode = rangingbehaviors;
		w=w+1;
		v = squeeze(giantoutputmatrix(w,:,:,1));
		e = squeeze(giantoutputmatrix(w,:,:,2));
		p = squeeze(giantoutputmatrix(w,:,:,3));
		k = find(abs(v)>threshold);
		[ind,jnd] = ind2sub(size(v), k);
		SItable{w}.vnames = {vnames{ind}};
		SItable{w}.outputnames = {outputnames{jnd}};
		SItable{w}.SI = v(k);
		SItable{w}.err = e(k);
		SItable{w}.P0 = p(k);
		% if ~isempty(ind);
		% 	SAviz(basedir,unique({vnames{ind}}),windmode,unique(outputnums(jnd)),'n','n');
		% end
	end

	