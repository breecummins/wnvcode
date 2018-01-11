function [ksstats,lenstats] = KSempiricaldist(fname,remove);
	
	%Constructs empirical distribution of KS statistics from simulation data. ksstats(1,:) = mean, ksstats(2,:) = 2.5% percentile, kstats(3,:) = 97.5% percentile. Time varies along the columns. lenstats tells how many comparisons were made at each moment in time (if the mosquitoes are removed, this decreases).
	%If remove = 1, zeros representing mosquitoes that have reached the source are removed from the simulation.
	
load(fname);
ksstats = [];
lenstats = [];

if exist('remove','var') && remove ==1;
	for t = 1:size(R,2);
		c=0;
		KS = [];
		for k = 1:totruns;
			ind = (r.Nm*(k-1) + 1):(r.Nm*k);
			d1 = R(ind,t);
			d1 = d1(d1>0);
			for l = (k+1):totruns;
				jnd = (r.Nm*(l-1) + 1):(r.Nm*l);
				d2 = R(jnd,t);
				d2 = d2(d2>0);
				if length(d1) > 10 && length(d2) > 10;
					c = c+1;
					[H,P,KS(c)] = kstest2(d1,d2);
				end
			end
		end
		vec = sort(KS);
		lenstats(t) = length(vec);
		ksstats(1,t) = mean(vec);
		ksstats(2,t) = vec(7);
		ksstats(3,t) = vec(293);
	end
else;
	for t = 1:size(R,2);
		c=0;
		KS = [];
		for k = 1:totruns;
			ind = (r.Nm*(k-1) + 1):(r.Nm*k);
			d1 = R(ind,t);
			for l = (k+1):totruns;
				c = c+1;
				jnd = (r.Nm*(l-1) + 1):(r.Nm*l);
				d2 = R(jnd,t);
				[H,P,KS(c)] = kstest2(d1,d2);
			end
		end
		vec = sort(KS);
		lenstats(t) = length(vec);
		ksstats(1,t) = mean(vec);
		ksstats(2,t) = vec(7);
		ksstats(3,t) = vec(293);
	end
end
				