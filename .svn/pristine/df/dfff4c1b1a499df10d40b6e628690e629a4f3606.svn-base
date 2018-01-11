function [C Ctotal bigfind smallfind bigratio ratio whichchicken] = ...
    Matrix(C,s,run,mosqcount,movieask,savename)

% Creates a matrix of the carbon dioxide spread and produces visuals

% cross_switch = s.cross_switch;
Ctotal(1,1) = sum(sum(C));
G_old = zeros(size(s.mx));
theta = [];
inradius = [];
whichchicken = [];
mx = s.mx;
my = s.my;
mxkeep = [];
mykeep = [];
mxind = [];
myind = [];
timer = 0;
figure('Units','normalized','Position',[0 0 1 1])

% define wind, per upwinding scheme
[vx vy vxpa vxna vypa vyna] = WindMatrixCreation(s.windx,s.windy,s.X,s.Y,s.h);

% redefinition of host positions for Source.m interpolation
Sx2 = (s.Sy - (s.y0 - s.h/2))./s.h;
Sy2 = (s.Sx - (s.x0 - s.h/2))./s.h;

% create C (matrix of carbon dioxide concentrations) at each time step,
% with wind, host output, mosquito movement, and visuals
for index = 1:length(s.tn)
    
    if C < 0
        disp('Error: C < 0')
        break
    end
    
    [Cxp Cxn Cyp Cyn A] = CenterDiffApprox(C);
    vC = Wind(vxpa,vxna,vypa,vyna,Cxp,Cxn,Cyp,Cyn,C,s.h);
    % redefine C with incorporated source inputs; Cp for testing
    [C_bare Cp] = Source(C,s.S,Sx2,Sy2,index);
    C = C_bare + (s.K*A) - (vC*s.dt);

    [mx my whichchicken G_old theta outsideradius inradius mxkeep mykeep mxind myind] = MoveMosqSample(C,s,index,G_old,theta,mx,my,vx,vy,inradius,whichchicken,mxkeep,mykeep,mxind,myind);
    
    if (rem(index,s.frames) == 0) && ~(strcmp(movieask,'n'))
        newindex = (index/s.frames);
        N = Visuals(s,C,index,mx,my,vx,vy,mxkeep,mykeep,savename,mosqcount,run,mxind,myind);
        M(1,newindex) = N;
    end
    
    Ctotal(1,index+1) = sum(sum(C));
    
    if timer == s.tn(index)
        break
    end
    if isempty(outsideradius)
        timer = s.tn(index) + s.dt;
    end
    
end

[bigfind smallfind bigratio ratio] = Ratio(whichchicken,s.Sx);

switch movieask
    case 'm'
        movie(M)
    case 'a'
        movie(M)
        movie2avi(M,['Movies/',savename,' ',date,'.avi'],'fps',5)
end