function test_doubleadvection_analysis()
	
	close all
	
	load ~/rsyncfolder/data/WNV/FullSimulationNewRuleNewAdvect/DoubleAdvection.mat
	
	Ctot = [];
	leg={};
	ctr = 0;
	for Vmag = Vvec;
		ctr=ctr+1;
		s = eval(['results.V',int2str(Vmag*10)]);
		% figure
		% Ccontourviz(s.xg,s.yg,s.C(:,:,end),s.params,s.Tvec(end));
		Ctot(:,ctr) = CO2sum(s.C);
		leg{end+1} = ['V = ', num2str(Vmag), ', sat. lev. ~ ',int2str(round(Ctot(end,ctr)))];
	end
	
	figure
	plot(s.Tvec,Ctot,'LineWidth',2)
	set(gca,'FontSize',24)
	set(gcf,'PaperSize',[8,6])  
	set(gcf,'PaperPosition',[0,0,8,6])
	xlabel('Nondiml time')
	ylabel('Total nondiml CO_2')
	legend(leg,'Location','SouthEast','FontSize',16)


end %function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Ctot = CO2sum(C);
	
	% THE INPUT ARGUMENT IS A 3D MATRIX COMPOSED OF A TIME SEQUENCE OF CO2 VALUES ON A 2D GRID. X,Y,T ARE THE VARIABLES ASSOCIATED WITH THE 1ST, 2ND, AND 3RD DIMENSIONS RESPECTIVELY. THE OUTPUT ARGUMENT IS A TIMESERIES OF THE TOTAL CO2 IN THE DOMAIN OVER TIME.
	
	Ctot = [];
	for k = 1:size(C,3);
		Ctot(k) = sum(sum(C(:,:,k)));
	end
end %function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Ccontourviz(xg,yg,C,p,t);

	contour(xg,yg,C)
	axis([0,p.L,0,p.L])
	colormap(cool)
	colorbar
	set(gca,'FontSize',24)
	set(gcf,'PaperSize',[8,6])  
	set(gcf,'PaperPosition',[0,0,8,6])
	title(['V = ', num2str(p.Vmag),', nondiml time = ',num2str(t)])

end %function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




