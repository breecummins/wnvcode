function [newx,newy,r] = moveMosquitoes(x,y,r);
	
	% This function updates the position of each mosquito. x and y contain the coordinates of the current positions of all of the mosquitoes. r is a structure containing parameters needed for the updating process.
	
	if r.rulenum < 10; %CO2 doesn't matter in diffusion = rule 10
		[C, mag, ang] = CO2(x,y);
		if r.dir == 't';
			dif = abs(C-r.memC);
		end	
	end
	
	%First pick the new direction...
	if r.dir == 'r'; %...randomly
		newdir = 2*pi*rand(r.Nm,1);
	elseif r.dir == 'g';  %....according to the gradient
		newdir = pickDirection(ang,r.minang,r.maxang,mag,r.thresh_dir,r.satrtn_dir,r.concav_dir);
	elseif r.dir == 't'; %....according to memory
		newdir = pickDirection(r.memang,r.minang,r.maxang,dif,r.thresh_dir,r.satrtn_dir,r.concav_dir);
		jnd = find(C-r.memC < 0);
		newdir(jnd) = newdir(jnd) -pi; %correct direction if the difference is negative
		r.memang = newdir; r.memC = C; %update mosquito memory
	end
	
	%Now pick the speed...
	if r.spd == 'f'; %...as always fixed at 1
		newspd = ones(r.Nm,1);
	elseif r.spd == 'r'; %...chosen randomly between limits
		newspd = r.minspd + (r.maxspd - r.minspd)*rand(r.Nm,1);
	elseif r.spd == 'g'; %....according to the gradient
		newspd = r.maxspd - (r.maxspd-r.minspd).*ResponseFunction(mag,r.thresh_spd,r.satrtn_spd,r.concav_spd);
	elseif r.spd == 't'; %...according to memory
		newspd = r.maxspd - (r.maxspd-r.minspd).*ResponseFunction(dif,r.thresh_spd,r.satrtn_spd,r.concav_spd); 
	elseif r.spd == 'c'; %...according to concentration
		newspd = r.maxspd - (r.maxspd-r.minspd).*ResponseFunction(C,r.thresh_spd,r.satrtn_spd,r.concav_spd);		
	end
		
	%Finally, move the mosquitoes....
	newx = x + newspd.*r.dt.*cos(newdir);
	newy = y + newspd.*r.dt.*sin(newdir);
		
		
		
		
		
		
		
	
	