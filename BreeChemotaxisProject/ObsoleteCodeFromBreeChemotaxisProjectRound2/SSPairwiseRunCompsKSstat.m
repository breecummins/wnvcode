function [ksmean,fname]=SSPairwiseRunCompsKSstat(basers,baseps,comprs,compps,van,rmos,savefile,viz,ksmean_self,ks025percent_self,ks975percent_self,perturb)

% basers, baseps is the rule/parameter set pair to which I am comparing each of comprs(k), compps(k)
% van == 1 means use altered data where the mosquitoes are removed within a certain radius of the source. Otherwise use unaltered data.
%%van == 1 and rmos == 0 means the vanished mosqitoes are given a distance of 0. van == 1 and rmos == 1 means the mosquitoes are removed from the data set when they reach the source
%savefile==1 means save the results to a file (file name returned in fname).
%viz == 1 means plot results. Default is no plot.
%if viz == 1, ksmean_self and the 95% C.I. endpoints must be specified -- this is the empirical KS distribution for basers, baseps.
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
tot=length(compps)+1;
ctr = 0;
allpsets = [baseps,compps];
allrsets = [basers,comprs];
tic
for k = 1:length(allrsets);
	strm = sprintf('%02d',allrsets(k));
	strp = sprintf('%03d',allpsets(k));
	fname = [basefname,strm,'_paramset',strp,'.mat'];
	load(fname);
	if exist('van','var') && van == 1;
		eval(['ed_rs',strm,'_pset',strp,'= edvanished;'])
	else;
		eval(['ed_rs',strm,'_pset',strp,'= eucdist;'])
	end
	ctr=ctr+1;
	if mod(ctr,10)==0;
		disp([int2str(ctr),' of ',int2str(tot), ' files.'])
	end
end
disp('Finished loading.')
toc		

tot = tr^2*length(comprs)*length(tS);
strbm = sprintf('%02d',basers);
strbp = sprintf('%03d',baseps);
edbase = eval(['ed_rs',strbm,'_pset',strbp]);
ksstat=zeros(tr^2,length(tS),length(comprs)); 
c=0;
tic
for p = 1:length(compps);
	strm = sprintf('%02d',comprs(p));
	strp = sprintf('%03d',compps(p));
	ed = eval(['ed_rs',strm,'_pset',strp]);
	for t = 1:length(tS);
		d=0;
		for k = 1:tr;
			rb = edbase((k-1)*Nm+1:k*Nm,t);
			for k1 = 1:tr;
				d= d+1;          
				r = ed((k1-1)*Nm+1:k1*Nm,t);
				%KS test
				if exist('van','var') && van == 1 && exist('rmos','var') && rmos == 1;
					ib = find(rb > 0);
					ic = find(r > 0);
					if length(ib)>=10 && length(ic) >=10;
						[j1,j2,ksstat(d,t,p)] = kstest2(rb(ib),r(ic));
					else;
						kstat(d,t,p) = 0;
					end
				else;
					[j1,j2,ksstat(d,t,p)] = kstest2(rb,r);
				end

				c=c+1;
				if mod( c,round(tot/100) ) == 0;
					disp([int2str(c), ' of ', int2str(tot)]);
				end
			end
		end
	end
end
toc

ksmean={};
for k = 1:length(comprs);
	[ind,jnd] = find(ksstat(:,:,k)==0);
	if ~isempty(ind);
		knd = min(jnd)-1;
	else;
		knd = length(ksstat(1,:,k));
	end
	ksmean{k} = mean(ksstat(:,1:knd,k),1);
end

if exist('savefile','var') && savefile == 1;
	if exist('perturb','var') && perturb ==1;
		newfnamestart = fullfile(basedir,'KSstatPerturb_PairwiseRunComps');
	else;
		newfnamestart = fullfile(basedir,'KSstat_PairwiseRunComps');
	end
	
	newfnameend = 'vs';
	if length(comprs) <= 5;
		for k = 1:length(comprs);
			newfnameend = [newfnameend,'_RS',sprintf('%02d',comprs(k)),'PS',sprintf('%03d',compps(k))];
		end
	else;
		u = unique(comprs);
		newfnameend = [newfnameend,'_RS'];
		for rs = u;
			newfnameend = [newfnameend,sprintf('%02d',rs)];
		end
		newfnameend = [newfnameend,'_variousparams'];
	end

	if exist('van','var') && van == 1;
		newfnameend = [newfnameend,'_van'];
	end
	if exist('rmos','var') && rmos == 1;
		newfnameend = [newfnameend,'_rmos'];
	end
	fname = [newfnamestart,'_ruleset',strbm,'_paramset',strbp,'_',newfnameend,'.mat'];
	save(fname,'ksstat','ksmean','basers','baseps','comprs','compps');
end

if exist('viz','var') && viz ==1;
	SSPairwiseRunCompsKSstat_Viz(basers,baseps,comprs,compps,ksmean,ksmean_self,ks025percent_self,ks975percent_self);
end
