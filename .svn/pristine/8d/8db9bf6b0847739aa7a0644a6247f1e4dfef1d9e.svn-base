function [ksmean_self,ks025percent_self,ks975percent_self,fname]=SSPairwiseRunCompsKSstatSelfOnly(basers,baseps,van,rmos,savefile,viz,stdflag,perturb)

% basers, baseps are the rule/parameter sets for which I am calculating empirical distributions of KS stats. These do *not* compare to each other; only within (basers(k),baseps(k)) comparisons.
% van == 1 means use altered data where the mosquitoes are removed within a certain radius of the source. Otherwise use unaltered data.
%%van == 1 and rmos == 0 means the vanished mosqitoes are given a distance of 0. van == 1 and rmos == 1 means the mosquitoes are removed from the data set when they reach the source
%viz == 1 means plot results. Default is no plot.
%savefile == 1 means save the results as a file. Default is don't.
%perturb == 1 means do the perturbed analysis. Default is don't.

%%%%%%%%%%%%%%%%% change these when changing the data set to work with. Other data sets may necessitate other changes in the code. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
basedir='~/WNVSixthRuns/';
if exist('perturb','var') && perturb ==1;
	basefname = fullfile(basedir,'StackAllTimesPerturb_RuleSet'); 
else;
	basefname = fullfile(basedir,'StackAllTimes_RuleSet'); %note that StackAllTimes has the corrected rule set 5.
end
load(fullfile(basedir,'AllRules_fixedvariables.mat')) %get fixed variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tr = fixedvars.totruns;
Nm = fixedvars.Nm;
tS = fixedvars.tSpace;

disp('Loading files....')
tic
for k = 1:length(basers);
	strm = sprintf('%02d',basers(k));
	strp = sprintf('%03d',baseps(k));
	fname = [basefname,strm,'_paramset',strp,'.mat'];
	load(fname);
	if exist('van','var') && van == 1;
		eval(['ed_rs',strm,'_pset',strp,'= edvanished;'])
	else;
		eval(['ed_rs',strm,'_pset',strp,'= eucdist;'])
	end
end
disp('Finished loading.')
toc		

tot = tr*(tr-1)/2*length(tS)*length(baseps);
ksstat_self=zeros(tr*(tr-1)/2,length(tS),length(baseps)); 
c=0;
tic
for p = 1:length(baseps);
	strm = sprintf('%02d',basers(p));
	strp = sprintf('%03d',baseps(p));
	edbase = eval(['ed_rs',strm,'_pset',strp]);
	for t = 1:length(tS);
		d=0;
		for k = 1:tr;
			rb = edbase((k-1)*Nm+1:k*Nm,t);
			for k1 = k+1:tr;
				d=d+1;
				rb2 = edbase((k1-1)*Nm+1:k1*Nm,t);
				if exist('van','var') && van == 1 && exist('rmos','var') && rmos == 1;
					ib = find(rb >0);
					ib2 = find(rb2 > 0);
					if length(ib)>10 && length(ib2) >10;
						[j1,j2,ksstat_self(d,t,p)]  = kstest2(rb(ib),rb2(ib2));
					else;
						ksstat_self(d,t,p) = 0;
					end
				else;
					[j1,j2,ksstat_self(d,t,p)] = kstest2(rb,rb2);
				end

				c=c+1;
				if mod( c,round(tot/10) ) == 0;
					disp([int2str(c), ' of ', int2str(tot)]);
				end
			end
		end
	end
end
toc

ksmean_self={};
ks025percent_self={};
ks975percent_self={};
for p = 1:length(baseps);
	[ind,jnd] = find(ksstat_self(:,:,p)==0);
	if ~isempty(ind);
		knd = min(jnd)-1;
	else;
		knd = length(ksstat_self(1,:,p));
	end
	ksmean_self{p} = mean(ksstat_self(:,1:knd,p),1);
	for t = 1:knd;
		svec = sort(ksstat_self(:,t,p));
		ks025percent_self{p}(t) = svec(7);
		ks975percent_self{p}(t) = svec(293);
	end
end

if exist('savefile','var') && savefile == 1;
	if exist('perturb','var') && perturb ==1;
		newfnamestart = fullfile(basedir,'KSstatPerturb_PairwiseRunComps_SelfOnly');
	else;
		newfnamestart = fullfile(basedir,'KSstat_PairwiseRunComps_SelfOnly');
	end
	newfnameend = '';
	for k = 1:length(basers);
		newfnameend = [newfnameend,'_RS',sprintf('%02d',basers(k)),'PS',sprintf('%03d',baseps(k))];
	end
	fname = [newfnamestart,newfnameend,'.mat'];
	save(fname,'ksstat_self','ksmean_self','ks025percent_self','ks975percent_self','basers','baseps');
end

if exist('viz','var') && viz ==1;
	SSPairwiseRunCompsKSstatSelfOnly_Viz(basers,baseps,ksmean_self,ks025percent_self,ks975percent_self,stdflag);
end
