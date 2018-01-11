function R = runSimulation(totruns,X,Y,T,Trec,r,fname,C,xv,yv);
	
	% This function generates the simulation data. 
	% INPUTS:
	% totruns is the number of simulations to run.
	% X and Y are the limits of the box that the mosquitoes start out in.
	% T is the total run time.
	% Trec is a vector containing the times at which to record mosquito postions.
	% r is a structure containing all the parameters needed to run the simulations.
	% If fname is provided, parameters and output are saved to fname in the local folder (unless a full path is provided).
	% If the stationary CO2 concentration C is passed in along with the grid locations xv and yv (vectors, not mesh grids) where it is evaluated, then the mosquito positions will be graphed during the computation.
	% OUTPUTS:
	% R is a 2D matrix containing the distance of each mosquito from the source over time (mosquito id in rows, time in columns).
	
	R = zeros(totruns*r.Nm,length(Trec));
	
	for k = 1:totruns;	
		% disp(['Run = ',int2str(k)])
		[x,y]=setInitialConditions(X,Y,r.Nm);
		for t = 0:r.dt:T;
			[x,y,r] = moveMosquitoes(x,y,r);
			ind = find(abs(Trec-t) < 1.e-1*r.dt);
			if ~isempty(ind); 
				R((r.Nm*(k-1) +1):r.Nm*k,ind) = sqrt(x.^2 + y.^2);
			end
			if exist('C','var') && mod(t,10*r.dt) == 0;
				contour(xv,yv,C,30);
				title(['Time = ',num2str(t)],'FontSize',14);
				colormap(cool);
				colorbar;
				axis equal;
				axis([-2,2,-1.5,2.5]);
				% axis off;
				hold on;
				plot(x,y,'k.');  
				pause(0.01);
				hold off;
				if t == 0;
					pause(5)
				end
			end
		end
	end
	
	if exist('fname','var');
		save(fname,'R','totruns','X','Y','T','Trec','r')
	end
	
	