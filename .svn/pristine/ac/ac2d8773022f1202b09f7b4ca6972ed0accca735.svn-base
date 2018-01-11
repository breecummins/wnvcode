function R = vanishMosquitoes(dirname,critrad,savefile,ending);
	
	%Removes mosquitoes within a critical radius of the source. dirname is *either* a file name or a directory. savefile = 1 means save the file. 'ending' is an optional argument that specifies the ending to tack on to the input file name. Default is '_van'.
	
	try;
		load(dirname) %dirname is a file
		d = 1;
		flag = 0;
	catch;
		d=dir(dirname); %dirname is a directory
		flag=1;
	end
	
	for j = 1:length(d);
		if flag;
			if d(j).name(1) ~= '.';
				fname = fullfile(dirname,d(j).name);
				load(fname)
			elseif d(j).name(1) == '.';
				continue
			end
		end
		for k = 1:size(R,1);
			ind = find(R(k,:) < critrad,1);
			if ~isempty(ind);
				R(k,ind:end) = 0;
			end
		end
		
		if savefile == 1;
			if ~exist('ending','var');
				ending='_van.mat'; 
			elseif fname(end-3:end) ~= '.mat';
				ending = [ending,'.mat'];
			end
			if fname(end-3:end) == '.mat';
				fname(end-3:(end-4+length(ending))) = ending;
			else;
				fname(end+1:(end+length(ending))) = ending;
			end
			save(fname,'critrad','R','totruns','X','Y','T','Trec','r');
		end	
		
	end
	
		
