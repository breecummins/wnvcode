function SetRandomSeed(randseed);
	
	% SET RANDOM SEED
	a=version;
	if str2num(a(1:3)) >= 7.7;
		RandStream.setDefaultStream(RandStream('mt19937ar','seed',randseed));
	else;
		rand('twister',randseed)
		randn('state',randseed) 
	end

	