%Given a vector flow field and a domain shape, determine which
%boundary points are inflow points and which ones are outflow.
function [lbind,rbind,tbind,bbind] = FindInflowOutflow(u,v,M,N)
  lbind = NaN(N,1);
  rbind = NaN(N,1);
  tbind = NaN(M,1);
  bbind = NaN(M,1);
  
  if (length(u) > 1)
    lbind = (0.5*(u(:,1)+u(:,2))) < 0;
    rbind = (0.5*(u(:,end)+u(:,end-1))) > 0;
  else
    lbind = ones(N,1)*(u < 0);
    rbind = ones(N,1)*(u > 0);
  end
  if (length(v) > 1)
    bbind = (0.5*(v(1,:)+v(2,:))) < 0;
    tbind = (0.5*(v(end,:)+v(end-1,:))) > 0;
  else
    bbind = ones(M,1)*(v < 0);
    tbind = ones(M,1)*(v > 0);
  end
end