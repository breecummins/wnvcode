function [ksmean,lenstats] = KScompare(fname1,fname2,remove);
	
	%Calculates KS statistics between two datasets. ksmean is the mean of the KS stats over time. lenstats tells how many comparisons were made at each moment in time (if the mosquitoes are removed, this decreases).
	%If remove = 1, zeros representing mosquitoes that have reached the source are removed from the simulation.
	
load(fname1);
R1 = R;
load(fname2);
R2 = R;

ksmean = [];
lenstats = [];

if exist('remove','var') && remove ==1;
	for t = 1:length(Trec);
		c=0;
		KS = [];
		for k = 1:totruns;
			ind = (r.Nm*(k-1) + 1):(r.Nm*k);
			d1 = R1(ind,t);
			d1 = d1(d1>0);
			for l = 1:totruns;
				jnd = (r.Nm*(l-1) + 1):(r.Nm*l);
				d2 = R2(jnd,t);
				d2 = d2(d2>0);
				if length(d1) > 10 && length(d2) > 10;
					c = c+1;
					[H,P,KS(c)] = kstest2(d1,d2);
				end
			end
		end
		vec = sort(KS);
		lenstats(t) = length(vec);
		ksmean(t) = mean(vec);
	end
else;
	for t = 1:length(Trec);
		c=0;
		KS = [];
		for k = 1:totruns;
			ind = (r.Nm*(k-1) + 1):(r.Nm*k);
			d1 = R1(ind,t);
			for l = 1:totruns;
				jnd = (r.Nm*(l-1) + 1):(r.Nm*l);
				d2 = R2(jnd,t);
				c = c+1;
				[H,P,KS(c)] = kstest2(d1,d2);
			end
		end
		vec = sort(KS);
		lenstats(t) = length(vec);
		ksmean(t) = mean(vec);
	end
end
