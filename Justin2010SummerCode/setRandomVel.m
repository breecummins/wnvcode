function [r1,r2,V1p,V1m,V2p,V2m,tRand] = setRandomVel(V1,V2,Vmag,Ng,dt);
	
	randcst = 0.75;
	meanval = 0;
	stddev = 0.5;
	r1 = randcst*(meanval + stddev*randn(Ng,Ng))*Vmag;  
	r2 = randcst*(meanval + stddev*randn(Ng,Ng))*Vmag;
	% r1=0;
	% r2=0;
	

	%set masked values for upwind calculations
	maskp = ((V1+r1)>0);
	V1p = maskp.*(V1+r1);
	maskm = ((V1+r1)<0);
	V1m = maskm.*(V1+r1);
	maskp = ((V2+r2)>0);
	V2p = maskp.*(V2+r2);
	maskm = ((V2+r2)<0);
	V2m = maskm.*(V2+r2);


	tRand = 25*dt;
	