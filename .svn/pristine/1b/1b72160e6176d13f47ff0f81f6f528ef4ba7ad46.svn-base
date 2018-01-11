% ChickenJuice.m

clear

%SET RANDOM SEED
a=version;
if str2num(a(1:3)) >= 7.7;
	RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));
%	defaultStream = RandStream.getDefaultStream;
%	savedState = defaultStream.State;
else;
	rand('twister',sum(100*clock))
	randn('state',sum(100*clock)) 
end

%INITIALIZE VALUES
[L,Ng,nu,dt,Tf,U,xg,yg,h,tGraph] = setParams;

load ChickenLocs
xc1 = xc(:,42);
yc1 = yc(:,42);

xc2 = xc(:,48);
yc2 = yc(:,48);
for wind_mode = 4

    [xm0,ym0,tm,tMosq,tReport, mem0] = setMosquitoes(L,h,Tf,dt,wind_mode); %%NEW
    [xm1,ym1,tm1,tMosq,tReport, mem1] = setMosquitoes(L,h,Tf,dt,wind_mode);
    [V1,V2,Vmag] = setInitialVel(Ng);
    [r1,r2,V1p,V1m,V2p,V2m,tRand] = setRandomVel(V1,V2,Vmag,Ng,dt);
    %[distsqd] = initialCalculations(xc,yc,xg,yg);

    C = zeros(Ng,Ng);
    C1 = zeros(Ng,Ng);
    xm=[];
    ym=[];
    mem=[];
    xmp=[];
    ymp=[];
    memp=[];
    count = zeros(1,length(xc1));
    countp = zeros(1,length(xc2));
    lost=0;


    %RUN THE FOR LOOP
    for t = 0 : dt : Tf

        % MAKE MATRICES FOR CALCULATING DERIVATIVES
        [Cxp,Cxm,Cyp,Cym] = SliceC(C);
        [Cxp1,Cxm1,Cyp1,Cym1] = SliceC(C1);

        % SPREAD THE SOURCE CO2 TO THE UNDERLYING GRID
        S = SpreadToGrid(xc1,yc1,C,h,U*dt);
        S1 = SpreadToGrid(xc2,yc2,C1,h,U*dt);

        % CALCULATE DIFFUSION
        D = DiffuseC(C, dt, h, nu, Cxp, Cxm, Cyp, Cym);
        D1 = DiffuseC(C1, dt, h, nu, Cxp1, Cxm1, Cyp1, Cym1);

        % CALCULATE ADVECTION
        A = AdvectC(dt, h, V1p, V1m, V2p, V2m, Cxp, Cxm, Cyp, Cym, C);	
        A1 = AdvectC(dt, h, V1p, V1m, V2p, V2m, Cxp1, Cxm1, Cyp1, Cym1, C1);	

        % SUM ALL OF THE TERMS.
        C = S + D + A; % S has both the old C and the new source C in it.
        C1 = S1 + D1 + A1; % S has both the old C and the new source C in it.

        % MOVE THE CRITTERS
        if (mod(t,tMosq) == 0)
            if ~isempty(xm);
                [xm,ym,count,lost, mem] = MoveMosquitoes(xm,ym,tMosq,V1p,V1m,V2p,V2m,C,Cxp,Cxm,Cyp,Cym,h,L,xc1,yc1,count,lost,mem,wind_mode,Vmag);
            end
            if ~isempty(xmp);
                [xmp,ymp,countp,lost, memp] = MoveMosquitoes(xmp,ymp,tMosq,V1p,V1m,V2p,V2m,C1,Cxp1,Cxm1,Cyp1,Cym1,h,L,xc2,yc2,countp,lost,memp,wind_mode,Vmag);
            end
        end
        if ~isempty(tm) && t > tm(1);
            [xm,ym,tm,xm0,ym0, mem, mem0] = insertMosquitoes(t,tm,xm,ym,mem,xm0,ym0, mem0); %%NEW
        end
        if ~isempty(tm1) && t > tm1(1);
            [xmp,ymp,tm1,xm1,ym1, memp, mem1] = insertMosquitoes(t,tm1,xmp,ymp,memp,xm1,ym1, mem1); %%NEW
        end

        % RECALCULATE RANDOM WIND
        if (mod(t,tRand) == 0)
            [r1,r2,V1p,V1m,V2p,V2m] = setRandomVel(V1,V2,Vmag,Ng,dt);
        end 

        % GRAPH CO2, CHICKENS, AND MOSQUITOES
        if mod(t,tGraph)==0;
            GraphC1(C,t,h,xm,ym,xc1,yc1,1);
            GraphC1(C1,t,h,xmp,ymp,xc2,yc2,2);
        end

        clear Cxp Cxm Cyp Cym S D A
        clear Cxp1 Cxm1 Cyp1 Cym1 S1 D1 A1

    end
end