%SSstackfilespeturb.m

clear 

load ~/WNVSixthRuns/Perturbation_fixedvariables.mat
criticalradius = 1.5*fixedvars.h;

for r = 1:3;
	eucdist = [];
	for k = 1:25;
		fname = ['~/WNVSixthRuns/Perturbation_paramset',sprintf('%03d',r),'_run',sprintf('%02d',k)];
		load(fname)
		eucdist(end+1:end+fixedvars.Nm,:) = squeeze(EuclideanDist(:,r,:));
	end
	
	edvanished = eucdist;
	for m = 1:size(eucdist,1);
		ind = find(eucdist(m,:) <= criticalradius,1);
		edvanished(m,ind:end) = 0;
	end
	
	if r == 1;
		strr = '01';
		strp = '013';
	elseif r == 2;
		strr = '02';
		strp = '027';
	elseif r ==3;
		strr = '06';
		strp = '012';
	end
		
	save(['~/WNVSixthRuns/StackAllTimesPerturb_RuleSet',strr,'_paramset',strp,'.mat'],'edvanished','eucdist','ruleparams','criticalradius');
	
end 

