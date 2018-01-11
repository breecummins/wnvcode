function vec = makecolumn(vec)

%This function checks to make sure vec is a column vector.


sz = size(vec);
if sz(1) == 1 && sz(2) ~= 1;  %if vec is a row vector...
    vec = vec.';   %...make it a column vector instead. 
elseif sz(2) ~= 1;
	error('Input argument must be nx1 or 1xn!')
end
