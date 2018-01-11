function z=SSRadialDistNormalBetweenRuleSets2_Viz(fname,subsetind);
	
	%plots the results (or a subset of the results through subsetind) of the z-score output of SSRadialDistNormalBetweenRuleSets2.m. If the information is saved, load the file.
	
	basedir='~/WNVSixthRuns/';
	
	try;
		load(fullfile(basedir,fname))
	catch;
		try;
			load(fname)
		catch;
			error('File name not found. Aborting.')
		end
	end

	if ~exist('subsetind','var') || isempty(subsetind);
		subsetind = 1:length(comprs);
	end
	
	load(fullfile(basedir,'AllRules_fixedvariables.mat')) %get fixed variables
	tS = fixedvars.tSpace;
		
	if exist('zval','var');	
		leg={};
		z=[];
		for k = subsetind;
			pv = SSparamsets(compps(k));
			leg{end+1}=['RS ', int2str(comprs(k)), ', PS [', num2str(pv(1)),', ',num2str(pv(2)),', ',int2str(round(12*pv(3)/pi)),'\pi/12]'];
			h = isnan(zval(:,:,k));
			if any(any(h));
				[ind,jnd] = find(h);
				zval(ind,jnd,k) = 0;
			end
			z(end+1,:) = mean(zval(:,:,k),1);
		end
	
		figure
		plot(tS,z)
		hold on 
		h = isnan(zval_self);
		if any(any(h));
			[ind,jnd] = find(h);
			zval_self(ind,jnd) = 0;
		end
		plot(tS,mean(zval_self,1),'b','LineWidth',2)
		plot(tS,2.575*ones(size(tS)),'k','LineWidth',2)
		plot(tS,1.96*ones(size(tS)),'r','LineWidth',2)
		plot(tS,-2.575*ones(size(tS)),'k','LineWidth',2)
		plot(tS,-1.96*ones(size(tS)),'r','LineWidth',2)
		hold off
		legend(leg)
		pv = SSparamsets(baseps);
		title(['Rule set ',int2str(basers),', Param set [', num2str(pv(1)),', ',num2str(pv(2)),', ',int2str(round(12*pv(3)/pi)),'\pi/12]'])
		xlabel('Time')
		ylabel('z-score')
	end
	% if exist('pval','var');
	% 	leg={};
	% 	z=[];
	% 	for k = subsetind;
	% 		pv = SSparamsets(compps(k));
	% 		leg{end+1}=['RS ', int2str(comprs(k)), ', PS [', num2str(pv(1)),', ',num2str(pv(2)),', ',int2str(round(12*pv(3)/pi)),'\pi/12]'];
	% 		z(end+1,:) = mean(pval(:,:,k),1);
	% 	end
	% 
	% 	figure
	% 	plot(tS,z)
	% 	hold on 
	% 	plot(tS,mean(pval_self,1),'b','LineWidth',2)
	% 	plot(tS,0.1*ones(size(tS)),'k','LineWidth',2)
	% 	plot(tS,0.02*ones(size(tS)),'r','LineWidth',2)
	% 	plot(tS,-0.1*ones(size(tS)),'k','LineWidth',2)
	% 	plot(tS,-0.02*ones(size(tS)),'r','LineWidth',2)
	% 	hold off
	% 	legend(leg)
	% 	pv = SSparamsets(baseps);
	% 	title(['Rule set ',int2str(basers),', Param set [', num2str(pv(1)),', ',num2str(pv(2)),', ',int2str(round(12*pv(3)/pi)),'\pi/12]'])
	% 	xlabel('Time')
	% 	ylabel('p-value')
	% end


	

