function [data] = getSimResults_stop(fname,stoptime);

	load(fname);
	
	data=[];	
	for k=1:length(fieldnames(alloutput))/3;
		results = eval(['alloutput.results',sprintf('%02d',k)]);
		
		%mosquito data
		times = results.tmfinal - results.tmentrance;
		ind=find(times<=stoptime);
		newnumchicks = length(ind);
		data(k,1) = newnumchicks/p.Nm;
		data(k,2) = mean(times);
		
	end	
		
end %function
