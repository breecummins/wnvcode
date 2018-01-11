%SSfindmatches_script.m

clear 
close all

load ~/WNVSixthRuns/AllRules_fixedvariables.mat

basers = 10;
baseps = 1;
comprs = 1:9;
wlo = [0.1:0.2:0.9];
wstd = [0.1,0.25,0.5];
van = 1;
rmos = 1;
graph=0;
stdflag=1;
savefile=0;
fname='~/WNVSixthRuns/bestmatches_rule10_pset001_vanished_rmos_ksstat.mat';

[ksmean_self,ks025percent_self,ks975percent_self]=SSPairwiseRunCompsKSstatSelfOnly(basers,baseps,van,rmos,savefile,graph,stdflag); %will have to move this into the for loop when there are multiple baseps's
ksmean_self=ksmean_self{1}; %change from cell to vector
ks025percent_self=ks025percent_self{1};
ks975percent_self=ks975percent_self{1};

matches=[];

c=0;
for cr = comprs;
	c=c+1;
	b=0;
	for bp = baseps;
		b=b+1;
		pb = SSparamsets(basers,bp);
		disp(['RS ',int2str(basers),', PS ',int2str(bp),' ([', num2str(pb(1)),', ',num2str(pb(2)),', ',num2str(pb(3)),']), vs RS ',int2str(cr)])

		bestmatches = SSfindmatches_targeted(basers, bp, cr, ksmean_self, van, rmos, wlo, wstd,graph);
		bestmatches = unique(bestmatches);
		ksmean = SSPairwiseRunCompsKSstat(basers,bp,cr*ones(size(bestmatches)),bestmatches,van,rmos,savefile,graph,ksmean_self,ks025percent_self,ks975percent_self);
		
		sumks=[];
		for k=1:length(ksmean);
			m = min(length(ksmean{k}),length(ksmean_self));
			sumks(k) = sum(abs(ksmean{k}(1:m)-ksmean_self(1:m)))/m;  %divide by m to avoid picking shortest vectors.
		end

		disp('match vector = '), disp(bestmatches)
		ind = find(sumks == min(sumks),1);
		disp('bestmatch = '), disp(bestmatches(ind))
		% pv = SSparamsets(cr,bestmatch(ind));
		matches(c,b) = bestmatches(ind);
		% 
		% figure(b)
		% SSPairwiseRunCompsKSstat_Viz(fn);
		% title(['RS ',int2str(basers),', PS ',int2str(bp),' ([', num2str(pb(1)),', ',num2str(pb(2)),', ',int2str(round(12*pb(3)/pi)),'\pi/12]), vs RS ',int2str(cr),', PS ', int2str(bestmatch(ind)),' ([', num2str(pv(1)),', ',num2str(pv(2)),', ',int2str(round(12*pv(3)/pi)),'\pi/12])'])
		% pause(0.1)
	end
end
		
save(fname,'matches', 'basers', 'baseps', 'comprs', 'van', 'rmos');	
			
			
			
			
			
			