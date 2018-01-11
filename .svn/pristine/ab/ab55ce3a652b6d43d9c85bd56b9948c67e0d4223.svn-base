%=========================================================================%
% TWO-DIMENSIONAL DIFFUSION EQUATION
%=========================================================================%

clear all
close all
format compact
clc

tic
time = num2str(rem(now,1));
day = date;

mkdir(['Results/',day,'/',time,'/'])
mkdir('Movies/')
mkdir('VarSave/')
mkdir(['VarSave/',day,'/',time,'/'])
addpath Code/
diary(['VarSave/',day,'/',time,'/diary.txt'])
diary on
disp(time)


% RUNTIME
%-----------
% if tstop is empty, runs until all mosquitos find hosts; if tstop contains
% a scalar (best to be a multiple of 600 for CO2 frames in Visuals.m), runs
% until that end
tstop = [20000];


% INITIAL SEED
%----------------
% saves value on which initial seed is based
rtime = fix(sum(100*clock));
% to rerun a simulation with a saved initial seed, uncomment the line below
% and comment out the following line
% load('VarSave/09-Mar-2012/0.39041/rtime.mat','-mat','rtime')
rand('seed',rtime)
save(['VarSave/',day,'/',time,'/rtime.mat'],'rtime')


% USER INPUT
%-------------------------------------------------------------------------%
% The GrowCO2 file to be loaded must be entered manually.
dummy=[];
[runcount,windtype,savename,mosqcount,chickencount,...
    littlechicken,windsense,pretime,loadname] = Conditions_mps(dummy);


% VARIABLES
%-------------------------------------------------------------------------%
[s C] = Variable_struct_mps(chickencount,littlechicken,windtype,mosqcount,...
    windsense,pretime,loadname,tstop,time,day);


% COGS
%-------------------------------------------------------------------------%
for run = 1:runcount
    [C2 bigfind smallfind bigratio ratio whichchicken]...
        = Matrix(C,s,run,mosqcount,savename,windtype,time,day,chickencount);
    List(1,run) = bigfind;
    List(2,run) = bigratio;
    List(3,run) = smallfind;
    List(4,run) = ratio;
    nummosq(run,1) = length(whichchicken);
    fprintf('Run %1.0f complete\n',run)
end

[List] = Results(List,savename,nummosq,runcount,time,day);
diary off
toc