function [C bigfind smallfind bigratio ratio whichchicken] = ...
    Matrix(C,s,run,mosqcount,savename,windtype,time,day,chickencount)

mkdir(['VarSave/',day,'/',time,'/',savename,' ',num2str(run)])

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

%   block for dipole wind (recalculated for each run)
    s.f = dptheta(s,chickencount);
    [s.wx s.wy] = dp(s,chickencount,s.XZ,s.YZ);
    s.windx = s.wx(2:end-1,2:end-1);
    s.windy = s.wy(2:end-1,2:end-1);
    % saveas(gcf,['Images\MainBunker\',loadname,'_',num2str(now),'_dpgrid.jpg'])
    % close

[vx vy vxpa vxna vypa vyna] = WindMatrixCreation(s,windtype,chickencount);

% redefinition of host positions for Source.m interpolation
Sx2 = (s.Sy - (s.y0 - s.h/2))./s.h;
Sy2 = (s.Sx - (s.x0 - s.h/2))./s.h;

% visual components to be saved once
    save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/struct.mat'],'-struct','s')
    save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/vx.txt'],'vx','-ascii')
    save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/vy.txt'],'vy','-ascii')
    save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/savename.txt'],'savename','-ascii')
    save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/mosqcount.txt'],'mosqcount','-ascii')
    save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/run.txt'],'run','-ascii')
    save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/time.txt'],'time','-ascii')

% the initial timestep of visual components saved repeatedly
    save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/1C.txt'],'C','-ascii')
    save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/1mx.txt'],'mx','-ascii')
    save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/1my.txt'],'my','-ascii')

for index = 1:length(s.tn)
    
    % check that carbon dioxide amounts are always positive
    if C < 0, disp('Error: C < 0'), break, end
    
    [Cxp Cxn Cyp Cyn A] = CenterDiffApprox(C);
    if strcmp(windtype,'no') == 1
        vC = zeros(size(C));
    else
        vC = Wind(vxpa,vxna,vypa,vyna,Cxp,Cxn,Cyp,Cyn,C,s.h);
    end
    [C_bare Cp] = Source(C,s.S,Sx2,Sy2,index);
    C = C_bare + (s.K*A) - (vC*s.dt);

    if ((mod(index,s.move)==0)) && (s.tn(index) >= s.mt0)
        [mx my whichchicken G_old theta outsideradius inradius mxkeep mykeep mxind myind] = ...
            MoveMosqSample(C,s,index,G_old,theta,mx,my,vx,vy,inradius,whichchicken,mxkeep,mykeep,mxind,myind,mosqcount);
    end
    lm = length(mx);
    if (mod(index,s.frames)==0)
        save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/index.txt'],'index','-append','-ascii')
        mxp = mx'; myp = my';
        save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/mx.txt'],'mxp','-append','-ascii')
        save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/my.txt'],'myp','-append','-ascii')
        save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/lm.txt'],'lm','-append','-ascii')
        mxk = mxkeep'; myk = mykeep';
        save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/mxkeep.txt'],'mxk','-append','-ascii')
        save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/mykeep.txt'],'myk','-append','-ascii')
        mxi = mxind'; myi = myind';
        save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/mxind.txt'],'mxi','-append','-ascii')
        save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/myind.txt'],'myi','-append','-ascii')
    end
    if (mod(index,10*s.frames)==0)
        save(['VarSave/',day,'/',time,'/',savename,' ',num2str(run),'/C.txt'],'C','-append','-ascii')
    end
    
    % second statement calculates the time step after when there are no
    % free mosquitoes left; the first stops the loop at that next timestep
    % so that visuals do not stop prematurely
    if timer == s.tn(index), break, end
    if isempty(outsideradius), timer = s.tn(index) + s.dt; end

end

[bigfind smallfind bigratio ratio] = Ratio(whichchicken,s.Sx);