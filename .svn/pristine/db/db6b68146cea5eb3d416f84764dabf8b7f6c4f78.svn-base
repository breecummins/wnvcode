function G = InterpFromGrid(x,y,C,h,parametric)

CO2_dims = size(C);

j0 = fix(x/h)+1;
i0 = fix(y/h)+1;

%Determine which mosquitoes have left the CO2 grid.
out_x = find(j0 <= 1 | j0 >= CO2_dims(2));
out_y = find(i0 <= 1 | i0 >= CO2_dims(1));
total_out = unique([out_x;out_y]);

indices = 1:length(x);
total_in = indices(not(ismember(indices,total_out)));

rx = (x/h) - j0+1;
ry = (y/h) - i0+1;

N = length(x);
G = zeros(size(x));
if nargin == 5
    G(total_out) = parametric(total_out);
end

index_list = ((j0(total_in)-1).*CO2_dims(2) + i0(total_in));
G(total_in) = (1-rx(total_in)).*(1-ry(total_in)).*C(index_list) + ...
  rx(total_in).*(1-ry(total_in)).*C(index_list+CO2_dims(2)) + ...
  (1-rx(total_in)).*ry(total_in).*C(index_list+1) + ...
  rx(total_in).*ry(total_in).*C(index_list+CO2_dims(2)+1); 