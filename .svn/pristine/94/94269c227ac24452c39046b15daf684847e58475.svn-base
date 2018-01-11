function S = SpreadToGrid(x,y,C,h,U)

%BILINEAR SPREAD
j0 = fix(x/h)+1;  
i0 = fix(y/h)+1;  

rx = (x/h) - j0+1;  
ry = (y/h) - i0+1; 

N = length(x);
S = zeros(size(C));
for k = 1 : N
   S(i0(k),j0(k))     = S(i0(k),j0(k))     + (1-rx(k))*(1-ry(k))*U;
   S(i0(k),j0(k)+1)   = S(i0(k),j0(k)+1)   + rx(k)*(1-ry(k))*U;
   S(i0(k)+1,j0(k))   = S(i0(k)+1,j0(k))   + (1-rx(k))*ry(k)*U;
   S(i0(k)+1,j0(k)+1) = S(i0(k)+1,j0(k)+1) + rx(k)*ry(k)*U;
end

