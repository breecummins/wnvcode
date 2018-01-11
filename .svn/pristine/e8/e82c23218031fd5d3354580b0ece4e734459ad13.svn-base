function [xm,ym,count,lost, mem] = MoveMosquitoes(xm,ym,tMosq,V1p,V1m,V2p,V2m,C,Cxp,Cxm,Cyp,Cym,h,L,xc,yc,count,lost,mem, wind_mode,Vmag);
	
    %wind_mode is an optional argument, check for it
    if exist('wind_mode','var') == 0
        wind_mode = 1;
    end
    CO2_threshold = 1e-3; %Randomly chosen value

	% FIND THE WIND VELOCITY AT THE MOSQUITO LOCATIONS
	V1 = V1p + V1m; V2 = V2p + V2m;
	um = InterpFromGrid(xm,ym,V1,h, V1Parametric(xm,ym,Vmag));
	vm = InterpFromGrid(xm,ym,V2,h, V2Parametric(xm,ym,Vmag));
	vmag = sqrt( um.^2 + vm.^2 );


	% MAGNITUDE OF WIND VELOCITY AFFECTS THE DIRECTION
	theta0v = atan2(vm,um); 
    maxVmag = max(max(sqrt(V1.^2 + V2.^2)));
    alphaMinv = pi*1/6;  alphaMaxv = pi/2;
    thetav = pickDirection(theta0v,alphaMinv,alphaMaxv,vmag,maxVmag);

    %Check for CO2 thresholding, downwind models use this
    %to travel upwind under certain CO2 concentration values
    CO2_value = InterpFromGrid(xm, ym, C, h);
    direction = CO2_value > CO2_threshold;
    
    %Two-state wind speed system. If the mosquito is in a long
    %range searching state, constant speed. If it is actively
    %seeking a CO2 source, vary the wind speed w.r.t. absolute
    %CO2 concentration. This will help prevent the wind factor
    %overpowering the effect of the CO2 factor for larger CO2 values.
    maxC = max(max(C));
    spdMin = .25;
    spdMax = 1.5;
    spd = pickSpeed(spdMin,spdMax,CO2_value,maxC);
    ind = find(direction==0);
    spd(ind) = spdMax.*ones(size(ind));
    

    if (wind_mode == 1) %Upwind Movement
        vxm = -tMosq.*spd.*cos(thetav);
        vym = -tMosq.*spd.*sin(thetav);
    elseif (wind_mode == 2) %Downwind Movement
    	vxm = ((-1).^direction).*spd.*tMosq.*cos(thetav);
        vym = ((-1).^direction).*spd.*tMosq.*sin(thetav);
    elseif (wind_mode == 3) %Crosswind Movement with upwind bias
        for counter = 1:length(mem(:,1))
            if (mem(counter,1) == 0)
                mem(counter,2) = -mem(counter,2);
                mem(counter,1) = 150+ceil(rand*25);
            end
        end
        mem(:,1) = mem(:,1)-1; %%decrement the timers
        thetav = thetav + ((pi/4)*mem(:,2)).*(0.^direction);
        vxm = -tMosq.*spd.*cos(thetav);
        vym = -tMosq.*spd.*sin(thetav);
    elseif (wind_mode == 4) %Crosswind movement with downwind bias
        for counter = 1:length(mem(:,1))
            if (mem(counter,1) == 0)
                mem(counter,2) = -mem(counter,2);
                mem(counter,1) = 150+ceil(rand*25);
            end
        end
        mem(:,1) = mem(:,1)-1; %%decrement the timers
        thetav = thetav + ((pi/4)*mem(:,2)).*(0.^direction);
        
    	vxm = ((-1).^direction).*spd.*tMosq.*cos(thetav);
        vym = ((-1).^direction).*spd.*tMosq.*sin(thetav);
    elseif (wind_mode == 5) %Crosswind only
        for counter = 1:length(mem(:,1))
            if (mem(counter,1) == 0)
                mem(counter,2) = -mem(counter,2);
                mem(counter,1) = 50+ceil(rand*25);
            end
        end
        mem(:,1) = mem(:,1)-1; %%decrement the timers
        thetav = thetav + ((pi/2)*mem(:,2)).*(0.^direction);
        
    	vxm = ((-1).^direction).*spd.*tMosq.*cos(thetav);
        vym = ((-1).^direction).*spd.*tMosq.*sin(thetav);
    end

	% MAKE THE CO2 GRADIENT
	dCdx = (Cxp-Cxm)/(2*h);
	dCdy = (Cyp-Cym)/(2*h);
	
	gradxm = InterpFromGrid(xm,ym,dCdx,h);
	gradym = InterpFromGrid(xm,ym,dCdy,h);
	gradmag = sqrt( gradxm.^2 + gradym.^2 );

	% MAGNITUDE OF GRADIENT AFFECTS THE DIRECTION
	theta0 = atan2(gradym,gradxm);
    maxGradmag = max(max(sqrt(dCdx.^2 + dCdy.^2)));
    alphaMin = pi*1/6;  alphaMax = pi;
    theta = pickDirection(theta0,alphaMin,alphaMax,gradmag,maxGradmag);
    % Vary the speed of the mosquitoes according to the absolute
    % concentration
    spd = pickSpeed(spdMin,spdMax,CO2_value,maxC);



	cxm = tMosq.*spd.*cos(theta);
	cym = tMosq.*spd.*sin(theta);

	
	% MOVE THE MOSQUITOES USING WIND, CO2 GRADIENT
	bet=1/2; del=1/2; %weights
	sp = bet + del;
    
    %Calculate the weights on an individual agent basis to account
    %for CO2 thresholding
    bet_ind = bet+not(direction)*del;
    del_ind = del-not(direction)*del;
	
	xdir = (bet_ind.*vxm + del_ind.*cxm)/sp + um*tMosq; %last term is an approximation to the velocity field over the tMosq time period -- vel dir may have changed in there
	ydir = (bet_ind.*vym + del_ind.*cym)/sp + vm*tMosq;
	
	xm = xm + xdir;
	ym = ym + ydir;
 
	
	% REMOVE THE MOSQUITOES WHO FIND A HOST
	rad = h; ind =[];
	for k = 1:length(xm);
		dist = sqrt( (xc - xm(k)).^2 + (yc - ym(k)).^2 );
		if all(dist > rad);
			ind(end+1) =k;
		else;
			jnd = find(dist == min(dist(find(dist <= rad))));
			count(jnd)=count(jnd)+1;
		end
	end
	xm = xm(ind); ym = ym(ind);
    mem = mem(ind,:);
 	xdir = xdir(ind); ydir = ydir(ind);
    
   %  % REMOVE THE MOSQUITOES WHO LEAVE THE BOX AFTER PASSING THE CHICKENS
   % xvel = mean(mean(V1)); yvel = mean(mean(V2));
   % if yvel > 1.e-5;
   %     	ind = find(ym > h/2); 
   %      if length(ind)~=length(xm);
   %          dif = length(xm)-length(ind);
   %      	xm=xm(ind); ym=ym(ind); 
   %       	xdir = xdir(ind); ydir = ydir(ind);
   %         	lost=lost+dif;
   %      end
   %  elseif yvel < -1.e-5;
   %      ind = find(ym < L-h/2); 
   %  	if length(ind)~=length(xm);
   %    		dif = length(xm)-length(ind);
   %         	xm=xm(ind); ym=ym(ind); 
   %          xdir = xdir(ind); ydir = ydir(ind);
   %  		lost=lost+dif;
   %      end
   % 		
   %  end	
   % 
   %  if xvel > 1.e-5;
   %     	ind = find(xm > h/2); 
   %      if length(ind)~=length(xm);
   %          dif = length(xm)-length(ind);
   %      	xm=xm(ind); ym=ym(ind); 
   %     	 	xdir = xdir(ind); ydir = ydir(ind);
   %         	lost=lost+dif;
   %      end
   %  elseif xvel < -1.e-5;
   %      ind = find(xm < L-h/2); 
   %      if length(ind)~=length(xm);
   %      	dif = length(xm)-length(ind);
   %         	xm=xm(ind); ym=ym(ind); 
   %          xdir = xdir(ind); ydir = ydir(ind);
   %  		lost=lost+dif;
   %      end
   %  end	
    
	% KEEP THE OTHER MOSQUITOES IN BOUNDS IN CASE THEY STEP OUT OF THE BOX
%    idxj = find( ym>L-h ); if isempty(idxj)==0, ym(idxj) = ym(idxj)-ydir(idxj); end
 %   idxj = find( ym<h );   if isempty(idxj)==0, ym(idxj) = ym(idxj)-ydir(idxj); end
  %  idxi = find( xm>L-h ); if isempty(idxi)==0, xm(idxi) = xm(idxi)-xdir(idxi); end
   % idxi = find( xm<h );   if isempty(idxi)==0, xm(idxi) = xm(idxi)-xdir(idxi); end

	
	
	