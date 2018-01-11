function [Ustat,stddevsout] = SSUstatStacks_onetime(basers,baseps,comprs,compps,timeind)

%Compare rule set basers (using paper nomenclature) with param set baseps to each rule set/param set pair comprs(k), compps(k).
%timeind is an index into tSpace. The absolute time of the analysis is tSpace(timeind).

basedir = '~/WNVSixthRuns/';

try;
	disp(['Evaluating rule set ', int2str(basers), ', param set ', int2str(baseps),'...'])
	load(fullfile(basedir,['Stack_RuleSet',sprintf('%02d',basers),'_paramset',sprintf('%03d',baseps),'_timeindex',sprintf('%03d',timeind),'.mat']))
	basedist = eucdist;
catch;
	basedist=stackfiles(basers,baseps,timeind,basedir);
end

Ustat =[];
for k = 1:length(comprs);
	disp(['Evaluating rule set ', int2str(comprs(k)), ', param set ', int2str(compps(k)),'...'])
	try;	
		load(fullfile(basedir,['Stack_RuleSet',sprintf('%02d',comprs(k)),'_paramset',sprintf('%03d',compps(k)),'_timeindex',sprintf('%03d',timeind),'.mat']))
		compdist = eucdist;
	catch;
		compdist=stackfiles(comprs(k),compps(k),timeind,basedir);
	end	
	
	Ustat(k) = WilcoxonRankSum(basedist,compdist);
	
end

N = size(basedist,1);
[avg,stddev] = NormalApproxForRankSumTest(N,N);
val = abs(Ustat - avg);
stddevsout=val/stddev;

