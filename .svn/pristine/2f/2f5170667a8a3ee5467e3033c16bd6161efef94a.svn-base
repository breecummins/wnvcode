function [numcontacts,Linf, L2] = comparediffusion(plotperfile,plotframes,recordframes);

	% Compare the difference in concentration fields between simulations 
	% with and without diffusion. Peclet number indicates that it shouldn't 
	% matter. 

	% recordframes is the nondim'l time between each recorded odor plume. Default 25.
	% If plotframes = 1, then the odor plume will be plotted at each
	% recorded time for each different odor plume. Default 0, no plotting.
	% If plotperfile = 1, then summary stats will be plotted for each file.
	% Default 0, no plotting.

	if ~exist('recordframes','var');
		recordframes = 25;
	end

	if ~exist('plotframes','var');
		plotframes = 0;
	end

	if ~exist('plotperfile','var');
		plotperfile = 0;
	end


	fnamestr = {'', '_wind1', '_wind2', '_wind3', '_wind4'};
	Linf = {};
	L2 = {};

	lowind = 1.e6;

	for n = 1:length(fnamestr);
		
		fileend = fnamestr{n};
		numcontacts_with = [];
		numcontacts_no = [];

		for strategy = ['u','d','c'];

			if strategy == 'u';
				disp('Upwind strategy')
				titlestr = 'Upwind';
			elseif strategy == 'd';
				disp('Downwind strategy')
				titlestr = 'Downwind';
			elseif strategy == 'c';
				disp('Crosswind strategy')
				titlestr = 'Crosswind';
			else;
				error('Mosquito strategy not recognized. Argument should be ''u'', ''d'', or ''c''.')
			end


			basedir = '/scratch03/bcummins/mydata/wnv/NoDiffusion';
			load(fullfile(basedir,[titlestr,'_withdiffusion',fileend,'.mat']))
			C_with = results.C;
			numcontacts_with(end+1) = length(results.whichchicken);
			load(fullfile(basedir,[titlestr,'_nodiffusion',fileend,'.mat']))
			C_no = results.C;
			numcontacts_no(end+1) = length(results.whichchicken);


			if strategy == 'c';
	
				lowind = min(lowind, min(size(C_with,3),size(C_no,3))-2);

				for k = 2:lowind;
					Linf{n}(k-1) = max(max( abs(C_with(:,:,k) - C_no(:,:,k)) ));
					L2{n}(k-1) = sqrt( sum(sum( ( (C_with(:,:,k) - C_no(:,:,k)) ).^2 )) ) * p.h ;
					
					if plotframes;

						figure(1);
						clf
						hold on
						Cmx = max(max(C_with(:,:,k)));
						contour((p.h/2 : p.h : p.L-p.h/2),(p.h/2 : p.h : p.L-p.h/2),C_with(:,:,k),linspace(p.CO2_thresh,Cmx,15)); %(0:0.01*Cmx:Cmx)
						set(gca,'FontSize',24)
						axis([0,p.L,0,p.L])
						colormap(jet)
						colorbar
						axis off
						title('with diffusion')
						set(gcf,'PaperPosition',[0,0,8.0,6.0])
						set(gcf,'PaperSize',[8.0,6.0])
						saveas(gcf,['/scratch03/bcummins/mydata/wnv/NoDiffusion/frame_withdiff',fileend,'_',sprintf('%02d',k),'.png'],'png')

						clf
						hold on
						Cmx = max(max(C_no(:,:,k)));
						contour((p.h/2 : p.h : p.L-p.h/2),(p.h/2 : p.h : p.L-p.h/2),C_no(:,:,k),linspace(p.CO2_thresh,Cmx,15)); %(0:0.01*Cmx:Cmx)
						set(gca,'FontSize',24)
						axis([0,p.L,0,p.L])
						colormap(jet)
						colorbar
						axis off
						title('no diffusion')
						set(gcf,'PaperPosition',[0,0,8.0,6.0])
						set(gcf,'PaperSize',[8.0,6.0])
						saveas(gcf,['/scratch03/bcummins/mydata/wnv/NoDiffusion/frame_nodiff',fileend,'_',sprintf('%02d',k),'.png'],'png')

						clf
						hold on
						Cmx = max(max(abs(C_no(:,:,k)-C_with(:,:,k))));
						contour((p.h/2 : p.h : p.L-p.h/2),(p.h/2 : p.h : p.L-p.h/2),abs(C_no(:,:,k)-C_with(:,:,k)),linspace(0,Cmx,15)); %(0:0.01*Cmx:Cmx)
						set(gca,'FontSize',24)
						axis([0,p.L,0,p.L])
						colormap(jet)
						colorbar
						axis off
						title('difference')
						set(gcf,'PaperPosition',[0,0,8.0,6.0])
						set(gcf,'PaperSize',[8.0,6.0])
						saveas(gcf,['/scratch03/bcummins/mydata/wnv/NoDiffusion/frame_comp',fileend,'_',sprintf('%02d',k),'.png'],'png')
					end

				end
			end
		end

		times = (1:lowind-1)*recordframes;

		numcontacts.upwind.diff(n) = numcontacts_with(1);
		numcontacts.upwind.nodiff(n) = numcontacts_no(1);
		numcontacts.downwind.diff(n) = numcontacts_with(2);
		numcontacts.downwind.nodiff(n) = numcontacts_no(2);
		numcontacts.crosswind.diff(n) = numcontacts_with(3);
		numcontacts.crosswind.nodiff(n) = numcontacts_no(3);
		
		if plotperfile;

			clf
			plot(times,Linf{n}(:),'LineWidth',2);
			set(gca,'FontSize',24)
			title(['Diff/No diff, CO_2 thresh = ', sprintf('%.03f',p.CO2_thresh)],'FontSize',18')
			xlabel('Time')
			ylabel('L_\infty')
			set(gcf,'PaperPosition',[0,0,8.0,6.0])
			set(gcf,'PaperSize',[8.0,6.0])
			saveas(gcf,['/scratch03/bcummins/mydata/wnv/NoDiffusion/Linf',fileend,'.png'],'png')

			clf
			plot(times,L2{n}(:),'LineWidth',2);
			set(gca,'FontSize',24)
			title('Diffusion vs none')
			xlabel('Time')
			ylabel('L_2')
			set(gcf,'PaperPosition',[0,0,8.0,6.0])
			set(gcf,'PaperSize',[8.0,6.0])
			saveas(gcf,['/scratch03/bcummins/mydata/wnv/NoDiffusion/L2',fileend,'.png'],'png')

			clf
			bar(reshape([numcontacts_with;numcontacts_no],1,[]))
			set(gca,'FontSize',24,'XTickLabel',{'ud', 'und', 'dd', 'dnd', 'cd', 'cnd'})
			title('Diffusion vs no diffusion')
			ylabel('# contacts')
			set(gcf,'PaperPosition',[0,0,8.0,6.0])
			set(gcf,'PaperSize',[8.0,6.0])
			saveas(gcf,['/scratch03/bcummins/mydata/wnv/NoDiffusion/numcontacts',fileend,'.png'],'png')

			clf
			numcontactsrat = (numcontacts_with - numcontacts_no)./ numcontacts_with;
			bar(numcontactsrat)
			set(gca,'FontSize',24,'XTickLabel',{'up', 'down', 'cross'})
			title('Proportional difference in contacts')
			ylabel('prop contacts')
			set(gcf,'PaperPosition',[0,0,8.0,6.0])
			set(gcf,'PaperSize',[8.0,6.0])
			saveas(gcf,['/scratch03/bcummins/mydata/wnv/NoDiffusion/propdifferencecontacts',fileend,'.png'],'png')

		end

	end

	% calculate averages
	diffusion.avg = [mean(numcontacts.upwind.diff),mean(numcontacts.downwind.diff),mean(numcontacts.crosswind.diff)];
	diffusion.std = [std(numcontacts.upwind.diff),std(numcontacts.downwind.diff),std(	numcontacts.crosswind.diff)];
	nodiffusion.avg = [mean(numcontacts.upwind.nodiff),mean(numcontacts.downwind.nodiff),mean(numcontacts.crosswind.nodiff)];
	nodiffusion.std = [std(numcontacts.upwind.nodiff),std(numcontacts.downwind.nodiff),std(numcontacts.crosswind.nodiff)];
	propchange.avg = [mean(abs(numcontacts.upwind.diff - numcontacts.upwind.nodiff)./numcontacts.upwind.diff),mean(abs(numcontacts.downwind.diff - numcontacts.downwind.nodiff)./numcontacts.downwind.diff),mean(abs(numcontacts.crosswind.diff - numcontacts.crosswind.nodiff)./numcontacts.crosswind.diff)];
	propchange.std = [std(abs(numcontacts.upwind.diff - numcontacts.upwind.nodiff)./numcontacts.upwind.diff),std(abs(numcontacts.downwind.diff - numcontacts.downwind.nodiff)./numcontacts.downwind.diff),std(abs(numcontacts.crosswind.diff - numcontacts.crosswind.nodiff)./numcontacts.crosswind.diff)];

	L2mat = zeros(length(fnamestr),lowind-1);
	Linfmat = zeros(length(fnamestr),lowind-1);

	for n = 1:length(fnamestr);	
		L2mat(n,:) = L2{n}(1:lowind-1);
		Linfmat(n,:) = Linf{n}(1:lowind-1);
	end

	L2avg = mean(L2mat,1);
	Linfavg = mean(Linfmat,1);
	L2std = std(L2mat,1);
	Linfstd = std(Linfmat,1);

	%plot averages
	clf
	bar(propchange.avg,'FaceColor',[0.8,0.8,0.8])
	hold on
	errorbar(propchange.avg,propchange.std,'k+')
	set(gca,'XTickLabel',{'up','down','cross'},'FontSize',24)
	title('Average over wind of prop change in contacts')
	ylabel('prop contacts')
	saveas(gcf,['/scratch03/bcummins/mydata/wnv/NoDiffusion/avgpropdifferencecontacts.png'],'png')

	clf
	errorbar(times,Linfavg,Linfstd)
	set(gca,'FontSize',24)
	title('Average over wind of L_\infty error')
	xlabel('time')
	ylabel('L_\infty error')
	saveas(gcf,['/scratch03/bcummins/mydata/wnv/NoDiffusion/avgLinf.png'],'png')


