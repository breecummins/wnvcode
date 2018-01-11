function G = InterpFromGrid(x,y,C,h,parametric)

CO2_dims = size(C);

j0 = fix(x/h)+1;
i0 = fix(y/h)+1;

%Determine which mosquitoes have left the CO2 grid.
out_x = find(j0 <= 1 | j0 >= CO2_dims(1));
out_y = find(i0 <= 1 | i0 >= CO2_dims(2));
total_out = unique([out_x;out_y]);

indices = 1:length(x);
total_in = indices(not(ismember(indices,total_out)));

rx = (x/h) - j0+1;
ry = (y/h) - i0+1;

N = length(x);
%F = zeros(size(x));
G = zeros(size(x));
if nargin == 5
%    F(total_out) = parametric(total_out);
    G(total_out) = parametric(total_out);
end
%for k = total_in
  %Make sure this one hasn't left the CO2 grid
%  if (any(total_out == k))
    %Were we provided with parametric data?
 %   if nargin < 5
  %    F(k) = 0;
   % else
    %  F(k) = parametric(k);
    %end
  %else
%    F(k) = F(k) + ...
%   (1-rx(k))*(1-ry(k))*C(i0(k),j0(k)) + rx(k)*(1-ry(k))*C(i0(k),j0(k)+1) + ...
%   (1-rx(k))*ry(k)*C(i0(k)+1,j0(k)) + rx(k)*ry(k)*C(i0(k)+1,j0(k)+1);
 % end
%end

index_list = ((j0(total_in)-1).*CO2_dims(2) + i0(total_in));
G(total_in) = (1-rx(total_in)).*(1-ry(total_in)).*C(index_list) + ...
  rx(total_in).*(1-ry(total_in)).*C(index_list+CO2_dims(2)) + ...
  (1-rx(total_in)).*ry(total_in).*C(index_list+1) + ...
  rx(total_in).*ry(total_in).*C(index_list+CO2_dims(2)+1); 