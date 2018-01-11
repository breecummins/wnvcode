function r = implicit_RHS_exact_grad(x,dt,h,nu,C_width,C_height,l_bounds,r_bounds,t_bounds,b_bounds,t)
  %Implicitly define our diffusion operator on a given vector.
  alpha = nu*dt/(2*h^2);
  r = NaN(size(x));
  
  %This next chunk of code defines each row in our diffusion
  %operator.
  
  %Handle LL corner case
  r(1) = (1-2*alpha)*x(1) + alpha*x(2) + alpha*x(C_width+1);
  %Handle LR corner case
  r(C_width) = (1-2*alpha)*x(C_width) + alpha*x(C_width-1) + alpha*x(2*C_width);
  %Handle UL corner case
  r(C_width*(C_height-1)+1) = (1-2*alpha)*x(C_width*(C_height-1)+1) + alpha*x(C_width*(C_height-1)+2) + alpha*x(C_width*(C_height-2)+1);
  %Handle UR corner case
  r(C_width*C_height) = (1-2*alpha)*x(C_width*C_height) + alpha*x(C_width*C_height-1) + alpha*x(C_width*(C_height-1));
  %Handle bottom boundary
  for i = 2:(C_width-1)
    r(i) = (1-3*alpha)*x(i) + alpha*(x(i+1)+x(i-1)) + alpha*x(i+C_width);
  end
  %Handle top boundary
  gi = 2;
  for i = (C_width*(C_height-1)+2):(C_width*C_height-1)
    r(i) = (1-3*alpha)*x(i) + alpha*(x(i+1)+x(i-1)) + alpha*x(i-C_width);
    gi = gi+1;
  end
  %Handle the general 'inner' case
  for i = 2:(C_height-1)
    for j = 2:(C_width-1)
      k = j+(i-1)*C_width;
      r(k) = (1-4*alpha)*x(k) + alpha*(x(k+1)+x(k-1)+x(k+C_width)+x(k-C_width));
    end
  end
  %Handle the left boundary
  for i = (C_width+1):C_width:(C_width*(C_height-2)+1)
    r(i) = (1-3*alpha)*x(i) + alpha*(x(i+C_width)+x(i-C_width)) + alpha*x(i+1);
  end
  %Handle the right boundary
  for i = (2*C_width):C_width:(C_width*(C_height-1))
    r(i) = (1-3*alpha)*x(i) + alpha*(x(i+C_width)+x(i-C_width)) + alpha*x(i-1);
  end
end