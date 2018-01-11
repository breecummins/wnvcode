function out = SSlookupparamsFourthRuns(argin);
	
	%turns param tuple into integer or vice versa; param tuple = [maxspd,minspd,minang] for both input and output
	
	if length(argin) ~= 1 && length(argin) ~=3;
		error('Input argument not recognized. Must be an integer in [1,132] or a 3-vector with a known parameter set of the form [max speed, min speed, min angle].')
	end
	
	out = [];
	
	%runs from SSMaster3
	maxspd=	1.25:0.25:2;
	minspd=	0.25:0.25:0.75;
	minang=[pi/12:pi/12:10*pi/12];	
	
	nmxs = length(maxspd);
	nmns = length(minspd);	
	nmna = length(minang);
	col1 = repmat(maxspd,nmns*nmna,1);
	col1 = col1(:);
	col2 = repmat(minspd,nmna,nmxs);
	col2 = col2(:);
	col3 = repmat(minang,1,nmxs*nmns).';
	pmat = [col1,col2,col3];
	
	%add ons for addt'l runs from SSMaster4
	minang = 0;
	col1 = repmat(maxspd,nmns,1);
	col1 = col1(:);
	col2 = repmat(minspd,1,nmxs);
	col2 = col2(:);
	col3 = repmat(minang,1,nmxs*nmns).';
	pmat = [pmat;col1,col2,col3];
	
	
	if length(argin) == 1;
		try;
			out = pmat(argin,:);
		catch;
			disp('Match not found. Integer input arguments must be in the range [1,120].')
		end
	elseif length(argin) == 3;
		ind1 = find(pmat(:,1) == argin(1));
		ind2 = find(pmat(:,2) == argin(2));
		ind3 = find(round(pmat(:,3)*12/pi) == round(argin(3)*12/pi));
		out = intersect(intersect(ind1,ind2),ind3);
		if isempty(out);
			disp('Match not found. Vector input argument is an unknown parameter set.')
		end
	end
	
	
	
	%THE METHODD BELOW GIVES THE SAME ANSWERS, BUT IS ON AVERAGE SLOWER.
	% out1=[];
	% 
	% tic
	% c=0;
	% for k = maxspd;
	% 	for l = minspd;
	% 		for m = minang;
	% 			c=c+1;
	% 			if length(argin) == 1 && argin == c;
	% 				out1 = [k,l,m];
	% 				break;
	% 			elseif length(argin) == 3 && argin(1) == k && argin(2) == l && round(argin(3)*12/pi) == round(m*12/pi);
	% 				out1 = c;
	% 				break;
	% 			end
	% 		end
	% 		if ~isempty(out1);
	% 			break;
	% 		end
	% 	end
	% 	if ~isempty(out1);
	% 		break;
	% 	end
	% end
	% toc
	% 
	