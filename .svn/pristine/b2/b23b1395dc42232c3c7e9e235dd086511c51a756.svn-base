function G = InterpFromGrid(x,y,C,h,parametric)

CO2_dims = size(C);

%find grid indices of the mosquitoes. *Depends on (0,0) being the lower left corner.*
j0 = fix((x-h/2)/h)+1; %shifted for cell centered grid
i0 = fix((y-h/2)/h)+1;

%Determine which mosquitoes have left the CO2 grid. 
out_x = find(j0 < 1 | j0 >= CO2_dims(2));
out_y = find(i0 < 1 | i0 >= CO2_dims(1));
total_out = unique([out_x;out_y]);
total_in = setdiff(1:length(x),total_out);

%Find the coefficients for interpolation.
rx = ((x-h/2)/h) - j0+1;
ry = ((y-h/2)/h) - i0+1;

%Take care of mosquitoes outside the domain.
N = length(x);
G = zeros(size(x));
if nargin == 5
    G(total_out) = parametric(total_out);
end

%Interpolate inside the domain.
G(total_in) = (1-rx(total_in)).*(1-ry(total_in)).*C(sub2ind(size(C),i0(total_in),j0(total_in))) + rx(total_in).*(1-ry(total_in)).*C(sub2ind(size(C),i0(total_in),j0(total_in)+1)) + (1-rx(total_in)).*ry(total_in).*C(sub2ind(size(C),i0(total_in)+1,j0(total_in))) + rx(total_in).*ry(total_in).*C(sub2ind(size(C),i0(total_in)+1,j0(total_in)+1));

	