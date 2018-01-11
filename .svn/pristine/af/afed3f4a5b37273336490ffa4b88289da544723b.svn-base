function [Cxp,Cxm,Cyp,Cym] = SliceC(C,l_bounds,r_bounds,t_bounds,b_bounds,nu,t,h);
	
	corer=C(2:end-1,:);
	corec=C(:,2:end-1);
	row1=C(1,:);
	rowe=C(end,:);
	col1=C(:,1);
	cole=C(:,end);

    %Calculate the value at the ghost points
    col1 = u_exact(l_bounds(:,1),l_bounds(:,2),t,1,nu);
    cole = u_exact(r_bounds(:,1),r_bounds(:,2),t,1,nu);
    rowe = u_exact(t_bounds(:,1),t_bounds(:,2),t,1,nu)';
    row1 = u_exact(b_bounds(:,1),b_bounds(:,2),t,1,nu)';

    Cyp = [C(2:end,:);rowe];
    Cym = [row1;C(1:end-1,:)];
    Cxp = [C(:,2:end),cole];
    Cxm = [col1,C(:,1:end-1)];