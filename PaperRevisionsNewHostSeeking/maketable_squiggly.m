%maketable_squiggly.m

clear

basedir = '~/WNVNewHostSeeking/CompareFlows';
% basedir = '~/WNVNewHostSeeking/NoStochasticity';
fnamestring = 'velprofile';
longestflight = 350;

%consolidate data and calculate statistics (only needs to be done once for each flight length)
collateSimdata_squiggly(basedir,fnamestring,longestflight);

%make table
load(fullfile(basedir,'alldata.mat'))
names = { 'Upwind','Downwind','Crosswind' };

for k = 1:3;
	for l =1:2;
		wind=names{k};
		if l == 1;
			str = 'straight';
		elseif l == 2;
			str = 'meander';
		end
		fprintf([wind,', ',str,' \n'])
		fprintf('%f %f %d %d %f \n', datamean(l,1,k),datastd(l,1,k),round(datamean(l,2,k)),round(datastd(l,2,k)),datastop(l,1,k))
	end
end

