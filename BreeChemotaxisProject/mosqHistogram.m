function mosqHistogram(fnamelist,h,s,c,runnum,tspan);
	
	%fnamelist is a cell array of string file names (a single string for one file name is supported).
	%if h =1 (default), make histogram movies; set to 0 otherwise
	%if s = 1 (default), plot number of mosquitoes at source; set to 0 otherwise
	%if c = 1 (default), plot the cdf
	%runnum is an optional argument containing the single simulation to graph. Will be applied to all graphs. The default is to use *all* runs.
	%tspan is an optional vector argument containing times at which to plot histograms and cdfs (but does not affect 's' plot). default is all recorded times. 
	
	close all
	
	try;
		load(fnamelist);
		d1 = R;
		lenlist = 1;
		ind = find(fnamelist == '/',1,'last');
		leg=fnamelist(ind+1:ind+6);
	catch;
		leg={};
		for k = 1:length(fnamelist);
			load(fnamelist{k});
			eval(['d',int2str(k),' = R;']);
			ind = find(fnamelist{k} == '/',1,'last');
			leg{end+1} = fnamelist{k}(ind+1:ind+6);
		end
		lenlist = k;
	end
	
	if ~exist('critrad','var');
		critrad = 0;
		disp('Mosquitoes are not being set to zero at source.')
	end
	
	if exist('runnum','var');
		rind = (r.Nm*(runnum-1)+1):(r.Nm*runnum);
	else;
		rind = 1:size(R,1);
	end
	
	if exist('tspan','var') && ~isempty('tspan');
		tvec =[];
		for ts = tspan;
			ind = find(abs(Trec-ts) == min(abs(Trec-ts)));
			tvec(end+1) = ind;
		end
	else;
		tvec = 1:length(Trec);
	end
		
	clrs = [0,0,0; 0,0,1; 1,0,0; 0,0.7,0; 0,0.7,1; 1,0.6,0];
	set(0,'DefaultAxesFontSize',24)
	
	if ~exist('h','var') || h == 1;
		figure
		hold on
		ctr = 0;
		for t = tvec;
			if length(tvec)<7;
				ctr=ctr+1;
				if ~exist('c','var') || c == 1;
					hobj=subplot(2,length(tvec),ctr);
					p = get(hobj,'pos');
					p(2)=p(2)-0.05;
					set(hobj,'pos',p)
				else;
					subplot(1,length(tvec),ctr)
				end
			end
			for k = 1:lenlist;
				hist(eval(['d',int2str(k),'(rind,t)']),25);
				axis([0,10,0,100])
				hold on
			end
			hobj = findobj(gca,'Type','patch');
			for k = 1:lenlist;
				if lenlist > 1;
					set(hobj(k),'FaceColor','None','EdgeColor',clrs(lenlist-k+1,:))
				else;
					set(hobj(k),'FaceColor',clrs(lenlist-k+1,:),'EdgeColor',clrs(lenlist-k+1,:))
				end
			end
			if (ctr == ceil(length(tvec)/2) && c ==0) || length(tvec) >= 7;	
				xlabel('Distance')
			end
			if ctr == 1 || length(tvec) > 7;
				ylabel('# mosquitoes')
			end
			if lenlist >1;
				legend(leg)
			end
			if ~exist('c','var') || c == 1;
				set(gca,'XTickLabel',[])
				grid on
				set(gcf, 'PaperSize', [8 6]);
				set(gcf, 'PaperPosition', [0,0,8,6]);
			end
			if ctr>1;
				set(gca,'YTickLabel',[])
			end
			title(['t = ',num2str(Trec(t))])
			pause(1.0)
			hold off
		end
	end
	
	if ~exist('c','var') || c == 1;
		r=critrad:critrad:10;
		ctr=0;
		for t = tvec;
			if length(tvec)<7;
				ctr=ctr+1;
				if ~exist('h','var') || h == 1;
					hobj=subplot(2,length(tvec),length(tvec)+ctr);
					p = get(hobj,'pos');
					p(2)=p(2)+0.05;
					set(hobj,'pos',p)
				else;
					subplot(1,length(tvec),ctr)
				end
			end
			for k = 1:lenlist;
				d = eval(['d',int2str(k),';']);
				cdfunc = [];
				for d2s = r;
					cdfunc(end+1)=sum(d(rind,t)<d2s);
				end
				plot(r,cdfunc/length(rind),'Color',clrs(k,:),'LineWidth',2)
			end
			if lenlist >1;
				legend(leg,'Orientation','Horizontal','Location','NorthOutside')
			end
			axis([0,r(end),0,1.1])
			if ctr == ceil(length(tvec)/2) || length(tvec) > 7;	
				xlabel('Distance')
			end
			if ctr == 1 || length(tvec) > 7;
				ylabel('CDF')
			end
			if ctr>1;
				set(gca,'YTickLabel',[])
			end
			if h == 0;
				title(['Time = ',num2str(Trec(t))])
			end
			box on
			grid on
		end
	end
	
	if ~exist('s','var') || s == 1;
		figure
		hold on
		for k = 1:lenlist;
			d = eval(['d',int2str(k),';']);
			plot(Trec,sum(d(rind)==0,1),'Color',clrs(k,:),'LineWidth',2)
		end
		legend(leg,'Orientation','Horizontal','Location','NorthOutside')
		axis([0,Trec(end),0,length(rind)])	
		xlabel('Time')
		ylabel('# of mosquitoes at source')
		box on
		grid on
		set(gcf, 'PaperSize', [8 6]);
		set(gcf, 'PaperPosition', [0,0,8,6]);
	end
	
	