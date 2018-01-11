function [xc,yc] = setChickensConstantDensity(p);
	
	xc = []; yc=[];
	for g = 1:length(p.Nc);
		% Group 1
		[x1,y1] = placeChickens(p.chickBoxCenter(g,1), p.chickBoxCenter(g,2), p.chickBoxLength(g), p.chickBoxWidth(g), p.Nc(g), p.minChickDist);
		
		xc=[xc;x1];
		yc=[yc;y1];	
	end
	
	function [x,y] = placeChickens(xcenter, ycenter, xsidelen, ysidelen, Nchick, minSep)

		% initial guesses for postions
		x = xcenter - xsidelen/2 + xsidelen*rand(Nchick,1);
		y = ycenter - ysidelen/2 + ysidelen*rand(Nchick,1);

		%spread out the initial postions if needed
		if Nchick > 1;
			for k = 1:length(x);
				dist = sqrt((x(k)-x).^2 + (y(k) - y).^2);
				dist = [dist(1:k-1);dist(k+1:end)];
				iter = 0;
				while (any(dist < minSep)) && (iter < 50000);
					x(k) = xcenter - xsidelen/2 + xsidelen*rand;
					y(k) = ycenter - ysidelen/2 + ysidelen*rand;
					dist = sqrt((x(k)-x).^2 + (y(k) - y).^2);
					dist = [dist(1:k-1);dist(k+1:end)];
					iter = iter +1;
				end
				if iter == 50000;
					disp(['Chicken ',int2str(k),' may be too close to another chicken.'])
					disp(min(dist))
				end
			end	
		end

	end %function
end %function