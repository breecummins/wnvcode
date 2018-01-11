%Wilcoxontest.m

clear
close all

nd = 0;
bm = 1;

N=5000;
[avg,stddev] = NormalApproxForRankSumTest(N,N);

%normal distribution
if nd;
	r1 = [10+1*randn(N,1), 10.1+1*randn(N,1),10.2+1.1*randn(N,1),10.3+1.1*randn(N,1), 10.4+1.2*randn(N,1), 10.3+1.2*randn(N,1),10.2+1.3*randn(N,1), 10.1+1.3*randn(N,1), 10+1.4*randn(N,1), 9.7+1.4*randn(N,1),9.5+1.4*randn(N,1), 9.3+1.6*randn(N,1),9+1.7*randn(N,1), 8.5+1.8*randn(N,1), 8+2.0*randn(N,1), 7+2.2*randn(N,1), 6+2.2*randn(N,1), 5+2.3*randn(N,1), 4+2.4*randn(N,1), 3+2.5*randn(N,1),2.5+2.6*randn(N,1), 2.2+2.7*randn(N,1), 2+2.8*randn(N,1), 1.9+2.9*randn(N,1), 1.85+3.0*randn(N,1), 1.825+3*randn(N,1), 1.82+3*randn(N,1), 1.82+3*randn(N,1), 1.82+3*randn(N,1), 1.825+3*randn(N,1), 1.82+3*randn(N,1), 1.82+3*randn(N,1), 1.82+3*randn(N,1)];


	for shift = [0,0.001,0.01,0.1,0.2,0.3,0.4,0.5];
		t=['Mean shifted by ',num2str(shift)];
	
		r2 = [10+1*randn(N,1), 10.1+1*randn(N,1),10.2+1.1*randn(N,1),10.3+1.1*randn(N,1), 10.4+1.2*randn(N,1), 10.3+1.2*randn(N,1),10.2+1.3*randn(N,1), 10.1+1.3*randn(N,1), 10+1.4*randn(N,1), 9.7+1.4*randn(N,1),9.5+1.4*randn(N,1), 9.3+1.6*randn(N,1),9+1.7*randn(N,1), 8.5+1.8*randn(N,1), 8+2.0*randn(N,1), 7+2.2*randn(N,1), 6+2.2*randn(N,1), 5+2.3*randn(N,1), 4+2.4*randn(N,1), 3-shift+2.5*randn(N,1),2.5-shift+2.6*randn(N,1), 2.2-shift+2.7*randn(N,1), 2-shift+2.8*randn(N,1), 1.9-shift+2.9*randn(N,1), 1.85-shift+3.0*randn(N,1), 1.825-shift+3*randn(N,1), 1.82-shift+3*randn(N,1), 1.82-shift+3*randn(N,1), 1.82-shift+3*randn(N,1), 1.825-shift+3*randn(N,1), 1.82-shift+3*randn(N,1), 1.82-shift+3*randn(N,1), 1.82-shift+3*randn(N,1)];

		figure
		errorbar(mean(r1,1),std(r1,1)) 
		hold on
		errorbar(mean(r2,1),std(r2,1),'r')
		title(t) 

		U=[];
		for s = 1:size(r1,2);
			U(end+1) = WilcoxonRankSum(r1(:,s),r2(:,s));
		end

		zscore = (U - avg)./stddev;
		figure
		plot(zscore)
		hold on 
		plot(2.575*ones(size(zscore)),'k','LineWidth',2)
		plot(1.96*ones(size(zscore)),'r','LineWidth',2)
		plot(-2.575*ones(size(zscore)),'k','LineWidth',2)
		plot(-1.96*ones(size(zscore)),'r','LineWidth',2)
		title(t)
	end
end

%bimodal distribution
if bm;
	
	a1 = 8; mu1 = 0.7; b1 = a1*(1/mu1 - 1);
	a2 = 10; mu2 = 0.1; b2 = a2*(1/mu2 - 1);
	
	%plot the beta distributions
	% x=0:0.001:1;
	% y1 = betapdf(x,a1,b1);
	% y2 = betapdf(x,a2,b2);
	% plot(x,y1,'b',x,y2,'r')
	
	num = [0,0,2,3,5,6,8,8,10,20,50,125,345,742,1112,1866,2441,3015,3892,4357,4697,4782,4831,4848,4857,4860,4862,4865,4865];
	r1 =[];
	
	for k = 1:length(num);
		N2 = num(k);
		N1 = N - N2;
		r1(:,k) = [betarnd(a1,b1,[N1,1]); betarnd(a2,b2,[N2,1])];
	end
	
	v2 = a2*b2/((a2+b2)^2*(a2+b2+1));
	
	for shift = 0.004;
		t=['Lower mean shifted down by ',num2str(shift), '. Variance same.'];
		
		mu3 = mu2 - shift;
		a3 = mu3*(mu3*(1-mu3)/v2 - 1); b3 = a3*(1/mu3 - 1);
		
		figure
		%plot the beta distributions
		x=0:0.001:1;
		y1 = betapdf(x,a1,b1);
		y2 = betapdf(x,a2,b2);
		plot(x,y1,'k',x,y2,'b')
		title('Beta distributions')
		xlabel('distance')
		ylabel('pdf')
		
		figure
		y2 = betapdf(x,a2,b2);		
		y3 = betapdf(x,a3,b3);
		plot(x,y2,'b',x,y2,'b',x,y3,'r')
		title('Original and shifted lower distributions.')
		xlabel('distance')
		ylabel('pdf')
				
		r2=[];
		for k = 1:length(num);
			N2 = num(k);
			N1 = N - N2;
			r2(:,k) = [betarnd(a1,b1,[N1,1]); betarnd(a3,b3,[N2,1])];
		end

		figure
		errorbar(mean(r1,1),std(r1,1)) 
		hold on
		errorbar(mean(r2,1),std(r2,1),'r') 
		title(t)
		xlabel('time')
		ylabel('Mean distance (and std) of 5000 samples')
		

		U=[];
		for s = 1:size(r1,2);
			U(end+1) = WilcoxonRankSum(r1(:,s),r2(:,s));
		end

		zscore = (U - avg)./stddev;
		figure
		plot(zscore)
		hold on 
		plot(2.575*ones(size(zscore)),'k','LineWidth',2)
		plot(1.96*ones(size(zscore)),'r','LineWidth',2)
		plot(-2.575*ones(size(zscore)),'k','LineWidth',2)
		plot(-1.96*ones(size(zscore)),'r','LineWidth',2)
		title(t)
		xlabel('time')
		ylabel('z-score')
		
		
	end
	
	
end


















