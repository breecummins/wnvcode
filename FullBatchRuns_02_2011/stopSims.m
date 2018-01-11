function [recordmeans,currentmaxsims,flag]=stopSims(snum,minsims,maxsims,stopcritcst,results,p,recordmeans,currentmaxsims);
	
	data = getSensitivityData(results,p);
	recordmeans(end+1,:) = mean(data,1);
	if snum >= minsims+5;
		rm0 = mean(recordmeans,1);
		rm1 = mean(recordmeans(1:end-1,:),1);
		rm2 = mean(recordmeans(1:end-2,:),1);
		rm3 = mean(recordmeans(1:end-3,:),1);
		rm4 = mean(recordmeans(1:end-4,:),1);
		rm5 = mean(recordmeans(1:end-5,:),1);
		dif1 = abs(rm0 - rm1); dif2 = abs(rm0 - rm2); dif3 = abs(rm0-rm3);
		if all(dif1 <= stopcritcst*rm0) && all(dif2 <= stopcritcst*rm0) && all(dif3 <= stopcritcst*rm0);
			currentmaxsims = max(currentmaxsims,snum);
			disp(['Convergence reached at simulation ', int2str(snum),'. Mean outputs are: '])
			disp(rm0)
			flag = 'done';
		elseif 	snum == maxsims;
			currentmaxsims = max(currentmaxsims,snum);
			disp(['Convergence not reached at simulation ', int2str(snum),'.'])
			disp('Last four mean outputs are: ')
			disp([rm0;rm1;rm2;rm3])
			flag = 'done';
		else;
			flag = 'goon';
		end
	else;
		flag = 'goon';
	end
	