function TT = checkTarget(col,TT,xm,ym,sourcex,sourcey,t,rad);
	
	ind = find(sqrt((xm-sourcex).^2 + (ym-sourcey).^2) < rad);
	if ~isempty(ind);
		for k = 1:length(ind);
			if TT(ind(k),col)==0;
				TT(ind(k),col)=t;
			end
		end
	end
	