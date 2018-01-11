function fname=SSRadialDistNormalBetweenRuleSets2Subset(basers,baseps,comprs,compps,van)

% basers, baseps is the rule/parameter set pair to which I am comparing each of comprs(k), compps(k)
% van == 1 means use altered data where the mosquitoes are removed within a certain radius of the source. Otherwise use unaltered data.

%%%%%%%%%%%%%%%%% change these when changing the data set to work with. Other data sets may necessitate other changes in the code. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
basedir='~/WNVSixthRuns/';
newfnamestart = fullfile(basedir,'Zval');
basefname = fullfile(basedir,'StackAllTimes_RuleSet');
load(fullfile(basedir,'AllRules_fixedvariables.mat')) %get fixed variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tr = fixedvars.totruns;
Nm = fixedvars.Nm;
tS = fixedvars.tSpace;

u=unique(comprs);
newfnameend = 'SubsetvsRS';
for num = u;
	newfnameend = [newfnameend,'_',sprintf('%02d',num)];
end
if exist('van','var') && van == 1;
	newfnameend = [newfnameend,'_van'];
end


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

tot = tr*length(comprs)*length(tS);
strbm = sprintf('%02d',basers);
strbp = sprintf('%03d',baseps);
edbase = eval(['ed_rs',strbm,'_pset',strbp]);
zval=zeros(tr,length(tS),length(comprs)); 
zval_self=zeros(tr,length(tS)); 
c=0;
tic
for p = 1:length(compps);
	strm = sprintf('%02d',comprs(p));
	strp = sprintf('%03d',compps(p));
	ed = eval(['ed_rs',strm,'_pset',strp]);
	for t = 1:length(tS);
		for k = 1:tr;
			rb = edbase((k-1)*Nm+1:k*Nm,t);
			r = ed((k-1)*Nm+1:k*Nm,t);
			[junk1,junk2,stats] = ranksum(rb,r);
			zval(k,t,p) = stats.zval;
			[junk1,junk2,stats] = ranksum(rb,rb);
			zval_self(k,t) = stats.zval;

			c=c+1;
			if mod( c,round(tot/100) ) == 0;
				disp([int2str(c), ' of ', int2str(tot)]);
			end
		end
	end
end
toc

fname = [newfnamestart,'_ruleset',strbm,'_paramset',strbp,'_',newfnameend,'.mat'];
save(fname,'zval','zval_self','basers','baseps','comprs','compps');

