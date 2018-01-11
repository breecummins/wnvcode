function D = DiffuseC_CrankNicolson(C,tolerance,t,LHS,RHS);
  %Before anything, convert C to be a column vector. Remember the
  %original size so we can fix it in the end
  [M,N] = size(C);
  
  %Apply the left hand side operator
  D = reshape(C,M*N,1);
  D = BandMatrixMult(RHS,M,D);
  
  %% CG begins here
  r_0 = D - BandMatrixMult(LHS,M,D);
  p_0 = r_0;
  
  r_k = r_0;
  p_k = p_0;
  while (norm(r_k) > tolerance)
    Ap_k = BandMatrixMult(LHS,M,p_k);
    alpha_k = (r_k'*r_k) / (p_k'*Ap_k);
    D = D + alpha_k*p_k;
    r_k1 = r_k - alpha_k*Ap_k; %We still need r_k, so keep it for a bit
    beta_k = (r_k1'*r_k1) / (r_k'*r_k);
    p_k = r_k1 + beta_k*p_k;
    r_k = r_k1;
  end
  
  %Output D in a square shape
  D = reshape(D,M,N);
end