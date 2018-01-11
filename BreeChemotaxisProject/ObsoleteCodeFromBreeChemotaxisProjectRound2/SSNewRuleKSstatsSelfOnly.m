%SSNewRuleKSstatsSelfOnly.m

%This script is hard-coded to do analysis only in the case where the mosquitoes are removed at the source. 

%%%%%%%%%%%%%%%%% change these when changing the data set to work with. Other data sets may necessitate other changes in the code. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
basedir='~/WNVNewRule/';
basefname = fullfile(basedir,'StackAllTimes_Rule02_newruleparam'); 
load(fullfile(basedir,'Rule02_fixedvariables.mat')) %get fixed variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tr = fixedvars.totruns;
Nm = fixedvars.Nm;
tS = fixedvars.tSpace;
baseps = 1:6;

disp('Loading files....')
tic
for k = baseps;
	strp = sprintf('%03d',k);
	fname = [basefname,strp,'.mat'];
	load(fname);
	eval(['ed_pset',strp,'= edvanished;'])
end
disp('Finished loading.')
toc	

tot = tr*(tr-1)/2*length(tS)*length(baseps);
ksstat_self=zeros(tr*(tr-1)/2,length(tS),length(baseps)); 
c=0;
tic
for p = 1:length(baseps);
	strp = sprintf('%03d',baseps(p));
	edbase = eval(['ed_pset',strp]);
	for t = 1:length(tS);
		d=0;
		for k = 1:tr;
			rb = edbase((k-1)*Nm+1:k*Nm,t);
			ib = find(rb >0);
			for k1 = k+1:tr;
				d=d+1;
				rb2 = edbase((k1-1)*Nm+1:k1*Nm,t);
				ib2 = find(rb2 > 0);
				if length(ib)>10 && length(ib2) >10;
					[j1,j2,ksstat_self(d,t,p)]  = kstest2(rb(ib),rb2(ib2));
				else;
					ksstat_self(d,t,p) = 0;
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

newfnamestart = fullfile(basedir,'KSstat_PairwiseRunComps_SelfOnly_Rule2');
newfnameend = '';
for k = 1:length(baseps);
	newfnameend = [newfnameend,'_PS',sprintf('%03d',baseps(k))];
end
fname = [newfnamestart,newfnameend,'.mat'];
save(fname,'ksstat_self','ksmean_self','ks025percent_self','ks975percent_self');
