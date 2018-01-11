function SSScalarViz(runthis,graphthis,recordthis,rulesets,fudgefactor)

%	runthis=1 means push all scalar statistics into one file 
%	graphthis=1 means show the graphs for the methods in the vector rulesets (a subset of 1:9)
%	recordthis=1 means record the frames as they are graphed
%   choose =0 to avoid any of the above actions
%   rulesets is a vector containing the rule sets to graph
%   fudgefactor is a scalar or vector that transforms rulesets into the appropriate indices (for example, if not all the rule sets were calculated in a file, then the rule set number and index location of the results will not match). Default is 0 (rulesets are also indices).

basedir = '~/WNVThirdRuns/ScalarMeasures/'; %alter with code changes
newfname='MemoryAverages.mat';		%alter with code changes
fvfname='~/WNVThirdRuns/MemoryRules_fixedvariables'; %alter with code changes
numruns=25;
if nargin < 5 || isempty(fudgefactor);
	fudgefactor=0;
end

if runthis ==1;
	%alter with code changes
	! ls ~/WNVThirdRuns/ScalarMeasures/average_paramset*.mat | wc -l > numfiles 
	load numfiles
	pmax = round(numfiles/numruns);
	load([basedir,'average_paramset01_run01'])
	sz = size(element.data);
	vals_by_method=zeros(sz(1),sz(2),numfiles);
	ind=1;
	for pset = 1:pmax;
		strp = sprintf('%02d',pset);
		for runs = 1:numruns;
			strr = sprintf('%02d',runs);
			avfname = ['average_paramset',strp,'_run',strr];
			load([basedir,avfname])
			d=element.data;
			vals_by_method(:,:,ind)=d;
			if mod(ind,100) == 0;
				disp([int2str(ind),' of ',int2str(numfiles)])
			end
			ind=ind+1;
			clear element
		end
	end

	save([basedir,newfname],'vals_by_method','numfiles','pmax','numruns','fudgefactor')
end


if graphthis == 1;
	
	set(0,'DefaultAxesFontSize',16)
	load(fvfname)

	if runthis==0;
		load([basedir,newfname])
	end

	dirnum='';
	for k = rulesets;
		dirnum = [dirnum,int2str(k)];
	end
	
	colors = [0,0,0; 1,0,0; 0,1,0; 0,0,1; 0.5,0.5,0.5; 1,1,0; 0,1,1; 1,0,1];
	frame=1;
	
	for t = 1:size(vals_by_method,2);
		for meth = rulesets-fudgefactor;
			data = squeeze(vals_by_method(meth,t,:));
			hist(data,50)	
			hold on
		end
		h = findobj(gca,'Type','patch');
		q=1;
		leg={};
		for c = rulesets;
			set(h(q),'FaceColor','None','EdgeColor',colors(q,:))
			leg{end+1} = int2str(c);
			q=q+1;
		end
		legend(leg,'Orientation','horizontal','Location','NorthOutside')
		title(['average distance, time = ',num2str(fixedvars.tSpace(t))])
		axis([0,1,0,numfiles*300/2000])
		hold off
		if recordthis == 1;
			f=sprintf('%03d',frame);
			fname = [basedir,'/movies',dirnum,'/frame',f,'.png'];
			saveas(gcf,fname,'png')
			frame=frame+1;
		else;
			pause(0.001)
		end
	end	
end
			
		