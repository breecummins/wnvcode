function eucdist=SSstackfilesalltimes(rs,ps,savefile,basedir);

%This function pools all the runs together for rule set 'rs' and param set 'ps'. savefile = 1 means save the results.

load(fullfile(basedir,'AllRules_fixedvariables.mat'))

eucdist = [];
for k = 1:25;
	if rs == 5;
		load(fullfile(basedir,['Rule5onlyMaxScaling_paramset',sprintf('%03d',ps),'_run',sprintf('%02d',k)]))
		eucdist(end+1:end+fixedvars.Nm,:) = squeeze(EuclideanDist(:,1,:));
	else;
		load(fullfile(basedir,['AllRules_paramset',sprintf('%03d',ps),'_run',sprintf('%02d',k)]))
		eucdist(end+1:end+fixedvars.Nm,:) = squeeze(EuclideanDist(:,rs,:));
	end
end

if nargin > 2 && savefile == 1;
	save(fullfile(basedir,['StackAllTimes_RuleSet',sprintf('%02d',rs),'_paramset',sprintf('%03d',ps),'.mat']),'eucdist','ruleparams');
end