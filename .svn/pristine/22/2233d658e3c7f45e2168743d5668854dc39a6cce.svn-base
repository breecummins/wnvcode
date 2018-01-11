function eucdist=stackfiles(rs,ps,timeind,basedir);

%This function pools all the runs together for rule set 'rs' and param set 'ps' at the time tSpace(timeind).

load(fullfile(basedir,'AllRules_fixedvariables.mat'))
realtime = fixedvars.tSpace(timeind); 
disp(['This stack is at time ', num2str(realtime),'.'])

eucdist = [];
for k = 1:25;
	load(fullfile(basedir,['AllRules_paramset',sprintf('%03d',ps),'_run',sprintf('%02d',k)]))
	eucdist(end+1:end+fixedvars.Nm) = EuclideanDist(:,rs,timeind);
end

save(fullfile(basedir,['Stack_RuleSet',sprintf('%02d',rs),'_paramset',sprintf('%03d',ps),'_timeindex',sprintf('%03d',timeind),'.mat']),'eucdist')