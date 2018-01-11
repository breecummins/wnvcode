function [xm,ym,tm,mem] = setMosquitoes(p);
	
    % INITIAL MOSQ POSITIONS
    if (p.wind_mode == 1 || p.wind_mode == 3)
        %Start at the top for upwind movement
    	[xm,ym] = PlacePoints(p.Nm,[0 1]*p.L,[p.L-2*p.h,p.L-2*p.h],p.L,p.h); %entrance location
    elseif (p.wind_mode == 2 || p.wind_mode > 3)
        %Start at the bottom for downwind or crosswind movement
        [xm,ym] = PlacePoints(p.Nm,[0 1]*p.L,[2*p.h,2*p.h],p.L,p.h); %entrance location
    end

	% MOSQ ENTRANCE TIMES
	tm = PlacePoints(p.Nm,p.entrytimerange,[0,0],p.Tf,p.dt,'n'); %entrance time
	tm = sort(tm);
	
	% MEMORY FOR CROSS-WIND MOVEMENT
    mem = zeros(p.Nm,2);
	if p.wind_mode >2;
	    mem(:,1) = CWDuration(p);
	    mem(:,2) = sign(rand(p.Nm,1)-.5);
	end

