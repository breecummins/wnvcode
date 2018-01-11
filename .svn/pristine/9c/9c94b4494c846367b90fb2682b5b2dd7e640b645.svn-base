function Ustat=SSRadialDistNormalBetweenRuleSets(basefname,basemethod,compmethods,newfname)

load([basefname,'_fixedvariables.mat']); %get fixed variables
numparams = 80;
pskip = 2;
tskip = 4;

disp('Loading files....')
tot=numparams/pskip*fixedvars.totruns;
ctr = 0;
tic
for p = 1:pskip:numparams;
	strp = sprintf('%02d',p);
	for k = 1:fixedvars.totruns;
		strk = sprintf('%02d',k);
		fname = [basefname,'_paramset',strp,'_run',strk,'.mat'];
		load(fname);
		eval(['ed_pset',strp,'_run',strk,'= EuclideanDist;'])
		ctr=ctr+1;
		if mod(ctr,100)==0;
			disp([int2str(ctr),' of ',int2str(tot), ' files.'])
		end
	end
end
disp('Finished loading.')
toc		

tot = fixedvars.totruns*(fixedvars.totruns+1)/2*numparams/pskip*length(compmethods)*length(fixedvars.tSpace)/tskip;
for p = 1:pskip:numparams;
	disp(['Parameter set ', int2str(p)])
	strp = sprintf('%02d',p);
	Ustat=zeros(fixedvars.totruns*(fixedvars.totruns+1)/2,numparams/pskip,length(compmethods),length(fixedvars.tSpace)/tskip); 
	c=0;
	d=0;
	tic
	for k = 1:fixedvars.totruns;
		strk = sprintf('%02d',k);
		ed1 = eval(['ed_pset',strp,'_run',strk]);
		for k1 = k:fixedvars.totruns;
			strk1 = sprintf('%02d',k1);
			d= d+1;          
			for p1 = 1:pskip:numparams;
				strp1 = sprintf('%02d',p1);
				ed2 = eval(['ed_pset',strp1,'_run',strk1]);
				for t = 1:tskip:length(fixedvars.tSpace);
					r1 = ed1(:,basemethod,t);
					for m = 1:length(compmethods);
						r2 = ed2(:,compmethods(m),t);

						%Wilcoxon rank-sum test
						Ustat(d,p1,m,t) = WilcoxonRankSum(r1,r2);
				
						c=c+1;
						if mod( c,round(tot/100) ) == 0;
							disp([int2str(c), ' of ', int2str(tot)]);
							toc
						end
					end
				end
			end
		end
	end
	fname = [newfname,'_paramset',strp,'.mat'];
	save(fname,'Ustat','basefname','basemethod','compmethods') 
end


