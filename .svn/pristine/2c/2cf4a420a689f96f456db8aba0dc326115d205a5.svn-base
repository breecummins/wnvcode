function [ksmean,fname]=SSNewRuleKSstats(baseps,compps,savefile,viz,ksmean_self,ks025percent_self,ks975percent_self)

% baseps is the parameter set to which I am comparing each of compps(k)
%savefile==1 means save the results to a file (file name returned in fname).
%viz == 1 means plot results. Default is no plot.
%if viz == 1, ksmean_self and the 95% C.I. endpoints must be specified -- this is the empirical KS distribution for basers, baseps.
%perturb == 1 means do the perturbed analysis. Default is don't.

%%%%%%%%%%%%%%%%% change these when changing the data set to work with. Other data sets may necessitate other changes in the code. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
basedir='~/WNVNewRule/';
basefname = fullfile(basedir,'StackAllTimes_Rule02_newruleparam'); 
load(fullfile(basedir,'Rule02_fixedvariables.mat')) %get fixed variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tr = fixedvars.totruns;
Nm = fixedvars.Nm;
tS = fixedvars.tSpace;

disp('Loading files....')
tot=length(compps)+1;
ctr = 0;
allpsets = [baseps,compps];
tic
for k = 1:length(allpsets);
	strp = sprintf('%03d',allpsets(k));
	fname = [basefname,strp,'.mat'];
	load(fname);
	eval(['ed_pset',strp,'= edvanished;'])
end
disp('Finished loading.')
toc		

tot = tr^2*length(compps)*length(tS);
strbp = sprintf('%03d',baseps);
edbase = eval(['ed_pset',strbp]);
ksstat=zeros(tr^2,length(tS),length(compps)); 
c=0;
tic
for p = 1:length(compps);
	strp = sprintf('%03d',compps(p));
	ed = eval(['ed_pset',strp]);
	for t = 1:length(tS);
		d=0;
		for k = 1:tr;
			rb = edbase((k-1)*Nm+1:k*Nm,t);
			for k1 = 1:tr;
				d= d+1;          
				r = ed((k1-1)*Nm+1:k1*Nm,t);
				%KS test
				ib = find(rb > 0);
				ic = find(r > 0);
				if length(ib)>=10 && length(ic) >=10;
					[j1,j2,ksstat(d,t,p)] = kstest2(rb(ib),r(ic));
				else;
					kstat(d,t,p) = 0;
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
for k = 1:length(compps);
	[ind,jnd] = find(ksstat(:,:,k)==0);
	if ~isempty(ind);
		knd = min(jnd)-1;
	else;
		knd = length(ksstat(1,:,k));
	end
	ksmean{k} = mean(ksstat(:,1:knd,k),1);
end

if exist('savefile','var') && savefile == 1;
	newfnamestart = fullfile(basedir,'KSstat_PairwiseRunComps_Rule2');
	
	newfnameend = 'vs';
	for k = 1:length(compps);
		newfnameend = [newfnameend,'_PS',sprintf('%03d',compps(k))];
	end
	fname = [newfnamestart,'_newparamset',strbp,'_',newfnameend,'.mat'];
	save(fname,'ksstat','ksmean','baseps','compps');
end

if exist('viz','var') && viz ==1;
	SSNewRuleKSstats_Viz(baseps,compps,ksmean,ksmean_self,ks025percent_self,ks975percent_self);
end
