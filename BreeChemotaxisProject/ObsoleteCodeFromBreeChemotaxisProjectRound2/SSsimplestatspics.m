%SSsimplestatspics.m
clear
close all

load ~/WNVSixthRuns/AllRules_fixedvariables

tind = [find(fixedvars.tSpace == 0),find(fixedvars.tSpace == 5),find(fixedvars.tSpace == 15),find(fixedvars.tSpace == 30),find(fixedvars.tSpace == 60)];

load ~/WNVSixthRuns/StackAllTimes_RuleSet02_paramset027
r02edvan = edvanished;

load ~/WNVSixthRuns/StackAllTimes_RuleSet10_paramset001
r10edvan = edvanished;

set(0,'DefaultAxesFontSize',24)

nov = {'r02edvan','r10edvan'};

% %histograms
% for n = 1:length(nov);
% 	for m = 1:length(tind);
% 		subplot(length(nov),length(tind),(n-1)*length(tind)+m)
% 		inz = find(eval([nov{n},'(1:200,tind(m))'])>0);
% 		if m ==1;
% 			hist(eval([nov{n},'(inz,tind(m))']),8)
% 		else;
% 			hist(eval([nov{n},'(inz,tind(m))']),16)
% 		end
% 		axis([0,0.9,0,60])
% 		if n ==1;
% 			title(['Time = ',num2str(fixedvars.tSpace(tind(m)))])
% 			if m == 1;
% 				ylabel('\nabla C direction, C speed')
% 			end
% 		elseif n == length(nov);
% 			if m == 1;
% 				ylabel('Diffusion')
% 			elseif m==ceil(length(tind)/2);
% 				h=xlabel('Distance to source');
% 			end
% 			h=findobj(gca,'Type','patch');
% 			set(h,'FaceColor','red')
% 		end
% 	end
% end

% %cfds
% for n = 1:length(nov);
% 	figure
% 	for m = 1:length(tind);
% 		subplot(2,length(tind),m)
% 		inz = find(eval([nov{n},'(1:200,tind(m))'])>0);
% 		if m ==1;
% 			hist(eval([nov{n},'(inz,tind(m))']),8)
% 		else;
% 			hist(eval([nov{n},'(inz,tind(m))']),16)
% 		end
% 		axis([0,0.9,0,60])
% 		if m == 1 && n ==1;
% 			ylabel('\nabla C direction, C speed')
% 		end
% 		if n == 2;
% 			h=findobj(gca,'Type','patch');
% 			set(h,'FaceColor','red')
% 			if m ==1;
% 				ylabel('Diffusion')
% 			end
% 		end
% 		subplot(2,length(tind),m+length(tind))
% 		sv = sort(eval([nov{n},'(inz,tind(m))']));
% 		refvec = 0:0.05:1;
% 		csvec=[];
% 		for r = refvec;
% 			num = find(sv <= r, 1, 'last');
% 			if isempty(num);
% 				num=0;
% 			end
% 			csvec(end+1) = num;
% 		end
% 		if n == 1;
% 			plot(refvec,csvec,'b-','LineWidth',2)
% 			if m == 1;
% 				ylabel('\nabla C direction, C speed')
% 			end
% 		elseif n ==2;
% 			plot(refvec,csvec,'r-','LineWidth',2)
% 			if m ==1;
% 				ylabel('Diffusion')
% 			end
% 		end
% 		axis([0,1,0,200])
% 	end
% end



% % normalized cfds
% figure
% for n = 1:length(nov);
% 	for m = 1:length(tind);
% 		subplot(2,length(tind),(n-1)*length(tind)+m)
% 		inz = find(eval([nov{n},'(1:200,tind(m))'])>0);
% 		sv = sort(eval([nov{n},'(inz,tind(m))']));
% 		refvec = 0:0.05:1;
% 		csvec=[];
% 		for r = refvec;
% 			num = find(sv <= r, 1, 'last');
% 			if isempty(num);
% 				num=0;
% 			end
% 			csvec(end+1) = num;
% 		end
% 		if n == 1;
% 			plot(refvec,csvec./max(csvec),'b-','LineWidth',2)
% 			if m == 1;
% 				ylabel('\nabla C direction, C speed')
% 			end
% 		elseif n ==2;
% 			plot(refvec,csvec./max(csvec),'r-','LineWidth',2)
% 			if m == 1;
% 				ylabel('Diffusion')
% 			elseif m == 3;
% 				xlabel('Distance to source')
% 			end		
% 		end	
% 		axis([0,1,0,1])		
% 	end
% end

