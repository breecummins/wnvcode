function [avgdist,stddist]=SSViewDist2Source(rsets,psets,van,rmos,graph1,graph2,stdflag)

% Find the average dist to the source for each rsets(k), psets(k) during all runs. If graph1 == 1, graph histograms; if graph2 == 1 graph averages. if stdflag == 1, graph the standard deviations.
%van == 1 means use the data where the distance of the agents to the source is set to zero after a critical radius
% van == 1 and rmos == 1 means throw out the zeros; i.e. remove the agents after reaching the critical radius

basedir = '~/WNVSixthRuns/';

load(fullfile(basedir,['AllRules_fixedvariables']))

avgdist=zeros(length(rsets),length(fixedvars.tSpace));
stddist=zeros(length(rsets),length(fixedvars.tSpace));
bigdist =zeros(0,0,0);

for k = 1:length(rsets)
	if mod(k,10) == 0;
		disp([int2str(k), ' of ', int2str(length(rsets)),' rule/parameter set pairs.'])
	end
	load(fullfile(basedir,['StackAllTimes_RuleSet',sprintf('%02d',rsets(k)),'_paramset',sprintf('%03d',psets(k))]))
	if exist('van','var') && van == 1 && exist('rmos','var') && rmos == 1;
		for t = 1:size(edvanished,2);
			ind = find(edvanished(:,t)>0);
			if length(ind) >= 10;
				avgdist(k,t) = mean(edvanished(ind,t));
				stddist(k,t) = std(edvanished(ind,t));
			end
		end
		if exist('graph1','var') && graph1 == 1;
			bigdist(:,:,k) = edvanished;
		end
	elseif exist('van','var') && van == 1;
		avgdist(k,:) = mean(edvanished,1);
		stddist(k,:) = std(edvanished,0,1);
		if exist('graph1','var') && graph1 == 1;
			bigdist(:,:,k) = edvanished;
		end
	else;
		avgdist(k,:) = mean(eucdist,1);
		stddist(k,:) = std(eucdist,0,1);
		if exist('graph1','var') && graph1 == 1;
			bigdist(:,:,k) = eucdist;
		end
	end
end


if exist('graph1','var') && graph1 == 1;
	colors = [0,0,0; 1,0,0; 0,0,1; 0.5,0.5,0.5; 0.8,0.8,0.8; 0,1,0; 1,1,0; 0,1,1; 1,0,1; 0.5,0.5,0; 0,0.5,0.5];
	
	leg={};
	for r = rsets;
		leg{end+1} = ['RS ',int2str(r)];
	end
	
	figure
	for t = 1:size(bigdist,2);
		for k = 1:length(rsets);
			hist(squeeze(bigdist(:,t,k)),500)
			hold on	
		end
		h = findobj(gca,'Type','patch');
		for q = 1:length(rsets);
			set(h(q),'FaceColor','None','EdgeColor',colors(q,:))
		end
		legend(leg,'Orientation','horizontal','Location','NorthOutside')
		title(['distance, time = ',num2str(fixedvars.tSpace(t))])
		axis([0,1,0,size(bigdist,1)/10])
		hold off
		pause(0.001)
		% if fixedvars.tSpace(t) == 15;
		% 	return
		% end
	end
end

	
if exist('graph2','var') && graph2 == 1;
	leg={};
	for k = 1:length(rsets)
		pv = SSparamsets(rsets(k),psets(k));
		leg{end+1} = ['RS ',int2str(rsets(k)),', PS [', num2str(pv(1)),', ',num2str(pv(2)),', ',int2str(round(12*pv(3)/pi)),'\pi/12]'];;
	end
	figure
	hold on
	if exist('rmos','var') && rmos ==1;
		sparind = [1:4:41,43:2:81,82:length(fixedvars.tSpace)];
		m = size(avgdist,1);
		clrs = get(0,'DefaultAxesColorOrder');
		for k = 1:m;
			ind = find(avgdist(k,:)>0);
			if stdflag == 1;
				plot(fixedvars.tSpace(ind),avgdist(k,ind),'Color',clrs(k,:),'LineWidth',2) %might want to plot these all last, so they are on top of the bars...?
				newind = intersect(ind,sparind(k:m:end));
				hobj=errorbar(fixedvars.tSpace(newind),avgdist(k,newind),stddist(k,newind),'.','Color',clrs(k,:));
				hAnnotation = get(hobj,'Annotation');
				hLegendEntry = get(hAnnotation,'LegendInformation');
				set(hLegendEntry,'IconDisplayStyle','off')
			else;
				plot(fixedvars.tSpace(ind),avgdist(k,ind),'Color',clrs(k,:))
			end
		end
	else;
		errorbar(repmat(fixedvars.tSpace,size(avgdist,1),1).',avgdist.',stddist.')
	end
	axis([0,125,-0.2,1])
	set(gca,'FontSize',24)
	legend(leg,'FontSize',16)
	xlabel('Time','FontSize',24)
	ylabel('Mean distance to source \pm \sigma','FontSize',24)
	% title('vanished')
	% figure
	% errorbar(repmat(fixedvars.tSpace,size(avgdist,1),1).',avgdisto.',stddisto.')
	axis([0,125,0,1])
	% legend(leg)
	% xlabel('Time')
	% ylabel('Mean distance to source')
	% title('orig')
end

