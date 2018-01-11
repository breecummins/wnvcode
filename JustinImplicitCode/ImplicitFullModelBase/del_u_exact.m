%For this problem, we are assuming a homogeneous Neumann BC at
%the boundary points (the only points this function will be
%called for).
function [grad_u] = del_u_exact(x,y,t,b,nu)
  ux = zeros(size(x));
  uy = zeros(size(x));
  grad_u = [ux,uy];
end
