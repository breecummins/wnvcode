function S = SpreadToGrid2(x,y,h,s,szC,t)

	S = zeros(szC);

if mod(t,80) <10;
	%BILINEAR SPREAD
	j0 = fix(x/h)+1;  
	i0 = fix(y/h)+1;  

	rx = (x/h) - j0+1;  
	ry = (y/h) - i0+1; 

	N = length(x);
	for k = 1 : N
	   S(i0(k),j0(k))     = S(i0(k),j0(k))     + (1-rx(k))*(1-ry(k))*s;
	   S(i0(k),j0(k)+1)   = S(i0(k),j0(k)+1)   + rx(k)*(1-ry(k))*s;
	   S(i0(k)+1,j0(k))   = S(i0(k)+1,j0(k))   + (1-rx(k))*ry(k)*s;
	   S(i0(k)+1,j0(k)+1) = S(i0(k)+1,j0(k)+1) + rx(k)*ry(k)*s;
	end
end