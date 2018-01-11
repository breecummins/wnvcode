function [xm,ym]=SSMosqWalls(xm,ym,dxm,dym,h,L);

% KEEP THEM IN BOUNDS IN CASE THEY STEP OUT OF THE BOX
   idxj = find( ym>L-2*h ); if isempty(idxj)==0, ym(idxj) = ym(idxj)-dym(idxj); end
   idxj = find( ym<2*h );   if isempty(idxj)==0, ym(idxj) = ym(idxj)-dym(idxj); end
   idxi = find( xm>L-2*h ); if isempty(idxi)==0, xm(idxi) = xm(idxi)-dxm(idxi); end
   idxi = find( xm<2*h );   if isempty(idxi)==0, xm(idxi) = xm(idxi)-dxm(idxi); end
