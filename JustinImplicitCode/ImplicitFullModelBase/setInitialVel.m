function [V1p,V1m,V2p,V2m,Vmag] = setInitialVel(xg,yg);

  Vmag = 0.2;
  V1 = V1Parametric(xg,yg,Vmag);  
  V2 = V2Parametric(xg,yg,Vmag); 

  %set masked values for upwind calculations
  maskp = V1>0;
  V1p = maskp.*V1;
  maskm = V1<0;
  V1m = maskm.*V1;
  maskp = V2>0;
  V2p = maskp.*V2;
  maskm = V2<0;
  V2m = maskm.*V2;
