%SSNewRuledist2source.m

clear 
close all

basedir = '~/WNVNewRule/StackAllTimes_Rule02_newruleparam';
%psets = [1,2,3];
psets = [4,5,6];

bigdist =zeros(0,0,0);
for k = 1:length(psets)
	load([basedir,sprintf('%03d',psets(k))])
	bigdist(:,:,k) = edvanished;
end

sum(bigdist(:,end,1)==0)

load ~/WNVNewRule/Rule02_fixedvariables.mat

colors = [0,0,0; 1,0,0; 0,0,1; 0.5,0.5,0.5; 0.8,0.8,0.8; 0,1,0; 1,1,0; 0,1,1; 1,0,1; 0.5,0.5,0; 0,0.5,0.5];

leg={};
for p = psets;
	leg{end+1} = ['PS ',int2str(p)];
end

figure(1)
for t = 1:size(eucdist,2);
	for k = 1:length(psets);
		hist(squeeze(bigdist(:,t,k)),500)
		hold on	
	end
	h = findobj(gca,'Type','patch');
	for q = 1:length(psets);
		set(h(q),'FaceColor','None','EdgeColor',colors(psets(q),:))
	end
	legend(leg,'Orientation','horizontal','Location','NorthOutside')
	title(['distance, time = ',num2str(fixedvars.tSpace(t))])
	axis([0,1,0,size(bigdist,1)/20])
	hold off
	pause(0.001)
	% if fixedvars.tSpace(t) == 15;
	% 	return
	% end
end

