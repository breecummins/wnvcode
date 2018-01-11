function [data,d,avgcwf,L,Nm,hr] = getSimResults_density(fname,getplume,Np);

	%getplume = 0 or 1 means do not or do calculate odor plume information. Np = numebr of test points to find plume width.
	
	try;
		load(fname);
	catch;
		disp([fname,' not found. Skipping...'])
		d=0; avgcwf=0; L=0; Nm=0; hr=0;
		if getplume;
			data=zeros(2,4);
		else;
			data=zeros(2,2);
		end  
		return
	end
	
	d = p.Nm/p.L; %linear mosquito density
	avgcwf = mean(p.crosswind_duration); 
	L=p.L;
	Nm=p.Nm;
	hr = p.host_radius;
	
	data=[];	
	for k=1:length(fieldnames(alloutput))/3;
		results = eval(['alloutput.results',sprintf('%02d',k)]);
		
		%mosquito data
		data(k,1) = length(results.whichchicken)/p.Nm;
		data(k,2) = mean(results.tmfinal - results.tmentrance);
		
		%plume data
		if getplume;
			plumewidth=[];
			plumelength=[];
			for l=1:size(results.C,3); %for each recorded moment in time (1-8 possible), do......
				%get the CO2 threshold contour for the CO2 plume -- see notes below
				c=contourc((p.h/2 : p.h : p.L-p.h/2),(p.h/2 : p.h : p.L-p.h/2),results.C(:,:,l),[p.CO2_thresh,p.CO2_thresh]);
			
				%find plume
				i1=find(c(1,:)>p.CO2_thresh); %greater than threshold has to do with the way the c matrix is constructed. It cuts out the colummns where there is the contour value and the number of vertices in the contour (see excerpted docs below). This algorithm depends on the locations of the contours being well-separated from the CO_2 threshold. In most cases, this threshold is very small -- close to zero -- and the x and y contour values are large greater than 10). 
				c1=c(:,i1);
				[plumewidth(l), plumelength(l)] = plumedata(c1,p,Np);	 
			end	
			data(k,3) = mean(plumelength); %length of the fully developed odor plume
			data(k,4) = mean(plumewidth); %width of the fully developed odor plume
		end
	end	
		
end %function

% c is a two-row matrix specifying all the contour lines. Each contour line defined in matrix c begins with a column that contains the value of the contour (specified by v and used by clabel), and the number of (x,y) vertices in the contour line. The remaining columns contain the data for the (x,y) pairs.

% c = [value1 xdata(1) xdata(2) ... xdata(dim1) value2 xdata(1) xdata(2) ... xdata(dim2)...
%		dim1  ydata(1) ydata(2) ... ydata(dim1)  dim2  ydata(1) ydata(2) ... ydata(dim2)...];

