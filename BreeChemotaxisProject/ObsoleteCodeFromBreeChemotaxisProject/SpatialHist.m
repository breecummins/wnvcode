%SpatialHist.m

clear
close all 

load ~/rsyncfolder/data/WNV/mosqrules.mat

descriptions_filename = {'Grad_pick_dir_and_spd','Grad_pick_dir_spd_fixed','Grad_pick_dir_spd_rand','Conc_dir_mem_pick_spd', 'Conc_dir_mem_spd_mem', 'Conc_dir_mem_spd_fixed', 'Conc_dir_mem_spd_rand','Conc_dir_rand_pick_spd','Diffusion', 'Bacterial_random' };

h=1/125;
NumMethods = 10;
L= 1;
Nm = 1000;
tSpace = 0.1;

%Gaussian for smoothing histogram
x = -16*h:h:16*h;
[xG,yG]=meshgrid(x,x);
G = exp(-xG.^2/(2*(2*h)^2) -yG.^2/(2*(2*h)^2));
G = G./sum(sum(G));

tvar = size(SpatialDistX,3);
Hist = zeros([size(C,1),size(C,2),NumMethods,tvar]);
SmoothedHist = zeros([size(C,1),size(C,2),NumMethods,tvar]);
for k = 9%NumMethods;
%for k =1:7;
	% figure
	% h1 = gcf;
	figure
	h2=gcf;
	front = ['~/rsyncfolder/data/WNV/',descriptions_filename{k}];
	for j1 = 1:tvar;
		% figure(h1)
		% subplot(2,tvar/2,j1)
		% hist3([SpatialDistX(:,k,j1),SpatialDistY(:,k,j1)],'Edges',{[0:h:L-h/2].',[0:h:L-h/2].'});
		% axis([0,1,0,1,0,max(max(Hist(:,:,k,j1)))+1])
		% title([descriptions_short{k},', t=', num2str(j1*tSpace)])
		Hist(:,:,k,j1)=hist3([SpatialDistX(:,k,j1),SpatialDistY(:,k,j1)],'Edges',{[0:h:L-h/2].',[0:h:L-h/2].'});
		A = conv2(Hist(:,:,k,j1),G,'same');
		if abs(sum(sum(A))-Nm) > 1;
			disp( 'Convolution isn''t working right.')
			disp(descriptions_filename{k}), disp(['time ',num2str(j1*tSpace)]), disp(sum(sum(A))), disp(Nm)
		end
		figure(h2)
		% subplot(2,tvar/2,j1)
		SmoothedHist(:,:,k,j1) = A.';
	end
	for j1 = 1:tvar;
		mesh([0:h:L-h/2].',[0:h:L-h/2].',SmoothedHist(:,:,k,j1));%+max(max(n)))
		axis([0,1,0,1,0,1.1*max(max(max(SmoothedHist(:,:,k,:))))])
		title(['t=', num2str(j1*tSpace)])
		axis off
		colorbar
		
		str=sprintf('%03d',j1);  %make sure the index has 3 digits
        name=[front,str,'.jpg'];
        saveas(h2,name,'jpg');  %save the figure as a jpeg 
	end
end

