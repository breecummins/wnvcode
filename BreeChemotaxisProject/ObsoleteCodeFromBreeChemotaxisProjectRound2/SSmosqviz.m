function SSmosqviz(fname,fixedvarfname,rulesets,rf,figfname,timesubset)

%fname has the mosquito positions at each time; fixedvarfname has the concentration gradient; rulesets is a vector of rule sets to graph; rf ==1 means save figures under figfname_3digit#.png (default is don't save); timesubset is an optional argument that lets you plot and save only a subset of the times. Input the actual times that you want, not the indices.

close all

%fname = '~/WNVSixthRuns/AllRules_paramset012_run01.mat';
try;
	load(fname);
catch;
	load(fullfile('~/WNVSixthRuns',fname));
end

if ~exist('C','var');
	try;
		load(fixedvarfname);
	catch;
		load(fullfile('~/WNVSixthRuns',fixedvarfname));
	end
	
	C = fixedvars.C;
	h=fixedvars.h;
	tSpace=fixedvars.tSpace;
end

if exist('timesubset','var');
	timeind=[];
	for k = 1:length(timesubset);
		tvec = abs(fixedvars.tSpace - timesubset(k));
		timeind(end+1) = find(tvec == min(tvec));
	end
else;
	timeind = 1:length(tSpace);
end



figure(1)
%change size of window
g=get(gcf,'Position');
set(gcf,'Position',[g(1)-g(1)/2,2*g(2),2*g(3),2*g(4)])
set(gca,'FontSize',24)

for t = timeind;
	
	figure(1);
	% % clf
	
	%graph the concentration with 50 contour lines
	Cmx = max(max(C));
	contour((h/2:h:1-h/2),(h/2:h:1-h/2),C,30);
	title(['Time = ',num2str(tSpace(t))])
	% h=colorbar;
	% set(h,'FontSize',16)
	colormap(hot)
	colorbar('FontSize',24)
	set(gca, 'CLim', [0, 1]);
	axis equal
	axis([0,1,0,1])
	axis off
	hold on
	
	%Plot mosquitoes
	c = { 'k.','b.','r.','c.','m.','ks','bs','rs','cs','ms' };
	leg={'CO2'};
	%for k =1:NumMethods;
	cind =1;
	for k = rulesets;
		plot(SpatialDistX(:,k,t),SpatialDistY(:,k,t),c{cind},'MarkerSize',16);  %flip x and y to be compatible with the meshgrid representation of the CO2
		leg{end+1}=['Rule ',int2str(k)];
		cind=cind+1;
	end 
	
	%legend(leg,'Location','NorthWest','FontSize',14);
	% legend('boxoff')
	
	if exist('rf','var') && rf == 1;
		fname = [figfname,'_',sprintf('%03d',t),'.png'];
		saveas(gcf,fname,'png')
	else;	
		pause(0.0001)
	end
	
	hold off
end
