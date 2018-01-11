function out = SSlookuptable(in, flag)

% If flag == 'ind2paper': This function takes the rule set number given in the *program* and translates it to the rule set number used in the *paper*. 
% If flag == 'paper2ind': This function takes the rule set number given in the *paper* and translates it to the rule set number used in the *program*. 
% Only works for a scalar.

if ~all(size(in) == [1,1]);
	error('Input number must be a scalar.')
end

if (in == 1 || in == 5);
	out =in;
	return
end

if flag == 'ind2paper';
	if ~isempty(intersect(in,[2,3,6:9]));
		out = in+1;
	elseif in == 10;
		out =2;
	elseif in == 4;
		out = 6;
	else;
		error('Input number must be an integer in the range [1,10].')
	end	
elseif flag == 'paper2ind';
	if ~isempty(intersect(in,[3,4,7:10]));
		out = in-1;
	elseif in == 2;
		out =10;
	elseif in == 6;
		out = 4;
	else;
		error('Input number must be an integer in the range [1,10].')
	end	
else;
	error('Value for flag not recognized.')	
end



