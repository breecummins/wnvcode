function collateSimdata_squiggly(basedir,fnamestring,longestflight)
	
	savefname = fullfile(basedir,'alldata.mat');
	names = { 'Upwind','Downwind','Crosswind' };
	
	datamean=zeros(0,0,0);
	datastd=zeros(0,0,0);
	datastop=zeros(0,0,0);
	datastopstd=zeros(0,0,0);
	
	for k = [2,3];
		for n = 1:3;
			fname = fullfile(basedir,[names{n},'_',fnamestring,int2str(k)]);
			data = getSimResults_density(fname,0);
			md = mean(data,1);
			sd = std(data,[],1);
			datamean(k-1,:,n) = md;
			datastd(k-1,:,n) = sd;
			data = getSimResults_stop(fname,longestflight);
			md = mean(data,1);
			sd = std(data,[],1);
			datastop(k-1,:,n) = md;
			datastopstd(k-1,:,n) = sd;
		end
	end
	
		README = ['The first dimension of datamean and datastd denotes the velocity profile used (1=straight, 2=squigglyR2). ' ...
	'The second dimension contains the mean and std proportion of mosquitoes that found the group (1st element) ' ...
	'and the mean and std time to host (2nd element). The third dimension of datamean and datastd denotes ranging behavior ' ...
	'(upwind = 1, downwind = 2, crosswind = 3). datastop and datastopstd are the same except that all mosquito trajectories ' ...
	'longer than longestflight steps are removed from the statistics (limited flight time).'];

		save(savefname,'README','datamean','datastd','datastop','datastopstd','longestflight')
				

