function [C Cp] = Source(C,S,Sx,Sy,k)

% Calculates the source term by extrapolating the amount of source input at
% the source location to the adjacent grid points and adding those amounts
% to the amount of CO2 already present

for g = 1:length(Sx)
    % identifies gridpoints adjacent to source point
    Corner1(g) = C(floor(Sx(g)),floor(Sy(g)));
    Corner2(g) = C(ceil(Sx(g)),floor(Sy(g)));
    Corner3(g) = C(floor(Sx(g)),ceil(Sy(g)));
    Corner4(g) = C(ceil(Sx(g)),ceil(Sy(g)));
	
    % finds percent concentrations
    alpha(g) = ceil(Sx(g)) - Sx(g);
    beta(g) = ceil(Sy(g)) - Sy(g);
    
    Cp1(g) = (alpha(g).*beta(g).*S(g,k));
	Cp2(g) = ((1-alpha(g)).*beta(g).*S(g,k));
    Cp3(g) = (alpha(g).*(1-beta(g)).*S(g,k));
    Cp4(g) = ((1-alpha(g)).*(1-beta(g)).*S(g,k));
    Cp(g,k) = Cp1(g) + Cp2(g) + Cp3(g) + Cp4(g);
    
    % redefines new concentrations at the gridpoints
    C(floor(Sx(g)),floor(Sy(g))) = Corner1(g) + Cp1(g);
    C(ceil(Sx(g)),floor(Sy(g))) = Corner2(g) + Cp2(g);
    C(floor(Sx(g)),ceil(Sy(g))) = Corner3(g) + Cp3(g);
    C(ceil(Sx(g)),ceil(Sy(g))) = Corner4(g) + Cp4(g);
end