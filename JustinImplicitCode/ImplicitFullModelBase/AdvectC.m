function A = AdvectC(dt, h, V1p, V1m, V2p, V2m, Cxp, Cxm, Cyp, Cym, C);
  dCdxp = (Cxp-C)/h;
  dCdxm = (C-Cxm)/h;
  dCdyp = (Cyp-C)/h;
  dCdym = (C-Cym)/h;
		
  advC = -(V1p.*dCdxm + V1m.*dCdxp + V2p.*dCdym + V2m.*dCdyp);
  A = dt*advC;
