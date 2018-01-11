function [V1,V2,Vmag] = setInitialVel(Ng,xg,yg);
	
	%STRAIGHT FLOW
	Vmag = 0.2;
	V1 = V1Parametric(ones(Ng,Ng),0,Vmag);  
	V2 = V2Parametric(0,ones(Ng,Ng),Vmag); 

    %STRAIGHT FLOW
%	Vmag = 0.2;
%	V1 = (0.1)*Vmag*ones(Ng,Ng);  
%	V2 = (1)*Vmag*ones(Ng,Ng); 
	
	%CURLY FLOW
	% V1 = Vmag*(yg-0.5);  
	% V2 = Vmag*(-xg+0.5); 
	