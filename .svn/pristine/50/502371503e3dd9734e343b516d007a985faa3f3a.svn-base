%SSPairwiseKSPerturb.m

	clear
	close all
	
	basers = 2; baseps = 27; 
	van = 1; rmos = 1; savefile = 1; perturb =1; viz2 = 1;
	viz = 0; stdflag = 0;
	comprs = [1,6]; compps = [13,12];
	
	[ksmean_self,ks025percent_self,ks975percent_self,fname]=SSPairwiseRunCompsKSstatSelfOnly(basers,baseps,van,rmos,savefile,viz,stdflag,perturb);
	ksmean = SSPairwiseRunCompsKSstat(basers,baseps,comprs,compps,van,rmos,savefile,viz2,ksmean_self{1},ks025percent_self{1},ks975percent_self{1},perturb);
	
	basers = 1; baseps = 13; 
	van = 1; rmos = 1; savefile = 1; perturb =1; viz2 = 1;
	viz = 0; stdflag = 0;
	comprs = 2; compps = 27;
	
	[ksmean_self,ks025percent_self,ks975percent_self,fname]=SSPairwiseRunCompsKSstatSelfOnly(basers,baseps,van,rmos,savefile,viz,stdflag,perturb);
	ksmean = SSPairwiseRunCompsKSstat(basers,baseps,comprs,compps,van,rmos,savefile,viz2,ksmean_self{1},ks025percent_self{1},ks975percent_self{1},perturb);
				
	basers = 6; baseps = 12; 
	van = 1; rmos = 1; savefile = 1; perturb =1; viz2 = 1;
	viz = 0; stdflag = 0;
	comprs = 2; compps = 27;
	
	[ksmean_self,ks025percent_self,ks975percent_self,fname]=SSPairwiseRunCompsKSstatSelfOnly(basers,baseps,van,rmos,savefile,viz,stdflag,perturb);
	ksmean = SSPairwiseRunCompsKSstat(basers,baseps,comprs,compps,van,rmos,savefile,viz2,ksmean_self{1},ks025percent_self{1},ks975percent_self{1},perturb);
				
	
