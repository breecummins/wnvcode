function vC = Wind(vxpa,vxna,vypa,vyna,Cxp,Cxn,Cyp,Cyn,C,h)

% Calculates the term vC

% previous and next x and y
Cxpa = ((vxpa > 0).*Cxp) + ((vxpa <= 0).*C);
Cxna = ((vxna > 0).*C) + ((vxna <= 0).*Cxn);
Cypa = ((vypa > 0).*Cyp) + ((vypa <= 0).*C);
Cyna = ((vyna > 0).*C) + ((vyna <= 0).*Cyn);

dvC_dx = ((vxna.*Cxna) - (vxpa.*Cxpa))/h;
dvC_dy = ((vyna.*Cyna) - (vypa.*Cypa))/h;

vC = dvC_dx + dvC_dy;