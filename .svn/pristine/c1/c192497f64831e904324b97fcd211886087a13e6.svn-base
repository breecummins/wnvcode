%=========================================================================%
% TWO-DIMENSIONAL DIFFUSION EQUATION
%=========================================================================%

clear all
close all
format compact
clc


% USER INPUT
%-------------------------------------------------------------------------%
dummy=[];
[runcount,windtype,movieask,savename,mosqcount,chickencount,...
    littlechicken,windsense,pretime,loadname] = Conditions(dummy);


% VARIABLES
%-------------------------------------------------------------------------%
[s C] = Variable_struct(chickencount,littlechicken,windtype,mosqcount,...
    windsense,pretime,loadname);


% COGS
%-------------------------------------------------------------------------%
for run = 1:runcount
    [C Ctotal bigfind smallfind bigratio ratio whichchicken]...
        = Matrix(C,s,run,mosqcount,movieask,savename);
    C = zeros(size(s.X));
    List(1,run) = bigfind;
    List(2,run) = bigratio;
    List(3,run) = smallfind;
    List(4,run) = ratio;
    nummosq(run,1) = length(whichchicken);
    fprintf('Run %1.0f complete\n',run)
end

[List] = Results(List,savename,nummosq,runcount);