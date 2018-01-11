function r = implicit_RHS_exact_grad(x,dt,h,nu,C_width,C_height,l_bounds,r_bounds,t_bounds,b_bounds,t)
  %Implicitly define our diffusion operator on a given vector.
  alpha = nu*dt/(2*h^2);
  r = NaN(size(x));

  %%NEW: Add the exact gradient bits.
  gl_n = del_u_exact(l_bounds(:,1),l_bounds(:,2),t,1,nu)*[-h;0];
  gr_n = del_u_exact(r_bounds(:,1),r_bounds(:,2),t,1,nu)*[h;0];
  gt_n = del_u_exact(t_bounds(:,1),t_bounds(:,2),t,1,nu)*[0;h];
  gb_n = del_u_exact(b_bounds(:,1),b_bounds(:,2),t,1,nu)*[0;-h];
  gl_np1 = del_u_exact(l_bounds(:,1),l_bounds(:,2),t+dt,1,nu)*[-h;0];
  gr_np1 = del_u_exact(r_bounds(:,1),r_bounds(:,2),t+dt,1,nu)*[h;0];
  gt_np1 = del_u_exact(t_bounds(:,1),t_bounds(:,2),t+dt,1,nu)*[0;h];
  gb_np1 = del_u_exact(b_bounds(:,1),b_bounds(:,2),t+dt,1,nu)*[0;-h];
  
  %This next chunk of code defines each row in our diffusion
  %operator.
  
  %Handle LL corner case
  r(1) = (1-2*alpha)*x(1) + alpha*x(2) + alpha*x(C_width+1) + alpha*(gl_n(1)+gb_n(1)+gl_np1(1)+gb_np1(1));
  %Handle LR corner case
  r(C_width) = (1-2*alpha)*x(C_width) + alpha*x(C_width-1) + alpha*x(2*C_width) + alpha*(gr_n(1)+gb_n(end)+gr_np1(1)+gb_np1(end));
  %Handle UL corner case
  r(C_width*(C_height-1)+1) = (1-2*alpha)*x(C_width*(C_height-1)+1) + alpha*x(C_width*(C_height-1)+2) + alpha*x(C_width*(C_height-2)+1) + alpha*(gl_n(end)+gt_n(1)+gl_np1(end)+gt_np1(1));
  %Handle UR corner case
  r(C_width*C_height) = (1-2*alpha)*x(C_width*C_height) + alpha*x(C_width*C_height-1) + alpha*x(C_width*(C_height-1)) + alpha*(gr_n(end)+gt_n(end)+gr_np1(end)+gt_np1(end));
  %Handle bottom boundary
  for i = 2:(C_width-1)
    r(i) = (1-3*alpha)*x(i) + alpha*(x(i+1)+x(i-1)) + alpha*x(i+C_width) + alpha*(gb_n(i)+gb_np1(i));
  end
  %Handle top boundary
  gi = 2;
  for i = (C_width*(C_height-1)+2):(C_width*C_height-1)
    r(i) = (1-3*alpha)*x(i) + alpha*(x(i+1)+x(i-1)) + alpha*x(i-C_width) + alpha*(gt_n(gi)+gt_np1(gi));
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
  gi = 2;
  for i = (C_width+1):C_width:(C_width*(C_height-2)+1)
    r(i) = (1-3*alpha)*x(i) + alpha*(x(i+C_width)+x(i-C_width)) + alpha*x(i+1) + alpha*(gl_n(gi)+gl_np1(gi));
    gi = gi+1;
  end
  %Handle the right boundary
  gi = 2;
  for i = (2*C_width):C_width:(C_width*(C_height-1))
    r(i) = (1-3*alpha)*x(i) + alpha*(x(i+C_width)+x(i-C_width)) + alpha*x(i-1) + alpha*(gr_n(gi)+gr_np1(gi));
    gi = gi+1;
  end
end