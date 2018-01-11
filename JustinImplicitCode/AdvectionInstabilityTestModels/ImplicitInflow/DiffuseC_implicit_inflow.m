function D = DiffuseC_implicit_inflow(C, dt, h, nu, tolerance,t,LBind,RBind);
  %Refactor the diffusion code as an implementation of
  %the Conjugate gradient method.

  %Before anything, convert C to be a column vector. Remember the
  %original size so we can fix it in the end
  dims = size(C);
  
  %Do some pre-processing to the current state before we solve
  %the system
  D = reshape(C,dims(1)*dims(2),1);
  Dp = implicit_RHS_inflow(D,dt,h,nu,dims(1),dims(2),t,LBind,RBind);
  D = Dp;
  
  %% CG begins here
  r_0 = D - DiffusionOp_inflow(D,dt,h,nu,dims(1),dims(2),LBind,RBind);
  p_0 = r_0;
  
  r_k = r_0;
  p_k = p_0;
  while (norm(r_k) > tolerance)
    Ap_k = DiffusionOp_inflow(p_k,dt,h,nu,dims(1),dims(2),LBind,RBind);
    alpha_k = (r_k'*r_k) / (p_k'*Ap_k);
    D = D + alpha_k*p_k;
    r_k1 = r_k - alpha_k*Ap_k; %We still need r_k, so keep it for a bit
    beta_k = (r_k1'*r_k1) / (r_k'*r_k);
    p_k = r_k1 + beta_k*p_k;
    r_k = r_k1;
  end
  
  %Output D in a square shape
  D = reshape(D,dims(1),dims(2));
end