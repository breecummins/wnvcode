function C = GrowMatrix(C,s,windtype,chickencount,growtime,savename,titulo)

% Creates a matrix of the carbon dioxide

[vx vy vxpa vxna vypa vyna] = WindMatrixCreation(s,windtype,chickencount);

% redefinition of host positions for Source.m interpolation
Sx2 = (s.Sy - (s.y0 - s.h/2))./s.h;
Sy2 = (s.Sx - (s.x0 - s.h/2))./s.h;

% create C (matrix of carbon dioxide concentrations) at each time step,
% with wind and host output
for index = 1:length(s.tn)

    [Cxp Cxn Cyp Cyn A] = CenterDiffApprox(C);
    if strcmp(windtype,'no') == 1
        vC = zeros(size(C));
    else
        vC = Wind(vxpa,vxna,vypa,vyna,Cxp,Cxn,Cyp,Cyn,C,s.h);
    end
    % redefine C with incorporated source inputs; Cp for testing
    [C_bare Cp] = Source(C,s.S,Sx2,Sy2,index);
    C = C_bare + (s.K*A) - (vC*s.dt);

%     if mod(index,50) == 0
%         N = GrowVisuals(C,savename,titulo,s);
%         pause(.01)
%     end
    
end