function SSNewRulemosqviz(pset,runnum)

close all

load(['~/WNVNewRule/Rule02_newruleparam',sprintf('%03d',pset),'_run',sprintf('%02d',runnum)]);
load ~/WNVNewRule/Rule02_fixedvariables.mat;

C = fixedvars.C;
h=fixedvars.h;
tSpace=fixedvars.tSpace;
timeind = 1:length(tSpace);

figure(1)
%change size of window
g=get(gcf,'Position');
set(gcf,'Position',[g(1)-g(1)/2,2*g(2),2*g(3),2*g(4)])
set(gca,'FontSize',24)

for t = timeind;
	
	figure(1);
	% % clf
	
	%graph the concentration with 50 contour lines
	contour((h/2:h:1-h/2),(h/2:h:1-h/2),C,30);
	title(['Time = ',num2str(tSpace(t))])
	% h=colorbar;
	% set(h,'FontSize',16)
	colormap(hot)
	colorbar('FontSize',24)
	set(gca, 'CLim', [0, 1]);
	axis equal
	axis([0,fixedvars.domainL,0,fixedvars.domainL])
	axis off
	hold on
	
	%Plot mosquitoes
	c = { 'k.','b.','r.','c.','m.','ks','bs','rs','cs','ms' };
	leg={'CO2'};
	%for k =1:NumMethods;
	cind =1;

	plot(SpatialDistX(:,1,t),SpatialDistY(:,1,t),c{cind},'MarkerSize',16);  %flip x and y to be compatible with the meshgrid representation of the CO2
	leg{end+1}=['Param set ',int2str(pset)];
	
	%legend(leg,'Location','NorthWest','FontSize',14);
	% legend('boxoff')
	
	pause(0.0001)
	
	hold off
end
