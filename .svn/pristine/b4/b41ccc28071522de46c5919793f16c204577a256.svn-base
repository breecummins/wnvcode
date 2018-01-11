%SpatialStatistics.m

clear
close all

cumf=0;

load ~/rsyncfolder/data/WNV/mosqrules.mat

if cumf == 1; 

	%Compare the spatial distributions of mosquitoes at different times using Fasano and Franceschini's alteration of Peeacock's method.

	CumDistFuncsll = zeros(size(SpatialDistX));
	CumDistFuncslg = zeros(size(SpatialDistX));
	CumDistFuncsgl = zeros(size(SpatialDistX));
	CumDistFuncsgg = zeros(size(SpatialDistX));

	n = size(SpatialDistX,1);

	for k1 = 1:size(SpatialDistX,3);
		for j1 = 1:size(SpatialDistX,2);
			tic
			x = SpatialDistX(:,j1,k1);
			y = SpatialDistY(:,j1,k1);
		
			[fll, flg, fgl, fgg] = KS2DCumDist(x,y);
		
			CumDistFuncsll(:,j1,k1)=fll;		
			CumDistFuncslg(:,j1,k1)=flg;		
			CumDistFuncsgl(:,j1,k1)=fgl;
			CumDistFuncsgg(:,j1,k1)=fgg;		
			toc
		end
	end
		
	save ~/rsyncfolder/data/WNV/mosqrulestats.mat CumDistFuncs* 

	figure;
	plot3(x,y,fll,'.')
	figure;
	plot3(x,y,flg,'.')
	figure;
	plot3(x,y,fgl,'.')
	figure;
	plot3(x,y,fgg,'.')
else;
	load ~/rsyncfolder/data/WNV/mosqrulestats.mat
end


% find D_KS for interesting comparisons
sig=zeros(size(SpatialDistX,2),size(SpatialDistX,2),0);
D_KS=sig;Z_n=sig;
for k1 = 1:size(SpatialDistX,3);
	for j1 = 1:size(SpatialDistX,2);
		Fll = CumDistFuncsll(:,j1,k1);
		Flg = CumDistFuncslg(:,j1,k1);
		Fgl = CumDistFuncsgl(:,j1,k1);
		Fgg = CumDistFuncsgg(:,j1,k1);
		for l1 = 1:size(SpatialDistX,2);
			% if l1 == j1;
			% 	continue
			% end
			fll = CumDistFuncsll(:,l1,k1);
			flg = CumDistFuncslg(:,l1,k1);
			fgl = CumDistFuncsgl(:,l1,k1);
			fgg = CumDistFuncsgg(:,l1,k1);
			[sig(l1,j1,k1), D_KS(l1,j1,k1), Z_n(l1,j1,k1)] = KS2DGetSig([Fll,Flg,Fgl,Fgg],[fll,flg,fgl,fgg]);
			
		end
	end
end

save ~/rsyncfolder/data/WNV/mosqrulestats.mat sig D_KS Z_n -append 	

		
		
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%		
% %PEACOCK METHOD -- TAKES TOO LONG TOO BE USEFUL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % for k1 = 1:size(SpatialDistX,3);
% k1=1;
% 	%for j1 = 1:size(SpatialDistX,2);
% 	j1 = 1;
% 		x = SpatialDistX(:,j1,k1);
% 		[x,ind] = sort(x);
% 		y = SpatialDistY(:,j1,k1);
% 		y=y(ind);
% 		ys = sort(y);
% 		n = length(x);
% 		f = zeros(n,n);
% 		count = 0;
% 		for a = 1:n;
% 			for b = 1:n;
% 				for c = 1:(a-1); 
% 					if y(c) < ys(b);
% 						f(a,b) = f(a,b) +1;
% 					end
% 					count = count+1;
% 					if mod(count,10000000) == 0;
% 						disp(count)
% 					end
% 				end
% 			end
% 		end
% 		f=f./n;
% 		max(max(f))
% 		figure
% 		imagesc(f)
% 		
% 	%end
% % end