% % overlaid normalized cfds
% figure
% for m = 1:length(tind);
% 	subplot(1,length(tind),m)
% 	hold on
% 	for n = 1:length(nov);
% 		inz = find(eval([nov{n},'(1:200,tind(m))'])>0);
% 		sv = sort(eval([nov{n},'(inz,tind(m))']));
% 		refvec = 0:0.05:1;
% 		csvec=[];
% 		for r = refvec;
% 			num = find(sv <= r, 1, 'last');
% 			if isempty(num);
% 				num=0;
% 			end
% 			csvec(end+1) = num;
% 		end
% 		if n == 1;
% 			plot(refvec,csvec./max(csvec),'b-','LineWidth',2)
% 			compvec = csvec./max(csvec);
% 		elseif n ==2;
% 			plot(refvec,csvec./max(csvec),'r-','LineWidth',2)
% 			diffvec = csvec./max(csvec);
% 			dvec = abs(compvec - diffvec);
% 			ind = find(dvec==max(dvec));
% 			minval = min(compvec(ind),diffvec(ind));
% 			maxval = max(compvec(ind),diffvec(ind));
% 			linevec = linspace(minval,maxval,25);
% 			plot(refvec(ind)*ones(1,25),linevec,'k-','LineWidth',4)
% 			set(gca,'XTick',[])
% 			set(gca,'YTick',[0.2,0.4,0.6,0.8,1])
% 			xlabel(['KS=', sprintf('%0.2g',maxval-minval)])
% 			if m ==1;	
% 				ylabel('Normalized CDFs')
% 			end
% 		end	
% 		axis([0,1,0,1])		
% 	end
% end




