function fname=SSRadialDistNormalBetweenRuleSets2(basers,baseps,comprs,compps,van,rmos,viz)

% basers, baseps is the rule/parameter set pair to which I am comparing each of comprs(k), compps(k)
% van == 1 means use altered data where the mosquitoes are removed within a certain radius of the source. Otherwise use unaltered data.
%%van == 1 and rmos == 0 means the vanished mosqitoes are given a distance of 0. van == 1 and rmos == 1 means the mosquitoes are removed from the data set when they reach the source
%viz == 1 means call SSRadialDistNormalBetweenRuleSets2_Viz to plot results. Default is no plot.

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
newfnameend = 'vs_RS';
for num = u;
	newfnameend = [newfnameend,sprintf('%02d',num)];
end
if exist('van','var') && van == 1;
	newfnameend = [newfnameend,'_van'];
end
if exist('rmos','var') && rmos == 1;
	newfnameend = [newfnameend,'_rmos'];
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

tot = tr^2*length(comprs)*length(tS);
strbm = sprintf('%02d',basers);
strbp = sprintf('%03d',baseps);
edbase = eval(['ed_rs',strbm,'_pset',strbp]);
if exist('van','var') && van == 1 && exist('rmos','var') && rmos == 1;
	pval=zeros(tr^2,length(tS),length(comprs)); 
	pval_self=zeros(tr*(tr+1)/2,length(tS)); 
else;
	zval=zeros(tr^2,length(tS),length(comprs)); 
	zval_self=zeros(tr*(tr+1)/2,length(tS)); 
	pval=zeros(tr^2,length(tS),length(comprs)); 
	pval_self=zeros(tr*(tr+1)/2,length(tS)); 
end
c=0;
tic
for p = 1:length(compps);
	strm = sprintf('%02d',comprs(p));
	strp = sprintf('%03d',compps(p));
	ed = eval(['ed_rs',strm,'_pset',strp]);
	for t = 1:length(tS);
		d=0;
		f=0;
		for k = 1:tr;
			rb = edbase((k-1)*Nm+1:k*Nm,t);
			for k1 = 1:tr;
				d= d+1;          
				r = ed((k1-1)*Nm+1:k1*Nm,t);
				%Wilcoxon rank-sum test
				if exist('van','var') && van == 1 && exist('rmos','var') && rmos == 1;
					ib = find(rb > 0);
					ic = find(r > 0);
					if ~isempty(rb(ib)) || ~isempty(r(ic));
						pval(d,t,p) = ranksum(rb(ib),r(ic));
					else;
						pval(d,t,p) = 0;
					end
				else;
					[pval(d,t,p),junk2,stats] = ranksum(rb,r);
					zval(d,t,p) = stats.zval;
				end
					
				if k1 >=k;
					f=f+1;
					rb2 = edbase((k1-1)*Nm+1:k1*Nm,t);
					if exist('van','var') && van == 1 && exist('rmos','var') && rmos == 1;
						ib2 = find(rb2 > 0);
						if ~isempty(rb(ib)) || ~isempty(rb2(ib2));
							pval_self(f,t) = ranksum(rb(ib),rb2(ib2));
						else;
							pval_self(d,t,p) = 0;
						end
					else;
						[pval_self(f,t),junk2,stats] = ranksum(rb,rb2);
						zval_self(f,t) = stats.zval;
					end
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

fname = [newfnamestart,'_ruleset',strbm,'_paramset',strbp,'_',newfnameend,'.mat'];

if exist('van','var') && van == 1 && exist('rmos','var') && rmos == 1;
	save(fname,'pval','pval_self','basers','baseps','comprs','compps');
else;
	save(fname,'pval','pval_self','zval','zval_self','basers','baseps','comprs','compps');
end 

if exist('viz','var') && viz ==1;
	z=SSRadialDistNormalBetweenRuleSets2_Viz(fname);
end
