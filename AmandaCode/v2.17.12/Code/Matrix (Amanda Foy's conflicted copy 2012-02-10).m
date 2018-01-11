function [C bigfind smallfind bigratio ratio whichchicken] = ...
    Matrix(C,s,run,mosqcount,movieask,savename)

% Creates a matrix of the carbon dioxide spread each time step and visuals

G_old = zeros(size(s.mx));
theta = [];
inradius = [];
outsideradius = s.mx;
whichchicken = [];
mx = s.mx; my = s.my;
mxkeep = []; mykeep = [];
mxind = []; myind = [];
timer = 0;
s_collect = sum(sum(s.C));
figure('Units','normalized','Position',[0 0 1 1])

[vx vy vxpa vxna vypa vyna] = WindMatrixCreation(s.windx,s.windy,s.X,s.Y,s.h);

% redefinition of host positions for Source.m interpolation
Sx2 = (s.Sy - (s.y0 - s.h/2))./s.h;
Sy2 = (s.Sx - (s.x0 - s.h/2))./s.h;

for index = 1:length(s.tn)
    
    % check that carbon dioxide amounts are always positive
    if C < 0, disp('Error: C < 0'), break, end
    
    [Cxp Cxn Cyp Cyn A] = CenterDiffApprox(C);
    vC = Wind(vxpa,vxna,vypa,vyna,Cxp,Cxn,Cyp,Cyn,C,s.h);
    [C_bare Cp] = Source(C,s.S,Sx2,Sy2,index);
    C = C_bare + (s.K*A) - (vC*s.dt);

    if ((mod(index,s.move)==0))
        [mx my whichchicken G_old theta outsideradius inradius mxkeep mykeep mxind myind] = ...
            MoveMosqSample(C,s,index,G_old,theta,mx,my,vx,vy,inradius,whichchicken,mxkeep,mykeep,mxind,myind,mosqcount);
    end
    if (mod(index,s.frames)==0) && ~(strcmp(movieask,'n'))
        dispindex = index/s.frames;
        N = Visuals(s,C,index,mx,my,vx,vy,mxkeep,mykeep,savename,mosqcount,run,mxind,myind);
        M(1,dispindex) = N;
    end    

    % test for stability of carbon dioxide amounts; c1 = 0 indicates
    % instability, breaks the current loop and the function file
%     Ctotal = sum(sum(C));
%     [s_collect c1] = Check1(Ctotal,index,s,s_collect);
%     if c1 == 0, break, end
    
    % test for accuracy of carbon dioxide amounts; c2 = 0 indicates
    % imprecision, NOT COMPLETE
%     c2 = Check2(C);
%     if c2 == 0, break, end
    
    % second statement calculates the time step after when there are no
    % free mosquitoes left; the first stops the loop at that next timestep
    % so that visuals do not stop prematurely
    if timer == s.tn(index), break, end
    if isempty(outsideradius), timer = s.tn(index) + s.dt; end

end

[bigfind smallfind bigratio ratio] = Ratio(whichchicken,s.Sx);
switch movieask
    case 'm', movie(M)
    case 'a', movie(M)
        movie2avi(M,['Movies/',savename,' ',date,'.avi'],'fps',5)
end