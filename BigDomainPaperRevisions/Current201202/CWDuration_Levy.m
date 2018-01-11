function dur = CWDuration_Levy(avgDur,n)
	
	mapnum = 0.06 + (1-0.06)*rand(n,1); %rand gives a value in (0,1) open -- no problem with tangent in next line
	dur = round(avgDur + tan(pi*(mapnum - 0.5)));
	    