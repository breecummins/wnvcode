%Construct the five bands of a 2D Crank-Nicolson diffusion operator
%with specified dimensions
function [LHS,RHS] = Build2DLaplaceCN(M,N,dt,h,nu,BC,varargin)
  LHS = NaN(M*N,5);
  RHS = NaN(M*N,5);
  
  alpha = nu*dt/(2*h^2)
  
  %Construct the most general case possible; periodic BC

  %First column represents the diagonal
  LHS(:,1) = ones(size(M*N,1))*(1+4*alpha);
  %Second column represents the lower diagonal band
  LHS(:,2) = ones(size(M*N,1))*(-alpha);
  %Third column represents the upper diagonal band
  LHS(:,3) = ones(size(M*N,1))*(-alpha);
  %Fourth column is the outer lower diagonal
  LHS(:,4) = ones(size(M*N,1))*(-alpha);
  %Fifth column is the outer upper diagonal
  LHS(:,5) = ones(size(M*N,1))*(-alpha);

  RHS(:,1) = ones(size(M*N,1))*(1-4*alpha);
  RHS(:,2) = ones(size(M*N,1))*(alpha);
  RHS(:,3) = ones(size(M*N,1))*(alpha);
  RHS(:,4) = ones(size(M*N,1))*(alpha);
  RHS(:,5) = ones(size(M*N,1))*(alpha);
  
  %Now apply a particular boundary condition
  if (strcmp(BC,'periodic'))
    %Do nothing, we've already prescribed periodic BC
    return;
  elseif (strcmp(BC,'homogeneous_dirichlet'))
    %Left boundary
    LHS(1:M:(M*(N-1)+1),2) = 0;
    RHS(1:M:(M*(N-1)+1),2) = 0;
    %Right boundary
    LHS(M:M:(M*N),3) = 0;
    RHS(M:M:(M*N),3) = 0;
    %Lower boundary
    LHS(1:M,4) = 0;
    RHS(1:M,4) = 0;
    %Top boundary
    LHS((M*(N-1)+1):(M*N),5) = 0;
    RHS((M*(N-1)+1):(M*N),5) = 0;
  elseif (strcmp(BC,'homogeneous_neumann'))
    %Left boundary
    LHS(1:M:(M*(N-1)+1),2) = 0;
    RHS(1:M:(M*(N-1)+1),2) = 0;
    LHS(1:M:(M*(N-1)+1),1) = LHS(1:M:(M*(N-1)+1),1) - alpha;
    RHS(1:M:(M*(N-1)+1),1) = RHS(1:M:(M*(N-1)+1),1) + alpha;
    %Right boundary
    LHS(M:M:(M*N),3) = 0;
    RHS(M:M:(M*N),3) = 0;
    LHS(M:M:(M*N),1) = LHS(M:M:(M*N),1) - alpha;
    RHS(M:M:(M*N),1) = RHS(M:M:(M*N),1) + alpha;
    %Lower boundary
    LHS(1:M,4) = 0;
    RHS(1:M,4) = 0;
    LHS(1:M,1) = LHS(1:M,1) - alpha;
    RHS(1:M,1) = RHS(1:M,1) + alpha;
    %Top boundary
    LHS((M*(N-1)+1):(M*N),5) = 0;
    RHS((M*(N-1)+1):(M*N),5) = 0;
    LHS((M*(N-1)+1):(M*N),1) = LHS((M*(N-1)+1):(M*N),1) - alpha;
    RHS((M*(N-1)+1):(M*N),1) = RHS((M*(N-1)+1):(M*N),1) + alpha;
  elseif (strcmp(BC,'inflow'))
    %Here, varargin passes four vectors of logical values indicating
    %whether a particular boundary point is inflow or outflow in
    %the x and y direction.
    Lbind = varargin{1};
    Rbind = varargin{2};
    Tbind = varargin{3};
    Bbind = varargin{4};
    
    %First apply a homogeneous dirichlet BC to the boundary
    %Left boundary
    LHS((1:M:(M*(N-1)+1)),2) = 0;
    RHS((1:M:(M*(N-1)+1)),2) = 0;
    %Right boundary
    LHS((M:M:(M*N)),3) = 0;
    RHS((M:M:(M*N)),3) = 0;
    %Lower boundary
    LHS((1:M),4) = 0;
    RHS((1:M),4) = 0;
    %Top boundary
    LHS(((M*(N-1)+1):(M*N)),5) = 0;
    RHS(((M*(N-1)+1):(M*N)),5) = 0;
    
    %Now, apply linear extrapolation only to outflow points.
    %Left boundary
    lb_pts = find((1:M:(M*(N-1)+1)).*Lbind');
    LHS(lb_pts,1) = LHS(lb_pts,1) - 2*alpha;
    RHS(lb_pts,1) = RHS(lb_pts,1) - 2*alpha;
    LHS(lb_pts,3) = LHS(lb_pts,3) + alpha;
    RHS(lb_pts,3) = RHS(lb_pts,3) + alpha;    
    %Right boundary
    rb_pts = find((M:M:(M*N)).*Rbind');
    LHS(rb_pts,1) = LHS(rb_pts,1) - 2*alpha;
    RHS(rb_pts,1) = RHS(rb_pts,1) - 2*alpha;
    LHS(rb_pts,2) = LHS(rb_pts,2) + alpha;
    RHS(rb_pts,2) = RHS(rb_pts,2) + alpha;    
    %Lower boundary
    bb_pts = find((1:M).*Bbind');
    LHS(bb_pts,1) = LHS(bb_pts,1) - 2*alpha;
    RHS(bb_pts,1) = RHS(bb_pts,1) - 2*alpha;
    LHS(bb_pts,5) = LHS(bb_pts,5) + alpha;
    RHS(bb_pts,5) = RHS(bb_pts,5) + alpha;    
    %Top boundary
    tb_pts = find(((M*(N-1)+1):(M*N)).*Tbind');
    LHS(tb_pts,1) = LHS(tb_pts,1) - 2*alpha;
    RHS(tb_pts,1) = RHS(tb_pts,1) - 2*alpha;
    LHS(tb_pts,4) = LHS(tb_pts,4) + alpha;
    RHS(tb_pts,4) = RHS(tb_pts,4) + alpha;
  end
end
