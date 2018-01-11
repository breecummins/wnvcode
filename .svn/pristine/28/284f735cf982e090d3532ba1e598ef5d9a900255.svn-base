function [xm,ym,tm,tMosq,tReport, mem] = setMosquitoes(L,h,T,dt,wind_mode);
	
    %wind_mode is an optional argument, check for it
    if exist('wind_mode','var') == 0
        wind_mode = 1;
    end

	Nm = 200; %NUMBER OF MOSQUITOES
    %Calculate the initial location of the mosquitoes based on their
    %wind-dedendent behavior
    if (wind_mode == 1 || wind_mode == 3)
        %Start at the top for upwind movement
    	[xm,ym] = PlacePoints(Nm,[0 1]*L,[L-2*h,L-2*h],L,h); %entrance location
    elseif (wind_mode == 2 || wind_mode > 3)
        %Start at the bottom for downwind movement
        [xm,ym] = PlacePoints(Nm,[0 1]*L,[2*h,2*h],L,h); %entrance location
    end
	tm = PlacePoints(Nm,[2 2.5],[0,0],T,dt,'n'); %entrance time
	tm = sort(tm);
	
	tMosq = 1/100;  
	tReport = tMosq*100;
    
    %Memory for cross-wind movement
    mem = zeros(Nm,2);
    mem(:,1) = 50+ceil(rand(Nm,1)*25);
    mem(:,2) = sign(rand(Nm,1)-.5);