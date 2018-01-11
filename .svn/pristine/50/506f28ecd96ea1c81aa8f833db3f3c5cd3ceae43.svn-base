function Ustat=SSRadialDistNormal(basefname,baseparam,compparams,whichmethods,newfname)

load([basefname,'_fixedvariables.mat']); %get fixed variables
bp = sprintf('%02d',baseparam);

tot = (fixedvars.totruns*(fixedvars.totruns+1)/2)*length(compparams)*length(fixedvars.tSpace)*length(whichmethods);
c=0;
d=0;
Ustat=zeros(fixedvars.totruns*(fixedvars.totruns+1)/2,length(compparams),length(whichmethods),length(fixedvars.tSpace)); 
for k = 1:fixedvars.totruns;
	str = sprintf('%02d',k);
	fname = [basefname,'_paramset',bp,'_run',str,'.mat'];
	load(fname);
	ed1 = EuclideanDist;
	for k1 = k:fixedvars.totruns;
		str = sprintf('%02d',k1);
		d=d+1;
		for l = 1:length(compparams);
			cp = sprintf('%02d',l);
			fname = [basefname,'_paramset',cp,'_run',str,'.mat'];
			load(fname);
			ed2 = EuclideanDist;
		
			for t = 1:length(fixedvars.tSpace);
				for m = 1:length(whichmethods);
					r1 = ed1(:,m,t);
					r2 = ed2(:,m,t);

					%Wilcoxon rank-sum test
					Ustat(d,l,m,t) = WilcoxonRankSum(r1,r2);
				
					c=c+1;
					if mod( c,round(tot/100) ) == 0;
						disp([int2str(c), ' of ', int2str(tot)]);
					end
				end
			end
		end
	end
end

fname = [newfname,'.mat'];
save(fname,'Ustat','basefname','baseparam','compparams','whichmethods') 

