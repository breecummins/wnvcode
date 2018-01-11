function theta = pickDirection(theta0,fmin,fmax,indepvar,maxI);
	
	% slop = fmin + (fmax-fmin)./(1 + stretch*abs(indepvar));
	% s=sign(indepvar);
	% z = pi*(s-1)./2;
	% theta = theta0 +z + slop.*(2*rand(length(theta0),1)-1);
	
  %If the independent variable is universally 0, do regular diffusion
  if maxI ~= 0
	slop = fmax - (fmax-fmin).*(abs(indepvar)./maxI);
	theta = theta0 + slop.*(-1 + 2*rand(length(theta0),1));
	
	%correct direction if the independent variable is pointing backwards
	ind = find(indepvar < 0);
	theta(ind) = theta(ind) -pi;
  else
    %Uniformally distributed angles between -pi and pi
    theta = rand(length(theta0),1).*(2*pi) - pi;
  end