function G = InterpFromGrid(x,y,C,h)

% Interpolation [for the amount of CO2 at a vector location?]

% setup matrices
Cb = zeros(length(C(:,1))+2,length(C(1,:))+2);
Cb(1,2:end-1) = C(1,:);
Cb(2:end-1,:) = [C(:,1) C C(:,end)];
Cb(end,2:end-1) = C(end,:);
CO2_dims = size(Cb);
% G = zeros(size(x));

% floor indices of mosquito positions
i0 = fix(x/h)+1;
j0 = fix(y/h)+1;

% "percent" distance from previous gridpoint (treating h as one)
rx = (x/h) - i0 + 1;
ry = (y/h) - j0 + 1;

% indices (elements numbered through columns) adjacent to point of interest
index_list = j0 + ((i0-1).*CO2_dims(1));
index_xn = j0 + (i0.*CO2_dims(1));
index_yn = (j0+1) + ((i0-1).*CO2_dims(1));
index_xyn = (j0+1) + (i0.*CO2_dims(1));

% interpolation at the mosquito location (rx and ry correspond to alpha and
% beta in Source.m)
G = (1-rx).*(1-ry).*Cb(index_list) + rx.*(1-ry).*Cb(index_xn) + ...
    (1-rx).*ry.*Cb(index_yn) + rx.*ry.*Cb(index_xyn);