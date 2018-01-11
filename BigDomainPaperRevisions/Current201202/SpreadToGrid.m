function S = SpreadToGrid(x,y,h,s,szC)

%BILINEAR SPREAD (this depends on the lower left corner being zero)
j0 = fix((x-h/2)/h)+1; %shifted for cell centered grid
i0 = fix((y-h/2)/h)+1;

rx = ((x-h/2)/h) - j0+1;
ry = ((y-h/2)/h) - i0+1;

N = length(x);
S = zeros(szC);
for k = 1 : N
   S(i0(k),j0(k))     = S(i0(k),j0(k))     + (1-rx(k))*(1-ry(k))*s;
   S(i0(k),j0(k)+1)   = S(i0(k),j0(k)+1)   + rx(k)*(1-ry(k))*s;
   S(i0(k)+1,j0(k))   = S(i0(k)+1,j0(k))   + (1-rx(k))*ry(k)*s;
   S(i0(k)+1,j0(k)+1) = S(i0(k)+1,j0(k)+1) + rx(k)*ry(k)*s;
end

