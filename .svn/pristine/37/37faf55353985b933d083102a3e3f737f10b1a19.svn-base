function [x,y]=setInitialConditions(X,Y,Nm);
	
	%This function sets initial conditions for the chemotaxis project. X and Y are intervals that describe the box in which Nm mosquitoes should be initially placed. 
	
	%initialize mosquitoes
	dx = X(2)-X(1);    dy = Y(2)-Y(1); 
	x = dx*rand(Nm,1) + X(1); 
	y = dy*rand(Nm,1) + Y(1);
	
