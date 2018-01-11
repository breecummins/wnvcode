%SSMasterAnalysis.m

clear 
close all

basers = 1;
baseps=3;
compps = [];
for k = 0:11:121;
	compps = [compps, (2:6)+k];
end
compps = 26;
comprs = 2*ones(size(compps));

fname=SSRadialDistNormalBetweenRuleSets2Subset(basers,baseps,comprs,compps,1);
subsetind = 1:length(comprs);
SSRadialDistNormalBetweenRuleSets2_Viz(fname,subsetind);




