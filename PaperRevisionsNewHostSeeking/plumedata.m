function [pwidth, plen] = plumedata(c,p,Np);	
	% c is an edited contour matrix, p is a parameter structure, Np is the number of test points
	[ctmp1,js] = sort(c(1,:)); %sort the x values from smallest to largest
	ctmp2 = c(2,js); %match up the correct y-values
	plen = p.L - min(ctmp2); %the length of the plume is the domain length less the smallest y distance meeting threshold
	pd = [];
	for m = 1:Np;
		pd(m,:) = abs(ctmp2(m) - ctmp2(end-Np+1:end)); % calculate the y distances between the Np smallest x-values and the Np largest x values (constructing possibilities for plume width).
	end
	[inds,jnds] = find(pd<p.h); %if two y values are within h, we say they are the same point, and thus their x values can be compared
	if ~isempty(inds);
		jnds = length(ctmp2)-Np + jnds; %shift to get to the largest values
		bd = abs(ctmp1(inds)-ctmp1(jnds)); % of all the matching y-values, pick the biggest spread in x-distance. this is the plume width.
		pwidth = max(bd);
	else;
		error('Cannot get plume width.') % if this error pops up, pick more than Np smallest and largest values.
	end
end %function	
