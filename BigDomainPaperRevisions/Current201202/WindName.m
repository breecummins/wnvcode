function wname = WindName(windmode);
	
	if windmode == 1;
        wname = 'Upwind';
    elseif windmode == 2;
        wname = 'Downwind';
    elseif windmode == 3; 
        wname = 'CrossUp';
    elseif windmode == 4;
        wname = 'CrossDown';
    elseif windmode == 5;
        wname = 'Crosswind';
    else;
        error(['Wind behavior ',num2str(windmode),' not recognized.'])
    end
    