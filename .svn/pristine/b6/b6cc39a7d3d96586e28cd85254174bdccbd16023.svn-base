function out = SSparamsets(rs,ps);
	
	%this function relates parameter index to the associated parameter values.
	%rs is the rule set number -- required since the param evaluation changes depending on the rule set
	%ps must be an integer in 1:132 or a 3-vector in the form of ps = [maxspd,minspd,minang]. out is an integer index if ps is a 3-vector and vice versa; this works only for WNVSixth Runs
	
	if length(ps) ~= 1 && length(ps) ~=3;
		error('Input argument not recognized. Must be an integer in [1,132] or a 3-vector with a known parameter set of the form [max speed, min speed, min angle].')
	end
	
	out = [];
	
	maxspd=	1.25:0.25:2;
	minspd=	0.25:0.25:0.75;
	minang=0:pi/12:10*pi/12;
	fixedspd = 1;
	randang = pi;	
	
	nmxs = length(maxspd);
	nmns = length(minspd);	
	nmna = length(minang);
	col1 = repmat(maxspd,nmns*nmna,1);
	col1 = col1(:);
	col2 = repmat(minspd,nmna,nmxs);
	col2 = col2(:);
	col3 = repmat(minang,1,nmxs*nmns).';
	pmat = [col1,col2,col3];
		
	if length(ps) == 1;
		try;
			out = pmat(ps,:);
		catch;
			disp('Match not found. Integer input arguments must be in the range [1,132].')
		end
		
		if rs == 3 || rs == 7 || rs == 10;
			out(1) = fixedspd;
			out(2) = fixedspd;
		end
		if rs == 9 || rs == 10;
			out(3) = randang;
		end
		
	elseif length(ps) == 3;
		if rs == 3 || rs == 7;
			out = find(round(pmat(:,3)*12/pi) == round(ps(3)*12/pi));
		elseif rs == 9;
			ind1 = find(pmat(:,1) == ps(1));
			ind2 = find(pmat(:,2) == ps(2));
			out = intersect(ind1,ind2);
		elseif rs == 10;
			out = 1:nmxs*nmns*nmna;
		else;
			ind1 = find(pmat(:,1) == ps(1));
			ind2 = find(pmat(:,2) == ps(2));
			ind3 = find(round(pmat(:,3)*12/pi) == round(ps(3)*12/pi));
			out = intersect(intersect(ind1,ind2),ind3);
		end
		if isempty(out);
			disp('Match not found. Vector input argument is an unknown parameter set.')
		end
	end
	
		
		
