function data = getSimResults_stop(fname,stoptime);

	try;
		load(fname);
	catch;
		disp([fname,' not found. Skipping...'])
		data=zeros(2,2); 
		return
	end
	
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
