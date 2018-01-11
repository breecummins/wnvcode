function collateSimdata_density(basedir);
	
	savefname = fullfile(basedir,'alldata.mat');
	
	names = { 'Upwind','Downwind','Crosswind' };
	datamean = zeros(0,0,0);
	datastd = zeros(0,0,0);
	
	maxk = 8;
	
	for k = 1:maxk;
		for n = 1:3;
			alldata = [];
			if k >= 6;
				numiters = 30;
			elseif k >= 3;
				numiters = 20;
			else;
				numiters = 10;
			end
			for l = 1:numiters;
				fname = fullfile(basedir,[names{n},'_ft2perchick',int2str(k),'_iternum',int2str(l)]);
				[data,d,avgcwf,L,Nm,hr] = getSimResults_density(fname,1,40);
				alldata = [alldata; data];
			end
			md = mean(alldata);
			sd = std(alldata);
			datamean(k,:,n) = md;
			datastd(k,:,n) = sd;
		end
	end
	
	load(fname)
	avgcwfl = mean(p.crosswind_duration)*p.spdMax; 
	Nc = p.Nc;
	Ad = ((L*p.L0)*100/2.54/12)^2; %area of domain in ft^2

		
	README = ['The first dimension of datamean and datastd is the number of square feet per chicken. ' ...
'The second dimension contains the mean and std proportion of mosquitoes that found the group (1st element), ' ...
'the mean and std time to host (2nd element), and the plume length and width (3rd and 4th elements respectively).'...
'The third dimension of datamean and datastd denotes ranging behavior ' ...
'(upwind = 1, downwind = 2, crosswind = 3). L is the domain length, Nm is the number of mosquitoes released, ' ...
'd is the linear density of mosquitoes at release time, avgcwfl is the average crosswind flight length before changing ' ...
'direction, hr is the host radius, Nc is the number of hosts, and Ad is the area of the domain in ft^2. ' ...
'None of the last variables changes over the density simulations.']
	
	save(savefname,'README','datamean','datastd','L','Nm','d','avgcwfl','hr','Nc','Ad')
