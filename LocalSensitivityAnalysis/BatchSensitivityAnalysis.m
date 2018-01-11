function [inputs, outputs, rmbase, rmhigh, rmlow, data0, datah, datal] = BatchSensitivityAnalysis(varname,windmode,basedir);
	
	% input = simulation results (varname = 'string': the variable being varied, windmode = integer: the ranging flight behavior code, basedir = 'string', pathname to folder with simulation results)
	% output = local sensitivity analysis
	
	% find all files needed for the analysis
	wname = WindName(windmode);
	basefname = fullfile(basedir,[wname,'_basevalue.mat']);
	highfname = fullfile(basedir,[wname,'_',varname,'_higher.mat']);
	lowfname = fullfile(basedir,[wname,'_',varname,'_lower.mat']);
	
	% calculate the outputs for each set of simulations 
	[p0,data0] = loopOverStruct(basefname);
	[ph,datah] = loopOverStruct(highfname);
	[pl,datal] = loopOverStruct(lowfname);
		
	% calculate the running mean over ensemble (only the last row used in calculations, but this shows the convergence to the means over the simulations)
	rmbase = runningMean(data0);
	rmhigh = runningMean(datah);
	rmlow = runningMean(datal);
	
	% record inputs
	inputs = eval(['[pl.',varname,'; p0.',varname,'; ph.',varname,']']);
	
	% sensitivity
	vardif = inputs(3,:) - inputs(1,:); %difference between high and low parameter values
	SI = mean(inputs(2,:)).*(rmhigh(end,:)-rmlow(end,:))./mean(vardif); % center difference scaled by the base input
	SIplus = mean(inputs(2,:)).*(rmhigh(end,:)-rmbase(end,:))./(mean(vardif)/2);
	SIminus = mean(inputs(2,:)).*(rmbase(end,:)-rmlow(end,:))./(mean(vardif)/2);
	SIerr = abs(SIplus - SIminus)/2;
	
	% put the summary data together
	outputs = [rmlow(end,:); rmbase(end,:); rmhigh(end,:); SI; SIerr];

end %function


function checkParams(p0,p);
	if ~(p0.Nm == p.Nm) || ~all(p0.Nc == p.Nc);
		error('Either number of mosquitoes or number of chickens is not the same between simulations. Construct different outputs -- aborting.')
	end	
end %function


function [p,data] = loopOverStruct(fname);
	load(fname)
	numruns = length(fields(alloutput))/3;
	data=[];
	for k =1:numruns;
		r = eval(['alloutput.results',sprintf('%02d',k)]);
		data(k,:) = getSensitivityData(r,p);
	end
end %function

		
function rm = runningMean(data);
	rm=zeros(size(data));
	rm(1,:) = data(1,:);
	for k = 2:size(data,1);
		rm(k,:) = mean(data(1:k,:),1);
	end
end %function	

	
	
	
	