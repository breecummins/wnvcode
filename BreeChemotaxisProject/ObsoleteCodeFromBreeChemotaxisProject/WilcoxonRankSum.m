function [U,sct,bigvec_sorted,allind] = WilcoxonRankSum(samp1,samp2,p);
	
	%Calculates U-statistic based on sample 1 (other U-statistic is found by subtracting U from length(samp1)*length(samp2)). Samples 1 and 2 are vectors, not necessarily of the same length. p is the (optional) precision of the measurement; for example, p =4 means that samp1 and samp2 are only known out to the fourth decimal place (10^-4 place). Rounding occurs based on p.
	%U is the statistic, sct is a correction term for the standard deviation in the p-value testing.
	
	samp1 = makecolumn(samp1);
	samp2 = makecolumn(samp2);

	nsamp1 = length(samp1);
	nsamp2 = length(samp2);

	%apply measurement precision
	if exist('p','var');
		samp1 = round(samp1*10^p)*10^(-p);
		samp2 = round(samp2*10^p)*10^(-p);
	end

	%rank the distances from both of the samples simultaneously
	r1 = [samp1, ones(nsamp1,1)];
	r2 = [samp2, 2*ones(nsamp2,1)];
	bigvec = [r1; r2];
	[junk,ind] = sort(bigvec(:,1));
	bigvec_sorted = bigvec(ind,:);
	
	%track tied values
	allind = 1:(nsamp1+nsamp2);
	sct = 0;
	u = unique(bigvec_sorted(:,1));
	if length(u) < nsamp1+nsamp2;
		acc = [];
		for k = 1:length(u);
			ivec = find(bigvec_sorted(:,1) == u(k));
			allind(ivec) = mean(ivec);
			l = length(ivec);
			sct = sct + l^3 - l; %correction term for the standard deviation
		end
	end
			
	%now calculate the Mann-Whitney U/Wilcoxon's rank sum statistic)
	jnd = find(bigvec_sorted(:,2) == 1);
	U = sum(allind(jnd)) - nsamp1*(nsamp1 +1)/2;
