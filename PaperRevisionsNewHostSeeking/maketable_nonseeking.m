%maketable_nonseeking.m

clear

% basedir = '~/WNVNewHostSeeking/NonSeeking/AdvectionPlusRandWalk';
% basedir = '~/WNVNewHostSeeking/NonSeeking/AdvectionPlusRandWalk_LowerSpeed';
% basedir = '~/WNVNewHostSeeking/NonSeeking/AdvectionOnly';
basedir = '~/WNVNewHostSeeking/NonSeeking/RandWalkOnly';
fnamestring = 'velprofile';
longestflight = 2000;

%consolidate data and calculate statistics (only needs to be done once for each flight length)
collateSimdata_squiggly(basedir,fnamestring,longestflight);

%make table
load(fullfile(basedir,'alldata.mat'))
wind = 'Downwind' ;

for l =1:2;
	if l == 1;
		str = 'straight';
	elseif l == 2;
		str = 'meander';
	end
	fprintf([wind,', ',str,' \n'])
	fprintf('%f %f %d %d %f \n', datamean(l,1,2),datastd(l,1,2),round(datamean(l,2,2)),round(datastd(l,2,2)),datastop(l,1,2))
end

