function [r1,r2] = setRandomVel(p,s);
	
	%p is a parameter structure. s is a size vector.
	
	r1 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(s));  
	r2 = p.Vmag*p.randratio*(p.randmean + p.randstddev*randn(s));
	% r1=0;
	% r2=0;


	