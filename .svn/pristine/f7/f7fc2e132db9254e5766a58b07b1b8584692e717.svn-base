function [theta win] = PickDirection(theta0,fmin,fmax,indepvar,b0,bsat,kappa)

% Calculates alpha and picks mosquito direction theta from the window
% [theta0 - alpha, theta0 + alpha]

F = ResponseFunction(indepvar,b0,bsat,kappa);
win = fmax - (fmax-fmin).*F;
theta = theta0 + win.*(-1 + 2*rand(1,length(theta0)));