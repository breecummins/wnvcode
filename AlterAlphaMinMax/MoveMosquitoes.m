function [xm,ym,mem,results,tstart,Cmem,angmem] = MoveMosquitoes(xm,ym,mem,results,xc,yc,U,V,C,Cmem,angmem,p,t,tstart);
	
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% RESPONSE TO ABSOLUTE CO2
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % THRESHOLD CO2
    CO2_value = InterpFromGrid(xm, ym, C, p.h);
    direction = (CO2_value >= p.CO2_thresh);
    
    % FLYING SPEED IS MAXIMUM BELOW CO2 THRESHOLD, SLOWER ABOVE.
    spd = p.spdMax - (p.spdMax-p.spdMin).*ResponseFunction(CO2_value,p.CO2_thresh,p.CO2_sat,p.CO2_kappa);
    ind = find(direction==0);
    spd(ind) = p.spdMax.*ones(size(ind));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% RESPONSE TO CO2 COMPARED TO MEMORY
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% COMPARE TO OLD CO2 VALUE
	dif = abs(CO2_value - Cmem);
	% BIASED TO GO IN PREVIOUS DIRECTION IF CO2 INCREASES
    theta = pickDirection(angmem,p.Cdirmin,p.Cdirmax,dif,p.dif_thresh,p.dif_sat,p.dif_kappa);
	jnd = find(CO2_value - Cmem < 0);
	theta(jnd) = theta(jnd) -pi; %correct direction if the difference is negative
	Cmem = CO2_value; %update mosquito memory
	
	% CALCULATE MOSQ RESPONSE TO CO2 COMPARISON.
	cxm = p.tMosq.*spd.*cos(theta);
	cym = p.tMosq.*spd.*sin(theta);
	
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% RESPONSE TO WIND
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% FIND THE WIND DIRECTION AT THE MOSQUITO LOCATIONS (WITH SENSORY ERROR).
	um = InterpFromGrid(xm,ym,U,p.h, eval(['V1Parametric',p.vfunc,'(xm,ym,p.Vmag,t)']));
	vm = InterpFromGrid(xm,ym,V,p.h, eval(['V2Parametric',p.vfunc,'(xm,ym,p.Vmag,t)']));
	vmag = sqrt( um.^2 + vm.^2 );
	theta0v = atan2(vm,um); 
    thetav = pickDirection(theta0v,p.Vdirmin,p.Vdirmax,vmag,p.wind_thresh,p.wind_sat,p.wind_kappa);

 	% UPDATE TIMERS FOR CROSSWIND RANGING BEHAVIOR
	if p.wind_mode > 2; 
		 for counter = 1:length(mem(:,1))
	         if (mem(counter,1) == 0)
	             mem(counter,2) = -mem(counter,2);
	            mem(counter,1) = CWDuration(p);
	         end
	     end
	     mem(:,1) = mem(:,1)-1; %%decrement the timers
	end
		
	% USE RANGING FLIGHT BEHAVIOR TO CALCULATE RESPONSE TO WIND. WHEN CO2 >= THRESH, ALL FLIGHT IS UPWIND.
	if (p.wind_mode == 1) %Upwind Movement
		target_angle = thetav+pi;
	 elseif (p.wind_mode == 2) %Downwind Movement
		target_angle = thetav + pi.*direction;
	 elseif (p.wind_mode < 5) %Crosswind Movement with bias
	    target_angle = thetav + ((pi/4)*mem(:,2)).*not(direction) + pi.*direction; %FIXME -- I'm not sure this works for both upwind and downwind bias.
	 elseif (p.wind_mode == 5) %Crosswind only
	     target_angle = thetav + ((pi/2)*mem(:,2)).*not(direction) + pi.*direction;
 	 end
	 vxm = p.tMosq.*spd.*cos(target_angle);
     vym = p.tMosq.*spd.*sin(target_angle);
    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% COMBINE RESPONSES
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SCALE RELATIVE IMPORTANCE OF WIND AND CO2 GRADIENT FOR CHOOSING DIRECTION.
    windscaling = p.windweight+not(direction)*p.gradweight;
    gradscaling = p.gradweight-not(direction)*p.gradweight;
	
	% MOVE THE MOSQUITOES USING WIND AND CO2 GRADIENT AND PASSIVE ADVECTION
	xdir = windscaling.*vxm + gradscaling.*cxm + um*p.tMosq; 
	ydir = windscaling.*vym + gradscaling.*cym + vm*p.tMosq;
	xm = xm + xdir;
	ym = ym + ydir;
	angmem = atan2(ydir,xdir); %update mosquito memory
 
	
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% REMOVE THE MOSQUITOES WHO FIND A HOST
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	ind =[];
	for k = 1:length(xm);
		dist = sqrt( (xc - xm(k)).^2 + (yc - ym(k)).^2 );
		if all(dist > p.host_radius);
			ind(end+1) =k;
		else;
			jnd = find(dist == min(dist(find(dist <= p.host_radius))));
			results.whichchicken(end+1) = jnd;
			results.xmfinalpos(end+1) = xm(k);
			results.ymfinalpos(end+1) = ym(k);
			results.tmfinal(end+1) = t;
			results.tmentrance(end+1) = tstart(k);
		end
	end
	xm = xm(ind); ym = ym(ind); mem = mem(ind,:); tstart = tstart(ind); angmem = angmem(ind); Cmem = Cmem(ind);
	
	
	
	