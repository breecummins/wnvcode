function giantoutputmatrix = SAviz(basedir,vnames,rangingbehaviors,outputnums,closefigs,extragraph);
	
	% Makes pictures of SA output. Examples of inputs:
	% basedir='~/WNVFullBatchRuns/WNVSensitivityAnalysis/';
	% vnames = { 'host_radius','Vmag' };
	% rangingbehaviors = [1,2,5];
	% outputnumbers = [1,2,3]; %All the outputs are 1:4; default. (1=total finding host, 2=group 1, 3=group 2, 4=avg time)
	
	if closefigs == 'y';
		close all
		actr = 0;
	else;
		hl = findobj('type','figure');
		if ~isempty(hl);
			actr = max(hl);
		else;
			actr = 0;
		end
	end
	
	outputnames = getSensitivityNames;
	if ~exist('outputnums','var') || isempty(outputnums);
		outputnums = 1:4;
	end

	giantoutputmatrix = SAdata(basedir,vnames,rangingbehaviors,outputnums);
	
	w=0;
	for windmode = rangingbehaviors;
		w=w+1;
		wname = WindName(windmode);
		for k = 1:length(vnames);
			varname = vnames{k};
			tctr = 0;
			for op = outputnums;
				tctr=tctr+1;
				figure(actr+tctr)
				hold on
				errorbar(k,giantoutputmatrix(w,k,op,1),0.5*giantoutputmatrix(w,k,op,2),'.','LineWidth',2,'MarkerSize',16)
				if extragraph == 'y';
					errorbar(k,giantoutputmatrix(w,k,op,1),0.75*giantoutputmatrix(w,k,op,2),'r.')
				end
			end
		end
		tctr=0;
		for op = outputnums;
			tctr=tctr+1;
			figure(actr+tctr)
			plot([0,length(vnames)+1],[0,0],'k-')
			title([wname,', ',outputnames{op}],'FontSize',16)
			%ylabel('SI','FontSize',16)
			set(gca,'FontSize',16)
			set(gcf,'PaperSize',[8,6])
			set(gcf,'PaperPosition',[0,0,8,6])
			set(gca,'XTick',1:length(vnames),'XTickLabel',vnames)
			
		end
		actr = actr + length(outputnums);
	end