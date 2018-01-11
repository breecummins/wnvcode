function vec = makerow(vec)

%This function checks to make sure vec is a column vector.


sz = size(vec);
if sz(1) ~= 1 && sz(2) == 1;  %if vec is a column vector...
    vec = vec.';   %...make it a row vector instead. 
elseif sz(1) ~= 1;
	error('Input argument must be nx1 or 1xn!')
end
