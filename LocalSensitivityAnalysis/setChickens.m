function [xc,yc] = setChickens(p);
	
	%two groups of chickens
	x1center = p.chickLoc(1,1);
	y1center = p.chickLoc(1,2);
	x1spread = p.chickLoc(1,3);
	y1spread = p.chickLoc(1,4);
	
	[x1,y1] = placeChickens(x1center, y1center, x1spread, y1spread, p.Nc(1),p.host_radius);
	
	x2center = p.chickLoc(2,1);
	y2center = p.chickLoc(2,2);
	x2spread = p.chickLoc(2,3);
	y2spread = p.chickLoc(2,4);
	
	[x2,y2] = placeChickens(x2center, y2center, x2spread, y2spread, p.Nc(2),p.host_radius);
	
	xc = [x1;x2];  yc = [y1;y2];

	
end %function	


function [x,y] = placeChickens(xcenter, ycenter, xspread, yspread, Nchick,hostradius)
	
	
	%determine minimum acceptable distance between chickens (try to spread them out throughout the rectangle)
	mindist = min( min(xspread,yspread)/4, max(xspread,yspread)/(2*floor(Nchick/2))); % This is the smallest distance from the center of a cell to the edge of a cell in the specified rectangle. The cells are constructed to tile the rectangle. There are Nchick cells if Nchick is even, otherwise there are Nchick-1 cells.
	if mindist < hostradius;
		disp('Chickens may be closer together than the critical radius at which the mosquitoes are removed from the simulation:')
		disp(['Critical radius = ',num2str(hostradius)])
		disp(['Minimum allowable separation = ',num2str(mindist)])
	end
		
	% initial guesses for postions
	x = xcenter - xspread/2 + xspread*rand(Nchick,1);
	y = ycenter - yspread/2 + yspread*rand(Nchick,1);
	
	%spread out the initial postions if needed
	for k = 1:length(x);
		dist = sqrt((x(k)-x).^2 + (y(k) - y).^2);
		dist = [dist(1:k-1);dist(k+1:end)];
		iter = 0;
		while (any(dist < mindist)) && (iter < 100);
			x(k) = xcenter - xspread/2 + xspread*rand;
			y(k) = ycenter - yspread/2 + yspread*rand;
			dist = sqrt((x(k)-x).^2 + (y(k) - y).^2);
			dist = [dist(1:k-1);dist(k+1:end)];
			iter = iter +1;
		end
		if iter == 100;
			disp(['Chicken ',int2str(k),' may be too close to another chicken.'])
			disp(dist)
		end
	end	

end %function

