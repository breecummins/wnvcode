%trackmosq.m

clear
close all

load ~/WNVFifthRuns/AllRules_fixedvariables.mat

%track different mosquitoes over the same run
load ~/WNVFifthRuns/AllRules_paramset048_run01.mat

dist1 = squeeze(EuclideanDist(:,1,:));
dist2 = squeeze(EuclideanDist(:,2,:));
dist9 = squeeze(EuclideanDist(:,9,:));

mosqs = [1:5,11:15];
leg={};
for k = 1:length(mosqs);
	leg{end+1} = int2str(mosqs(k));
end
	
set(0,'DefaultAxesFontSize',24)

figure
plot(fixedvars.tSpace,dist1(mosqs,:))
ylim([0,1])
xlabel('Time')
ylabel('Distance to source')
%legend(leg)


figure
plot(fixedvars.tSpace,dist2(mosqs,:))
ylim([0,1])
xlabel('Time')
ylabel('Distance to source')
%legend(leg)


figure
plot(fixedvars.tSpace,dist9(mosqs,:))
ylim([0,1])
xlabel('Time')
ylabel('Distance to source')
%legend(leg)


% %track the same mosquito over different runs
% mosq=1;
% dist2=[];
% dist9=[];
% for k = 1:25;
% 	str = sprintf('%02d',k);
% 	load(['~/WNVFourthRuns/AllRules_paramset048_run',str]);
% 	dist2(k,:) = squeeze(EuclideanDist(mosq,SSlookuptable(2,'paper2ind'),:));
% 	dist9(k,:) = squeeze(EuclideanDist(mosq,SSlookuptable(9,'paper2ind'),:));
% end
% 	
% figure
% plot(fixedvars.tSpace,dist2(:,:))
% ylim([0,1])
% xlabel('Time')
% ylabel('Distance to source')
% 
% 
% figure
% plot(fixedvars.tSpace,dist9(:,:))
% ylim([0,1])
% xlabel('Time')
% ylabel('Distance to source')
% 
% 	
% 	
