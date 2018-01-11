function [bigfind smallfind bigratio ratio] = Ratio(whichchicken,Sx)

% Calculates the ratio between the per-capita encounter rate for the
% individual chicken versus the per-capita encounter rate for each chicken
% in the larger group

% finds how many mosquitoes have found the larger and smaller groups
bigfind = sum(whichchicken <= (length(Sx) - 1));
smallfind = sum(whichchicken > (length(Sx) - 1));
% per-capita encounter rate of the larger group
bigratio = bigfind/(length(Sx) - 1);
% ratio of the per-capita encounter rate of the smaller versus larger
% groups
ratio = smallfind/bigratio;