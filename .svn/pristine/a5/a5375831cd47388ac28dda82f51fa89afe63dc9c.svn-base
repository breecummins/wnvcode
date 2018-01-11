function [Cxp,Cxm,Cyp,Cym] = SliceC_exact_grad(C,l_bounds,r_bounds,t_bounds,b_bounds,nu,t,h);
	
	corer=C(2:end-1,:);
	corec=C(:,2:end-1);
	row1=C(1,:);
	rowe=C(end,:);
	col1=C(:,1);
	cole=C(:,end);

%     %Calculate the exact gradient at the boundaries
     grad_left = del_u_exact(l_bounds(:,1),l_bounds(:,2),t,1,nu);
     grad_right = del_u_exact(r_bounds(:,1),r_bounds(:,2),t,1,nu);
     grad_top = del_u_exact(t_bounds(:,1),t_bounds(:,2),t,1,nu);
     grad_bottom = del_u_exact(b_bounds(:,1),b_bounds(:,2),t,1,nu);
     row1 = (grad_bottom*[0;-h])' + C(1,:);
     rowe = (grad_top*[0;h])' + C(end,:);
     col1 = grad_left*[-h;0] + C(:,1);
     cole = grad_right*[h;0] + C(:,end);

    Cyp = [C(2:end,:);rowe];
    Cym = [row1;C(1:end-1,:)];
    Cxp = [C(:,2:end),cole];
    Cxm = [col1,C(:,1:end-1)];