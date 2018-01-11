function SpatialStatistics_Empirical(ruleparams,fixedvars,basefname)


for k = 1:fixedvars.totruns;
	disp(['Run ',int2str(k)])

	[SpatialDistX,SpatialDistY] = ExploreMosquitoBehavior(ruleparams,fixedvars);
	str = sprintf('%02d',k);
	fname = [basefname,'_run',str,'.mat'];

	radvec=zeros(fixedvars.Nm,size(SpatialDistX,2),size(SpatialDistX,3));
	tot = size(SpatialDistX,3)*size(SpatialDistX,2);
	for t = 1:size(SpatialDistX,3);
		for m = 1:size(SpatialDistX,2);
			EuclideanDist(:,m,t) = sqrt( (SpatialDistX(:,m,t) - fixedvars.sourcex).^2 +  (SpatialDistY(:,m,t) - fixedvars.sourcey).^2 );
		end
	end

	save(fname, 'SpatialDistX', 'SpatialDistY','EuclideanDist','ruleparams');
end	
	