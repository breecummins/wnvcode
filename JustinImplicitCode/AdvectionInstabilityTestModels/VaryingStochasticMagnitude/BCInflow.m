function [Cxm,Cxp,Cym,Cyp] = BCInflow(C,LBind,RBind);

    % INFLOW BCS
	z = zeros(size(C(:,1)));
	extrap = 2*C(end,:) - C(end-1,:);
	
	Cyp = [C(2:end,:);extrap];
	Cym = [z.';C(1:end-1,:)];
	Cxp = [C(:,2:end),z];
	Cxm = [z,C(:,1:end-1)];
	
	%correct outflow BCs
	Cxp(RBind,end) = 2*C(RBind,end) - C(RBind,end-1);
	Cxm(LBind,1) = 2*C(LBind,1) - C(LBind,2);

