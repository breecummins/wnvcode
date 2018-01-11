function SSScalarViz2(recordthis,rulesets,plotstd,inset)

%	recordthis=1 means record the frames as they are graphed
%   		 =0 means don't
%   rulesets is a vector containing the rule sets to graph
%	plotstd is a vector containing the rule sets to graph the standard deviation as well as the average; default is all rule sets
% inset = 1 means plot the averages in an inset

close all

avgsfname = '~/WNVSixthRuns/ScalarAverages.mat'; %alter with code changes
fvfname='~/WNVSixthRuns/AllRules_fixedvariables'; %alter with code changes
numruns=25;

if any(rulesets == 5);
	load('~/WNVSixthRuns/Rule5onlyMaxScaling_fixedvariables.mat')
	load('~/WNVSixthRuns/ScalarAverages_Rule5onlyMaxScaling.mat')
	avgmat5 = reshape(avgs,numcols,numrows,[]); %the order of the rows and columns is opposite because Matlab reshapes by taking elements columnwise.
	if max(abs(avgs(1:length(fixedvars.tSpace))-avgmat5(:,1,1).')) > 0;
		error('Something went wrong in the conversion from python to matlab. The data are not correctly ordered.')
	elseif size(avgmat5,3) ~= size(psetruns,1);
		error('Something went wrong in the conversion from python to matlab. The parameter sets were not correctly recorded.')
	end
end
	

if ~exist('plotstd','var');
	plotstd = rulesets;
end

set(0,'DefaultAxesFontSize',24)

if recordthis == 1;
	dirnum='';
	for k = rulesets;
		dirnum = [dirnum,int2str(k)];
	end
end

load(fvfname)
load(avgsfname)
%reshape vector into a 3D matrix. axes should be time by rule set by average. psetruns should have the parameter set number and run number associated with the average.
avgmat = reshape(avgs,numcols,numrows,[]); %the order of the rows and columns is opposite because Matlab reshapes by taking elements columnwise.
if max(abs(avgs(1:length(fixedvars.tSpace))-avgmat(:,1,1).')) > 0;
	error('Something went wrong in the conversion from python to matlab. The data are not correctly ordered.')
elseif size(avgmat,3) ~= size(psetruns,1);
	error('Something went wrong in the conversion from python to matlab. The parameter sets were not correctly recorded.')
end

colors = [0,0,0; 1,0,0; 0,0,1; 0.5,0.5,0.5; 0.8,0.8,0.8; 0,1,0; 1,1,0; 0,1,1; 1,0,1; 0.5,0.5,0; 0,0.5,0.5];
%colors = get(0,'DefaultAxesColorOrder');

leg={};
for r = rulesets;
	leg{end+1} = ['#',int2str(r)];
end


frame=1;
avg=[];
stddev=[];
for t = 1:size(avgmat,1);
	q=1;
	for r = rulesets;
		if r ~= 5;
			data = squeeze(avgmat(t,r,:));
		else;
			data = squeeze(avgmat5(t,1,:));
		end
		avg(q,t) = mean(data);
		stddev(q,t) = std(data);
		q=q+1;
		% hist(data,50)	
		% hold on
	end
	% h = findobj(gca,'Type','patch');
	% for q = 1:length(rulesets);
	% 	set(h(q),'FaceColor','None','EdgeColor',colors(q,:))
	% end
	% legend(leg,'Orientation','horizontal','Location','NorthOutside')
	% title(['average distance, time = ',num2str(fixedvars.tSpace(t))])
	% axis([0,1,0,size(avgmat,3)/10])
	% hold off
	if recordthis == 1;
		f=sprintf('%03d',frame);
		fname = [basedir,'/movies',dirnum,'/frame',f,'.png'];
		saveas(gcf,fname,'png')
		frame=frame+1;
	else;
		pause(0.001)
	end
end	

h = figure;
hold on	
for k = 1:length(rulesets)
	c = colors(k,:);
	plot(fixedvars.tSpace,avg(k,:),'Color',c,'LineStyle','-','LineWidth',2)
end	

for k = 1:length(plotstd)
	ind = find(rulesets == plotstd(k));
	c = colors(ind,:);
	plot(fixedvars.tSpace,avg(ind,:)+2*stddev(ind,:),'Color',c,'LineStyle','--')
	plot(fixedvars.tSpace,avg(ind,:)-2*stddev(ind,:),'Color',c,'LineStyle','--')
end

legend(leg,'FontSize',16,'Orientation','Horizontal','Location','NorthWest')
% legend(leg,'FontSize',16,'Orientation','Horizontal','Location','North')
xlim([0,125])
ylabel('Average over all parameters')
xlabel('Time')
hold off

if exist('inset','var') && inset == 1;
	% a2 = axes('pos',[0.65,0.675,0.25,0.25],'XTickLabel',[],'YTickLabel',[],'box','on');
	a2 = axes('pos',[0.6,0.55,0.3,0.3],'XTickLabel',[],'YTickLabel',[],'box','on');
	set(h,'CurrentAxes',a2)
	hold on
	for k = 1:length(rulesets)
		c = colors(k,:);
		plot(fixedvars.tSpace,avg(k,:),'Color',c,'LineStyle','-','LineWidth',2)
	end	
	axis([0,125,-0.2,0.8])
	hold off	
end