% time trace KS stat (worked the same when I used the home-rolled function from above, but matlab's functions are cleaner)
% KS=[];
% for m = 1:length(fixedvars.tSpace);
% 	inz = find(eval([nov{1},'(1:200,m)'])>0);
% 	v02 = eval([nov{1},'(inz,m)']);
% 	inz = find(eval([nov{2},'(1:200,m)'])>0);
% 	v10 = eval([nov{2},'(inz,m)']);
% 	if ~isempty(v02) && ~isempty(v10);
% 		[junk1,junk2, KS(m)] = kstest2(v02,v10);
% 	end
% end
% figure
% plot(fixedvars.tSpace(1:length(KS)), KS, 'k-', 'LineWidth', 2)
% ylabel('KS stat')
% xlabel('Time')
% 



% %empirical dist for diffusion
% [KSmean,KS007,KS293]=SSPairwiseRunCompsKSstatSelfOnly(10,1,1,1);
% figure
% % errorbar(fixedvars.tSpace,KSmean,KS007-KSmean,KS293-KSmean,'r-','LineWidth',2)
% plot(fixedvars.tSpace(1:length(KSmean{1})),KSmean{1},'r-','LineWidth',2)
% hold on
% sparind = [1:4:41,43:2:81,82:length(fixedvars.tSpace)];
% newind = intersect(1:length(KSmean{1}),sparind);
% errorbar(fixedvars.tSpace(newind),KSmean{1}(newind),KS007{1}(newind)-KSmean{1}(newind),KS293{1}(newind)-KSmean{1}(newind),'r.');
% axis([0,125,0,0.4])
% xlabel('Time')
% ylabel('Mean KS, 95% C.I.')



% %comparison between rules
% [KSmean,KS007,KS293]=SSPairwiseRunCompsKSstatSelfOnly(10,1,1,1);
% [ksmeancomp]=SSPairwiseRunCompsKSstat(10,1,2,27,1,1,0,1,KSmean{1},KS007{1},KS293{1},0);
% legend off
% axis([0,80,0,0.4])

% %good comparisons
% [KSmean,KS007,KS293]=SSPairwiseRunCompsKSstatSelfOnly(2,27,1,1);
% [ksmeancomp]=SSPairwiseRunCompsKSstat(2,27,[1,6],[13,12],1,1,0,1,KSmean{1},KS007{1},KS293{1},0);


% %KS tutorial fig for paper
% %cdfs
% for n = 1:length(nov);
% 	figure
% 	set(gcf, 'PaperSize', [8.5 14])                                          
% 	set(gcf, 'PaperPosition', [0.25 0.25 2.0 13.25]);
% 	m = 4;
% 	subplot(3,1,1)
% 	inz = find(eval([nov{n},'(1:200,tind(m))'])>0);
% 	hist(eval([nov{n},'(inz,tind(m))']),16)
% 	title(['Time = ',int2str(fixedvars.tSpace(tind(m)))])
% 	axis([0,0.9,0,60])
% 	if n == 2;
% 		h=findobj(gca,'Type','patch');
% 		set(h,'FaceColor','red')
% 	end
% 	subplot(3,1,2)
% 	sv = sort(eval([nov{n},'(inz,tind(m))']));
% 	refvec = 0:0.05:1;
% 	csvec=[];
% 	for r = refvec;
% 		num = find(sv <= r, 1, 'last');
% 		if isempty(num);
% 			num=0;
% 		end
% 		csvec(end+1) = num;
% 	end
% 	if n == 1;
% 		plot(refvec,csvec,'b-','LineWidth',2)
% 		% if m == 1;
% 		% 	ylabel('\nabla C direction, C speed')
% 		% end
% 	elseif n ==2;
% 		plot(refvec,csvec,'r-','LineWidth',2)
% 		% if m ==1;
% 		% 	ylabel('Diffusion')
% 		% end
% 	end
% 	axis([0,1,0,200])
% 	subplot(3,1,3)
% 	if n == 1;
% 		plot(refvec,csvec./max(csvec),'b-','LineWidth',2)
% 		% if m == 1;
% 		% 	ylabel('\nabla C direction, C speed')
% 		% end
% 	elseif n ==2;
% 		plot(refvec,csvec./max(csvec),'r-','LineWidth',2)
% 		% if m == 1;
% 		% 	ylabel('Diffusion')
% 		% elseif m == 3;
% 		% 	xlabel('Distance to source')
% 		% end		
% 	end	
% 	axis([0,1,0,1])	
% 	
% 	
% 	figure(2)	
% 	hold on
% 	if n == 1;
% 		plot(refvec,csvec./max(csvec),'b-','LineWidth',2)
% 		compvec = csvec./max(csvec);
% 	elseif n ==2;
% 		plot(refvec,csvec./max(csvec),'r-','LineWidth',2)
% 		diffvec = csvec./max(csvec);
% 		dvec = abs(compvec - diffvec);
% 		ind = find(dvec==max(dvec));
% 		minval = min(compvec(ind),diffvec(ind));
% 		maxval = max(compvec(ind),diffvec(ind));
% 		linevec = linspace(minval,maxval,25);
% 		plot(refvec(ind)*ones(1,25),linevec,'k-','LineWidth',4)
% 		set(gca,'XTick',[])
% 		set(gca,'YTick',[0,0.2,0.4,0.6,0.8,1])
% 		xlabel(['KS=', sprintf('%0.2g',maxval-minval)])
% 		% if m ==1;	
% 		% 	ylabel('Normalized CDFs')
% 		% end
% 	end	
% 	box on
% 	axis([0,1,0,1])		
% end
% 

% KS over time for paper
KS=[];
for m = 1:length(fixedvars.tSpace);
	inz = find(eval([nov{1},'(1:200,m)'])>0);
	v02 = eval([nov{1},'(inz,m)']);
	inz = find(eval([nov{2},'(1:200,m)'])>0);
	v10 = eval([nov{2},'(inz,m)']);
	if length(v02) >= 10;
		[junk1,junk2, KS(m)] = kstest2(v02,v10);
	end
end
figure
plot(fixedvars.tSpace(1:length(KS)), KS, 'k-', 'LineWidth', 2)
ylabel('KS statistic')
xlabel('Time')





