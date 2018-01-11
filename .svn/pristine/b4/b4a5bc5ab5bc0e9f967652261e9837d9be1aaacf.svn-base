function SSAssessEffectVaryParams(rs, ps, stdflag);
	
	%This function examines the changes caused by varying parameters for the rule set rs. ps is a cell array, where ps{1} = max speed, ps{2} = min speed, and ps{3} = min angle. One of these values may be replaced by a list of parameter values indicating that this value is to be varied while the others are held constant. The parameter values given must be from those already run. An exception will be raised if unknown parameter values are supplied. 
	%Example: ps = {[1.25,1.5,1.75,2],0.5,4*pi/12} will vary the maximum speed and fix the min speed and min ang.
	%stdflag is an option for the visualization functions.
	
	if length(ps{1}) > 1;
		pind=[];
		for k = 1:length(ps{1});
			pv = [ps{1}(k), ps{2}, ps{3}];
			pind(k) = SSparamsets(rs, pv);
		end
	elseif length(ps{2}) > 1;
		pind=[];
		for k = 1:length(ps{2});
			pv = [ps{1}, ps{2}(k), ps{3}];
			pind(k) = SSparamsets(rs, pv);
		end
	elseif length(ps{3}) > 1;
		pind=[];
		for k = 1:length(ps{3});
			pv = [ps{1}, ps{2}, ps{3}(k)];
			pind(k) = SSparamsets(rs, pv);
		end
	else;
		pind = SSparamsets(rs,[ps{1}, ps{2}, ps{3}]);
	end	
		
		
	SSViewDist2Source(rs*ones(size(pind)),pind,1,1,0,1,stdflag);
	pause(0.01)
	SSPairwiseRunCompsKSstatSelfOnly(rs*ones(size(pind)),pind,1,1,1,stdflag);
	
	
	
		
	