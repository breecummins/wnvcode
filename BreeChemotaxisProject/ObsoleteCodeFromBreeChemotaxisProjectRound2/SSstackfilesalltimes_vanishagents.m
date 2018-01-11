%SSstackfilesalltimes_vanishagents.m

clear

load ~/WNVSixthRuns/AllRules_fixedvariables
criticalradius = 1.5*fixedvars.h;

for k = 1:10;
	for l = 1:132;
		% if (k == 1 && l == 3) || (k == 2 && l == 26)
			disp(['Evaluating rule set ', int2str(k), ', param set ', int2str(l),'...'])
			fname = ['~/WNVSixthRuns/StackAllTimes_RuleSet',sprintf('%02d',k),'_paramset',sprintf('%03d',l),'.mat'];
			load(fname);
			edvanished = eucdist;
			for m = 1:size(eucdist,1);
				ind = find(eucdist(m,:) <= criticalradius,1);
				edvanished(m,ind:end) = 0;
			end
			save(fname,'edvanished','eucdist','ruleparams','criticalradius')
		% end
	end
end
		