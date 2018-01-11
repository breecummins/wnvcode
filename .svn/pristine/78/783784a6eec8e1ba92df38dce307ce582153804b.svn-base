%SSRadialDist.m

clear

fname = ['~/rsyncfolder/data/WNV/MosqResultsForEmpiricalStatsGradvConcNewGradParams_0200_run0001.mat'];
load(fname);

tot = totruns^2*size(SpatialDistX,3)*size(SpatialDistX,2)^2;
c=0;
d=0;
Ustat=zeros(totruns^2,size(SpatialDistX,2),size(SpatialDistX,2),size(SpatialDistX,3)); 
KSdist=zeros(totruns^2,size(SpatialDistX,2),size(SpatialDistX,2),size(SpatialDistX,3)); 
for k = 1:totruns;
	str = sprintf('%04d',k);
	fname = ['~/rsyncfolder/data/WNV/MosqResultsForEmpiricalStatsGradvConcNewGradParams_0200_run',str,'.mat'];
	load(fname);
	rvk1 = radvec;
	
	for k1 = 1:totruns;
		str = sprintf('%04d',k1);
		fname = ['~/rsyncfolder/data/WNV/MosqResultsForEmpiricalStatsGradvConcNewGradParams_0200_run',str,'.mat'];
		load(fname);
		rvk2 = radvec;
		d=d+1;
		
		for t = 1:size(SpatialDistX,3);
			for m = 1:size(SpatialDistX,2);
				r1 = rvk1(:,m,t);
				for m1 = 1:size(SpatialDistX,2);
					r2 = rvk2(:,m1,t);

					%Wilcoxon rank-sum test
					Ustat(d,m,m1,t) = WilcoxonRankSum(r1,r2);
					
					%KS distance
					%KSdist(d,m,m1,t) = KS1D(r1,r2); %FIXME -- not getting a good stat
				
					c=c+1;
					if mod( c,round(tot/500) ) == 0;
						disp([int2str(c), ' of ', int2str(tot)]);
					end
				end
			end
		end
	end
end

save '~/rsyncfolder/data/WNV/StatsGradvConcNewGradParams.mat' Ustat 

