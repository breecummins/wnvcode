function collateSimdata_2groups(basedir);
	
	savefname = fullfile(basedir,'alldata.mat');
	
	names = { 'Upwind','Downwind','Crosswind' };
	datamean = zeros(0,0);
	datastd = zeros(0,0);
	smallmean = zeros(0,0);
	largemean = zeros(0,0);
	total=zeros(0,0);
	
	maxk = 5;
	
	for k = 1:maxk;
		for n = 1:3;
			alldata = [];
			for l = 1:10;
				fname = fullfile(basedir,[names{n},'_numchicks',int2str(k),'_iternum',int2str(l)]);
				[data,d,avgcwf,L,Nm,hr] = getSimResults_2groups(fname,1,40);
				alldata = [alldata; data];
			end
			smallgroup = alldata(:,3);
			largegroup = alldata(:,2);
			ratios = smallgroup./largegroup;
			md = mean(ratios);
			sd = std(ratios);
			
			datamean(k,n) = md;
			datastd(k,n) = sd;
			smallmean(k,n) = mean(smallgroup);
			largemean(k,n) = mean(largegroup);
			total(k,n)= mean(largegroup+smallgroup);						
		end
	end
	
	Nc = [9,1; 8,2; 7,3; 6,4; 5,5]; %number of chickens in the group
		
	README = ['The first index of datamean and datastd is the number of chickens in the small group and ' ...
'the second index denotes ranging behavior (upwind = 1, downwind = 2, crosswind = 3). The contents are the ' ...
'mean and std of the ratio of proportions of mosquitoes that found the small group to the large group. ' ...
'smallmean and largemean contain the mean proportions of mosquitoes finding the small and large groups respectively.' ...
'total contains mean proportion of mosquitoes finding any group. Nc is the number of hosts per group.']
	
	save(savefname,'README','datamean','datastd','smallmean','largemean','total','Nc')
