%=========================================================================%
% CARBON DIOXIDE GROWER
%=========================================================================%

clear all
close all
format compact
clc

mkdir('Images/GrowCO2/')
addpath Code/
addpath Code/GrowCO2/


% USER INPUT
%-------------------------------------------------------------------------%
dummy=[];
[windtype,savename,chickencount,littlechicken,growtime,titulo] = ...
    GrowConditions(dummy);


% VARIABLES
%-------------------------------------------------------------------------%
[s C] = GrowVariables_mps(chickencount,littlechicken,windtype,growtime);


% COGS
%-------------------------------------------------------------------------%
C = GrowMatrix(C,s,windtype,chickencount,growtime,savename,titulo);
save(['Code/GrowCO2/',savename,'.mat'],'C')


% VISUALS
% -------------------------------------------------------------------------%
% N = GrowVisuals(C,savename,titulo,s);