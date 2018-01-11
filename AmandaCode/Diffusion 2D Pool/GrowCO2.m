%=========================================================================%
% CARBON DIOXIDE GROWER
%=========================================================================%

clear all
close all
format compact
clc


addpath GrowCO2/

% USER INPUT
%-------------------------------------------------------------------------%
dummy=[];
[windtype,savename,chickencount,littlechicken,growtime,titulo] = ...
    GrowConditions(dummy);


% VARIABLES
%-------------------------------------------------------------------------%
[s C] = GrowVariables(chickencount,littlechicken,windtype,growtime);


% COGS
%-------------------------------------------------------------------------%
C = GrowMatrix(C,s);
save(['GrowCO2/',savename,'.mat'],'C')


% VISUALS
% -------------------------------------------------------------------------%
N = GrowVisuals(C,savename,titulo,s);