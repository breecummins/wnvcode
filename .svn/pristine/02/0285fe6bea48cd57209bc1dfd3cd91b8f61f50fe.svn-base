function [ksstats,ksmean, lenstats1, lenstats2, Trec, bestmatch] = findBestMatch(dirname1,wc1,dirname2,wc2,graph);
	
	%inputs are four strings. dirname1 contains the directory name containing the files that I want to compare results with. wc1 is a wild card string containing the particular files in that directory that I am interested in. dirname2, wc2 is the information for the comparison files. Example: dirname1 = 'booga' and wc1 = 'Rule04*_van*' finds all the files in directory booga beginning with 'Rule04' and followed by the characters '_van' somewhere in the file name. The algorithm finds the single best match between the files dirname1/wc1 and the ones in dirname2/wc2. Note that wc1 can be a filename, so that the optimization only occurs over dirname2/wc2. 
	%graph =1 means graph the resulting KS comparison.

	d1 = dir(fullfile(dirname1,wc1));
	d2 = dir(fullfile(dirname2,wc2));
	err = zeros(length(d1),length(d2));
	for k = 1:length(d1);
		load(fullfile(dirname1,d1(k).name))
		bc = sum(R==0,1); %cost function will involve the number of mosquitoes at the source....
		bm = mean(R>0,1);  %...and the mean position of the remaining mosquitoes
		if sum(bc) < 100;
			disp('Warning: Not many mosquitoes are reaching the source. May want to consider another cost function.')
		end
		for l = 1:length(d2)
			load(fullfile(dirname2,d2(l).name))
			cc = sum(R==0,1); 
			cm = mean(R>0,1);
			gamma = 0.5;
			err(k,l)= gamma*sum(abs(bc-cc)) + (1-gamma)*sum(abs(bm-bc));
		end
	end
	
	[ind,jnd] = find(err == min(min(err)));
	bestmatch{1} = fullfile(dirname1,d1(ind).name);
	bestmatch{2} = fullfile(dirname2,d2(jnd).name);
	
	[ksstats,ksmean, lenstats1, lenstats2, Trec] = KSviz(bestmatch{1},bestmatch{2},0,[],[],graph);