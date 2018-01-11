clear all
close all
clc

addpath('VarSave/30-Apr-2012/0.67809/21020 dp 1800sec 1r 1/')

figure('Units','normalized','Position',[0 0 1 1])

s = load('struct.mat','-mat');
load -ascii C.txt
load -ascii index.txt
load -ascii mx.txt
load -ascii my.txt
load -ascii vx.txt
load -ascii vy.txt
load -ascii mxkeep.txt
load -ascii mykeep.txt
load -ascii savename.txt
load -ascii mosqcount.txt
load -ascii run.txt
load -ascii mxind.txt
load -ascii myind.txt
load -ascii lm.txt
load -ascii time.txt

length(C)
length(index)

% temporary leave out of mxkeep and mykeep (turns mosquito red at host)
mxkeep = []; mykeep = [];

sizeC = size(s.X);
rows = sizeC(1);
lmn = 0;
savename = char(savename);
mosqcount = char(mosqcount);
time = char(time);
mxindn = 0;  myindn = 0;

mkdir(['Movies/',[date,' ',time,' ',savename,' ',num2str(run) ],'/'])

for i = 1:length(index)
    ic = floor(i/10)+1;
    Cn = C(((rows*(ic-1))+1):(rows*ic),:);
    indexn = index(i);
    mxn = mx(lmn+1:lmn+lm(i));
    myn = my(lmn+1:lmn+lm(i));
    if strcmp(mosqcount,'1')
        mxindn = mxind(1:lmn+1); myindn = myind(1:lmn+1);
    end
    lmn = lmn +lm(i);
    Visuals(s,Cn,indexn,mxn,myn,vx,vy,mxkeep,mykeep,savename,mosqcount,run,mxindn,myindn,time)
end