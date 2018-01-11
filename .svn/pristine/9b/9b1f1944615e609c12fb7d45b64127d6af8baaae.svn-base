%SSNewRuleStackFiles.m

clear

load ~/WNVNewRule/Rule02_fixedvariables.mat
criticalradius =  1.5*fixedvars.h; %=1.2L in new scaling

for ps = 1:6;
	disp(['Evaluating rule set 2, param set ', int2str(ps),'...'])
	fname = ['~/WNVNewRule/StackAllTimes_Rule02_newruleparam',sprintf('%03d',ps),'.mat'];
	eucdist = [];
	for k = 1:25;
		load(['~/WNVNewRule/Rule02_newruleparam',sprintf('%03d',ps),'_run',sprintf('%02d',k)])
		eucdist(end+1:end+fixedvars.Nm,:) = squeeze(EuclideanDist(:,1,:));
	end
	edvanished = eucdist;
	for m = 1:size(eucdist,1);
		ind = find(eucdist(m,:) <= criticalradius,1);
		edvanished(m,ind:end) = 0;
	end
	save(fname,'edvanished','eucdist','newruleparams','criticalradius')	
end
