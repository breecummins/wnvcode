function SSfindmatches_script_postprocessing(fname);
	
	%fname is a string beginning with '~/WNVSixthRuns/bestmatches_'
	%this function does backwards comparisons (see the reversed arguments in SSPairwiseRunCompsKSstat)
	
	load(fname)
	savefile = 1;
	viz = 1;
	
	clr=get(0,'DefaultAxesColorOrder');
	
	for c = 1:size(matches,1);
		for b = 1:size(matches,2);
			close all
			[ksmean_self,ks025percent_self,ks975percent_self,fname]=SSPairwiseRunCompsKSstatSelfOnly(comprs(c),matches(c,b),1,1,1);
			ksmean = SSPairwiseRunCompsKSstat(comprs(c),matches(c,b),basers,baseps(b),van,rmos,savefile,viz,ksmean_self{1},ks025percent_self{1},ks975percent_self{1});
			input('Press "Enter" when done editing figure.')
saveas(1,['~/rsyncfolder/data/WNV/WNVSixthRuns/KSstats/KSstat_RS',sprintf('%02d',comprs(c)),'PS',sprintf('%03d',matches(c,b)),'_vs_RS',sprintf('%02d',basers),'PS',sprintf('%03d',baseps(b)),'.pdf'],'pdf')
			
		end
	end
	
	