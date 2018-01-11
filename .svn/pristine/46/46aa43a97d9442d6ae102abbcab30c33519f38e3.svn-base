function g = AdvectC(xg,yg,C,Cxp,Cxm,Cyp,Cym,U,V,h,Vmag,vfunc,t);

% CALCULATE SHIFTED X AND Y VELOCITIES
Uxp = [U(:,2:end),eval(['V1Parametric',vfunc,'(xg(:,end)+h,yg(:,end),Vmag,t)'])];
Uxm = [eval(['V1Parametric',vfunc,'(xg(:,1)-h,yg(:,1),Vmag,t)']), U(:,1:end-1)];
Vyp = [V(2:end,:); eval(['V2Parametric',vfunc,'(xg(end,:),yg(end,:)+h,Vmag,t)'])];
Vym = [eval(['V2Parametric',vfunc,'(xg(1,:),yg(1,:)-h,Vmag,t)']); V(1:end-1,:)];

%CALCULATE VELOCITY AVERAGES ON CELL EDGES
up = 0.5*(U+Uxp);
um = 0.5*(U+Uxm);
vp = 0.5*(V+Vyp);
vm = 0.5*(V+Vym);

%FLUXES ON THE EDGES OF THE CELLS USING A CONSERVATIVE UPWINDING SCHEME
Flxx = (C.*(up>0) + Cxp.*(up<=0)).*up - (Cxm.*(um>0) + C.*(um<=0)).*um;
Flxy = (C.*(vp>0) + Cyp.*(vp<=0)).*vp - (Cym.*(vm>0) + C.*(vm<=0)).*vm;
g = (Flxx+Flxy)/h;


%%%%%%%%%%%%%%%%%%%%%%
% %for testing
% figure
% quiver(xg,yg,U,V)
% figure
% quiver(xg+h,yg,Uxp,[V(:,2:end),V2Parametric(xg(:,end)+h,yg(:,end),Vmag)])
% figure
% quiver(xg-h,yg,Uxm,[V2Parametric(xg(:,1)-h,yg(:,1),Vmag), V(:,1:end-1)])
% figure
% quiver(xg,yg+h,[U(2:end,:); V1Parametric(xg(end,:),yg(end,:)+h,Vmag)],Vyp)
% figure
% quiver(xg,yg-h,[V1Parametric(xg(1,:),yg(1,:)-h,Vmag); U(1:end-1,:)],Vym)
% %end testing

