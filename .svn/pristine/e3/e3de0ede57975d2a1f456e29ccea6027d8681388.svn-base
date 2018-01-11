%=========================================================================%
% TESTS
%=========================================================================%


clear all
close all
format compact
clc

% WindMatrixCreation.m
%-------------------------------------------------------------------------%
X = [1 1 1; 2 2 2; 3 3 3];
Y = X';
windx = @(X,Y) X./Y;
windy = @(X,Y) Y./X;
h = 1;

[vx vy vxpa vxna vypa vyna] = WindMatrixCreation(windx,windy,X,Y,h);

vxpaT = [.5 .75 (5/12); 1.5 1.5 (5/6); 2.5 2.25 1.25];
vxnaT = [.75 (5/12) .5; 1.5 (5/6) (5/6); 2.25 1.25 (7/6)];
vypaT = [.5 1.5 2.5; .75 1.5 2.25; 2.5 (5/6) 1.25];
vynaT = [.75 1.5 2.25; (5/12) (5/6) 1.25; .5 (5/6) (7/6)];

if vxpaT ~= vxpa
    disp('vxpa error')
elseif vxnaT ~= vxna
    disp('vxna error')
elseif vypaT ~= vypa
    disp('vypa error')
elseif vynaT ~= vyna
    disp('vyna error')
else
    disp('WindMatrixCreation.m good')
end
%-------------------------------------------------------------------------%


% CenterDiffApprox.m
%-------------------------------------------------------------------------%
C = [1 2 3; 4 5 6; 7 8 9];

[Cxp Cxn Cyp Cyn A] = CenterDiffApprox(C);

AT = [4 3 2; 1 0 -1; -2 -3 -4];

if AT ~= A
    disp('CenterDiffApprox.m error')
else
    disp('CenterDiffApprox.m good')
end
%-------------------------------------------------------------------------%


% Wind.m
%-------------------------------------------------------------------------%
vC = Wind(vxpa,vxna,vypa,vyna,Cxp,Cxn,Cyp,Cyn,C,h);

CxpaT = ((vxpa > 0).*Cxp);
CxnaT = ((vxna > 0).*C);
CypaT = ((vypa > 0).*Cyp);
CynaT = ((vyna > 0).*C);

dvC_dxT = ((vxna.*CxnaT)-(vxpa.*CxpaT))/h;
dvC_dyT = ((vyna.*CynaT)-(vypa.*CypaT))/h;
vCT = dvC_dxT + dvC_dyT;

if vCT ~= vC
    disp('Wind.m error')
else
    disp('Wind.m good')
end


% Source.m
%-------------------------------------------------------------------------%
Sx = [1.2 2.8];
Sy = [1.3 1.3];
S = 1*ones(length(Sx),1);
index = 1;

[CT1 Cp] = Source(C,S,Sx,Sy,index);

CT2 = [1.56 2.28 3.56; 4.24 5.12 6.24; 7 8 9];

if Cp ~= S
    disp('Source.m Cp error')
elseif CT1 ~= CT2
    disp('Source.m C redefinition error')
else
    disp('Source.m good')
end


% InterpFromGrid.m
%-------------------------------------------------------------------------%
x = [1.2 2.6];
y = [3.0 2.9];

G = InterpFromGrid(x,y,C,h);

GT = [7.2 8.3];

if G~=GT
    disp('InterpFromGrid.m error')
else
    disp('InterpFromGrid.m good')
end


% ResponseFunction.m
%-------------------------------------------------------------------------%
bsat = 10; b0 = 5;
kappa = 0;

F = ResponseFunction(G,b0,bsat,kappa);

FT = [.44 .66];

if abs(F) - abs(FT) > 1e-15
    disp('ResponseFunction.m error')
else
    disp('ResponseFunction.m good')
end


% PickDirection.m
%=========================================================================%
theta0 = pi/4;
fmin = pi/8; fmax = pi;
indepvar = 6;

[theta win] = PickDirection(theta0,fmin,fmax,indepvar,b0,bsat,kappa);

winT = pi-((7*pi)*(.2/8));

if abs(win-winT) > 1e-15
    disp('PickDirection.m error')
else
    disp('PickDirection.m good')
end