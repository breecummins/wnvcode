function [avgdistlo,stddistlo,avgdisthi,stddisthi]=SSdist2source(rsets,psets,van,graph1,graph2)

% Find the average dist to the source for each rsets(k), psets(k) during all runs. If graph1 == 1, graph histograms; if graph2 == 1 graph averages.
%van == 1 means use the data where the agents have been removed from simulation

basedir = '~/WNVSixthRuns/';

avgdistlo=[];
stddistlo=[];
avgdisthi=[];
stddisthi=[];
bigdist =zeros(0,0,0);
for k = 1:length(rsets)
	if mod(k,10) == 0;
		disp([int2str(k), ' of ', int2str(length(rsets)),' rule/parameter set pairs.'])
	end
	load(fullfile(basedir,['StackAllTimes_RuleSet',sprintf('%02d',rsets(k)),'_paramset',sprintf('%03d',psets(k))]))
	if exist('van','var') && van == 1;
		for t = 1:size(edvanished,2);
			ih = find(edvanished(:,t)>0.25);
			il = find(edvanished(:,t)<=0.25);
			avgdistlo(k,t) = mean(edvanished(il,t),1);
			stddistlo(k,t) = std(edvanished(il,t),0,1);
			avgdisthi(k,t) = mean(edvanished(ih,t),1);
			stddisthi(k,t) = std(edvanished(ih,t),0,1);
		end
		if exist('graph1','var') && graph1 == 1;
			bigdist(:,:,k) = edvanished;
		end
	else;
		for t = 1:size(eucdist,2);
			ih = find(eucdist(:,t)>0.25);
			il = find(eucdist(:,t)<=0.25);
			avgdistlo(k,t) = mean(eucdist(il,t),1);
			stddistlo(k,t) = std(eucdist(il,t),0,1);
			avgdisthi(k,t) = mean(eucdist(ih,t),1);
			stddisthi(k,t) = std(eucdist(ih,t),0,1);
		end
		if exist('graph1','var') && graph1 == 1;
			bigdist(:,:,k) = eucdist;
		end
	end
end

sum(sum(bigdist(:,end,1)==0))
length(bigdist(:,end,1))


if (exist('graph1','var') && graph1 == 1) || (exist('graph2','var') && graph2 == 1);
	load(fullfile(basedir,['AllRules_fixedvariables']))
end

if exist('graph1','var') && graph1 == 1;
	colors = [0,0,0; 1,0,0; 0,0,1; 0.5,0.5,0.5; 0.8,0.8,0.8; 0,1,0; 1,1,0; 0,1,1; 1,0,1; 0.5,0.5,0; 0,0.5,0.5];
	
	leg={};
	for r = rsets;
		leg{end+1} = ['RS ',int2str(r)];
	end
	
	figure(1)
	for t = 1:size(eucdist,2);
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
	flag=1;
else;
	flag=0;
end

	
if exist('graph2','var') && graph2 == 1;
	leg={};
	for k = 1:length(rsets)
		pv = SSparamsets(rsets(k),psets(k));
		leg{end+1} = ['RS ',int2str(rsets(k)),', PS [', num2str(pv(1)),', ',num2str(pv(2)),', ',num2str(pv(3)),']'];
	end
	if flag == 1;
		figure(2)
	else;
		figure(1)
	end
	errorbar(repmat(fixedvars.tSpace,size(avgdistlo,1),1).',avgdistlo.',stddistlo.')
	hold on
	errorbar(repmat(fixedvars.tSpace,size(avgdisthi,1),1).',avgdisthi.',stddisthi.')
	axis([0,125,-0.2,1])
	legend(leg)
	xlabel('Time')
	ylabel('Mean distance to source')
	% title('vanished')
	% figure
	% errorbar(repmat(fixedvars.tSpace,size(avgdist,1),1).',avgdisto.',stddisto.')
	% axis([0,125,-0.2,1])
	% legend(leg)
	% xlabel('Time')
	% ylabel('Mean distance to source')
	% title('orig')
end

